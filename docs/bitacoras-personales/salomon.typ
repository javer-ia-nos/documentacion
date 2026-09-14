#let version = sys.inputs.at("version", default: "main")
#let git_base_url = "https://github.com/javer-ia-nos/Documentacion/tree/" + version
#let commit_url = "https://github.com/javer-ia-nos/Documentacion/commit/"

== Bitácora de Salomon Alfredo Avila Larrotta

Registro de contribuciones al diseño y la documentación de la arquitectura del
Sistema Bancario. Cada iteración indica su objetivo, una descripción breve del
trabajo realizado y el commit asociado.

=== Iteración 1: Diagrama de contexto del sistema en C4 nivel 1

*Fecha:* 21 de agosto de 2026 \
*Commit:* #link(commit_url + "344e80a315307f68a30e199e54b45399e2e39496", [344e80a · «Primera iteracion SystemContext»]) \
*Actividad:* Diagramas / Arquitectura

==== Objetivo

Construir el primer diagrama C4 de _System Context_ del Sistema Bancario a partir
de los casos de uso CU-01 a CU-30 y de los requisitos arquitectónicos ASR-01 a
ASR-06, con trazabilidad explícita entre cada elemento del diagrama y los
requisitos que lo justifican.

==== Descripción

Se modeló con #link("https://goa.design/model/", [goa.design/model]), que
describe el modelo C4 como código Go versionable y revisable por _pull request_.
Se reescribió la plantilla de ejemplo _Big Bank plc_ al dominio del proyecto en
`diagrams/test/model.go`, definiendo como actores al Cliente bancario y al Agente
de Atención al Cliente, como sistema en alcance al Sistema de Banca Digital y seis
sistemas externos, con cada relación anotada con los CU y ASR que la originan. Se
acotó el modelo al nivel 1 de C4 y se definieron estilos por _tag_ para persona,
interno y externo. El resultado fue `model.go` compilable, que genera
`diagrams/gen/SystemContext.svg`. Días después el equipo migró los diagramas a
#link(git_base_url + "/docs/diagrams", [draw.io]) por problemas de compatibilidad
de la herramienta y el contenido se trasladó a
#link(git_base_url + "/docs/diagrams/system-context.drawio", [system-context.drawio]).

=== Iteración 2: Notación C4 y limpieza de los tres diagramas

*Fecha:* 1 de septiembre de 2026 \
*Commit:* #link(commit_url + "fd587dffee96f94bfb3b9fd067770ad6a7628fcf", [fd587df · «Cambio visual de diagramas»]) \
*Actividad:* Diagramas / Documentación \
*Archivos:*
#link(git_base_url + "/docs/diagrams/system-context.png", [system-context.png]),
#link(git_base_url + "/docs/diagrams/container-view.png", [container-view.png]),
#link(git_base_url + "/docs/diagrams/components/component-backend.png", [component-backend.png]).

==== Objetivo

Alinear los tres diagramas C4 de contexto, contenedores y componentes con la
notación oficial de #link("https://c4model.com/", [c4model.com]) y corregir las
inconsistencias acumuladas entre ellos.

==== Descripción

En el diagrama de contexto se añadió la persona _Cajero_, encargada de las
operaciones de ventanilla del caso de uso CU-28. Se amplió «Agente de Atención al
Cliente» a _Personal del Banco de soporte y backoffice_, se renombró el sistema a
_Sistema Bancario_ y se reubicaron actores y flechas para que las etiquetas no se
solaparan. Se normalizó la paleta a los colores canónicos de C4, con `#08427B`
para persona, `#1168BD` para el sistema en alcance y `#999999` para los externos,
y se aplicó la notación _outline_ de c4model.com en las tres vistas, con cajas
blancas y etiqueta de tipo, relaciones como líneas discontinuas grises, sistemas
externos codificados por categoría de color según sean de notificaciones, de
pagos y recaudo o de riesgo y cumplimiento, y una leyenda por diagrama. Se
corrigieron elementos huérfanos y etiquetas duplicadas en `component-view` y
`container-view`. Se mantuvieron los seis sistemas externos porque siguen
respaldados por los requisitos ASR-04, CU-13, CU-26, CU-27 y CU-29. Queda
pendiente reestructurar `container-view` y `component-view` para la arquitectura
de microservicios prevista, con API Gateway, servicios de saldos y cuentas,
productos, autenticación y dispositivos, auditoría y transferencias, mensajería
con Kafka y sistema de cajeros.

=== Iteración 3: Actualización requerida del diagrama de contexto

*Fecha:* 7 de septiembre de 2026 \
*Commit:* #link(commit_url + "68915d3b1141f9510276200b190764d03976fb90", [68915d3 · «Actualizacion requerida del diagrama de contexto»]), integrado por Samuel Beltrán \
*Actividad:* Diagramas / Arquitectura

==== Objetivo

Ampliar el diagrama de contexto con los actores de banca empresarial y de
sucursal que faltaban, para reflejar todos los interlocutores del Sistema
Bancario antes de redactar la sección de stakeholders.

==== Descripción

Contribución en el proceso creativo, sin código mergeado propio. Participé en la
discusión y definición de los nuevos actores que se incorporaron a
`system-context.drawio`: persona jurídica, personal de atención al cliente
virtual, asesor comercial, funcionario de créditos, jefe de la sucursal,
especialista en comercio exterior, gerente de banca corporativa y ejecutivo de
relación, junto con su descripción y sus relaciones con el sistema. El cambio lo
integró Samuel Beltrán. Este diagrama quedó como base directa de la Iteración 4.

=== Iteración 4: Primera versión de «Stakeholders e intereses»

*Fecha:* 7 de septiembre de 2026 \
*Commit:* #link(commit_url + "c82edafe9ba94adb2df6f2209acbd2a794b616e5", [c82edaf · «Agregar primera version de los stakeholders»]) \
*Actividad:* Documentación \
*Archivos:*
#link(git_base_url + "/docs/arch-description.typ", [arch-description.typ]).

==== Objetivo

Redactar la primera versión de la sección _Stakeholders e intereses_ del
documento de arquitectura, alineada con el diagrama de contexto.

==== Descripción

Se completó la tabla de stakeholders con las columnas de rol, información de
contacto e intereses o expectativas, tomando como base únicamente las personas
que interactúan con el sistema según `system-context.drawio`: persona natural y
jurídica, cajero, personal de atención al cliente presencial y virtual, asesor
comercial, funcionario de créditos, jefe de la sucursal, especialista en comercio
exterior, gerente de banca corporativa y ejecutivo de relación. Se dejaron fuera
los sistemas externos y los stakeholders del proyecto académico. Cada interés se
redactó a partir de la descripción y las relaciones del actor en el diagrama de
contexto. Queda pendiente cerrar la trazabilidad de los roles corporativos y de
sucursal, que aún no tienen CU ni ASR que los respalde.

=== Iteración 5: Primera iteración de diagramas E/R

*Fecha:* 14 de septiembre de 2026 \
*Commit:* #link(commit_url + "42801991d741fa15d435213a2788d421a0ef4c7e", [4280199 · «Primera iteracion de diagramas E/R»]) \
*Actividad:* Diagramas / Arquitectura \
*Archivos:*
#link(git_base_url + "/docs/diagrams/er/authSeguridad_er.drawio", [authSeguridad_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/cuentas_er.drawio", [cuentas_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/tarjetas_er.drawio", [tarjetas_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/transacciones_er.drawio", [transacciones_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/financiero_er.drawio", [financiero_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/crm_er.drawio", [crm_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/notificaciones_er.drawio", [notificaciones_er.drawio]),
#link(git_base_url + "/docs/diagrams/er/auditoria_er.drawio", [auditoria_er.drawio]).

==== Objetivo

Diseñar los diagramas Entidad-Relación de las bases de datos de cada uno de los
ocho microservicios del backend, normalizados a tercera forma normal y con
trazabilidad a los componentes definidos en `component-backend.drawio`.

==== Descripción

Se crearon ocho diagramas draw.io en `docs/diagrams/er/`, uno por microservicio:
Autenticación y Seguridad, Cuentas, Tarjetas, Transacciones, Financiero, CRM,
Notificaciones y Auditoría. Cada diagrama usa el formato de tabla relacional con
columnas de indicador PK/FK, nombre de atributo en _camelCase_ y tipo de dato SQL.
Las claves primarias son UUID y se incluyen llaves foráneas a sistemas externos
donde corresponde. Las entidades se clasifican por color: azul claro para tablas
principales, verde para catálogos, amarillo para tablas puente M:N y morado para
referencias a sistemas externos. Las relaciones usan notación _crow's foot_ con
cardinalidades explícitas. Queda pendiente la revisión de esquemas con el equipo
y la generación de los scripts DDL a partir de estos diagramas.

=== Iteración 6: Corrección del rango CU-31 en los diagramas de componentes

*Fecha:* 14 de septiembre de 2026 \
*Commit:* #link(commit_url + "e44327a7055bea1ce41881b4b6d7e48a8690e979", [e44327a · «Arreglo en diagramas de componentes, no se contemplaba el CU-31»]) \
*Actividad:* Diagramas / Documentación \
*Archivos:*
#link(git_base_url + "/docs/diagrams/components/component-backend.drawio", [component-backend.drawio]),
#link(git_base_url + "/docs/diagrams/components/component-web.drawio", [component-web.drawio]),
#link(git_base_url + "/docs/diagrams/components/component-mobile.drawio", [component-mobile.drawio]).

==== Objetivo

Corregir el rango de casos de uso declarado por el componente Transacciones, que
la tabla de casos de uso ya ubicaba en el CU-31 sin que los diagramas de
componentes lo reflejaran.

==== Descripción

Se comparó cada uno de los ocho componentes del backend contra los treinta y un
casos de uso del sistema y se encontró que Transacciones se describía como
CU-24 a CU-30 en los tres diagramas de componentes. Se amplió el texto a
CU-24 a CU-31 en los tres archivos.

=== Iteración 7: Entidad AutoSavingSchedule en el diagrama E/R de Cuentas

*Fecha:* 14 de septiembre de 2026 \
*Commit:* #link(commit_url + "830e86b51453acb91516ca0226705e08eb818a92", [830e86b · «Fix del diagrama ER para soportar el ahorro automatico»]) \
*Actividad:* Diagramas / Arquitectura \
*Archivos:*
#link(git_base_url + "/docs/diagrams/er/cuentas_er.drawio", [cuentas_er.drawio]).

==== Objetivo

Cerrar el vacío del modelo de datos de Cuentas, que aún no tenía ninguna tabla
capaz de persistir la programación de ahorro automático del CU-09.

==== Descripción

Se agregó la tabla AutoSavingSchedule con el monto, la frecuencia, la próxima
fecha de ejecución y las referencias a la cuenta origen y al destino en
subcuenta o meta de ahorro, junto con sus relaciones hacia Account, SubAccount
y SavingsGoal.

=== Iteración 8: Primera iteración del diagrama dinámico de ahorro automático

*Fecha:* 14 de septiembre de 2026 \
*Commit:* #link(commit_url + "480ee1b731d33dba63ef79d38cfd85d5f4f6e4f4", [480ee1b · «Primera iteracion del diagrama de ahorro automatico»]) \
*Actividad:* Diagramas / Arquitectura \
*Archivos:*
#link(git_base_url + "/docs/diagrams/processes/programacion-ahorro-automatico.drawio", [programacion-ahorro-automatico.drawio]).

==== Objetivo

Modelar el comportamiento del CU-09 en la sección de vista de procesos mediante
un C4 Dynamic Diagram en estilo secuencia.

==== Descripción

Se creó el primer diagrama dinámico en `diagrams/processes`, con el cliente
bancario, la aplicación, los componentes de Cuentas, Transacciones, Auditoría y
Notificaciones, la base de datos transaccional y el proveedor de notificaciones
como participantes. El flujo numerado cubre la configuración de la
programación y su ejecución automática mediante un disparador interno, con una
nota sobre el caso de saldo insuficiente. Queda pendiente enlazar este
diagrama desde `arch-description.typ`.

=== Iteración 9: Diagramas dinámicos de procesos restantes

*Fecha:* 14 de septiembre de 2026 \
*Commit:*
#link(commit_url + "c02eea6e6aafe36a5daf81048d7fdd53c68e305f", [c02eea6 · «CDT e inversiones»]),
#link(commit_url + "9290df6a5a3d18b65877ddd058d4e3d59dc49419", [9290df6 · «Gestión de préstamos»]),
#link(commit_url + "21f2d003c4eb7996af0211be1eacb7500d3ed488", [21f2d00 · «Pago de facturas de servicios»]),
#link(commit_url + "2a2ba7950cffbd8b71596932982a6041d35e5b21", [2a2ba79 · «Transferencias nacionales e internacionales»]),
#link(commit_url + "010fb0d2372c93b845612d6f9b9a237f7461f525", [010fb0d · «Transferencias cuentas propias y terceros»]) \
*Actividad:* Diagramas / Arquitectura \
*Archivos:*
#link(git_base_url + "/docs/diagrams/processes/solicitud-cdt-inversiones.drawio", [solicitud-cdt-inversiones.drawio]),
#link(git_base_url + "/docs/diagrams/processes/solicitud-gestion-prestamos.drawio", [solicitud-gestion-prestamos.drawio]),
#link(git_base_url + "/docs/diagrams/processes/pago-facturas-servicios.drawio", [pago-facturas-servicios.drawio]),
#link(git_base_url + "/docs/diagrams/processes/gestion-transferencias-internacionales-nacionales.drawio", [gestion-transferencias-internacionales-nacionales.drawio]),
#link(git_base_url + "/docs/diagrams/processes/transferencias-cuentas-propias-terceros.drawio", [transferencias-cuentas-propias-terceros.drawio]).

==== Objetivo

Completar la vista de procesos con un C4 Dynamic Diagram en estilo secuencia
para cada uno de los casos de uso críticos restantes de Financiero y
Transacciones: CU-12, CU-13, CU-27, CU-26 y CU-30.

==== Descripción

Se creó un diagrama dinámico por caso de uso en `diagrams/processes`, todos
con la misma convención visual y de nomenclatura del primer diagrama de
ahorro automático. Cada uno modela dos fases numeradas sobre los componentes
backend ya existentes en `component-backend.drawio`, con una nota sobre el
comportamiento crítico correspondiente cuando aplica. El de transferencias
internacionales aprovecha la relación ya modelada entre Transacciones y la
Pasarela de Pagos Internacionales, y el de transferencias a terceros suma el
componente CRM para la consulta de beneficiarios registrados. Ninguno de
estos cambios tocó el modelo ER ni los diagramas de componentes existentes.
Queda pendiente enlazar los seis diagramas de procesos desde
`arch-description.typ`.
