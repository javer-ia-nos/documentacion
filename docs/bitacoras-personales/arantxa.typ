== Bitacora de Arantxa Marian Espejo Malagon

=== 24/08/2026 — Diagrama de componentes de API Backend
Se elaboró el primer diagrama de componentes del backend (API Backend
Principal), basado en el diagrama de contenedores ya existente, cubriendo
los 8 módulos de negocio identificados en los casos de uso.
#link("https://github.com/javer-ia-nos/documentacion/commit/5f01bac", "5f01bac")

=== 25/08/2026 — Registro de diagrama de componentes
Se subió y registró el diagrama de componentes en el repositorio de
documentación.
#link("https://github.com/javer-ia-nos/documentacion/commit/edb2370", "edb2370")

=== 15/09/2026 — Diagramas de código (Auditoría y Transacciones)
Se crearon los primeros diagramas de código (nivel 4 C4) para los
contenedores de Auditoría y Transacciones, se corrigió el formato de los
diagramas de código y se eliminaron versiones anteriores obsoletas del
repositorio.
#link("https://github.com/javer-ia-nos/documentacion/commit/f520b8c", "f520b8c"),
#link("https://github.com/javer-ia-nos/documentacion/commit/150c575", "150c575")

=== 17/09/2026 — Diagrama de despliegue
Se elaboró el diagrama de vista física (deployment) del ambiente de
desarrollo, reflejando la estructura real de microservicios del equipo
(`ms-cuentas`, `ms-transacciones`, `ms-seguridad`, `ms-auditoria`, etc.)
más el `api-gateway` como punto de entrada.
#link("https://github.com/javer-ia-nos/documentacion/commit/8503453", "8503453")

=== 18/09/2026 — Primera versión de ms-seguridad
Se hizo el setup inicial del repositorio `ms-seguridad`: estructura de
carpetas (contracts, controllers, db, repositories, use-cases), corrección
del `README.md`, `package.json` y `compose.yml` (el repo había sido
copiado de la plantilla de `ms-financiero` sin renombrar), y esquema de
base de datos inicial.
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/cc4fae7", "cc4fae7")

=== 20/09/2026 — Alineación de nombres y reestructuración del modelo de datos
Se tradujo todo el esquema de base de datos y el código de `ms-seguridad`
de español a inglés (tablas, columnas, tipos), siguiendo la convención
acordada con el equipo. Posteriormente se reestructuró el modelo de datos
completo para calzar exactamente con el ER oficial documentado
(`authSeguridad_er.png`): separación de `users`/`credentials`, tabla
`sessions` para revocación de tokens, `user_roles` como relación N:M
(soporte de múltiples roles por usuario), y `transaction_limits` genérico
por tipo de límite. Se documentó la decisión en `ADR-01-autenticacion-jwt.md`.
#link("https://github.com/javer-ia-nos/documentacion/commit/c09082b", "c09082b"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/62f156e", "62f156e"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/3522cf8", "3522cf8")

=== 21/09/2026 — Integración con ui-shared, migración a Kafka, CU-01 y pruebas de integración
Día de mayor volumen de trabajo, con varios hitos:

- *Alineación de contrato con `ui-shared`*: se descubrió que el frontend ya
  esperaba un contrato distinto (`/limites`, `/dispositivos` en español,
  forma de respuesta de login específica) — se ajustaron los controladores
  y contratos de `ms-seguridad` para calzar exactamente, sin tocar el
  esquema interno de datos.
- *Fusión con CU-17 (dispositivos confiables)*: se integró el trabajo de
  Salomón Ávila (`device.repository.ts`, `device-trust.repository.ts`,
  `device.usecase.ts`) mediante un controlador de traducción en español
  (`dispositivos.controller.ts`) que expone el contrato esperado por
  `ui-shared`.
- *Migración a mensajería asíncrona (Kafka)*: se reemplazó el cliente HTTP
  directo hacia `ms-auditoria` por un productor Kafka (`eventos.client.ts`),
  siguiendo el mismo patrón ya usado por `ms-transacciones` (tópico
  `auditoria.evento-seguridad`).
- *Implementación de CU-01 en `ms-auditoria`*: esquema de datos fiel al ER
  (`AuditLog`, `AuditDetail`), consumidor Kafka (`eventos.consumer.ts`) con
  mappers por tópico de origen, y endpoints de consulta de historial
  (`GET /eventos/:usuarioId`).
- *Corrección de bugs de integración en `api-gateway`*: se encontró que
  `securityService.ts` leía un campo inexistente del JWT (`payload.rol` en
  vez de `payload.roles`) y que `auditService.ts` era un mock que nunca
  llamaba a `ms-auditoria` — se corrigieron ambos (recomendación entregada
  al responsable del repo, sin modificarlo directamente).
- *Pruebas de integración INT-01, INT-02 e INT-03* (asignadas según el Plan
  Maestro de `dev.typ`): escritas en el repositorio `integracion`, alineadas
  con las convenciones reales del equipo (credenciales `test@banco.com` /
  `Prueba123!`, sin broker de mensajería en el ambiente de pruebas). INT-03
  quedó con la validación del lado de `ms-transacciones` pendiente de
  confirmar contrato con el responsable de ese servicio.
- *Corrección de bugs de serialización de fechas*: se encontraron y
  corrigieron dos bugs relacionados (fechas pasadas como objeto `Date` en
  vez de ISO string, y falta de restricción `UNIQUE` en `transaction_limits`
  para SQLite) que causaban fallos intermitentes en las pruebas.

#link("https://github.com/javer-ia-nos/ms-seguridad/commit/e97dd26", "e97dd26"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/1c4c5a4", "1c4c5a4"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/3aee343", "3aee343"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/ea24fbb", "ea24fbb"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/253875d", "253875d"),
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/5a14fa7", "5a14fa7"),
#link("https://github.com/javer-ia-nos/ms-auditoria/commit/3bf63d2", "3bf63d2"),
#link("https://github.com/javer-ia-nos/ms-auditoria/commit/11e7db7", "11e7db7"),
#link("https://github.com/javer-ia-nos/integracion/commit/7d1dabb", "7d1dabb")

=== 22/09/2026 — Implementación de 2FA (TOTP) y cierre de cobertura de pruebas
Se implementó el segundo factor de autenticación (CU-18) usando TOTP
(RFC 6238, compatible con Google Authenticator): generación de secreto,
código QR (`otpauth://`), activación en dos pasos (generar + confirmar), y
exigencia del código en el login una vez activado (`428 Precondition
Required` con `requiere2FA: true` si falta). Se cerraron los huecos de
cobertura de pruebas detectados con `bun test --coverage`: caso de uso de
roles (CU-16) que no tenía ningún test, casos de error 404 en límites y
dispositivos, y se eliminó código muerto (funciones de repositorio sin
ningún uso real). Cobertura final: 96% de funciones, 95% de líneas.
#link("https://github.com/javer-ia-nos/ms-seguridad/commit/1e059dd", "1e059dd"),
#link("https://github.com/javer-ia-nos/documentacion/commit/6b1be23", "6b1be23")
