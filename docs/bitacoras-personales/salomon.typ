#let version = sys.inputs.at("version", default: "main")
#let git_base_url = "https://github.com/javer-ia-nos/Documentacion/tree/" + version
#let commit_url = "https://github.com/javer-ia-nos/Documentacion/commit/"
#let git_transacciones_base_url = "https://github.com/javer-ia-nos/ms-transacciones/tree/main"
#let commit_transacciones_url = "https://github.com/javer-ia-nos/ms-transacciones/commit/"
#let git_financiero_base_url = "https://github.com/javer-ia-nos/ms-financiero/tree/main"
#let commit_financiero_url = "https://github.com/javer-ia-nos/ms-financiero/commit/"
#let git_ui_shared_base_url = "https://github.com/javer-ia-nos/ui-shared/tree/main"
#let commit_ui_shared_url = "https://github.com/javer-ia-nos/ui-shared/commit/"
#let git_web_base_url = "https://github.com/javer-ia-nos/web/tree/main"
#let commit_web_url = "https://github.com/javer-ia-nos/web/commit/"
#let git_mobile_base_url = "https://github.com/javer-ia-nos/mobile/tree/main"
#let commit_mobile_url = "https://github.com/javer-ia-nos/mobile/commit/"
#let git_infra_base_url = "https://github.com/javer-ia-nos/infra/tree/main"
#let commit_infra_url = "https://github.com/javer-ia-nos/infra/commit/"
#let commit_cuentas_url = "https://github.com/javer-ia-nos/ms-cuentas/commit/"
#let commit_auditoria_url = "https://github.com/javer-ia-nos/ms-auditoria/commit/"
#let commit_crm_url = "https://github.com/javer-ia-nos/ms-crm/commit/"
#let commit_notificaciones_url = "https://github.com/javer-ia-nos/ms-notificaciones/commit/"
#let commit_seguridad_url = "https://github.com/javer-ia-nos/ms-seguridad/commit/"
#let commit_tarjetas_url = "https://github.com/javer-ia-nos/ms-tarjetas/commit/"

== Bitácora de Salomon Alfredo Avila Larrotta

Registro de contribuciones al diseño y la documentación de la arquitectura del
Sistema Bancario. Cada entrada indica fecha y hora, las personas involucradas,
su tipo, una descripción del trabajo (con el proceso ADD cuando corresponde a
una decisión de diseño) y las tareas pendientes que haya dejado abiertas.

=== Categorías de entrada

- *Decisión de diseño*: selección de un estilo, patrón, tecnología o proceso
  arquitectónico. Se documenta según el método ADD: drivers, conceptos de
  diseño analizados, diagramas preliminares y análisis preliminar de
  resultados.
- *Diagrama / Modelado*: creación o modificación de un diagrama C4, E/R o de
  proceso que no involucra una decisión arquitectónica nueva, sino la
  representación de una ya tomada.
- *Implementación*: desarrollo de código de backend, frontend o
  infraestructura que materializa una decisión de diseño previa.
- *DevOps / Infraestructura*: configuración de CI/CD, aprovisionamiento de
  servidores o despliegue.
- *Documentación*: redacción de secciones del documento de arquitectura o de
  la bitácora.
- *Corrección*: ajuste de un artefacto existente (diagrama, workflow, código)
  sin cambiar la decisión de fondo que lo originó.
- *Reunión / Colaboración*: discusión conjunta con el equipo sobre el diseño.

=== Iteración 1: Diagrama de contexto del sistema en C4 nivel 1

*Fecha y hora:* 21 de agosto de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + Diagrama / Modelado \
*Commit:* #link(commit_url + "344e80a315307f68a30e199e54b45399e2e39496", [344e80a · «Primera iteracion SystemContext»])

==== Descripción

*Drivers:* construir el primer diagrama C4 de _System Context_ del Sistema
Bancario a partir de los casos de uso CU-01 a CU-30 y de los requisitos
arquitectónicos ASR-01 a ASR-06, con trazabilidad explícita entre cada
elemento del diagrama y los requisitos que lo justifican.

*Conceptos de diseño analizados:* se evaluó modelar el diagrama como código
con #link("https://goa.design/model/", [goa.design/model]) (C4 versionable en
Go, revisable por _pull request_) frente a herramientas gráficas tipo
draw.io.

*Diagramas preliminares:* se reescribió la plantilla de ejemplo _Big Bank
plc_ al dominio del proyecto en `diagrams/test/model.go`, definiendo como
actores al Cliente bancario y al Agente de Atención al Cliente, como sistema
en alcance al Sistema de Banca Digital y seis sistemas externos, con cada
relación anotada con los CU y ASR que la originan. Se acotó el modelo al
nivel 1 de C4 y se definieron estilos por _tag_ para persona, interno y
externo.

*Análisis preliminar de resultados:* el `model.go` resultante era compilable
y generaba `diagrams/gen/SystemContext.svg`, pero días después el equipo
migró los diagramas a
#link(git_base_url + "/docs/diagrams", [draw.io]) por problemas de
compatibilidad de la herramienta; el contenido se trasladó a
#link(git_base_url + "/docs/diagrams/system-context.drawio", [system-context.drawio]).

=== Iteración 2: Notación C4 y limpieza de los tres diagramas

*Fecha y hora:* 1 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:* #link(commit_url + "fd587dffee96f94bfb3b9fd067770ad6a7628fcf", [fd587df · «Cambio visual de diagramas»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/system-context.png", [system-context.png]),
#link(git_base_url + "/docs/diagrams/container-view.png", [container-view.png]),
#link(git_base_url + "/docs/diagrams/components/component-backend.png", [component-backend.png])

==== Descripción

Objetivo: alinear los tres diagramas C4 de contexto, contenedores y
componentes con la notación oficial de
#link("https://c4model.com/", [c4model.com]) y corregir las inconsistencias
acumuladas entre ellos.

En el diagrama de contexto se añadió la persona _Cajero_, encargada de las
operaciones de ventanilla del caso de uso CU-28. Se amplió «Agente de
Atención al Cliente» a _Personal del Banco de soporte y backoffice_, se
renombró el sistema a _Sistema Bancario_ y se reubicaron actores y flechas
para que las etiquetas no se solaparan. Se normalizó la paleta a los colores
canónicos de C4 (`#08427B` persona, `#1168BD` sistema en alcance, `#999999`
externos), se aplicó la notación _outline_ en las tres vistas y se
codificaron los sistemas externos por categoría de color (notificaciones,
pagos y recaudo, riesgo y cumplimiento), con una leyenda por diagrama. Se
corrigieron elementos huérfanos y etiquetas duplicadas en `component-view` y
`container-view`. Se mantuvieron los seis sistemas externos porque siguen
respaldados por ASR-04, CU-13, CU-26, CU-27 y CU-29.

==== Tareas asignadas

Reestructurar `container-view` y `component-view` para la arquitectura de
microservicios prevista, con API Gateway, servicios de saldos y cuentas,
productos, autenticación y dispositivos, auditoría y transferencias,
mensajería con Kafka y sistema de cajeros.

=== Iteración 3: Actualización requerida del diagrama de contexto

*Fecha y hora:* 7 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta (discusión y
definición de actores), Samuel Beltrán Martínez (integró el cambio) \
*Tipo de entrada:* Reunión / Colaboración \
*Commit:* #link(commit_url + "68915d3b1141f9510276200b190764d03976fb90", [68915d3 · «Actualizacion requerida del diagrama de contexto»])

==== Descripción

Objetivo: ampliar el diagrama de contexto con los actores de banca
empresarial y de sucursal que faltaban, para reflejar todos los
interlocutores del Sistema Bancario antes de redactar la sección de
stakeholders.

Contribución en el proceso creativo, sin código mergeado propio. Participé en
la discusión y definición de los nuevos actores que se incorporaron a
`system-context.drawio`: persona jurídica, personal de atención al cliente
virtual, asesor comercial, funcionario de créditos, jefe de la sucursal,
especialista en comercio exterior, gerente de banca corporativa y ejecutivo
de relación, junto con su descripción y sus relaciones con el sistema. El
cambio lo integró Samuel Beltrán. Este diagrama quedó como base directa de la
Iteración 4.

=== Iteración 4: Primera versión de «Stakeholders e intereses»

*Fecha y hora:* 7 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Documentación \
*Commit:* #link(commit_url + "c82edafe9ba94adb2df6f2209acbd2a794b616e5", [c82edaf · «Agregar primera version de los stakeholders»]) \
*Archivos:* #link(git_base_url + "/docs/arch-description.typ", [arch-description.typ])

==== Descripción

Objetivo: redactar la primera versión de la sección _Stakeholders e
intereses_ del documento de arquitectura, alineada con el diagrama de
contexto.

Se completó la tabla de stakeholders con las columnas de rol, información de
contacto e intereses o expectativas, tomando como base únicamente las
personas que interactúan con el sistema según `system-context.drawio`:
persona natural y jurídica, cajero, personal de atención al cliente
presencial y virtual, asesor comercial, funcionario de créditos, jefe de la
sucursal, especialista en comercio exterior, gerente de banca corporativa y
ejecutivo de relación. Se dejaron fuera los sistemas externos y los
stakeholders del proyecto académico. Cada interés se redactó a partir de la
descripción y las relaciones del actor en el diagrama de contexto.

==== Tareas asignadas

Cerrar la trazabilidad de los roles corporativos y de sucursal, que aún no
tienen CU ni ASR que los respalde.

=== Iteración 5: Primera iteración de diagramas E/R

*Fecha y hora:* 14 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:* #link(commit_url + "42801991d741fa15d435213a2788d421a0ef4c7e", [4280199 · «Primera iteracion de diagramas E/R»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/er/authSeguridad_er.drawio", [authSeguridad_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/cuentas_er.drawio", [cuentas_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/tarjetas_er.drawio", [tarjetas_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/transacciones_er.drawio", [transacciones_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/financiero_er.drawio", [financiero_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/crm_er.drawio", [crm_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/notificaciones_er.drawio", [notificaciones_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/auditoria_er.drawio", [auditoria_er.drawio])

==== Descripción

Objetivo: diseñar los diagramas Entidad-Relación de las bases de datos de
cada uno de los ocho microservicios del backend, normalizados a tercera
forma normal y con trazabilidad a los componentes definidos en
`component-backend.drawio`.

Se crearon ocho diagramas draw.io en `docs/diagrams/er/`, uno por
microservicio: Autenticación y Seguridad, Cuentas, Tarjetas, Transacciones,
Financiero, CRM, Notificaciones y Auditoría. Cada diagrama usa el formato de
tabla relacional con columnas de indicador PK/FK, nombre de atributo en
_camelCase_ y tipo de dato SQL. Las claves primarias son UUID y se incluyen
llaves foráneas a sistemas externos donde corresponde. Las entidades se
clasifican por color: azul claro para tablas principales, verde para
catálogos, amarillo para tablas puente M:N y morado para referencias a
sistemas externos. Las relaciones usan notación _crow's foot_ con
cardinalidades explícitas.

==== Tareas asignadas

Revisar los esquemas con el equipo y generar los scripts DDL a partir de
estos diagramas.

=== Iteración 6: Corrección del rango CU-31 en los diagramas de componentes

*Fecha y hora:* 14 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Corrección \
*Commit:* #link(commit_url + "e44327a7055bea1ce41881b4b6d7e48a8690e979", [e44327a · «Arreglo en diagramas de componentes, no se contemplaba el CU-31»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/components/component-backend.drawio", [component-backend.drawio]),
#link(git_base_url + "/docs/diagrams/components/component-web.drawio", [component-web.drawio]),
#link(git_base_url + "/docs/diagrams/components/component-mobile.drawio", [component-mobile.drawio])

==== Descripción

Objetivo: corregir el rango de casos de uso declarado por el componente
Transacciones, que la tabla de casos de uso ya ubicaba en el CU-31 sin que
los diagramas de componentes lo reflejaran.

Se comparó cada uno de los ocho componentes del backend contra los treinta y
un casos de uso del sistema y se encontró que Transacciones se describía
como CU-24 a CU-30 en los tres diagramas de componentes. Se amplió el texto
a CU-24 a CU-31 en los tres archivos.

=== Iteración 7: Entidad AutoSavingSchedule en el diagrama E/R de Cuentas

*Fecha y hora:* 14 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:* #link(commit_url + "830e86b51453acb91516ca0226705e08eb818a92", [830e86b · «Fix del diagrama ER para soportar el ahorro automatico»]) \
*Archivos:* #link(git_base_url + "/docs/diagrams/er/cuentas_er.drawio", [cuentas_er.drawio])

==== Descripción

Objetivo: cerrar el vacío del modelo de datos de Cuentas, que aún no tenía
ninguna tabla capaz de persistir la programación de ahorro automático del
CU-09.

Se agregó la tabla AutoSavingSchedule con el monto, la frecuencia, la
próxima fecha de ejecución y las referencias a la cuenta origen y al destino
en subcuenta o meta de ahorro, junto con sus relaciones hacia Account,
SubAccount y SavingsGoal.

=== Iteración 8: Primera iteración del diagrama dinámico de ahorro automático

*Fecha y hora:* 14 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:* #link(commit_url + "480ee1b731d33dba63ef79d38cfd85d5f4f6e4f4", [480ee1b · «Primera iteracion del diagrama de ahorro automatico»]) \
*Archivos:* #link(git_base_url + "/docs/diagrams/processes/programacion-ahorro-automatico.drawio", [programacion-ahorro-automatico.drawio])

==== Descripción

Objetivo: modelar el comportamiento del CU-09 en la sección de vista de
procesos mediante un C4 Dynamic Diagram en estilo secuencia.

Se creó el primer diagrama dinámico en `diagrams/processes`, con el cliente
bancario, la aplicación, los componentes de Cuentas, Transacciones,
Auditoría y Notificaciones, la base de datos transaccional y el proveedor de
notificaciones como participantes. El flujo numerado cubre la configuración
de la programación y su ejecución automática mediante un disparador interno,
con una nota sobre el caso de saldo insuficiente.

==== Tareas asignadas

Enlazar este diagrama desde `arch-description.typ`.

=== Iteración 9: Diagramas dinámicos de procesos restantes

*Fecha y hora:* 14 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:*
#link(commit_url + "c02eea6e6aafe36a5daf81048d7fdd53c68e305f", [c02eea6 · «CDT e inversiones»]),
#link(commit_url + "9290df6a5a3d18b65877ddd058d4e3d59dc49419", [9290df6 · «Gestión de préstamos»]),
#link(commit_url + "21f2d003c4eb7996af0211be1eacb7500d3ed488", [21f2d00 · «Pago de facturas de servicios»]),
#link(commit_url + "2a2ba7950cffbd8b71596932982a6041d35e5b21", [2a2ba79 · «Transferencias nacionales e internacionales»]),
#link(commit_url + "010fb0d2372c93b845612d6f9b9a237f7461f525", [010fb0d · «Transferencias cuentas propias y terceros»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/processes/solicitud-cdt-inversiones.drawio", [solicitud-cdt-inversiones.drawio]),
#link(git_base_url + "/docs/diagrams/processes/solicitud-gestion-prestamos.drawio", [solicitud-gestion-prestamos.drawio]),
#link(git_base_url + "/docs/diagrams/processes/pago-facturas-servicios.drawio", [pago-facturas-servicios.drawio]),
#link(git_base_url + "/docs/diagrams/processes/gestion-transferencias-internacionales-nacionales.drawio", [gestion-transferencias-internacionales-nacionales.drawio]),
#link(git_base_url + "/docs/diagrams/processes/transferencias-cuentas-propias-terceros.drawio", [transferencias-cuentas-propias-terceros.drawio])

==== Descripción

Objetivo: completar la vista de procesos con un C4 Dynamic Diagram en estilo
secuencia para cada uno de los casos de uso críticos restantes de Financiero
y Transacciones: CU-12, CU-13, CU-27, CU-26 y CU-30.

Se creó un diagrama dinámico por caso de uso en `diagrams/processes`, todos
con la misma convención visual y de nomenclatura del primer diagrama de
ahorro automático. Cada uno modela dos fases numeradas sobre los componentes
backend ya existentes en `component-backend.drawio`, con una nota sobre el
comportamiento crítico correspondiente cuando aplica. El de transferencias
internacionales aprovecha la relación ya modelada entre Transacciones y la
Pasarela de Pagos Internacionales, y el de transferencias a terceros suma el
componente CRM para la consulta de beneficiarios registrados. Ninguno de
estos cambios tocó el modelo ER ni los diagramas de componentes existentes.

==== Tareas asignadas

Enlazar los seis diagramas de procesos desde `arch-description.typ`.

=== Iteración 10: Corrección del flujo de CI/CD para generación de documentación por tags

*Fecha y hora:* 15 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* DevOps / Infraestructura \
*Commit:* #link(commit_url + "980052324aa09a0d57a0ddd20dbd234a0fddd6c7", [9800523 · «Arreglar la generacion de la documentacion por el tag»]) \
*Archivos:* #link(git_base_url + "/.github/workflows/doc-generation.yaml", [doc-generation.yaml])

==== Descripción

Objetivo: corregir la acción de integración continua en GitHub Actions
encargada de compilar los documentos Typst y publicar los artefactos PDF y
_releases_ cuando se crean o publican tags de versión en el repositorio de
Documentación.

Se modificó el archivo de workflow `.github/workflows/doc-generation.yaml`
para asegurar que la variable del tag de versión se pase correctamente como
parámetro de entrada a Typst (`--input version="${{ github.ref_name }}"`),
evitando errores durante la ejecución de los disparadores basados en tags y
garantizando la exportación y publicación automática de `bitacora.pdf`,
`arch-description.pdf` y `dev.pdf`.

=== Iteración 11: Implementación del microservicio ms-transacciones y casos de uso asignados

*Fecha y hora:* 15 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + Implementación \
*Commit:*
#link(commit_transacciones_url + "ea41703b5e05a63e8376ac0eacccbe1f16ccb8c9", [ea41703 · «Primera iteracion del microservicio, inicializacion y demas basicos»]),
#link(commit_transacciones_url + "a558b12956d1c9a37ec38e90ceb1afcd1bc398db", [a558b12 · «Primera iteracion del CU-30»]),
#link(commit_transacciones_url + "b9fadfa7f2583fdd6afd2efe6da3f8cc6a0f0ff8", [b9fadfa · «Fix de errores de UUID por validacion, retornos HTTP y pruebas de DB en el actions con BUN usando SQlite»]),
#link(commit_transacciones_url + "d711402c8f316b147f0d91b576ec68fcd6c0274c", [d711402 · «Se realizaron las pruebas y demas codigo relacionado al CU-26»]),
#link(commit_transacciones_url + "e842e30cdc01de7a4383f1572e27e5d1ec39ca24", [e842e30 · «Mejora de pruebas de integracion»]),
#link(commit_transacciones_url + "c878688562dc5c9e57f7b9abd1a0315e7c7eb3d3", [c878688 · «Codigo relacionado al CU-24»]),
#link(commit_transacciones_url + "c0bfb272adca0592149a353a3de5d21d9dba8c12", [c0bfb27 · «Primer avance del codigo relacionado con el CU-28»]) \
*Archivos:*
#link(git_transacciones_base_url + "/src/server.ts", [server.ts]),
#link(git_transacciones_base_url + "/src/contracts", [contracts/]),
#link(git_transacciones_base_url + "/src/repositories", [repositories/]),
#link(git_transacciones_base_url + "/src/use-cases", [use-cases/]),
#link(git_transacciones_base_url + "/src/controllers", [controllers/]),
#link(git_transacciones_base_url + "/src/test", [test/])

==== Descripción

*Drivers:* construir el microservicio `ms-transacciones` satisfaciendo los
cuatro casos de uso asignados a Salomón (CU-30, CU-26, CU-24 y CU-28), con
tipado estricto, aislamiento de base de datos para CI/CD y una batería
exhaustiva de pruebas automatizadas.

*Conceptos de diseño analizados:* arquitectura limpia por capas (contratos,
repositorios, casos de uso, controladores) sobre Bun y Elysia.js; para la
capa de persistencia en pruebas se evaluó requerir un contenedor PostgreSQL
levantado frente a usar SQLite en memoria con el driver nativo `bun:sql`.

*Diagramas preliminares:* se apoyó en el diagrama de componentes del backend
(`component-backend.drawio`, Iteración 6) como referencia de los límites del
microservicio.

*Análisis preliminar de resultados:* se optó por SQLite en memoria en
`service.db.ts` para que los tests unitarios y los flujos de GitHub Actions
corrieran de forma aislada. Con esa base se implementaron las transferencias
entre cuentas propias y a terceros (CU-30), transferencias internacionales
vía SWIFT e interbancarias vía ACH (CU-26), administración de pagos
automáticos y programados con control de ciclo de vida (CU-24), y registro
de depósitos en efectivo, consignación con cheques y retiros presenciales en
ventanilla (CU-28). Cada caso de uso integra los clientes de `ms-cuentas`,
`ms-auditoria` y `ms-notificaciones`, con validaciones estrictas y
comprobantes bancarios unívocos, culminando en una suite automatizada de 46
pruebas aprobadas sin errores de compilación TypeScript.

=== Iteración 12: Estructuración base y estandarización del microservicio ms-financiero

*Fecha y hora:* 15 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Implementación \
*Commit:* #link(commit_financiero_url + "06a4510a80aa558ec6e8fa632c96ba1454a6573d", [06a4510 · «Inicializacion del repo con plantillas y estructura de carpetas temporal»]) \
*Archivos:*
#link(git_financiero_base_url + "/package.json", [package.json]),
#link(git_financiero_base_url + "/Dockerfile", [Dockerfile]),
#link(git_financiero_base_url + "/compose.yml", [compose.yml]),
#link(git_financiero_base_url + "/src/server.ts", [server.ts]),
#link(git_financiero_base_url + "/src/db/service.db.ts", [service.db.ts]),
#link(git_financiero_base_url + "/README.md", [README.md])

==== Descripción

Objetivo: extrapolar el esqueleto y las buenas prácticas arquitectónicas
validadas en `ms-transacciones` al repositorio `ms-financiero`, dejando la
estructura de capas lista para el desarrollo de los casos de uso CU-10 a
CU-13.

Se configuró el proyecto con Bun y Elysia.js, replicando la arquitectura
limpia desacoplada en carpetas para contratos, repositorios, casos de uso,
controladores y clientes inter-servicio. Se incluyó el soporte de doble
entorno en `service.db.ts` (SQLite en memoria para pruebas automáticas y
PostgreSQL para ejecución con Docker Compose), el `Dockerfile` optimizado y
una suite inicial de pruebas que verifica la salud del servicio y la
conectividad a la base de datos.

=== Iteración 13: Creación y consolidación de la librería compartida de componentes y hooks (ui-shared)

*Fecha y hora:* 15 y 16 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + Implementación \
*Commit:*
#link(commit_ui_shared_url + "49f3ec9b27ede3ec90575a0eda4cb689c62424c2", [49f3ec9 · «Commit inicial para los componentes»]),
#link(commit_ui_shared_url + "31a1865d7ddb3198b609573c592a2a24823b7699", [31a1865 · «Correccion para poder correr el workflow»]),
#link(commit_ui_shared_url + "de99cd52822c095958ed3663247619fa80be5b77", [de99cd5 · «Arreglar token para el workflow»]),
#link(commit_ui_shared_url + "598ba9218d33ddda4d2504a202df31394952b8aa", [598ba92 · «Actualizacion del package.json»]),
#link(commit_ui_shared_url + "1046f8422993017770c9172805fabb2f221b5a14", [1046f84 · «Avance en el componente de prueba»]),
#link(commit_ui_shared_url + "38d833d19789f1a38b8d4d72c99437af3d9a7d31", [38d833d · «Avance del paquete»]),
#link(commit_ui_shared_url + "e911968935ec39fdafebb3ff9197c7eaa128bc5c", [e911968 · «Actualizacion del readme»]) \
*Archivos:*
#link(git_ui_shared_base_url + "/src/hooks/useTransferencia.ts", [useTransferencia.ts]),
#link(git_ui_shared_base_url + "/src/components/BotonBancario.tsx", [BotonBancario.tsx]),
#link(git_ui_shared_base_url + "/src/components/TarjetaSaldo.tsx", [TarjetaSaldo.tsx]),
#link(git_ui_shared_base_url + "/src/utils/index.ts", [utils/index.ts]),
#link(git_ui_shared_base_url + "/package.json", [package.json]),
#link(git_ui_shared_base_url + "/tsconfig.json", [tsconfig.json]),
#link(git_ui_shared_base_url + "/README.md", [README.md]),
#link(git_ui_shared_base_url + "/.github/workflows/publish.yaml", [publish.yaml])

==== Descripción

*Drivers:* desacoplar la lógica de negocio y los componentes visuales
universales del Sistema Bancario para reutilizarlos directamente tanto en la
aplicación Web (Astro + React) como en la aplicación Móvil (React Native).

*Conceptos de diseño analizados:* librería transversal publicada como
paquete (`@javer-ia-nos/ui-shared`) frente a duplicar lógica en cada
frontend; hooks headless que manejan estado y HTTP sin ligarse al DOM ni a
primitivas de plataforma, sobre primitivas de React Native compatibles con
`react-native-web` para que un mismo componente renderice en ambas
plataformas.

*Análisis preliminar de resultados:* se implementó el hook
`useTransferencia` (estado transaccional y comunicación HTTP), utilidades de
formateo financiero en pesos colombianos y los componentes
`BotonBancario`/`TarjetaSaldo`. Se configuró el empaquetado TypeScript con
generación de tipos `.d.ts`, paths de exportación limpios y automatización
del flujo de CI/CD en GitHub Actions para compilar, autenticar y publicar el
paquete con Bun.

=== Iteración 14: Inicialización e integración de componentes en el frontend Web (web)

*Fecha y hora:* 15 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Implementación \
*Commit:*
#link(commit_web_url + "09c56f68543b8224b8179abbbadc43cf65790d22", [09c56f6 · «COmmit inicial de estructura»]),
#link(commit_web_url + "6d25030dddd1e0052dab21d2500cfb95579a07cf", [6d25030 · «Primer componente en web»]) \
*Archivos:*
#link(git_web_base_url + "/astro.config.mjs", [astro.config.mjs]),
#link(git_web_base_url + "/package.json", [package.json]),
#link(git_web_base_url + "/src/layouts/LayoutPrincipal.astro", [LayoutPrincipal.astro]),
#link(git_web_base_url + "/src/pages/index.astro", [index.astro]),
#link(git_web_base_url + "/src/pages/transferencias.astro", [transferencias.astro]),
#link(git_web_base_url + "/src/components/FormularioTransferencia.tsx", [FormularioTransferencia.tsx])

==== Descripción

Objetivo: inicializar la aplicación Web del Sistema Bancario utilizando
Astro con la integración de React, estableciendo la estructura base del
portal transaccional y conectando los componentes y lógica de negocio
proveídos por `@javer-ia-nos/ui-shared`.

Se estructuró el proyecto en el repositorio `web` empleando Astro por su
óptimo rendimiento mediante arquitectura de islas. Se configuró la
integración oficial `@astrojs/react` en `astro.config.mjs` y se diseñó la
plantilla de navegación global en `LayoutPrincipal.astro` con soporte
responsivo y estética corporativa. Se crearon las páginas principales
(`index.astro` y `transferencias.astro`), e implementó el componente
interactivo `FormularioTransferencia.tsx` montado como isla de React en el
cliente (`client:load`), conectado directamente a la lógica de estado
provista por `ui-shared`, para la captura y validación de cuentas de origen,
cuentas de destino, montos en moneda local y visualización inmediata del
resultado de las transferencias.

=== Iteración 15: Configuración y desarrollo de la aplicación móvil con Expo (mobile)

*Fecha y hora:* 15 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Implementación \
*Commit:*
#link(commit_mobile_url + "919a6e6ed248958fe720eea9f2ce7ac54fcbb9c7", [919a6e6 · «Creacion de carpetas para movil»]),
#link(commit_mobile_url + "1c2352cc32446cb7df6a1cb3400c3549483cc6c4", [1c2352c · «Primera prueba de componente»]),
#link(commit_mobile_url + "fc0bccb2a4ba9a316252c44a74ae9960df297a3f", [fc0bccb · «Avance del mobile»]),
#link(commit_mobile_url + "5ad647cf9fa319e2e4f4a42a904b7c778d65572f", [5ad647c · «Prueba de renderizado»]),
#link(commit_mobile_url + "8314dedfc5628163dbb4c040bb00c9fa9f38cf13", [8314ded · «Avance funcional en movil»]),
#link(commit_mobile_url + "d0a1a4eb31f66483e73b8342d83733b7f434fa88", [d0a1a4e · «Añadir script para poder testear mas facil»]) \
*Archivos:*
#link(git_mobile_base_url + "/App.tsx", [App.tsx]),
#link(git_mobile_base_url + "/metro.config.js", [metro.config.js]),
#link(git_mobile_base_url + "/package.json", [package.json]),
#link(git_mobile_base_url + "/app.json", [app.json]),
#link(git_mobile_base_url + "/tsconfig.json", [tsconfig.json])

==== Descripción

Objetivo: inicializar, configurar y desarrollar la aplicación móvil del
Sistema Bancario utilizando React Native con Expo, consumiendo los
componentes y hooks de `@javer-ia-nos/ui-shared` y habilitando un entorno de
desarrollo ágil en dispositivos físicos.

Se inicializó el entorno móvil con Expo y TypeScript en el repositorio
`mobile`. Se ajustó la configuración del empaquetador Metro
(`metro.config.js`) para resolver correctamente los enlaces a la librería
compartida de componentes y evitar discrepancias de dependencias. En
`App.tsx` se diseñó la interfaz de usuario móvil mediante componentes
universales (`TarjetaSaldo`, `BotonBancario`), incorporando el hook
desacoplado `useTransferencia` para la ejecución reactiva de transferencias
bancarias con validación de saldo disponible y retroalimentación mediante
alertas nativas.

==== Tareas asignadas

Se añadieron scripts de ejecución y depuración directa por conexión USB en
dispositivos físicos Android para superar restricciones de red locales.

=== Iteración 16: Aprovisionamiento y orquestación del clúster de Kubernetes con Ansible (infra)

*Fecha y hora:* 17 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + DevOps / Infraestructura \
*Commit:*
#link(commit_infra_url + "a7f6226ead28c76380789531a37412ef0c3ae98d", [a7f6226 · «Configuracion inicial d kubernetes y flannel con ansible»]),
#link(commit_infra_url + "a07dbb0c96844a9a2e13e390dd7a132961011be0", [a07dbb0 · «Re organizacion de los archivos»]),
#link(commit_infra_url + "51ffb5a1c109551b3c53a092848b6fba6a664f1a", [51ffb5a · «Arreglo en ymls de containerd y kubernetes»]),
#link(commit_infra_url + "9ef646a1984c81feecbfeda1f25902207d82d56c", [9ef646a · «Re ordenamiento de pasos»]),
#link(commit_infra_url + "d17b32592101f0cc922078de9a6b440de5f51c4a", [d17b325 · «Fix en prerrequisitos para la conexion de los workers»]),
#link(commit_infra_url + "b5046ff424d1e2f8871a50ef1e85deee237469d8", [b5046ff · «cambio de tokens y hashes»]),
#link(commit_infra_url + "58ccfe5aa2b62c110913940204541b9efafdd628", [58ccfe5 · «Fix de roles para cada uno de los workers»]),
#link(commit_infra_url + "0f0d0f4231bdfee263f0cc0c034555f413b92594", [0f0d0f4 · «Fix del script»]) \
*Archivos:*
#link(git_infra_base_url + "/inventory/hosts.yml", [hosts.yml]),
#link(git_infra_base_url + "/inventory/group_vars/all/vars.yml", [vars.yml]),
#link(git_infra_base_url + "/inventory/group_vars/all/vault.yml", [vault.yml]),
#link(git_infra_base_url + "/playbooks/02-prereqs.yml", [02-prereqs.yml]),
#link(git_infra_base_url + "/playbooks/03-containerd.yml", [03-containerd.yml]),
#link(git_infra_base_url + "/playbooks/04-kubernetes-packages.yml", [04-kubernetes-packages.yml]),
#link(git_infra_base_url + "/playbooks/05-init-control-plane.yml", [05-init-control-plane.yml]),
#link(git_infra_base_url + "/playbooks/06-join-workers.yml", [06-join-workers.yml]),
#link(git_infra_base_url + "/playbooks/site.yml", [site.yml]),
#link(git_infra_base_url + "/README.md", [README.md])

==== Descripción

*Drivers:* automatizar el aprovisionamiento, configuración y puesta en
marcha del clúster de Kubernetes bare-metal del equipo, integrando un
plugin de red CNI y asegurando la incorporación transparente de los nodos
worker de cada integrante (requisito de desplegabilidad en 2+ computadores).

*Conceptos de diseño analizados:* automatización con Ansible mediante
playbooks idempotentes frente a configuración manual de cada nodo; como CNI
se seleccionó Flannel por simplicidad de operación sobre el bloque CIDR
`10.244.0.0/16`.

*Análisis preliminar de resultados:* se estructuró `infra` con una suite de
playbooks ejecutables a través de `site.yml`, cubriendo nombres de host y
`/etc/hosts`, módulos del kernel (`overlay`, `br_netfilter`) y `sysctl`,
Containerd con cgroup v2 en `systemd`, los paquetes oficiales de Kubernetes
(`kubelet`, `kubeadm`, `kubectl`), la inicialización del plano de control con
el manifiesto de red de Flannel, y el resguardo de los secretos de conexión
(tokens de unión y discovery token CA cert hashes) mediante Ansible Vault en
`vault.yml`.

=== Iteración 17: Implementación del patrón SAGA para disponibilidad transaccional (ASR-01)

*Fecha y hora:* 17 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño \
*Commit:*
#link(commit_transacciones_url + "2a0d314cc8a4340b1aebfa2ffe69ca8e97cb93ef", [2a0d314 · «Implemenetacion inicial de patron SAGA»]),
#link(commit_transacciones_url + "cc4089b1c75d623bac4c856fe53d40655e192f05", [cc4089b · «Implementacion del patron SAGA y arreglos en casos de uso»]) \
*Archivos:*
#link(git_transacciones_base_url + "/src/use-cases/transferir-intl.use-case.ts", [transferir-intl.use-case.ts]),
#link(git_transacciones_base_url + "/src/use-cases/transferir-fondos.use-case.ts", [transferir-fondos.use-case.ts]),
#link(git_transacciones_base_url + "/src/use-cases/procesar-transaccion-fisica.use-case.ts", [procesar-transaccion-fisica.use-case.ts]),
#link(git_transacciones_base_url + "/src/repositories/transaccion.repository.ts", [transaccion.repository.ts]),
#link(git_transacciones_base_url + "/src/repositories/transaccion-fisica.repository.ts", [transaccion-fisica.repository.ts]),
#link(git_transacciones_base_url + "/src/clients/cuentas.client.ts", [cuentas.client.ts]),
#link(git_transacciones_base_url + "/src/clients/pasarela-pagos.client.ts", [pasarela-pagos.client.ts]),
#link(git_transacciones_base_url + "/src/test/cu26-transferencias-intl.test.ts", [cu26-transferencias-intl.test.ts]),
#link(git_transacciones_base_url + "/src/test/cu30-transferencias.test.ts", [cu30-transferencias.test.ts])

==== Descripción

*Drivers:* ASR-01 (Disponibilidad Transaccional) exige que, ante una
interrupción imprevista de la red durante una transferencia internacional o
de terceros, el sistema reintente o asegure la atomicidad de la transacción
sin comprometer el saldo del usuario.

*Conceptos de diseño analizados:* bloqueos distribuidos pesados (2PC) frente
al patrón SAGA orquestado con transacciones de compensación y reintentos con
retroceso exponencial; se descartó 2PC por el acoplamiento y la latencia que
introduce entre microservicios distribuidos.

*Diagramas preliminares:* el flujo se apoyó en los diagramas dinámicos de
CU-26 y CU-30 ya modelados en la Iteración 9
(`gestion-transferencias-internacionales-nacionales.drawio`,
`transferencias-cuentas-propias-terceros.drawio`).

*Análisis preliminar de resultados:* se implementó el patrón SAGA en los
flujos críticos de transferencias internacionales (CU-26) y a terceros
(CU-30). Las operaciones se persisten inicialmente en estado `PENDING` en
`transaccion.repository.ts`; tras el débito en la cuenta de origen vía
`ms-cuentas`, se ejecutan llamadas externas con tolerancia a fallos y
reintentos con backoff exponencial. Si la pasarela de pagos o el servicio de
destino falla de forma definitiva, el orquestador SAGA ejecuta la
transacción compensatoria (reembolso exacto a la cuenta de origen, estado
`FAILED` y evento de auditoría `TRANSFERENCIA_FALLIDA_COMPENSADA`). Se
construyeron pruebas automatizadas de simulación de desconexión de red,
alcanzando 48 pruebas unitarias y de integración exitosas con cero errores
de TypeScript.

=== Iteración 18: Correcciones menores en el diagrama de contexto y en el workflow de documentación

*Fecha y hora:* 15 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Corrección \
*Commit:*
#link(commit_url + "be85b7da0df041bb74ea40de38e5e0a426ef52b3", [be85b7d · «Alineacion de flecha en diagrama de contexto»]),
#link(commit_url + "bb1fa8f8a9b2ff1065e05e119fab84ea78f34609", [bb1fa8f · «Fix del workflow»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/system-context.drawio", [system-context.drawio]),
#link(git_base_url + "/.github/workflows/doc-generation.yaml", [doc-generation.yaml])

==== Descripción

Objetivo: corregir un desalineamiento visual en `system-context.drawio` y un
error de orden en el flujo de _auto-commit_ de imágenes exportadas del
workflow de documentación.

Se ajustó el desplazamiento (_offset_) de una etiqueta de relación en el
diagrama de contexto que quedaba superpuesta a su flecha. En
`doc-generation.yaml` se detectó que el job hacía `git pull --rebase` antes
de crear el commit de las imágenes regeneradas, lo que descartaba el `git
add` pendiente en escenarios de carrera; se invirtió el orden a commit
primero y pull con rebase después, antes del push.

=== Iteración 19: Adaptación de los diagramas de componentes a la arquitectura de microservicios

*Fecha y hora:* 17 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + Diagrama / Modelado \
*Commit:*
#link(commit_url + "614975b940c4d6e02cd57b9de7542ab7507b4667", [614975b · «Actualizacion de diagramas de componentes para adaptacion a microservicios»]),
#link(commit_url + "5f130c989c8c1ed3770ebb08c36d9bb489150a25", [5f130c9 · «Arreglo de diagrama de componentes»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/components/component-backend.drawio", [component-backend.drawio]),
#link(git_base_url + "/docs/diagrams/components/component-web.drawio", [component-web.drawio]),
#link(git_base_url + "/docs/diagrams/components/component-mobile.drawio", [component-mobile.drawio])

==== Descripción

*Drivers:* los diagramas de componentes seguían representando un backend
monolítico con una base de datos compartida, en contradicción con la
arquitectura de microservicios ya implementada (base de datos propia por
servicio, Iteraciones 11-12).

*Conceptos de diseño analizados:* comunicación síncrona directa entre
servicios frente a mensajería asíncrona vía broker de eventos para los
flujos de notificación/auditoría; se conservó comunicación síncrona (gRPC)
únicamente para consultas de estado que exigen respuesta inmediata
(validación de cupo y de saldo).

*Análisis preliminar de resultados:* se reemplazó la nota genérica de acceso
a datos por «Base de datos (propia por servicio)» en cada componente del
backend y se introdujo el contenedor «Infraestructura - Broker de eventos»
con las relaciones de publicación/consumo asíncronas de cada microservicio
(`TransacciónRealizada`, `SaldoActualizado`/`AhorroProgramado`,
`TarjetaBloqueada`/`CupoActualizado`, `PréstamoAprobado`/`CDTConstituido`,
`LoginFallido`/`DispositivoNuevo`, `PQRSRadicada`/`ReclamaciónCreada`,
`NotificaciónEnviada`, y consumo de todos los eventos por Auditoría). Las
llamadas síncronas de validación de cupo y saldo quedaron explícitamente
etiquetadas como `gRPC`. Se corrigieron además referencias huérfanas en
`component-mobile.drawio` y `component-web.drawio`.

=== Iteración 20: Migración de los diagramas de procesos a mensajería asíncrona con Kafka

*Fecha y hora:* 18 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:*
#link(commit_url + "0abfbc527549cb1fafeb2db9d0caf187231a1d82", [0abfbc5 · «Actualizacion de diagramas de procesos»]),
#link(commit_url + "cd24a14393f171a352e4027befb60cb9ba8238b7", [cd24a14 · «arreglar vista»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/processes/transferencias-cuentas-propias-terceros.drawio", [transferencias-cuentas-propias-terceros.drawio]),
#link(git_base_url + "/docs/diagrams/processes/gestion-transferencias-internacionales-nacionales.drawio", [gestion-transferencias-internacionales-nacionales.drawio]),
#link(git_base_url + "/docs/diagrams/processes/pago-facturas-servicios.drawio", [pago-facturas-servicios.drawio]),
#link(git_base_url + "/docs/diagrams/processes/programacion-ahorro-automatico.drawio", [programacion-ahorro-automatico.drawio]),
#link(git_base_url + "/docs/diagrams/processes/solicitud-cdt-inversiones.drawio", [solicitud-cdt-inversiones.drawio]),
#link(git_base_url + "/docs/diagrams/processes/solicitud-gestion-prestamos.drawio", [solicitud-gestion-prestamos.drawio]),
#link(git_base_url + "/docs/diagrams/container-view.drawio", [container-view.drawio])

==== Descripción

Objetivo: alinear los seis diagramas dinámicos de procesos con la
arquitectura de microservicios ya reflejada en los diagramas de componentes
(Iteración 19): reemplazar las llamadas síncronas directas a Auditoría y
Notificaciones por publicación de eventos en Kafka, y eliminar toda
representación de una base de datos compartida entre servicios.

En los seis diagramas de `docs/diagrams/processes/` se sustituyeron las
llamadas HTTP directas a Auditoría y Notificaciones por un _lifeline_ del
broker Kafka con publicación asíncrona («sin esperar respuesta»). Al revisar
la trazabilidad de las bases de datos se detectó que CU-27, CU-09, CU-12 y
CU-13 mostraban a otros componentes leyendo o escribiendo saldo directamente
contra «la» base de datos, como si fuera compartida; se corrigió insertando
el _lifeline_ del componente Cuentas donde faltaba y separando cada paso de
validación/débito de saldo en su propia llamada gRPC a Cuentas, y se
renombraron las bases de datos de cada diagrama a su nombre real y exclusivo
del servicio (`BD Transacciones`, `BD Cuentas`, `BD Financiero`). Se ajustó
además una flecha en `container-view.drawio` que quedaba cruzando el borde
de una fase.

=== Iteración 21: Migración de los diagramas de código a la mensajería con Kafka

*Fecha y hora:* 18 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Diagrama / Modelado \
*Commit:* #link(commit_url + "5d880d193b0b0640005677dba94365892cffe650", [5d880d1 · «Visualizacion del broker de kafka»]) \
*Archivos:*
#link(git_base_url + "/docs/diagrams/code/code-view-backend-transacciones.drawio", [code-view-backend-transacciones.drawio]),
#link(git_base_url + "/docs/diagrams/code/code-view-backend-auditoria.drawio", [code-view-backend-auditoria.drawio]),
#link(git_base_url + "/docs/diagrams/code/code-financiero(backend).drawio", [code-financiero(backend).drawio])

==== Descripción

Objetivo: cerrar la última capa (C4 nivel 4, de código) que todavía
describía `ms-transacciones`, `ms-auditoria` y `ms-financiero`
comunicándose por clientes HTTP directos, para que coincidiera con la
mensajería asíncrona ya definida en las capas de componentes y de procesos.

En `code-view-backend-transacciones.drawio` se reemplazaron las clases
`NotificacionesClient` y `AuditoriaClient` por una única clase
`EventosClient (Kafka)` con el método `publicar(topic, payload)`,
retargeteando las relaciones existentes hacia ella. En
`code-view-backend-auditoria.drawio` se retiró el endpoint HTTP `POST
/eventos` del controlador y se agregó `EventosConsumer (Kafka)` con
`onMessage(topic, evento)`, conectado al caso de uso existente
`RegistrarEventoUseCase`. En `code-financiero(backend).drawio` —generado
desde PlantUML, con el código fuente embebido además de las formas nativas
ya renderizadas— se renombró la interfaz `IAuditService` a
`IEventosService`, el método `logTransaction(action, details)` a
`publicarEvento(topic, payload)`, y se aplicó el mismo estilo dorado usado
en los otros dos diagramas a la interfaz y sus relaciones entrantes para
marcarlas visualmente como mensajería asíncrona.

=== Iteración 22: Eliminación del cliente síncrono simulado de Auditoría/Notificaciones en ms-transacciones

*Fecha y hora:* 18 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Corrección \
*Commit:* #link(commit_transacciones_url + "74bd554e9ae12ccaa8381a6a6143db29e2063011", [74bd554 · «Fix para dejar de simular comunicacion y utilizar el broker»]) \
*Archivos:*
#link(git_transacciones_base_url + "/src/clients/eventos.client.ts", [eventos.client.ts]),
#link(git_transacciones_base_url + "/src/use-cases/transferir-fondos.use-case.ts", [transferir-fondos.use-case.ts]),
#link(git_transacciones_base_url + "/src/use-cases/transferir-intl.use-case.ts", [transferir-intl.use-case.ts]),
#link(git_transacciones_base_url + "/src/use-cases/procesar-transaccion-fisica.use-case.ts", [procesar-transaccion-fisica.use-case.ts]),
#link(git_transacciones_base_url + "/src/use-cases/administrar-pagos-programados.use-case.ts", [administrar-pagos-programados.use-case.ts])

==== Descripción

Objetivo: corregir la divergencia entre el código real de
`ms-transacciones` y el diagrama de código actualizado en la Iteración 21:
los cuatro casos de uso seguían invocando de forma directa y síncrona a
`auditoriaClient` y `notificacionesClient`, contradiciendo el `EventosClient
(Kafka)` ya documentado.

Se eliminaron `src/clients/auditoria.client.ts` y
`src/clients/notificaciones.client.ts`, que quedaron sin ningún consumidor.
Las cuatro clases de caso de uso (transferencias propias/terceros,
transferencias internacionales, transacciones presenciales y pagos
programados) se migraron a publicar en
`eventosClient.publicar("auditoria.evento-transaccion", payload)` y
`eventosClient.publicar("notificaciones.evento-transaccion", payload)` en
lugar de llamar directamente a los clientes retirados, incluyendo el camino
de fallo de compensación del SAGA. La suite de 48 pruebas automatizadas y la
verificación de tipos con `tsc --noEmit` se mantuvieron en verde tras el
cambio.

=== Iteración 23: Publicación de imágenes Docker en GitHub Container Registry y orquestación con Helm

*Fecha y hora:* 18 de septiembre de 2026 (hora no registrada) \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta (autor); tocó los
ocho microservicios del equipo (`ms-transacciones`, `ms-cuentas`,
`ms-financiero`, `ms-auditoria`, `ms-crm`, `ms-notificaciones`,
`ms-seguridad`, `ms-tarjetas`) y `infra` \
*Tipo de entrada:* Decisión de diseño + DevOps / Infraestructura \
*Commit:*
#link(commit_transacciones_url + "ce595efff59271edeb62439470e23e902e497c7f", [ce595ef · «Añádir subida a GitHub Container Registry»]) (ms-transacciones),
#link(commit_cuentas_url + "1a63a9fc18def75e338d421391a344357e1f416d", [1a63a9f · «añadir subida a GitHub Container Registry»]) (ms-cuentas),
#link(commit_financiero_url + "4b836b08e10f7bd81aecc8b0a3b8e770b6498bed", [4b836b0 · «Añádir subida a GitHub Container Registry»]) (ms-financiero),
#link(commit_auditoria_url + "2c20bf9a00618d95996fb61438c375b63c16da51", [2c20bf9 · «añádir subida a GitHub Container Registry»]) (ms-auditoria),
#link(commit_crm_url + "e43e64e829ff64cb8a3f0fbcd3e21e0907c31393", [e43e64e · «añadir subida a GitHub Container Registry»]) (ms-crm),
#link(commit_notificaciones_url + "74271c61933fd512c8e16ff421a43af2a098a88f", [74271c6 · «Añadir subida a GitHub Container Registry»]) (ms-notificaciones),
#link(commit_seguridad_url + "72a108042faebcacad282fb60cd7be78c592ca63", [72a1080 · «Añadir subida a GitHub Container Registry»]) (ms-seguridad),
#link(commit_tarjetas_url + "31e4459a57980896b1c0da372246d03f518cb201", [31e4459 · «Añádir subida a GitHub Container Registry»]) (ms-tarjetas),
#link(commit_infra_url + "a0c636b9252ae7ec56aba2b2c881e52eec72c778", [a0c636b · «Avance de infraestructura para adicionar helm y la subida de contenedores a GitHub Container Registry»]) (infra) \
*Archivos:*
#link(git_infra_base_url + "/charts/microservice", [charts/microservice/]),
#link(git_infra_base_url + "/charts/javer-ia-nos", [charts/javer-ia-nos/]),
#link(git_infra_base_url + "/Makefile", [Makefile]),
#link(git_infra_base_url + "/inventory/group_vars/all/vault.yml.example", [vault.yml.example])

==== Descripción

*Drivers:* cumplir el requisito de poder levantar toda la plataforma (ocho
microservicios y el frontend web) con un único comando sobre el clúster de
Kubernetes ya aprovisionado en la Iteración 16, publicando primero las
imágenes de cada servicio en un registro accesible desde los nodos.

*Conceptos de diseño analizados:* registro de contenedores privado propio
frente a GitHub Container Registry (`ghcr.io`) usando el `GITHUB_TOKEN` del
propio workflow, y chart de Helm específico por servicio frente a un chart
genérico y reutilizable instanciado varias veces.

*Análisis preliminar de resultados:* se agregó un workflow de GitHub Actions
(`docker-publish.yaml`) a cada uno de los ocho microservicios que construye
y publica la imagen en `ghcr.io/javer-ia-nos/<repo>` en cada push a `main`.
En `infra` se creó el chart genérico `charts/microservice`, que despliega el
Deployment/Service de la aplicación y, opcionalmente, su propia base de
datos PostgreSQL con Secret y PVC dedicados; y un chart paraguas
`charts/javer-ia-nos` que lo instancia nueve veces (ocho microservicios más
el frontend web) como dependencias aliaseadas, cada una con su imagen,
puerto y variables de entorno cruzadas hacia otros servicios (por ejemplo
`CUENTAS_SERVICE_URL` en Transacciones y Financiero) resueltas por el DNS
interno del clúster. Se agregó un `Secret` de tipo `dockerconfigjson` para
el _pull_ de las imágenes privadas y un `Makefile` con el objetivo `deploy`,
de modo que el despliegue completo se reduce a `make deploy` con el token de
GitHub como única variable de entorno.

==== Tareas asignadas

Documentar las contraseñas de cada base de datos y el token de GHCR como
variables nuevas en `vault.yml.example`, a completar en el `vault.yml`
cifrado real de cada integrante.

=== Iteración 24: Reimplementación de dispositivos confiables (CU-17) en ms-seguridad

*Fecha y hora:* 20 de septiembre de 2026, 16:00, y 21 de septiembre de 2026, 13:29 \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Corrección + Implementación \
*Commit:*
#link(commit_seguridad_url + "54e42baf4220b6f455f0a7d90038bf96518d2c58", [54e42ba · «CU-17»]),
#link(commit_seguridad_url + "7fb2b3bc8c782b49c6ae762ff484647e8e75a555", [7fb2b3b · «Re implementacion CU-17»]) \
*Archivos:*
#link("https://github.com/javer-ia-nos/ms-seguridad/tree/main/src/controllers/device.controller.ts", [device.controller.ts]),
#link("https://github.com/javer-ia-nos/ms-seguridad/tree/main/src/repositories/device.repository.ts", [device.repository.ts]),
#link("https://github.com/javer-ia-nos/ms-seguridad/tree/main/src/repositories/device-trust.repository.ts", [device-trust.repository.ts]),
#link("https://github.com/javer-ia-nos/ms-seguridad/tree/main/src/use-cases/device.usecase.ts", [device.usecase.ts]),
#link("https://github.com/javer-ia-nos/ms-seguridad/tree/main/src/test/devices.test.ts", [devices.test.ts])

==== Descripción

Objetivo: cerrar el ciclo completo de CU-17 (registro, consulta y revocación
de dispositivos confiables) en `ms-seguridad`, que ya tenía una primera
versión con nomenclatura en español (`dispositivo.controller.ts`,
`dispositivos.usecase.ts`).

El primer commit (`54e42ba`) añadió los repositorios `confianza.repository.ts`
y `dispositivo.repository.ts`, el caso de uso `dispositivos.usecase.ts` y el
seed de base de datos correspondiente. El segundo commit (`7fb2b3b`, al día
siguiente) reescribió el mismo caso de uso con nomenclatura en inglés
(`device.controller.ts`, `device.repository.ts`,
`device-trust.repository.ts`, `device.usecase.ts`), separando el registro de
confianza del dispositivo (`device-trust.repository.ts`) del registro del
dispositivo en sí, y amplió la suite de pruebas a 152 líneas en
`devices.test.ts`, cubriendo registro, listado, actualización de confianza y
revocación por `usuarioId`.

==== Tareas asignadas

Eliminar los archivos duplicados en español (`dispositivo.*`,
`dispositivos.*`) que quedaron del primer commit, para no mantener dos
implementaciones paralelas del mismo caso de uso.

=== Iteración 25: Reubicación de CU-27 y CU-29 de ms-financiero a ms-transacciones

*Fecha y hora:* 20 de septiembre de 2026, 21:42 \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + Implementación \
*Commit:*
#link(commit_financiero_url + "34c28dc1839e52ec340af435e481f6ff546fd4c6", [34c28dc · «Mover CU-27 y CU-29»]) (ms-financiero),
#link(commit_transacciones_url + "3018863f80a6237c35fa3dcd618974cf5af03e78", [3018863 · «Mover CU-27 y CU-29»]) (ms-transacciones) \
*Archivos:*
#link(git_transacciones_base_url + "/src/controllers/factura.controller.ts", [factura.controller.ts]),
#link(git_transacciones_base_url + "/src/controllers/billetera.controller.ts", [billetera.controller.ts]),
#link(git_transacciones_base_url + "/src/test/cu27-pagos-facturas.test.ts", [cu27-pagos-facturas.test.ts]),
#link(git_transacciones_base_url + "/src/test/cu29-billeteras-externas.test.ts", [cu29-billeteras-externas.test.ts])

==== Descripción

*Drivers:* CU-27 (pago de facturas de servicios) y CU-29 (soporte para
billeteras externas) estaban implementados en `ms-financiero`, cuyo límite
de contexto (certificados, saldo, CDT, préstamos) no corresponde a pagos ni
a integraciones de billeteras; la tabla de casos de uso y los diagramas de
componentes ya los ubicaban dentro de Transacciones (CU-24 a CU-31,
Iteración 6).

*Conceptos de diseño analizados:* mantener CU-27/CU-29 en `ms-financiero`
por costo de migración frente a moverlos a `ms-transacciones` para respetar
el límite de contexto ya documentado en la arquitectura.

*Análisis preliminar de resultados:* se retiraron de `ms-financiero` los
contratos, cliente de servicios externos, controlador, repositorio, casos
de uso y pruebas de CU-27/CU-29 (237 líneas eliminadas). En
`ms-transacciones` se recrearon como `factura.controller.ts` y
`billetera.controller.ts`, con sus propios contratos, repositorios y
clientes (`pagos-externos.client.ts`, `billeteras.client.ts`), y se migraron
las pruebas `cu27-pagos-facturas.test.ts` y `cu29-billeteras-externas.test.ts`.

=== Iteración 26: Enrutamiento real y validación de sesión en api-gateway

*Fecha y hora:* 20 de septiembre de 2026, 17:48 \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Implementación \
*Commit:* #link("https://github.com/javer-ia-nos/api-gateway/commit/f7b331cc052691cdd5142582da85c7648b9dcdae", [f7b331c · «implementar enrutamiento real y validación de sesión contra ms-seguridad»]) \
*Archivos:*
#link("https://github.com/javer-ia-nos/api-gateway/tree/main/index.ts", [index.ts]),
#link("https://github.com/javer-ia-nos/api-gateway/tree/main/src/services/securityService.ts", [securityService.ts]),
#link("https://github.com/javer-ia-nos/api-gateway/tree/main/tests/security.test.ts", [security.test.ts])

==== Descripción

Objetivo: reemplazar el enrutamiento y la validación de sesión simulados del
API Gateway por una integración real contra `ms-seguridad`, de modo que cada
petición hacia los microservicios internos pase primero por la verificación
de sesión activa.

Se amplió `index.ts` para enrutar dinámicamente hacia los microservicios de
backend y se reescribió `securityService.ts` para consultar la sesión del
usuario contra `ms-seguridad` en cada petición entrante, en lugar de la
lógica simulada anterior. Se agregó el workflow `docker-publish.yaml` y el
`Dockerfile` del gateway (antes ausentes) y se ampliaron `security.test.ts`
e `intent-audit.test.ts` para cubrir los nuevos casos de sesión válida,
sesión expirada y ausencia de token.

=== Iteración 27: Páginas de seguridad y ajustes visuales en el frontend Web

*Fecha y hora:* 20 de septiembre de 2026, entre las 16:51 y las 17:51 \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Implementación \
*Commit:*
#link(commit_web_url + "025688e207ca22619a543036b73a9a99a61b3cea", [025688e · «Añadir pagina principal»]),
#link(commit_web_url + "dc85c2542a5e4f9e7d484aefe289e7a5e7798882", [dc85c25 · «Fix de datos quemados»]),
#link(commit_web_url + "a6048d8ee55e9a60702171e75c6d5d9670f4df1c", [a6048d8 · «Actualizacion de componentes»]) \
*Archivos:*
#link(git_web_base_url + "/src/pages/seguridad.astro", [seguridad.astro]),
#link(git_web_base_url + "/src/components/PaginaSeguridad.tsx", [PaginaSeguridad.tsx]),
#link(git_web_base_url + "/src/components/PaginaPrincipal.tsx", [PaginaPrincipal.tsx]),
#link(git_web_base_url + "/src/components/FormularioTransferencia.tsx", [FormularioTransferencia.tsx])

==== Descripción

Objetivo: dar a la aplicación Web una página propia para la gestión de
seguridad de la cuenta (CU-17/CU-19) y eliminar los datos quemados que
todavía traían la página principal y el formulario de transferencia.

Se creó la página `seguridad.astro` con el componente `PaginaSeguridad.tsx`,
que consume los componentes de `ui-shared` para dispositivos confiables y
límites de transacción. Se corrigió `PaginaPrincipal.tsx` y
`FormularioTransferencia.tsx` para dejar de mostrar valores fijos y
consumir los datos reales expuestos por los hooks de `ui-shared`, y se
ajustó `astro.config.mjs` para el nuevo enrutamiento.

=== Iteración 28: Eliminación de datos quemados y exigencia de sesión en ui-shared

*Fecha y hora:* 20 de septiembre de 2026, entre las 16:51 y las 17:50 \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + Implementación \
*Commit:*
#link(commit_ui_shared_url + "82c84f2ba3a0666dddb76ccaf099721130e56a34", [82c84f2 · «Test visual y prueba de algunos casos de uso»]),
#link(commit_ui_shared_url + "b3ab49a21870ada50a06d759b7fb30b3a993eae6", [b3ab49a · «Componentes sin datos quemados»]),
#link(commit_ui_shared_url + "826d492fd15e9e6e04f592dbd8e4cf89b96997ef", [826d492 · «Exigir sesion»]) \
*Archivos:*
#link(git_ui_shared_base_url + "/src/components/FormularioLimites.tsx", [FormularioLimites.tsx]),
#link(git_ui_shared_base_url + "/src/components/FormularioLogin.tsx", [FormularioLogin.tsx]),
#link(git_ui_shared_base_url + "/src/components/PantallaDispositivosConfiables.tsx", [PantallaDispositivosConfiables.tsx]),
#link(git_ui_shared_base_url + "/src/components/PantallaInicioCuentas.tsx", [PantallaInicioCuentas.tsx]),
#link(git_ui_shared_base_url + "/src/hooks/useSesion.ts", [useSesion.ts]),
#link(git_ui_shared_base_url + "/src/hooks/useInicioCuentas.ts", [useInicioCuentas.ts])

==== Descripción

*Drivers:* los componentes de `ui-shared` construidos hasta la Iteración 13
renderizaban datos fijos de prueba; para que Web y Móvil pudieran mostrar
información real de cada usuario autenticado hacía falta un hook de sesión
compartido y que cada componente lo consumiera antes de pedir datos de
negocio.

*Conceptos de diseño analizados:* mantener el estado de sesión duplicado en
cada pantalla frente a centralizarlo en un hook headless (`useSesion`)
consumido por el resto de hooks de dominio.

*Análisis preliminar de resultados:* se agregaron `FormularioLimites`,
`FormularioLogin` y `PantallaDispositivosConfiables`, junto con sus hooks
(`useLimites`, `useLogin`, `useDispositivos`), como primera prueba visual
sobre CU-17, CU-18 y CU-19. Se creó `useSesion.ts` y `useInicioCuentas.ts`
para reemplazar los datos quemados de `PantallaInicioCuentas.tsx` y
`EncabezadoApp.tsx` por el saldo y los movimientos reales del usuario. Por
último, se modificaron `useDispositivos`, `useInicioCuentas`, `useLimites` y
`useTransferencia` para exigir una sesión activa antes de resolver sus
peticiones, devolviendo un estado de "sin autenticar" en vez de datos
simulados.

=== Iteración 29: Automatización de despliegue, autoescalado y rotación de secretos en infra

*Fecha y hora:* 20 de septiembre de 2026, entre las 00:11 y las 17:49 \
*Personas involucradas:* Salomón Alfredo Ávila Larrotta \
*Tipo de entrada:* Decisión de diseño + DevOps / Infraestructura \
*Commit:*
#link(commit_infra_url + "edbbbb6ed174a5e5355d8a9f24697c2b566b6e6f", [edbbbb6 · «Actualizacion del makefile para evitar errores»]),
#link(commit_infra_url + "a374299bc403df4aad3a95e48dc2356ae12f88fb", [a374299 · «Keel para actualizar los cambios en nuevas imagenes de ghcr»]),
#link(commit_infra_url + "71faaf0a8465a051282caf80bd600018e1713d3e", [71faaf0 · «Forzar rollout de los microservicios»]),
#link(commit_infra_url + "4accbd530e43c071d299020a0a645d51e079fee6", [4accbd5 · «Se añáde un playbook que destruye configuraciones para dejar maquinas en blanco»]),
#link(commit_infra_url + "01e207b59ef3600a815f8184140deed2e4ff6ca9", [01e207b · «Adicion de ultima maquina para el cluster de kubernetes»]),
#link(commit_infra_url + "9baf58a56669363a4fe804a21d1798decafeab48", [9baf58a · «Despliegue automatico de pods al momento de montaje»]),
#link(commit_infra_url + "20dbbeebf4120ea5d401eb48f0d8d006c8aa6565", [20dbbee · «Usar el repositorio APT para instalacion de helm»]),
#link(commit_infra_url + "4ecba52bf943b89ab70fd6f6d6bc93c7527a9e9f", [4ecba52 · «Instalar binario directo para evitar certificados rotos»]),
#link(commit_infra_url + "f59a91b4dea518251f9853607a87f541dba26ab9", [f59a91b · «Añádir el usuario explicitamente»]),
#link(commit_infra_url + "d7e75546b354b5e8cd6dbb5b6c176fe0e1221b74", [d7e7554 · «Actualizar local path storage»]),
#link(commit_infra_url + "79d18444a8a7f3969ea8315c0ef3f600171afbe9", [79d1844 · «Depuracion temporal»]),
#link(commit_infra_url + "29cb79af1fd08e70bf3c4d76d0ddd0adb12712f6", [29cb79a · «Adicion de firma»]),
#link(commit_infra_url + "eef58287afceecfaf898bf8437f9e8ed60d580bc", [eef5828 · «Revertir depuracion temporal»]),
#link(commit_infra_url + "1a6b482dd96b4df120eaa21194e653b61fdbcc02", [1a6b482 · «Inclusion de HPA para autoescalado»]),
#link(commit_infra_url + "543f258124c97e8fff6e19a09cdcc05690f0b916", [543f258 · «Arreglar bug de comillas que estaba generando error»]),
#link(commit_infra_url + "a701bec7654a053af8344324e13bf9cb050f412f", [a701bec · «Retirar keel y remplazar por cron job»]),
#link(commit_infra_url + "f62617aa6b37782674200e39f16f797331b62bbe", [f62617a · «Configuracion del ingress»]),
#link(commit_infra_url + "ff618f6e3d804104b4a465c0fb06c34283229b86", [ff618f6 · «Añádir el api gateway a la infraestructura»]),
#link(commit_infra_url + "e5f884ded812e2391e9a1b791b36ccb26afea317", [e5f884d · «Nuevo token generado»]),
#link(commit_infra_url + "2acf3af780c8428a13893dc037783a502b195fd5", [2acf3af · «Fix de deployment»]) \
*Archivos:*
#link(git_infra_base_url + "/Makefile", [Makefile]),
#link(git_infra_base_url + "/charts/microservice/templates/hpa.yaml", [hpa.yaml]),
#link(git_infra_base_url + "/charts/javer-ia-nos/templates/ingress-api.yaml", [ingress-api.yaml]),
#link(git_infra_base_url + "/playbooks/12-app.yml", [12-app.yml]),
#link(git_infra_base_url + "/playbooks/99-teardown.yml", [99-teardown.yml])

==== Descripción

*Drivers:* con las imágenes ya publicándose en GHCR (Iteración 23) faltaba
que el clúster las desplegara y actualizara automáticamente, tolerara
picos de carga, incorporara el sexto nodo del equipo y expusiera el API
Gateway hacia el exterior, todo con secretos gestionados de forma segura.

*Conceptos de diseño analizados:* para refrescar los pods con imágenes
nuevas se evaluó primero Keel (operador de auto-actualización por polling
sobre GHCR) frente a un `CronJob` propio de `kubectl rollout restart`; se
adoptó Keel primero (`a374299`) y se retiró horas después
(`a701bec`) por comportamiento poco predecible en el clúster bare-metal,
sustituyéndolo por el CronJob. Para el autoescalado se optó por un
`HorizontalPodAutoscaler` nativo de Kubernetes (`hpa.yaml`) en vez de un
umbral fijo de réplicas en el chart.

*Análisis preliminar de resultados:* se endureció el `Makefile` para
detectar errores tempranos, se agregó `playbooks/99-teardown.yml` para dejar
máquinas en blanco antes de reprovisionarlas, se incorporó el nodo de
Juliana como sexto miembro del clúster (`inventory/host_vars/juliana`), se
corrigió la instalación de Helm (primero por repositorio APT, luego por
binario directo, para evitar certificados rotos), se ajustó el usuario
explícito en los playbooks de almacenamiento e ingress, se agregó el
`HorizontalPodAutoscaler` por microservicio, se configuró
`ingress-api.yaml` para exponer el API Gateway y se integró su despliegue
en el chart paraguas. Los cambios de `vault.yml` («Adicion de firma»,
«Nuevo token generado») rotaron los secretos de conexión del clúster tras
detectar credenciales comprometidas durante las pruebas. Un cambio de
depuración temporal en `12-app.yml` se revirtió el mismo día
(`79d1844`/`eef5828`).

==== Tareas asignadas

Confirmar que el `CronJob` de rollout cubre el mismo caso de uso que
resolvía Keel (actualización automática al publicarse una imagen nueva) sin
reintroducir el comportamiento inestable observado.
