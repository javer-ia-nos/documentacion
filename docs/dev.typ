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
  [Asegurar que cada interacción cliente genere trazas con x-request-id y x-correlation-id. El Gateway captura la intención antes de ejecutar y la respuesta final, publicándolas de forma asíncrona en Kafka (`auditoria.peticion` y `auditoria.respuesta`) para que ms-auditoria las consuma y persista de forma inmutable sanitizando credenciales y datos sensibles.],

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
  [Probar que una transferencia entre cuentas del mismo banco mueva saldo de forma atómica: se debita la cuenta origen y se acredita la cuenta destino en una transacción coordinada. Si alguna de las operaciones falla o no hay saldo suficiente, no se aplica ningún movimiento neto: la solicitud se rechaza antes del débito o se compensa el débito ya aplicado (SAGA), y ambos saldos quedan intactos.],

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
    ms-core],
  [CU-10],
  [ms-financiero consume los saldos y fechas de apertura reales desde el módulo de Cuentas de ms-core para generar certificados oficiales (saldos, tributarios). El documento incluye un hash/código de verificación que puede ser validado públicamente sin requerir sesión.],

  [INT-13],
  [*Constitución de CDT y Retención de Fondos*],
  [Samuel Beltrán Martínez],
  [ms-financiero \
    ms-core],
  [CU-12 \
    CU-07],
  [Proceso de apertura de CDT en ms-financiero: se debitan los fondos de la cuenta en el módulo de Cuentas de ms-core, se bloquea el capital durante el plazo pactado y se proyectan los rendimientos según la tasa EA vigente.],

  [INT-14],
  [*Desembolso de Préstamo y Cobro de Cuota*],
  [Samuel Beltrán Martínez],
  [ms-financiero \
    ms-core],
  [CU-13 \
    CU-24],
  [Simulación, aprobación y desembolso de créditos en ms-financiero abonando el capital a la cuenta del cliente en ms-core. Se genera la tabla de amortización y se prueba el cobro de cuota, abono anticipado y liquidación total.],

  [INT-15],
  [*Pago de Facturas y Desglose de Tributos (GMF / IVA)*],
  [Samuel Beltrán Martínez],
  [ms-core \
    ms-financiero],
  [CU-27 \
    CU-31],
  [Procesamiento idempotente de recibos de servicios en el módulo de pagos de facturas de ms-core, debitando desde el mismo servicio y validando la respuesta del proveedor; CU-31 expone en ms-financiero el desglose de capital, interés e impuestos aplicables.],

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

  [INT-19],
  [*Ciclo de Vida de Dispositivos Confiables*],
  [Salomon Alfredo Avila Larrotta],
  [API Gateway \
    ms-seguridad \
    Broker Kafka],
  [CU-17],
  [Verificar que cada inicio de sesión desde un dispositivo nuevo (identificado por el encabezado `x-device-fingerprint`) lo registre y emita `seguridad.dispositivo-nuevo`; que el usuario lo consulte y lo enrole como confiable confirmando su contraseña (con vigencia opcional); y que al revocarlo el API Gateway rechace con 401 los tokens emitidos a ese dispositivo mientras los de los demás siguen válidos, publicando `seguridad.dispositivo-revocado` por _outbox_.],
)

#set text(size: 11pt)

#pagebreak()

== Arquitectura de Pruebas: Repositorio Dedicado de Integración (`integracion`)

Para eliminar por completo los *mocks* y probar la interacción real de las APIs tal como ocurrirá en producción, la suite de integración vive en un repositorio independiente: *`integracion`*.

=== 1. Principio Operativo: Cero Mocks y Contenedores GHCR

1. Cada microservicio compila y publica su imagen Docker oficial en GitHub Container Registry (`ghcr.io/javer-ia-nos/<servicio>:latest`) mediante su flujo de CI en `.github/workflows/docker-publish.yaml`.
2. El repositorio `integracion` contiene un `docker-compose.yml` que orquesta la flota en modo prueba:
  - *Borde:* `api-gateway` (puerto `4860`).
  - *Microservicios e infraestructura:* Los 7 microservicios del banco (`ms-core` —que unifica Cuentas y Transacciones—, `ms-seguridad`, `ms-financiero`, `ms-tarjetas`, `ms-crm`, `ms-notificaciones` y `ms-auditoria`), el frontend `web`, una instancia PostgreSQL dedicada por servicio inicializada con su `seed.sql`, un broker Apache Kafka (KRaft) y el simulador de pagos externos (`banca-mock-pagos-externos`).
3. Los tests de integración se ejecutan desde fuera de los contenedores como un cliente HTTP real (Black Box Testing), consumiendo las rutas a través del API Gateway (`http://localhost:4860`) o directamente al servicio evaluado.

=== 2. Estructura del Repositorio `integracion`

```
integracion/
├── docker-compose.yml            # Levanta Gateway, Web, los 7 microservicios, Postgres y Kafka
├── docker-compose.cu12-tests.yml # Stack aislado para CU-12, CU-13, CU-27, CU-31 y CU-33
├── package.json                  # Scripts de orquestación y runner de Bun
├── README.md                     # Instrucciones de uso para el equipo
├── src/
│   └── tests/                    # Suite principal E2E (19 archivos HTTP, gRPC, Kafka y Bun.WebView)
│       ├── int-04-cu30-transferencias.test.ts
│       ├── int-05-cu26-transferencias-externas.test.ts
│       ├── int-08-cu25-qr.test.ts
│       ├── int-09-cu09-ahorro-automatico.test.ts
│       └── ...
└── tests/                        # Pruebas de integración aisladas (CU-12, CU-13, CU-27, CU-31, CU-33)
```

=== 3. Anatomía de un Test de Integración E2E (Sin Mocks)

Cada archivo de prueba utiliza `bun:test` y `fetch` estándar hacia el Gateway real:

```typescript
import { describe, it, expect, beforeAll } from "bun:test";

const GATEWAY_URL = process.env.GATEWAY_URL ?? "http://localhost:4860";

describe("INT-04: Transferencia Bancaria Atómica (ms-transacciones <-> ms-cuentas)", () => {
  let tokenAuth: string;
  let cuentaOrigen: string;
  let cuentaDestino: string;
  const SALDO_ORIGEN = 500_000;
  const SALDO_DESTINO = 100_000;
  const MONTO = 150_000;

  const auth = () => ({
    "Content-Type": "application/json",
    Authorization: `Bearer ${tokenAuth}`,
  });

  const abrirCuenta = async (userId: string, depositoInicial: number) => {
    const res = await fetch(`${GATEWAY_URL}/cuentas/ahorros`, {
      method: "POST",
      headers: auth(),
      body: JSON.stringify({ userId, depositoInicial }),
    });
    expect(res.status).toBe(201);
    return ((await res.json()) as any).id as string; // UUID real
  };

  const saldo = async (id: string) => {
    const res = await fetch(`${GATEWAY_URL}/cuentas/${id}/saldo`, { headers: auth() });
    return ((await res.json()) as any).saldoDisponible as number;
  };

  beforeAll(async () => {
    // 1. Autenticarse en ms-seguridad a través del Gateway
    const loginRes = await fetch(`${GATEWAY_URL}/seguridad/auth/login`, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ email: "test@banco.com", password: "Prueba123!" }),
    });
    const loginData = (await loginRes.json()) as any;
    tokenAuth = loginData.token;

    // 2. Crear dos cuentas reales del mismo titular en ms-cuentas
    cuentaOrigen = await abrirCuenta(loginData.user.id, SALDO_ORIGEN);
    cuentaDestino = await abrirCuenta(loginData.user.id, SALDO_DESTINO);
  });

  it("Debe debitar la cuenta origen y acreditar la cuenta destino de forma atómica", async () => {
    // 3. Disparar la transferencia real entre cuentas propias
    const res = await fetch(`${GATEWAY_URL}/transacciones/transferencias`, {
      method: "POST",
      headers: { ...auth(), "x-correlation-id": "corr-int-04-real" },
      body: JSON.stringify({ cuentaOrigen, cuentaDestino, monto: MONTO, esPropia: true }),
    });

    expect(res.status).toBe(201);
    const data = (await res.json()) as any;
    expect(data.estado).toBe("COMPLETED");
    expect(data.numeroComprobante).toBeDefined();

    // 4. Certificar la consistencia contable en ms-cuentas
    expect(await saldo(cuentaOrigen)).toBe(SALDO_ORIGEN - MONTO);
    expect(await saldo(cuentaDestino)).toBe(SALDO_DESTINO + MONTO);
  });

  it("Debe rechazar sin mover saldo si el monto excede el saldo disponible", async () => {
    const res = await fetch(`${GATEWAY_URL}/transacciones/transferencias`, {
      method: "POST",
      headers: auth(),
      body: JSON.stringify({ cuentaOrigen, cuentaDestino, monto: 999_999_999, esPropia: true }),
    });

    expect(res.status).toBe(400);
    expect(await saldo(cuentaOrigen)).toBe(SALDO_ORIGEN - MONTO);
    expect(await saldo(cuentaDestino)).toBe(SALDO_DESTINO + MONTO);
  });
});
```

=== 4. ¿Cómo ejecutar y probar la suite?

==== Modo 1: Ejecución completa en un solo comando (Recomendado para CI y pruebas generales)
Descarga las imágenes más recientes de GHCR, levanta los contenedores en segundo plano, corre las pruebas secuencialmente (`bun test --parallel=1`) y luego desmonta el entorno:
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
  bun test src/tests/int-04-cu30-transferencias.test.ts
  ```
3. Si necesitas ver los logs de un servicio en vivo (ej. `ms-core`):
  ```bash
  docker compose logs -f ms-core
  ```
4. Al terminar tu jornada de pruebas, apaga el entorno:
  ```bash
  bun run down
  ```

#pagebreak()

== Comunicación gRPC entre microservicios

Las llamadas síncronas entre servicios (las que necesitan respuesta inmediata, como saldo, débito, crédito o verificación de dispositivo) usan gRPC. Todo lo demás viaja por Kafka mediante la tabla _outbox_ de cada servicio. Elysia sigue atendiendo el HTTP que llega del API Gateway; el servidor gRPC corre en el mismo proceso pero en su propio puerto, sin pasar por Elysia.

=== Librerías

- *`@grpc/grpc-js`*: implementación oficial de gRPC para JavaScript, en JavaScript puro, por lo que funciona en Bun y en el binario de `bun build --compile`. Se verificó en Bun 1.4.2: llamadas unarias, los tres tipos de _streaming_, plazos, cancelación, metadatos, códigos de error, compresión, balanceo `round_robin` y reintentos.
- *`ts-proto`*: genera desde el `.proto` el código TypeScript con los mensajes tipados y los stubs de cliente y servidor para `grpc-js`. La generación usa *`@bufbuild/buf`*, instalado por npm, sin necesidad de `protoc` en el sistema.

=== Contratos `.proto`

- El contrato canónico vive en el repositorio del servicio que lo implementa: `ms-core/proto/core.proto`. Los clientes, como `api-gateway`, guardan una copia idéntica.
- Después de cambiar un `.proto`, regenerar con `bun run proto:gen` y versionar el código generado (`src/grpc/generated/`). `bun run proto:check` avisa si la copia de un cliente quedó desalineada respecto a la canónica.
- Los montos viajan como texto decimal (`"150000.00"`), nunca como número de punto flotante.
- Códigos de error: `NOT_FOUND` (no existe), `FAILED_PRECONDITION` (rechazo definitivo: no se aplicó nada) y `UNAUTHENTICATED` (falta el token interno). Cualquier otro código significa un resultado incierto: se reintenta con la misma clave de idempotencia y, si persiste, la transferencia pasa a compensación.

=== Claves de idempotencia del CU-30

Cada movimiento en Cuentas lleva la clave `<transactionId>:debit`, `<transactionId>:credit` o `<transactionId>:compensation`. Repetir una llamada con la misma clave devuelve el resultado original sin mover saldo otra vez, así que reintentar es seguro.

=== Variables de entorno

#table(
  columns: (auto, 1fr),
  [*Variable*], [*Uso*],
  [`GRPC_PORT`], [Puerto del servidor gRPC (50051) en `ms-core`.],
  [`CORE_GRPC_URL`], [Destino de los clientes gRPC (ej. `api-gateway` y `ms-financiero`). En el clúster: `dns:///ms-core-grpc.<namespace>.svc.cluster.local:50051` (Service _headless_, balanceo `round_robin`); en local: `localhost:50051`.],
  [`INTERNAL_SERVICE_TOKEN`], [Token interno de servicio que viaja en el metadato `x-internal-token`. Sin él, los servidores responden `UNAUTHENTICATED`. En el clúster sale de Ansible Vault; en local, cualquier valor igual en ambos servicios.],
  [`KAFKA_BROKERS`], [Brokers de Kafka para el _relay_ del _outbox_ y los consumidores. Si no está definida, los eventos quedan pendientes en la tabla _outbox_ y no se pierden.],
)

=== Probar un servidor gRPC a mano

Cuando el servidor tiene _reflection_ habilitado se puede usar `grpcurl`. Si no, se le pasa el `.proto`:

```bash
grpcurl -plaintext -import-path proto -proto core.proto \
  -H "x-internal-token: $INTERNAL_SERVICE_TOKEN" \
  -d '{}' \
  localhost:50051 javerianos.core.v1.CoreService/ListarCuentas
```
