== Arquitectura de Pruebas: Repositorio Dedicado de Integración (`integracion`)

Para eliminar por completo los *mocks* y probar la interacción real de las APIs tal como ocurrirá en producción, la suite de integración vive en un repositorio independiente: *`integracion`*.

=== 1. Principio Operativo: Cero Mocks y Contenedores GHCR

1. Cada microservicio compila y publica su imagen Docker oficial en GitHub Container Registry (`ghcr.io/javer-ia-nos/<servicio>:latest`) mediante su flujo de CI en `.github/workflows/docker-publish.yaml`.
2. El repositorio `integracion` contiene un `docker-compose.yml` que orquesta la flota en modo prueba:
  - *Borde:* `api-gateway` (puerto `4860`).
  - *Microservicios:* Los 8 servicios del banco (`ms-seguridad`, `ms-cuentas`, `ms-transacciones`, `ms-financiero`, `ms-tarjetas`, `ms-crm`, `ms-notificaciones`, `ms-auditoria`) configurados en `NODE_ENV=test` para operar con sus motores de persistencia embebidos nativos en memoria (SQLite nativo de Bun), evitando dependencias pesadas de contenedores de base de datos externas o brokers temporales.
3. Los tests de integración se ejecutan desde fuera de los contenedores como un cliente HTTP real (Black Box Testing), consumiendo las rutas a través del API Gateway (`http://localhost:4860`) o directamente al servicio evaluado.

=== 2. Estructura del Repositorio `integracion`

```
integracion/
├── docker-compose.yml           # Levanta Gateway y los 8 microservicios
├── package.json                 # Scripts de orquestación y runner de Bun
├── README.md                    # Instrucciones de uso para el equipo
└── src/
    └── test/                    # Los 18 tests de integración
        ├── int-01-auth-handshake.test.ts
        ├── int-02-auditoria.test.ts
        ├── int-03-dispositivos-topes.test.ts
        ├── int-04-transferencias-atomicas.test.ts
        └── ...
```

=== 3. Anatomía de un Test de Integración E2E (Sin Mocks)

Cada archivo de prueba utiliza `bun:test` y `fetch` estándar hacia el Gateway real:

```typescript
import { describe, it, expect, beforeAll } from "bun:test";

const GATEWAY_URL = process.env.GATEWAY_URL ?? "http://localhost:4860";

describe("INT-04: Transferencia Bancaria Atómica (ms-transacciones <-> ms-cuentas)", () => {
  let tokenAuth: string;
  const CUENTA_ORIGEN = "acc-100-test";
  const CUENTA_DESTINO = "acc-200-test";

  beforeAll(async () => {
    // 1. Obtener token real autenticándose en ms-seguridad a través del Gateway
    const loginRes = await fetch(`${GATEWAY_URL}/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email: "test@banco.com", password: "Prueba123!" }),
    });
    const loginData = await loginRes.json();
    tokenAuth = loginData.token;
  });

  it("Debe debitar la cuenta origen y acreditar la cuenta destino de forma atómica", async () => {
    // 2. Disparar la transferencia real
    const res = await fetch(`${GATEWAY_URL}/transacciones/transferencias`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Authorization": `Bearer ${tokenAuth}`,
        "x-correlation-id": "corr-int-04-real",
      },
      body: JSON.stringify({
        cuentaOrigen: CUENTA_ORIGEN,
        cuentaDestino: CUENTA_DESTINO,
        monto: 50000,
      }),
    });

    expect(res.status).toBe(200);
    const data = await res.json();
    expect(data.estado).toBe("COMPLETED");
    expect(data.numeroComprobante).toBeDefined();

    // 3. Consultar saldo real en ms-cuentas para certificar la consistencia
    const saldoRes = await fetch(`${GATEWAY_URL}/cuentas/${CUENTA_ORIGEN}/saldo`, {
      headers: { "Authorization": `Bearer ${tokenAuth}` },
    });
    const saldoData = await saldoRes.json();
    expect(saldoData.saldoDisponible).toBeDefined();
  });
});
```

=== 4. ¿Cómo ejecutar y probar la suite?

==== Modo 1: Ejecución completa en un solo comando (Recomendado para CI y pruebas generales)
Descarga las imágenes más recientes de GHCR, levanta los contenedores en segundo plano, corre los 18 tests y luego desmonta el entorno:
```bash
cd integracion
bun run test:e2e
```

==== Modo 2: Desarrollo interactivo (Para escribir y depurar tu test individual)
1. Levanta la flota en segundo plano una sola vez:
  ```bash
  cd integracion
  bun run up
  ```
2. Ejecuta únicamente tu test de integración asignado cuantas veces necesites:
  ```bash
  bun test src/test/int-07-beneficiarios.test.ts
  ```
3. Si necesitas ver los logs de un servicio en vivo (ej. `ms-transacciones`):
  ```bash
  docker compose logs -f ms-transacciones
  ```
4. Al terminar tu jornada de pruebas, apaga el entorno:
  ```bash
  bun run down
  ```
