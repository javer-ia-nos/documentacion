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

=== 14/10/2026 - Implementacion CU-19
En ms-seguridad, el usuario puede consultar y actualizar su límite diario y su límite por operación,
con validación de permisos y de que el tope por operación no supere al diario. Los cambios se publican 
en Kafka mediante el patrón transactional outbox y ms-core los aplica al validar las transferencias, 
controlando tanto el tope por operación como el acumulado diario. Ante el cambio de requerimiento, 
rediseñé el caso para que los límites sean por cuenta y no por usuario: actualicé la tabla de límites, 
las rutas y el evento de Kafka, la validación de ms-core (que ahora usa la cuenta de origen) y la web, 
donde agregué un selector de cuenta. También agregué MS_CORE_URL en el compose de integracion y actualicé 
el test de integración INT-04. Las pruebas automáticas pasan (38 en ms-seguridad y 107 en ms-core), y 
comprobé desde la web y en la base de datos que cada cuenta guarda y aplica sus propios límites. 
Los cambios se subieron a los repositorios de ms-seguridad, ms-core, web e integracion.

=== 26/10/2026 — Implementación CU-09 (Ahorro automático)
Implementé el ahorro automático en ms-core reutilizando el programador genérico
(`programador.ts`) que se hizo para CU-24, en vez de crear un planificador nuevo: registré el tipo
`AHORRO_AUTOMATICO` y el programador se encarga de la recurrencia y de ejecutar cada ciclo. El usuario
puede crear, editar, pausar, reanudar y cancelar un ahorro (frecuencia diaria, semanal o mensual) que
transfiere un monto fijo desde una de sus cuentas a otra, usando el servicio de transferencias de CU-30
con una clave de idempotencia por ciclo para que un reintento no duplique el movimiento. Si en un ciclo no
hay saldo, la cuenta está inactiva o se supera un límite de CU-19, el ciclo se omite y queda registrado,
pero el ahorro sigue activo para el siguiente. Cada resultado publica un evento por el patrón
transactional outbox (notificación al usuario y auditoría). Agregué la tabla `auto_saving_schedule`
con las columnas `subAccountId` y `savingsGoalId` ya previstas, para que CU-08 (subcuentas) pueda
usarlas en la siguiente iteración sin cambiar el esquema. Expuse el caso por gRPC (ms-core) y por
el API Gateway, y creé la pantalla `/ahorro-automatico` y el botón en el home. Las pruebas automáticas
pasan (14 nuevas de CU-09; ms-core queda en 369 en total, de las cuales fallan solo las ~40 de ISO 20022
que necesitan `xmllint` en Windows), y comprobé desde la web y en la base de datos que el ahorro
mueve los saldos, que el caso sin saldo se omite y que pausar, reanudar y cancelar funcionan.
Los cambios se subieron a ms-core, api-gateway, web e integracion.
#link("https://github.com/javer-ia-nos/ms-core/commit/XXXXXXX", "XXXXXXX")

=== 01/11/2026 — Implementación CU-18 (Gestión de seguridad de la cuenta)
Reimplementé en la v2 el cambio de contraseña y el segundo factor, que en la v1 ya había hecho con TOTP,
y construí la pantalla de seguridad que describe el grafo de navegación (`SeguridadCuentaScreen`).
En ms-seguridad agregué el módulo `seguridad-cuenta`: el cambio de contraseña pide la clave actual, valida
una política (mínimo 8 caracteres con mayúscula, minúscula y número) y cierra la sesión; el 2FA usa TOTP
(RFC 6238, verificado con los vectores de prueba de la RFC), se activa en dos pasos (generar el secreto
y confirmar con un código) y se desactiva pidiendo clave y código. El secreto se guarda cifrado con
AES-256-GCM en la columna `mfaSecret` que ya existía, así que no cambió el esquema. Con el 2FA activo, el login
responde `428` con `requiere2FA: true` si falta el código, y lo valida antes de registrar el dispositivo
(CU-17) para que un intento fallido no deje rastro. Una decisión de diseño fue responder `403` y no `401` cuando
la clave o el código son incorrectos con la sesión activa, porque la web cierra la sesión ante cualquier
`401`. Cada cambio publica `seguridad.cambio-cuenta` por outbox y ms-notificaciones lo convierte en una alerta
al usuario. En la web creé la página `/seguridad` (con enlaces a Dispositivos y Límites), el QR para la app
autenticadora y el campo del código en el login. Dejé fuera el bloqueo por intentos fallidos porque la
documentación no define si es automático o lo hace un administrador. Las pruebas pasan (29 nuevas en
ms-seguridad, que queda en 102, y 32 en ms-notificaciones) y lo probé desde la web con una app
autenticadora real y en la base de datos. Los cambios se subieron a ms-seguridad, ms-notificaciones y web.

=== 08/11/2026 — Implementación CU-01 (Historial de actividad y sesiones) e INT-02
Construí desde cero el microservicio ms-auditoria, que hasta ahora solo tenía el endpoint de salud, y con
él el CU-01 y la integración INT-02 (trazabilidad perimetral). ms-auditoria consume por Kafka los eventos
de los demás servicios (`auditoria.peticion`, `auditoria.respuesta`, `auditoria.evento-sesion`,
`auditoria.evento-transaccion`, `seguridad.dispositivo-nuevo`, `seguridad.cambio-cuenta`, entre otros) y los
guarda en la tabla `audit_logs`. Cada mensaje se identifica por `tópico:partición:offset`, así que si Kafka
lo reentrega no se duplica el registro, y antes de guardar se sanitiza todo lo sensible (contraseñas, tokens,
códigos de verificación). Para cumplir la inmutabilidad que pide INT-02 agregué triggers en la base de datos
que rechazan UPDATE, DELETE y TRUNCATE sobre la bitácora. Expone `GET /auditoria/actividad` (con filtros por
categoría y fechas, y paginación), `GET /auditoria/sesiones` y la consulta `GET /eventos/:usuarioId` del
diagrama de código; el usuario sale siempre del JWT, de modo que cada cliente solo ve lo suyo, y solo un
administrador puede consultar a otro usuario. En ms-seguridad el login exitoso, el login fallido (con el
motivo: clave o código 2FA incorrecto) y el logout publican `auditoria.evento-sesion` por el outbox; como
ms-seguridad no guarda sesiones (el JWT es sin estado), decidí derivar las "sesiones" de estos eventos y no
agregar una tabla nueva. El API Gateway ahora publica `auditoria.peticion` antes de ejecutar y
`auditoria.respuesta` al terminar, con el mismo `x-request-id`, sin guardar cuerpos, cabeceras ni query
string, y sin que una falla de Kafka afecte al cliente. En la web creé la pantalla `/historial` (pestañas
Actividad y Sesiones, filtros y paginación), enlazada desde `/seguridad`. Dejé fuera de esta entrega el
reporte regulatorio, la política de retención y la exportación que aparecen en el modelo E/R, porque
pertenecen al reporte de cumplimiento y no al CU-01, y decidí no registrar los intentos de acceso con un
usuario inexistente, porque no hay a quién atribuirlos. Las pruebas pasan (16 nuevas en ms-auditoria, 4 en
ms-seguridad y 6 en api-gateway; en el gateway sigue fallando un test de `x-user-id` que ya fallaba antes de
mis cambios) y probé el flujo completo con el stack levantado: el login, el intento fallido y el logout
aparecen en la pantalla y en la base de datos, y la bitácora rechaza el DELETE. Los cambios se subieron a
ms-auditoria, ms-seguridad, api-gateway, web e integracion.

=== 09/11/2026 — Implementación CU-25 (Generación y escaneo de códigos QR)
Implementé en ms-core el cobro y el pago con códigos QR. Quien cobra genera un QR vinculado a una de sus
cuentas, con monto fijo o abierto y una vigencia; el texto del QR va firmado con HMAC-SHA256 y lleva el id,
el comercio, el monto y el vencimiento, nunca el número de cuenta, así que un código alterado se rechaza
antes de tocar la base de datos. Quien paga lo escanea o pega su texto, ms-core valida firma, estado y
vencimiento, y el pago debita y acredita en una sola transacción de base de datos reutilizando lo de CU-30
y CU-19: movimientos idempotentes, topes por operación y diarios, y bloqueo de las filas para que dos pagos
simultáneos del mismo QR de monto fijo no se cobren dos veces. Un QR de monto fijo se cobra una sola vez y
uno abierto sigue activo hasta que venza o su dueño lo cancele. Agregué las tablas `qr_codes` y `qr_payments`
(el E/R solo traía `QRPayment`, así que `qr_codes` hay que sumarla a los diagramas) y el tipo de
transacción `QR_PAYMENT`, y el pago publica por outbox los eventos de auditoría (`PAGO_QR`, que CU-01 ya muestra
en el historial de actividad) y de notificación. Lo expuse por gRPC y por el API Gateway
(`/transacciones/qr`) y creé la pantalla `/qr` con las pestañas Pagar y Cobrar, el QR dibujado, el escaneo
con la cámara y la opción de pegar el código, además de la etiqueta del movimiento en el historial de la
cuenta. Las pruebas pasan (17 nuevas en ms-core, 7 en api-gateway y la prueba de integración INT-08, de la que
comprobé todo salvo la parte que depende de Kafka) y lo probé desde la web con dos usuarios y la cámara real.
Los cambios se subieron a ms-core, api-gateway, web e integracion.
