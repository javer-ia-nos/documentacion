== Evidencia de testabilidad y trazabilidad

Testabilidad significa poder controlar las entradas y dependencias, observar el resultado y el estado interno relevante, y repetir la prueba sin depender de datos residuales. La evidencia de cada caso de uso no es un único test: combina contratos validados por Elysia/TypeBox, pruebas unitarias con dobles, pruebas de integración que levantan dependencias reales y una verificación visible en la web.

#set text(size: 7.5pt)
#table(
  columns: (0.55fr, 1.25fr, 1.35fr, 1.35fr, 1.1fr),
  table.header(
    [*CU*],
    [*Superficie y dueño V2*],
    [*Control de dependencias / prueba unitaria*],
    [*Prueba de integración reproducible*],
    [*Evidencia visual*],
  ),

  [CU-12],
  [Productos; `web` + `ms-financiero/inversiones`],
  [`AccountPort`, `OwnerVerifier`, fecha de liquidación controlable; `ms-financiero/src/tests/cu12.test.ts`],
  [`integracion/tests/cu12.integration.test.ts`: gateway, seguridad, financiero, gRPC, PostgreSQL e idempotencia],
  [Rendimiento diario y simulación de vencimiento/abono en la misma web.],

  [CU-13],
  [Préstamos; `web` + `ms-financiero/prestamos`],
  [`LoanAccountPort` y doble para desembolso/débito; `ms-financiero/src/tests/cu13.test.ts`],
  [`integracion/tests/cu13.integration.test.ts`: solicitud, aprobación, cuotas y pago anticipado],
  [Solicitud, plan de cuotas, pago de cuota y liquidación en la web.],

  [CU-27],
  [Servicios; `web` + `ms-core/pagos-facturas`],
  [Pruebas de proveedor, idempotencia y reversión; `ms-core/src/tests/cu27-pagos-servicios.test.ts`],
  [`integracion/tests/cu27.integration.test.ts`: proveedor, débito, persistencia y outbox],
  [Consulta, confirmación y comprobante de pago en `/servicios`.],

  [CU-29],
  [Billeteras; `web` + `ms-tarjetas/billeteras`],
  [Provisionador externo sustituible; `ms-tarjetas/src/tests/cu29.test.ts`],
  [`integracion/tests/cu29.integration.test.ts`: gateway, tarjetas, sandbox y PostgreSQL.],
  [Vinculación, desvinculación y revocación en `/tarjetas/billeteras`; pendiente recorrido Playwright en `demo/`.],

  [CU-31],
  [Intereses e impuestos; `web` + `ms-financiero/costos`],
  [Servicio de cálculo puro e invariantes de total; `ms-financiero/src/tests/cu31.test.ts`],
  [`integracion/tests/cu31.integration.test.ts`: API y desglose consistente],
  [Simulador de costos en la web, sin crear una obligación real.],

  [CU-33],
  [Tarjetas y `/admin`; `web` + `ms-tarjetas/tarjetas`],
  [`RiskEvaluator` sustituible y roles cliente/analista; `ms-tarjetas/src/tests/cu33.test.ts`],
  [`integracion/tests/cu33.integration.test.ts`: solicitud, autorización y dictamen],
  [Cliente radica; analista revisa y aprueba/rechaza en `/admin`.],
)
#set text(size: 11pt)

=== Tácticas aplicadas

- *Control de entradas y estado:* Docker Compose de integración crea servicios y bases PostgreSQL aislados. Las migraciones idempotentes permiten repetir la preparación sin borrar datos útiles; los montos, referencias y fechas de prueba se declaran explícitamente.
- *Abstracción de dependencias:* CU-12 y CU-13 separan el cliente de cuentas mediante puertos; CU-29 desacopla el provisionador de billeteras; CU-33 desacopla la evaluación de riesgo. Esto permite usar dobles de prueba sin ocultar las pruebas de integración que ejercitan gRPC y PostgreSQL reales.
- *Observación de resultados:* las respuestas HTTP, los estados persistidos, los eventos outbox y los comprobantes visibles se validan como postcondiciones. Las rutas `/health`, los logs de Docker y CloudBeaver ayudan a inspeccionar el entorno local sin modificar la lógica de negocio.
- *Límite de no determinismo:* los cálculos de CU-31 son puros; CU-12 controla su fecha de liquidación. Las fuentes de tiempo, azar y proveedores deben inyectarse o sustituirse en las pruebas para que un fallo sea repetible.

=== GitHub Actions y Prometheus: responsabilidades distintas

GitHub Actions es la evidencia primaria de *testabilidad*: en cada cambio instala dependencias, ejecuta validación de tipos, formato, pruebas de Bun y reportes; el repositorio `integracion` además levanta el entorno Docker, espera sus health checks y ejecuta los flujos integrados de CU-12, CU-13, CU-27, CU-29, CU-31 y CU-33. Un fallo conserva los logs necesarios para diagnosticarlo.

Prometheus y Grafana son evidencia complementaria de *observabilidad en ejecución*. El despliegue actual de infraestructura observa nodos, pods, reinicios y disponibilidad de despliegues. No se declara como métrica de negocio ni como reemplazo de las pruebas: los microservicios Bun/Elysia todavía no exponen un endpoint `/metrics` propio. Instrumentar el Gateway con contadores y latencia, y descubrirlo con un `ServiceMonitor`, es una mejora posterior y debe validarse antes de afirmarla como implementada.

=== Regla de cierre por caso de uso

Un CU solo se considera terminado cuando su comportamiento, dueño V2, migración si aplica, prueba unitaria, prueba de integración, evidencia visual y flujo documentado aparecen en esta matriz. Para el recorrido de navegador se adopta Playwright de forma incremental en `integracion`: cada prueba debe usar datos propios, selectores accesibles, un único worker para no competir por saldos y traza/captura solo al fallar. Mientras se incorpora, los recorridos existentes de Bun.WebView siguen siendo la evidencia visual automatizada disponible.
