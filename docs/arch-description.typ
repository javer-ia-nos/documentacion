#set page(paper: "us-letter", numbering: "1", margin: (x: 2.5cm, y: 2.5cm))
#set text(font: "Times New Roman", size: 11pt, lang: "es")
#set heading(numbering: "1.1.")
#set par(justify: true)
#import "@preview/datify:1.3.0": display-date

#let version = sys.inputs.at("version", default: "No asignada")

// Función para resaltar las instrucciones que deben ser eliminadas
#let instruction(body) = block(
  fill: rgb("e6f2ff"),
  inset: 10pt,
  radius: 4pt,
  width: 100%,
  text(fill: rgb("003366"), size: 10pt, style: "italic")[
    *Instrucción:* #body
  ],
)

#set table(
  stroke: 0.5pt + gray,
  fill: (col, row) => if row == 0 { luma(230) } else { none },
)

// --- Portada ---
#align(center)[
  #v(4cm)
  #text(size: 24pt, weight: "bold")[Sistema Bancario]
  // #v(1cm)
  // #text(size: 14pt)[Plantilla basada en el estándar arc42]
  #v(2cm)
  #text(size: 12pt)[
    *Equipo:* Javer-IA-nos \
    *Organización:* Pontificia Universidad Javeriana \
    *Fecha de entrega:* #display-date(datetime.today()) \
    *Versión actual:* #version \ \
    *Autores:* \ Miguel Francisco Vargas \
    Sara Rodriguez Urueña \
    Juliana Sofia Novoa Solano \
    Salomon Alfredo Avila Larrotta \
    Samuel Beltrán Martínez \
    Arantxa Marian Espejo Malagon
  ]
]

#pagebreak()

// #instruction[
//   Esta plantilla está basada en el estándar arc42 https://arc42.org/overview \
//   A continuación, encontrará las secciones requeridas para su entrega del documento de Descripción de la Arquitectura del Software. Todos los párrafos del color de este texto son las instrucciones para completar cada sección. Deben ser removidos del documento a entregar.
// ]

= Historial de Cambios
#instruction[
  *Propósito:* Describir brevemente los cambios que ha sufrido el documento, con el fin de llevar una adecuada administración de configuración. \
  *Contenido:* Una tabla que indique los cambios que ha sufrido el documento. Debe incluir, al menos: fecha del cambio, descripción del cambio y persona(s) que realizaron el cambio.
]

#align(center)[
  #table(
    columns: (1fr, 3fr, 1fr),
    align: left,
    stroke: 0.5pt + luma(200),
    fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
    [*Fecha*], [*Descripción del cambio*], [*Autor(es)*],
    [2026-08-18],
    [Se incorporaron los 30 casos de uso categorizados y aprobados por el docente. Asimismo, se integró una versión preliminar de la introducción y la primera iteración del glosario del documento. Por ultimo, se realizo la primera iteración de los requisitos arquitectónicamente significativos],
    [Salomón Avila],
  )
]

#pagebreak()

#outline(title: [Tabla de Contenidos], depth: 3, indent: auto)
// #instruction[
//   *Propósito:* Encontrar rápidamente una sección específica del documento. El resumen, y las listas de figuras y tablas no se incluyen en esta sección. La tabla de contenidos comienza en la Introducción, que es la página uno del documento.
// ]

#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

= Introducción
#instruction[
  *Propósito:* que el lector entienda los elementos más generales del documento y determine si vale la pena seguir leyéndolo. \
  *Contenido:*
  - Una breve explicación de qué trata el sistema.
  - Principales objetivos de negocio que el sistema debe cumplir.
  - Principales atributos de calidad que debe satisfacer la arquitectura.
  - Cuáles son las principales secciones del documento y de qué trata cada una. \
  *Tamaño recomendado:* 1-2 páginas
]

En la actualidad, las personas realizan sus operaciones financieras cotidianas a través de aplicaciones y plataformas digitales. Por ello, este proyecto consiste en diseñar y desarrollar un sistema bancario organizado en módulos especializados como auditoría, atención al cliente, cuentas, productos financieros, notificaciones, seguridad, tarjetas y transacciones para que los usuarios puedan gestionar su dinero de forma fácil y segura.

Para lograrlo, la arquitectura del software se enfoca en cumplir con características clave de calidad que requiere un banco. En primer lugar, busca garantizar una alta disponibilidad para que el sistema nunca se detenga y las transacciones pendientes no queden inconclusas. También prioriza un buen rendimiento y una rápida desplegabilidad, de modo que las operaciones sean veloces y las actualizaciones de la plataforma se implementen sin afectar el servicio.

Asimismo, la seguridad y la protección operativa son fundamentales para evitar pérdidas económicas por errores del sistema y para blindar la información de los clientes frente a fraudes. La arquitectura también permite una alta integrabilidad con billeteras digitales, cajeros y otros bancos. Por último, se facilita la modificación y la comprobabilidad, asegurando que se puedan añadir nuevas funciones sin alterar lo ya construido y que cada parte del sistema pueda probarse de forma aislada y rigurosa.

Para detallar todo esto, el documento presenta primero una visión general de los requisitos funcionales del sistema. A continuación, expone el modelo de dominio, los requerimientos arquitectónicos, las vistas de la arquitectura, las decisiones técnicas tomadas y los posibles riesgos para asegurar el éxito del proyecto.

= Visión general de los requisitos funcionales

A continuación se detallan los 30 casos de uso funcionales del sistema bancario, estructurados de forma modular y con identificadores únicos, desglosando componentes clave como cuentas, tarjetas, canales de atención y seguridad:

#set text(size: 7pt)
#table(
  columns: (auto, auto, auto, auto, auto),
  table.header([*ID*], [*Caso de Uso*], [*Descripción Detallada*], [*Categoría*], [*Asignado a*]),

  [CU-01],
  [*Historial de actividad y sesiones*],
  [Auditoría de inicios de sesión y registros de actividad de la cuenta.],
  [Auditoría],
  [Arantxa Marian Espejo Malagon],

  [CU-02],
  [*Chat de atención al cliente*],
  [Soporte interactivo en línea para resolución de dudas.],
  [CRM],
  [Juliana Sofia Novoa Solano],

  [CU-03],
  [*Gestión de beneficiarios (CRM)*],
  [Registro, actualización y administración de contactos frecuentes para transferencias.],
  [CRM],
  [Miguel Francisco Vargas],

  [CU-04],
  [*Gestión de solicitudes PQRS*],
  [Radicación y seguimiento de Peticiones, Quejas, Reclamos y Solicitudes.],
  [CRM],
  [Juliana Sofia Novoa Solano],

  [CU-05],
  [*Reclamaciones por transacciones*],
  [Revisión y disputas por transacciones no reconocidas o fraudulentas.],
  [CRM],
  [Juliana Sofia Novoa Solano],

  [CU-06],
  [*Gestión de cuentas corrientes (CRUD)*],
  [Apertura, modificación, consulta y cancelación de cuentas corrientes.],
  [Cuentas],
  [Sara Rodriguez Urueña],

  [CU-07],
  [*Gestión de cuentas de ahorros (CRUD)*],
  [Apertura, modificación, consulta y cancelación de cuentas de ahorros.],
  [Cuentas],
  [Sara Rodriguez Urueña],

  [CU-08],
  [*Gestión de subcuentas*],
  [Permitir al usuario separar dinero del saldo disponible en subcuentas de ahorro.],
  [Cuentas],
  [Sara Rodriguez Urueña],

  [CU-09],
  [*Programación de ahorro automático*],
  [Automatización de transferencias periódicas hacia metas o subcuentas de ahorro.],
  [Cuentas],
  [Miguel Francisco Vargas],

  [CU-10],
  [*Certificados bancarios*],
  [Generación automatizada de certificados de cuentas y productos.],
  [Financiero],
  [Samuel Beltrán Martínez],

  [CU-11],
  [*Consulta de saldo y movimientos*],
  [Visualización en tiempo real del saldo disponible y extractos detallados.],
  [Financiero],
  [Miguel Francisco Vargas],

  [CU-12],
  [*Solicitud de CDT e inversiones*],
  [Creación de certificados de depósito a término y consulta de rendimientos.],
  [Financiero],
  [Samuel Beltrán Martínez],

  [CU-13],
  [*Solicitud y gestión de préstamos*],
  [Aprobación, seguimiento y amortización de créditos bancarios.],
  [Financiero],
  [Samuel Beltrán Martínez],

  [CU-14],
  [*Notificaciones de movimientos*],
  [Envío de alertas instantáneas vía push, SMS o correo por cualquier tipo de transacción.],
  [Notificaciones],
  [Juliana Sofia Novoa Solano],

  [CU-15],
  [*Autenticación de usuarios*],
  [Acceso al sistema mediante credenciales.],
  [Seguridad],
  [Arantxa Marian Espejo Malagon],

  [CU-16],
  [*Autorización y control de roles*],
  [Verificación de permisos según el perfil del usuario autenticado.],
  [Seguridad],
  [Arantxa Marian Espejo Malagon],

  [CU-17],
  [*Gestión de dispositivos confiables*],
  [Registro, consulta y revocación de dispositivos seguros autorizados.],
  [Seguridad],
  [Salomon Alfredo Avila Larrotta],

  [CU-18],
  [*Gestión de seguridad de la cuenta*],
  [Cambio de claves, segundo factor y políticas de protección contra fraude.],
  [Seguridad],
  [Arantxa Marian Espejo Malagon],

  [CU-19],
  [*Límites y permisos de transacciones*],
  [Establecimiento de topes máximos diarios y por operación.],
  [Seguridad],
  [Arantxa Marian Espejo Malagon],

  [CU-20],
  [*Bloqueo y desbloqueo de tarjetas*],
  [Inhabilitación temporal o definitiva de tarjetas en caso de robo o pérdida.],
  [Tarjetas],
  [Juliana Sofia Novoa Solano],

  [CU-21],
  [*Emisión y gestión de tarjetas de crédito*],
  [Solicitud, activación y configuración de tarjetas de crédito.],
  [Tarjetas],
  [Sara Rodriguez Urueña],

  [CU-22],
  [*Emisión y gestión de tarjetas de débito*],
  [Solicitud, activación y configuración de tarjetas de débito.],
  [Tarjetas],
  [Sara Rodriguez Urueña],

  [CU-23],
  [*Realización de avances de tarjeta de crédito*],
  [Desembolso de efectivo a partir del cupo de la tarjeta de crédito.],
  [Tarjetas],
  [Miguel Francisco Vargas],

  [CU-24],
  [*Administración de pagos automáticos*],
  [Configuración de débitos programados y cobros periódicos automáticos.],
  [Transacciones],
  [Salomon Alfredo Avila Larrotta],

  [CU-25],
  [*Generación y escaneo de códigos QR*],
  [Cobros y pagos inmediatos mediante códigos QR.],
  [Transacciones],
  [Miguel Francisco Vargas],

  [CU-26],
  [*Gestión de transferencias internacionales*],
  [Envío y recepción de fondos hacia o desde el exterior.],
  [Transacciones],
  [Salomon Alfredo Avila Larrotta],

  [CU-27],
  [*Pago de facturas de servicios*],
  [Cancelación de servicios públicos y privados mediante convenios registrados.],
  [Transacciones],
  [Samuel Beltrán Martínez],

  [CU-28],
  [*Pagos físicos y transacciones presenciales*],
  [Gestión de cheques y consignaciones en ventanilla o canales físicos.],
  [Transacciones],
  [Salomon Alfredo Avila Larrotta],

  [CU-29],
  [*Soporte para billeteras externas*],
  [Vinculación de tarjetas a plataformas como Apple Pay o Google Wallet.],
  [Transacciones],
  [Samuel Beltrán Martínez],

  [CU-30],
  [*Transferencias entre cuentas propias y a terceros*],
  [Envío de fondos entre cuentas del mismo banco o cuentas interbancarias.],
  [Transacciones],
  [Salomon Alfredo Avila Larrotta],
)

#set text(size: 7pt)

= Modelo de dominio
#instruction[
  Diagrama que muestra los principales conceptos del sistema y sus relaciones. \
  *Contenido:* \
  - Diagramas de clases UML, donde cada clase representa un concepto del sistema (ver https://www.uml-diagrams.org/examples/hospital-domain-diagram.html) \
  - Tabla con las siguientes columnas: Concepto, Explicación
]

#table(
  columns: (1fr, 3fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Concepto*], [*Explicación*],
  [], [],
)

= Stakeholders e intereses
#instruction[
  Una tabla que especifique cada stakeholder, su información de contacto y qué intereses o expectativas tiene sobre el sistema que se está desarrollando (cómo espera beneficiarse del mismo).
]

#table(
  columns: (1fr, 2fr, 2fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Rol/Nombre*], [*Información de Contacto*], [*Intereses / expectativas*],
  [], [], [],
)

= Requisitos Arquitectónicamente Significativos (ASR)

#set text(size: 7pt)
#table(
  columns: (auto, auto, auto, auto, auto, auto, auto, auto),
  [*ID ASR*],
  [*Título del ASR*],
  [*Atributo de calidad*],
  [*Sub-atributo*],
  [*Funcionalidades*],
  [*Escenarios ASR*],
  [*Prioridad*],
  [*Asignado a*],

  [ASR-01],
  [Disponibilidad Transaccional],
  [Disponibilidad],
  [Tolerancia a fallos],
  [CU-11, CU-24, CU-26, CU-27, CU-30],
  [Ante una interrupción imprevista de la red durante una transferencia internacional o de terceros, el sistema debe reintentar o asegurar la atomicidad de la transacción sin comprometer el saldo del usuario.],
  [Alta],
  [Salomon Alfredo Avila Larrotta],

  [ASR-02],
  [Rendimiento en Operaciones Críticas],
  [Performance],
  [Tiempo de respuesta],
  [CU-11, CU-15, CU-25, CU-30],
  [El procesamiento de pagos mediante códigos QR y transferencias entre cuentas debe completarse en un tiempo de respuesta inferior a 2 segundos bajo alta concurrencia de usuarios.],
  [Alta],
  [Miguel Francisco Vargas],

  [ASR-03],
  [Seguridad y Protección contra Fraude],
  [Security],
  [Confidencialidad e Integridad],
  [CU-01, CU-02, CU-15, CU-18, CU-19, CU-26],
  [Un usuario no autorizado intenta acceder a la plataforma o vulnerar los controles de roles y doble factor; el sistema debe bloquear el acceso de forma inmediata y registrar el evento en auditoría.],
  [Alta],
  [Arantxa Marian Espejo Malagon],

  [ASR-04],
  [Integrabilidad con Terceros y Billeteras],
  [Integrability],
  [Interoperabilidad],
  [CU-12, CU-13, CU-27, CU-29],
  [El sistema debe integrarse de manera fluida y estandarizada con plataformas externas como Apple Pay, Google Wallet y pasarelas de pagos internacionales mediante APIs seguras.],
  [Alta],
  [Samuel Beltrán Martínez],

  [ASR-05],
  [Modificabilidad y Gestión de Productos],
  [Modifiability],
  [Extensibilidad],
  [CU-04, CU-05, CU-06, CU-07, CU-08, CU-21, CU-22],
  [Ante el lanzamiento de una nueva regulación o tipo de producto de crédito/ahorro, los desarrolladores deben poder modificar o añadir la lógica del CRUD de cuentas y tarjetas sin alterar los módulos de transacciones.],
  [Media],
  [Sara Rodriguez Urueña],

  [ASR-06],
  [Testabilidad y Auditoría del Sistema],
  [Testability],
  [Aislamiento y Trazabilidad],
  [CU-01, CU-04, CU-05, CU-14, CU-20, CU-24],
  [El equipo de calidad debe poder aislar y probar unitariamente los módulos de cuentas, PQRS y registros de auditoría de sesiones para verificar el cumplimiento normativo.],
  [Media],
  [Juliana Sofia Novoa Solano],
)
#set text(size: 11pt)

= Restricciones
#instruction[
  Indique cualquier restricción que limite la libertad de los ingenieros a la hora de decidir la arquitectura del sistema y las soluciones a los ASR. Las principales categorías de restricciones son: \
  - *Técnicas:* Directamente relacionadas con las tecnologías, métodos de ingeniería, sistemas de software, etc. \
  - *Organizacionales/políticas:* Situaciones internas o externas a la organización y de las personas que limiten las decisiones arquitectónicas del sistema. \
  - *Convencionales:* Necesidades de seguimiento de estándares, guías de codificación, leyes, etc.
]

#table(
  columns: (1fr, 1fr, 2fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Restricción*], [*Categoría*], [*Descripción*],
  [], [], [],
)

= Contexto y Alcance

#figure(
  caption: "Diagrama de contexto del sistema",
  align(
    center,
    image(
      "diagrams/system-context.png",
      width: 80%,
    ),
  ),
) <fig-system-context>

#instruction[
  Relación entre el sistema y su entorno (personas y otros sistemas). \
  *Contenido:* \
  - C4 Context Diagram o C4 System Landscape Diagram. Debe incluir todos los elementos externos relevantes (Actores, Sistemas externos). \
  - Explicación del diagrama.
]

= Vista de contenedores

#figure(
  caption: "Diagrama de vista de contenedores",
  align(
    center,
    image(
      "diagrams/container-view.png",
      width: 80%,
    ),
  ),
) <fig-container-view>

#instruction[
  Describir los contenedores y sus relaciones entre sí. \
  *Contenido:* C4 Container Diagram y explicación del diagrama.
]

= Vista de componentes

#figure(
  caption: "Diagrama de vista de componentes",
  align(
    center,
    image(
      "diagrams/component-view.png",
      width: 80%,
    ),
  ),
) <fig-component-view>

#instruction[
  Para cada contenedor de la sección anterior, describir sus componentes y relaciones entre sí. \
  *Contenido:* C4 Component Diagram (al menos uno por cada contenedor de la sección anterior) y explicación de cada diagrama.
]

= Vista de procesos
#instruction[
  Describir el comportamiento de las partes más críticas del sistema. No es necesario detallar el comportamiento de todos los elementos del sistema, sino solo aquellos más críticos en relación con los atributos de calidad. \
  *Contenido:* Para cada parte del sistema que lo requiera, un C4 Dynamic Diagram y explicación para cada diagrama.
]

= Vista física
#instruction[
  Para cada ambiente de ejecución (desarrollo, pruebas y producción), describir cómo se desplegarán los contenedores del sistema. \
  *Contenido:* C4 Deployment Diagram, al menos uno por cada ambiente de ejecución, y explicación de cada diagrama.
]

= Modelo de datos
#instruction[
  Si aplica, esta sección debe mostrar todos los modelos de datos persistentes usados en la aplicación: modelos ER, modelos de entidades, etc. Si es una arquitectura distribuida, indicar claramente a qué componentes o contenedores aplica cada modelo de datos. \
  *Contenido:* diagramas y su correspondiente explicación.
]

= Registros de Decisiones Arquitectónicas (ADR)
#instruction[
  Detallar la solución a cada ASR de alta prioridad mencionado en la sección "Requisitos Arquitectónicamente Significativos (ASR)". Cada ASR puede tener asociado uno o varios Registros de Decisiones de Diseño (ADR). \
  *Contenido:* Para cada decisión de alta prioridad, una subsección con los siguientes elementos: \
  - ID y Título del ADR. \
  - ID y Título del ASR. \
  - Problema: Descripción detallada del problema a resolver. \
  - Solución: Descripción detallada de la decisión. Típicamente requiere referenciar diagramas. Detallar: Tecnologías seleccionadas, Patrones y estilos, Metodologías/procesos. \
  - Consecuencias: positivas y negativas de dicha decisión.
]

= Riesgos técnicos
#instruction[
  Indicar todo lo que puede salir mal producto de cómo ha sido definida la arquitectura. Por ejemplo, componentes que pueden funcionar mal bajo ciertas condiciones, eventos que pueden hacer que se incumplan algunos atributos de calidad, etc. \
  *Contenido:* Tabla de riesgos ordenados por prioridad (Alta probabilidad + alto impacto = alta prioridad; Baja probabilidad + bajo impacto = baja prioridad). \
  - *Plan de mitigación:* qué hacer para reducir la probabilidad de que ocurra el riesgo. \
  - *Plan de contingencia:* qué hacer si el riesgo se materializa ("plan B").
]

#set text(size: 9pt)
#table(
  columns: (1fr, auto, auto, auto, 2fr, 2fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Riesgo*], [*Probabilidad*], [*Impacto*], [*Prioridad*], [*Plan de mitigación*], [*Plan de contingencia*],
  [], [], [], [], [], [],
)
#set text(size: 11pt)

= Glosario

Este glosario define los términos técnicos y de negocio utilizados a lo largo del documento, diseñados para facilitar la comprensión tanto de lectores con perfiles técnicos como de negocio.

* **Arquitectura de software*: Estructura fundamental de un sistema informático, compuesta por sus elementos, las relaciones entre ellos y las propiedades de ambos, que sirve de base para su diseño y evolución futura.

* **Atributo de calidad*: Característica no funcional que evalúa qué tan bien un sistema cumple con los requisitos operativos y de negocio, tales como la disponibilidad, la seguridad o el rendimiento.

* **Auditoría*: Módulo o proceso encargado de registrar, rastrear y supervisar todas las actividades, transacciones e inicios de sesión realizados en el sistema para garantizar la trazabilidad y seguridad.

* **Disponibilidad*: Atributo de calidad que mide la capacidad del sistema para mantenerse operativo y accesible de forma continua, asegurando que no se interrumpan transacciones en curso.

* **Integrabilidad*: Capacidad del sistema para conectarse, comunicarse e intercambiar datos de forma fluida con plataformas externas, tales como billeteras digitales, cajeros automáticos u otras entidades bancarias.

* **Modelo de dominio*: Representación conceptual de los objetos, entidades y reglas del mundo real dentro del negocio bancario (como cuentas, clientes, transacciones y tarjetas) que forman la lógica central del sistema.

* **Módulo*: Componente o unidad lógica independiente dentro del sistema software que agrupa una serie de funcionalidades específicas y acotadas.

* **Notificaciones*: Sistema automatizado encargado de enviar alertas instantáneas a los usuarios a través de canales como mensajes de texto, correos electrónicos o notificaciones emergentes sobre el estado de sus movimientos.

* **Procesamiento de transacciones*: Mecanismo encargado de recibir, validar, ejecutar y registrar operaciones financieras (como transferencias o pagos) garantizando la consistencia y seguridad del dinero.

* **Requisito funcional*: Descripción de un comportamiento, servicio o función específica que el sistema debe ser capaz de realizar bajo ciertas condiciones.

* **Requisitos Arquitectónicamente Significativos (ASR)*: Requisitos del sistema que tienen un impacto directo y profundo en la estructura y diseño de la arquitectura de software.

* **Seguridad y Protection Operativa (Safety)*: Conjunto de mecanismos orientados a proteger la información confidencial de los usuarios, controlar el acceso a las cuentas y prevenir pérdidas económicas o fraudes derivados de fallos en el sistema.

* **Sistema bancario*: Plataforma tecnológica integral diseñada para gestionar cuentas, productos financieros, transacciones y servicios de atención a los clientes de una entidad financiera.

* **Usabilidad*: Medida en la que el sistema y su interfaz gráfica permiten a los usuarios operar de manera intuitiva, rápida y sin fricciones técnicas.

= Referencias
#instruction[
  Referencias bibliográficas en formato APA o IEEE que hayan sido usadas en el documento[cite: 1].
]
