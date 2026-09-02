#let version = sys.inputs.at("version", default: "main")
#let git_base_url = "https://github.com/javer-ia-nos/Documentacion/tree/" + version
#let commit_url = "https://github.com/javer-ia-nos/Documentacion/commit/"

== Bitácora de Salomon Alfredo Avila Larrotta

Registro de contribuciones al diseño y la documentación de la arquitectura del
Sistema Bancario. Cada iteración indica su objetivo, el trabajo realizado, las
decisiones tomadas con su justificación, el resultado y el commit asociado.

=== Iteración 1 — Diagrama de Contexto del Sistema (C4 nivel 1)

*Fecha:* 21 de agosto de 2026 \
*Commit:* #link(commit_url + "344e80a315307f68a30e199e54b45399e2e39496", [344e80a — «Primera iteracion SystemContext»]) \
*Actividad:* Diagramas / Arquitectura

==== Objetivo

Construir el primer diagrama C4 de _System Context_ del Sistema Bancario a partir
de los casos de uso (CU-01 a CU-30) y los Requisitos Arquitectónicamente
Significativos (ASR-01 a ASR-06) levantados previamente, dejando trazabilidad
explícita entre cada elemento del diagrama y los requisitos que lo justifican.

==== Trabajo realizado

- Se trabajó con #link("https://goa.design/model/", [goa.design/model]) como
  herramienta de modelado: describe el modelo C4 como código Go y genera los
  diagramas con su CLI (`mdl`), lo que permite versionar y revisar el diagrama
  por _pull request_.
- Se partió de la plantilla de ejemplo _Big Bank plc_ que incluye la
  herramienta y se reescribió por completo al dominio del proyecto en
  `diagrams/test/model.go`:
  - *Actores:* Cliente bancario y Agente de Atención al Cliente.
  - *Sistema en alcance:* Sistema de Banca Digital.
  - *Sistemas externos:* Proveedor de Notificaciones, Billeteras Digitales
    Externas, Central de Riesgo – Bureau de Crédito, Proveedores de Servicios
    Públicos, Pasarela de Pagos Internacionales y Ente Regulador Financiero.
- Cada sistema externo y cada relación se anotó con los CU y ASR que la
  originan (p. ej. la Pasarela de Pagos Internacionales responde a CU-26 y
  ASR-01; el Bureau de Crédito a CU-13; el Ente Regulador a CU-01, ASR-03 y
  ASR-06).
- Se depuró el modelo para dejarlo solo en el nivel 1 de C4: se eliminaron los
  contenedores y las relaciones de niveles inferiores que traía el ejemplo, y se
  ajustaron el nombre del paquete y los _imports_ para que el modelo compilara y
  el generador produjera el SVG.
- Se definieron estilos por _tag_ (`persona`, `interno`, `externo`) para
  diferenciar visualmente los tipos de elemento.

==== Decisiones y justificación

- *Modelo como código en lugar de dibujo manual:* prioriza la trazabilidad y el
  control de cambios; el diagrama se regenera desde una única fuente de verdad.
- *Alcance limitado al nivel 1:* el objetivo de la iteración era acordar la
  frontera del sistema y sus interlocutores externos antes de entrar en
  contenedores y componentes.

==== Resultado

Modelo `model.go` compilable que genera `diagrams/gen/SystemContext.svg` con el
diagrama de contexto y sus estilos por _tag_.

==== Nota posterior

Días después el equipo migró los diagramas de `goa.design/model` a
#link(git_base_url + "/docs/diagrams", [draw.io]) por problemas de compatibilidad
de la herramienta, por lo que `model.go` dejó de ser la fuente de verdad. El
contenido de este diagrama se conservó y se trasladó a
#link(git_base_url + "/docs/diagrams/system-context.drawio", [system-context.drawio]).

=== Iteración 2 — Notación C4 y limpieza de los tres diagramas

*Fecha:* 1 de septiembre de 2026 \
*Commit:* #link(commit_url + "fd587dffee96f94bfb3b9fd067770ad6a7628fcf", [fd587df — «Cambio visual de diagramas»]) \
*Actividad:* Diagramas / Documentación \
*Archivos:*
#link(git_base_url + "/docs/diagrams/system-context.png", [system-context.png]),
#link(git_base_url + "/docs/diagrams/container-view.png", [container-view.png]),
#link(git_base_url + "/docs/diagrams/component-view.png", [component-view.png]).

==== Objetivo

Alinear los tres diagramas C4 (contexto, contenedores y componentes) con la
arquitectura objetivo del equipo y con la notación oficial de
#link("https://c4model.com/", [c4model.com]), y corregir las inconsistencias
acumuladas entre ellos.

==== Trabajo realizado

- *Ajuste del diagrama de contexto a la arquitectura objetivo.*
  - Se añadió la persona _Cajero_ (operaciones presenciales de ventanilla:
    consignaciones, retiros y cheques — CU-28), que antes no estaba
    representada.
  - Se amplió «Agente de Atención al Cliente» a _Personal del Banco (soporte y
    back-office)_, porque el canal interno no se limita al chat de PQRS.
  - Se renombró «Sistema de BancaDigital» a _Sistema Bancario_ y se corrigieron
    erratas de las descripciones.
  - Se reubicaron los actores y se reenrutaron las flechas para que las
    etiquetas no se solaparan.
- *Paleta C4 canónica.* El diagrama de contexto usaba colores propios
  (`#083F75`, `#1061B0`, un gris-morado `#8C8496`); se normalizó a la paleta
  estándar de C4 (persona `#08427B`, sistema en alcance `#1168BD`, externo
  `#999999`). Los diagramas de contenedores y componentes ya la usaban.
- *Notación «outline» de c4model.com en las tres vistas.*
  - Cajas de fondo blanco con borde y texto de color y etiqueta de tipo
    (`[Persona]`, `[Sistema de software]`, `[Contenedor]`, `[Componente]`).
  - Relaciones como líneas discontinuas grises con la etiqueta también en gris.
  - Sistemas externos codificados por _categoría de color_: rojo = Notificaciones;
    naranja = Pagos y recaudo (billeteras, servicios públicos, pasarela
    internacional); morado = Riesgo y cumplimiento (bureau de crédito, ente
    regulador).
  - Se agregó una _leyenda_ a cada diagrama y se unificó el nombre de la
    frontera a «Sistema Bancario».
- *Eliminación de información duplicada o inconsistente.*
  - _component-view:_ una flecha «Reporta eventos de auditoría y cumplimiento
    normativo» quedaba suelta (sin origen ni destino, resto de la vista de
    contenedores); se reconectó _Auditoría → Ente Regulador Financiero_.
  - _component-view:_ la etiqueta «Lee y escribe información transaccional»
    aparecía en dos flechas hacia la base de datos; la del componente de
    autenticación se corrigió a «Lee y escribe sesiones, roles y dispositivos».
  - _container-view:_ «Cliente Bancario» → «Cliente bancario» para que coincida
    con el diagrama de contexto.

==== Decisiones y justificación

- *Adoptar la notación de c4model.com:* es la referencia estándar del modelo C4
  (Simon Brown); el estilo _outline_ mejora la legibilidad y hace que las tres
  vistas se lean como un mismo sistema.
- *Color por categoría en los sistemas externos:* con seis sistemas externos un
  único color no aporta; agruparlos por dominio (notificaciones, pagos,
  regulación) facilita ubicar de qué se está hablando.
- *Mantener los seis sistemas externos pese al nuevo boceto de arquitectura:*
  siguen respaldados por ASR y CU (ASR-04, CU-13, CU-26, CU-27, CU-29); el
  boceto solo los omitía por enfocarse en el interior del sistema.
- *No rediseñar aún la vista de contenedores:* el boceto objetivo (API Gateway,
  microservicios, Kafka, sistema de cajeros) implica reestructurar
  `container-view` y `component-view`; se deja como trabajo siguiente para no
  mezclarlo con el cambio de notación.

==== Resultado

Los tres `.drawio` comparten paleta, notación y leyenda; el diagrama de contexto
refleja los canales de clientes (web y móvil), el de cajeros y el portal interno,
junto con sus interlocutores externos. Se eliminaron los elementos huérfanos y
las etiquetas repetidas.

==== Pendiente

Reestructurar `container-view` y `component-view` para la arquitectura de
microservicios: API Gateway, servicios de saldos/cuentas, productos,
autenticación y dispositivos, auditoría y transferencias, mensajería con Kafka y
sistema de cajeros.
