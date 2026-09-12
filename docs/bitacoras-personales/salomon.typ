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
