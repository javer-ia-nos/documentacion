= Documento de guia para nosotros

== Ver pdfs generados

Se puede ver una vista previa antes de generar la entrega, esto se hace entrado a las actions del repo (#link(
  "https://github.com/javer-ia-nos/Documentacion/actions",
  "ir a actions",
)):

#align(
  center,
  image("assets/dev/actions-1.png", width: 80%),
)

Y entra al commit del que quieras ver su documento generado:

#align(
  center,
  image("assets/dev/actions-2.png", width: 80%),
)

En esta ventana ahora podrás ver los artifacts, por ahora solo tenemos los pdfs, esto te descargará un zip con ambos archivos.

#align(
  center,
  image("assets/dev/action-artifacts.png", width: 80%),
)

#pagebreak()

== Plan Maestro de Tests de Integración entre Repositorios

Para asegurar que los microservicios, el API Gateway y los brokers de mensajería interoperen correctamente, a continuación se distribuyen las responsabilidades de pruebas de integración (E2E / inter-servicio) entre los integrantes del equipo según los casos de uso asignados.

#set text(size: 7.5pt)
#table(
  columns: (auto, 1.3fr, 1.2fr, 1fr, auto, 2.5fr),
  table.header(
    [*ID*],
    [*Nombre del Test*],
    [*Responsable*],
    [*Servicios Involucrados*],
    [*CUs*],
    [*Descripción, Flujo y Resultado Esperado*],
  ),

  [INT-01],
  [*Handshake de Autenticación y Validación de Token en Gateway*],
  [Arantxa Marian Espejo Malagon],
  [api-gateway \
    ms-seguridad],
  [CU-15 \
    CU-16],
  [Validar que el Gateway proteja rutas downstream, verifique la firma criptográfica del JWT (HS256) con el secreto compartido y propague el contexto del usuario. Peticiones sin token o alteradas deben responder 401 Unauthorized; peticiones válidas se reenvían al microservicio correspondiente.],

  [INT-02],
  [*Trazabilidad Perimetral e Inmutabilidad de Auditoría*],
  [Arantxa Marian Espejo Malagon],
  [api-gateway \
    ms-auditoria],
  [CU-01],
  [Asegurar que cada interacción cliente genere trazas con x-request-id y x-correlation-id. El Gateway captura la intención antes de ejecutar y la respuesta final, enviándolas de forma asíncrona a ms-auditoria para su persistencia inmutable sanitizando credenciales y datos sensibles.],

  [INT-03],
  [*Políticas de Dispositivo Confiable y Control de Topes*],
  [Arantxa Marian Espejo Malagon],
  [ms-seguridad \
    ms-transacciones],
  [CU-17 \
    CU-18 \
    CU-19],
  [Garantizar que una operación financiera valide la huella de la terminal (fingerprint) contra ms-seguridad y no sobrepase el tope diario o por transacción establecido. Si el dispositivo no es confiable o el monto excede el límite, la transacción debe ser bloqueada o exigir 2FA.],

  [INT-04],
  [*Transferencia Bancaria Atómica Débito/Crédito*],
  [Salomon Alfredo Avila Larrotta],
  [ms-transacciones \
    ms-cuentas],
  [CU-30],
  [Probar que una transferencia entre cuentas del mismo banco mueva saldo de forma atómica: se debita la cuenta origen y se acredita la cuenta destino en una transacción coordinada. Si alguna de las operaciones falla o no hay saldo suficiente, se debita y acredita de forma atómica o se realiza rollback completo.],

  [INT-05],
  [*Transferencia ACH Interbancaria y Orquestación de Estados*],
  [Salomon Alfredo Avila Larrotta],
  [ms-transacciones \
    ms-cuentas \
    Mock ACH],
  [CU-26],
  [Validar la orquestación de transferencias interbancarias hacia otras entidades. ms-transacciones congela el saldo en ms-cuentas y coloca la transacción en estado PENDING hasta que el mock de compensación ACH responde SETTLED o REJECTED.],

  [INT-06],
  [*Pagos Físicos en Ventanilla y Consignaciones*],
  [Salomon Alfredo Avila Larrotta],
  [ms-transacciones \
    ms-cuentas],
  [CU-28],
  [Conciliación de depósitos presenciales en sucursal/cajero físico hacia cuentas bancarias. Las consignaciones en efectivo acreditan saldo inmediatamente en ms-cuentas; las consignaciones con cheque registran saldo retenido hasta liberación de canje.],

  [INT-07],
  [*Transferencia a Beneficiario Agendado*],
  [Miguel Francisco Vargas],
  [ms-cuentas \
    ms-transacciones],
  [CU-03 \
    CU-30],
  [Verificar que un beneficiario registrado en ms-cuentas (con alias, tipo y número de cuenta) pueda ser consumido por ms-transacciones al iniciar una transferencia sin necesidad de reingresar los datos bancarios.],

  [INT-08],
  [*Pago Inmediato mediante Código QR (Generación -> Pago)*],
  [Miguel Francisco Vargas],
  [ms-transacciones \
    ms-cuentas],
  [CU-25 \
    CU-30],
  [Flujo completo de pagos con QR: un comercio o usuario receptor genera un código QR firmado en ms-transacciones vinculado a su cuenta; el pagador lo escanea, decodifica el payload y autoriza el débito inmediato desde su cuenta en ms-cuentas.],

  [INT-09],
  [*Ciclo de Ahorro Automático y Posición Consolidada*],
  [Miguel Francisco Vargas],
  [ms-cuentas \
    ms-financiero],
  [CU-08 \
    CU-09 \
    CU-11],
  [Probar que una regla periódica de ahorro programado transfiera saldo desde la cuenta matriz hacia un bolsillo/subcuenta en ms-cuentas, y verificar que la vista de posición consolidada en ms-financiero reporte con precisión el saldo disponible vs. saldo ahorrado.],

  [INT-10],
  [*Apertura de Cuenta con Validación de Identidad*],
  [Juliana Sofia Novoa Solano],
  [ms-cuentas \
    ms-seguridad],
  [CU-06 \
    CU-07 \
    CU-15],
  [Validar que la apertura de cuentas corrientes o de ahorros consulte a ms-seguridad para verificar que el usuario exista, esté activo y cuente con los permisos necesarios antes de asignar el nuevo número de cuenta bancaria.],

  [INT-11],
  [*Aislamiento de Bolsillos (Subcuentas) vs. Saldo Disponible*],
  [Juliana Sofia Novoa Solano],
  [ms-cuentas \
    ms-transacciones],
  [CU-07 \
    CU-08 \
    CU-30],
  [Verificar que los fondos apartados en subcuentas o bolsillos queden blindados del saldo transaccional ordinario. Intentos de transferencia por montos superiores al disponible (aunque el total con bolsillos lo cubra) deben ser rechazados.],

  [INT-12],
  [*Emisión de Certificados Bancarios y Validación Pública*],
  [Juliana Sofia Novoa Solano],
  [ms-financiero \
    ms-cuentas],
  [CU-10],
  [ms-financiero consume los saldos y fechas de apertura reales desde ms-cuentas para generar certificados oficiales (saldos, tributarios). El documento incluye un hash/código de verificación que puede ser validado públicamente sin requerir sesión.],

  [INT-13],
  [*Constitución de CDT y Retención de Fondos*],
  [Samuel Beltrán Martínez],
  [ms-financiero \
    ms-cuentas],
  [CU-12 \
    CU-07],
  [Proceso de apertura de CDT en ms-financiero: se debitan los fondos de la cuenta de ahorros en ms-cuentas, se bloquea el capital durante el plazo pactado y se proyectan matemáticamente los rendimientos según la tasa EA vigente.],

  [INT-14],
  [*Desembolso de Préstamo y Cobro de Cuota*],
  [Samuel Beltrán Martínez],
  [ms-financiero \
    ms-cuentas \
    ms-transacciones],
  [CU-13 \
    CU-24],
  [Simulación, aprobación y desembolso de créditos en ms-financiero abonando el capital a la cuenta del cliente en ms-cuentas. Se genera la tabla de amortización y se prueba el cobro de la primera cuota mediante débito o pago programado.],

  [INT-15],
  [*Pago de Facturas y Desglose de Tributos (GMF / IVA)*],
  [Samuel Beltrán Martínez],
  [ms-transacciones \
    ms-cuentas],
  [CU-27 \
    CU-31],
  [Procesamiento del pago de recibos de servicios públicos y recargas en ms-transacciones, debitando de ms-cuentas y desglosando de manera transparente los intereses, IVA y gravamen a movimientos financieros (4x1000) aplicables.],

  [INT-16],
  [*Avance de Efectivo de Tarjeta de Crédito hacia Cuenta*],
  [Sara Rodríguez Urueña],
  [ms-tarjetas \
    ms-cuentas \
    ms-transacciones],
  [CU-21 \
    CU-23],
  [Operación de avance en ms-tarjetas: se reduce el cupo disponible de la tarjeta de crédito, se genera la transacción financiera diferida a cuotas y se abonan los fondos inmediatamente a la cuenta bancaria en ms-cuentas.],

  [INT-17],
  [*Bloqueo Preventivo de Tarjeta y Radicación de Disputa*],
  [Sara Rodríguez Urueña],
  [ms-tarjetas \
    ms-crm],
  [CU-20 \
    CU-05],
  [Al detectar una transacción sospechosa o por solicitud del usuario, se bloquea el plástico en ms-tarjetas y se radica automáticamente un ticket de reclamación/disputa en ms-crm. Intentos de pago posteriores con dicha tarjeta deben ser rechazados.],

  [INT-18],
  [*Despacho Multicanal de Alertas por Eventos Financieros*],
  [Sara Rodríguez Urueña],
  [Broker Kafka \
    ms-notificaciones],
  [CU-14],
  [Validar que ante eventos publicados en Kafka (transacciones por montos relevantes, bloqueos o inicios de sesión sospechosos), ms-notificaciones consuma el mensaje y despache la alerta según el canal preferido del usuario (SMS, Push o Correo).],
)

#set text(size: 11pt)

#pagebreak()

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
