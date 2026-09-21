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

    [2026-08-30],
    [Se revisaron los casos de uso y modificaron para especificar mejor algunos puntos importantes.
      - *CU-14 ( Notificaciones )*: Se agregan algunos tipos importantes de notificaciones.
      - *CU-21 ( Gestión de TC )*: Se agregan consultas importantes para el usuario.
      - *CU-26 ( transferencias )*: Se generaliza este caso de uso para permitir transacciones internas y nacionales.
      - *CU-31 ( info intereses e impuestos)*: Información clara para los usuarios.
      - *CU-32 ( facturas y servicios )*: Para poder pagar facturas y servicios.
    ],
    [Miguel Francisco Vargas],

    [2026-09-07],
    [Se agregaron los nuevos diagramas de componentes para cada contenedor del sistema.],
    [Miguel Francisco Vargas],

    [2026-09-07], [Se añadio la primera version de los stakeholders], [Salomon Avila],

    [2026-09-19], [Se intercambiaron los casos de uso entre Juliana y Sara], [Sara Rodríguez],

    [2026-09-20], [Inclusión de la entidad ChatMessage en el modelo E/R de CRM (CU-02) para el soporte del historial de mensajes en chat de atención.], [Equipo de Arquitectura],
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
  [Sara Rodríguez Urueña],

  [CU-03],
  [*Gestión de beneficiarios*],
  [Registro, actualización y administración de contactos frecuentes para transferencias.],
  [Cuentas],
  [Miguel Francisco Vargas],

  [CU-04],
  [*Gestión de solicitudes PQRS*],
  [Radicación y seguimiento de Peticiones, Quejas, Reclamos y Solicitudes.],
  [CRM],
  [Sara Rodríguez Urueña],

  [CU-05],
  [*Reclamaciones por transacciones*],
  [Revisión y disputas por transacciones no reconocidas o fraudulentas.],
  [CRM],
  [Sara Rodríguez Urueña],

  [CU-06],
  [*Gestión de cuentas corrientes (CRUD)*],
  [Apertura, modificación, consulta y cancelación de cuentas corrientes.],
  [Cuentas],
  [Juliana Sofia Novoa Solano],

  [CU-07],
  [*Gestión de cuentas de ahorros (CRUD)*],
  [Apertura, modificación, consulta y cancelación de cuentas de ahorros.],
  [Cuentas],
  [Juliana Sofia Novoa Solano],

  [CU-08],
  [*Gestión de subcuentas*],
  [Permitir al usuario separar dinero del saldo disponible en subcuentas de ahorro.],
  [Cuentas],
  [Juliana Sofia Novoa Solano],

  [CU-09],
  [*Programación de ahorro automático*],
  [Automatización de transferencias periódicas hacia metas o subcuentas de ahorro.],
  [Cuentas],
  [Miguel Francisco Vargas],

  [CU-10],
  [*Certificados bancarios*],
  [Generación automatizada de certificados de cuentas y productos.],
  [Financiero],
  [Juliana Sofía Novoa Solano],

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
  [*Centro de notificaciones*],
  [Configuración y envío de alertas transaccionales (vía push, SMS o correo) por movimientos superiores a montos definidos o ingresos desde dispositivos nuevos. Notificaciones publicitarias, informativas, entre otras.],
  [Notificaciones],
  [Sara Rodríguez Urueña],

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
  [Sara Rodríguez Urueña],

  [CU-21],
  [*Emisión y gestión de tarjetas de crédito*],
  [Solicitud, activación y configuración de tarjetas de crédito. Consulta de cupo, visualización de movimientos, pago de extracto a cuotas y avances de efectivo.],
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
  [Sara Rodríguez Urueña],

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
  [*Gestión de transferencias internacionales y nacionales*],
  [Envío y recepción de fondos hacia o desde el exterior. Envio y recepción de fondos interbancarias o internas.],
  [Transacciones],
  [Salomon Alfredo Avila Larrotta],

  [CU-27],
  [*Pago de facturas de servicios*],
  [Cancelación de servicios públicos y privados mediante convenios registrados, además de recargas a operadores moviles.],
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

  [CU-31],
  [*Información clara sobre intereses e impuestos aplicados a compras*],
  [Información clara sobre intereses e impuestos aplicados a compras, ya sea en avances, compras por tarjeta de credito o creditos ofrecidos. Visualización de cuotas pendientes y abonos a capital.],
  [Transacciones],
  [Samuel Beltrán Martínez],
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

#set text(size: 9pt)
#table(
  columns: (1.2fr, 1.3fr, 2.5fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Rol/Nombre*], [*Información de Contacto*], [*Intereses / expectativas*],

  [Persona natural],
  [Canales digitales: app móvil y portal web],
  [Consultar saldos, realizar transferencias, gestionar tarjetas y solicitar productos financieros desde web y móvil. Espera disponibilidad continua del servicio, transacciones que se completen en pocos segundos y protección de sus datos y fondos frente a fraudes.],

  [Persona jurídica],
  [Canales digitales: app móvil y portal web; ejecutivo de relación asignado],
  [Gestionar los productos financieros de la empresa por canales digitales con controles y trazabilidad. Espera soporte para operaciones de alto volumen, segregación de permisos y disponibilidad para su operación diaria.],

  [Cajero],
  [Sucursal, módulo del sistema para cajeros],
  [Registrar operaciones presenciales de ventanilla tales como consignaciones, retiros y cheques de forma confiable y con conciliación correcta contra las cuentas de los clientes.],

  [Personal de atención al cliente presencial],
  [Sucursal, puesto de atención],
  [Atender dudas generales de los usuarios y asignar turnos. Espera acceso ágil a la información del cliente para resolver consultas y canalizar solicitudes.],

  [Personal de atención al cliente virtual],
  [Centro de contacto, por canales virtuales],
  [Atender los canales generales de preguntas de los usuarios de forma remota. Espera herramientas con acceso al historial del cliente y tiempos de respuesta bajos.],

  [Asesor comercial],
  [Sucursal o canal comercial],
  [Ofrecer asesoramiento sobre inversiones, préstamos y crecimiento de patrimonio. Espera consultar productos e información del cliente para proponer soluciones a la medida.],

  [Funcionario de créditos],
  [Área de crédito y cartera],
  [Evaluar y hacer seguimiento a las solicitudes de financiación y abrir procesos de crédito. Espera poder consultar el historial crediticio del solicitante y gestionar el ciclo de la solicitud.],

  [Jefe de la sucursal],
  [Dirección de sucursal],
  [Controlar que los registros y procesos diarios de la sucursal funcionen de manera correcta. Espera funciones de coordinación y verificación general de la operación.],

  [Especialista en comercio exterior],
  [Área de comercio exterior],
  [Apoyar a las empresas que importan o exportan mediante cartas de crédito. Espera gestionar giros internacionales y el financiamiento del comercio fronterizo.],

  [Gerente de Banca Corporativa],
  [Banca corporativa],
  [Dirigir las estrategias de entrada y salida de dinero para clientes corporativos. Espera visibilidad y liderazgo financiero estratégico sobre las operaciones de grandes empresas.],

  [Ejecutivo de Relación],
  [Banca corporativa, cartera empresarial],
  [Administrar la cartera de empresas asignada, analizar las necesidades del negocio y ofrecer soluciones a medida a partir de la información del sistema.],
)
#set text(size: 11pt)

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
  [Juliana Sofia Novoa Solano],

  [ASR-06],
  [Testabilidad y Auditoría del Sistema],
  [Testability],
  [Aislamiento y Trazabilidad],
  [CU-01, CU-04, CU-05, CU-14, CU-20, CU-24],
  [El equipo de calidad debe poder aislar y probar unitariamente los módulos de cuentas, PQRS y registros de auditoría de sesiones para verificar el cumplimiento normativo.],
  [Media],
  [Sara Rodriguez Urueña],
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

El diagrama de contexto (@fig-system-context) ubica al Sistema Bancario en el centro y muestra los dieciséis actores que interactúan con él. Los clientes finales, la persona natural y la persona jurídica, consultan saldos, realizan transferencias, gestionan tarjetas y solicitan productos financieros desde los canales web y móvil. El resto son roles internos del banco: el cajero atiende las operaciones de ventanilla, el personal de atención al cliente presencial y virtual resuelve dudas y asigna turnos, y el asesor comercial, el funcionario de créditos, el jefe de la sucursal, el especialista en comercio exterior, el gerente de Banca Corporativa y el ejecutivo de relación cumplen funciones administrativas y comerciales, cada uno con una relación distinta hacia el sistema.

Hacia afuera, el sistema se integra con seis sistemas externos. El proveedor de notificaciones envía alertas y eventos de seguridad. Las billeteras digitales externas se sincronizan con las tarjetas vinculadas del cliente. La central de riesgo entrega el score crediticio necesario para aprobar los préstamos. Los proveedores de servicios públicos reciben los pagos de facturas registradas. La pasarela de pagos internacionales procesa las transferencias al exterior. Y el ente regulador financiero recibe los reportes de auditoría y cumplimiento. Cada relación queda etiquetada con el propósito del intercambio de información, siguiendo la notación de c4model.com.

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

El diagrama de contenedores (@fig-container-view) describe tres puntos de entrada para los actores humanos. La Single-Page Application, construida en React y TypeScript, atiende a los clientes que operan desde el navegador. La Aplicación Móvil, en React Native, atiende a los clientes desde el smartphone y todavía consume la API de cada microservicio directamente, sin pasar por un API Gateway. El Portal de Atención y Backoffice, también en React, permite que el Agente de Atención al Cliente gestione PQRS, reclamaciones y chats de soporte. Los tres llaman al dominio de backend, compuesto por los mismos ocho microservicios ya presentados en la Vista de componentes: Autenticación y Seguridad, Cuentas, Tarjetas, Transacciones, Financiero, CRM, Notificaciones y Auditoría. Estos microservicios se comunican entre sí de forma asíncrona a través del Broker de Eventos Kafka, salvo las validaciones de saldo y cupo, que viajan por gRPC directo hacia Cuentas porque requieren respuesta inmediata. Hacia afuera, cada microservicio dueño de la integración correspondiente se comunica directamente con su sistema externo: Transacciones con la Pasarela de Pagos Internacionales, los Proveedores de Servicios Públicos y las Billeteras Digitales; Financiero con la Central de Riesgo; Notificaciones con el Proveedor de Notificaciones; y Auditoría con el Ente Regulador Financiero.

= Vista de componentes

== Vista de componentes para el Back-End

#figure(
  caption: "Diagrama de vista de componentes para el Back-end",
  align(
    center,
    image(
      "diagrams/components/component-backend.png",
      width: 80%,
    ),
  ),
) <fig-backend-component-view>

== Vista de componentes para la página web

#figure(
  caption: "Diagrama de vista de componentes para la página web",
  align(
    center,
    image(
      "diagrams/components/component-web.png",
      width: 80%,
    ),
  ),
) <fig-webpage-component-view>

== Vista de componentes para la aplicación movil

#figure(
  caption: "Diagrama de vista de componentes para la aplicación movil",
  align(
    center,
    image(
      "diagrams/components/component-mobile.png",
      width: 80%,
    ),
  ),
) <fig-mobile-component-view>

#instruction[
  Para cada contenedor de la sección anterior, describir sus componentes y relaciones entre sí. \
  *Contenido:* C4 Component Diagram (al menos uno por cada contenedor de la sección anterior) y explicación de cada diagrama.
]

El componente de Back-end (@fig-backend-component-view) descompone el backend en ocho microservicios, cada uno con su propia base de datos PostgreSQL. Autenticación y Seguridad cubre el inicio de sesión, las sesiones, los roles, los dispositivos confiables y los límites de transacción. Cuentas cubre el CRUD de cuentas corrientes y de ahorro, las subcuentas y el ahorro automático. Tarjetas cubre la emisión, el bloqueo y desbloqueo, y los avances de crédito. Transacciones cubre las transferencias, los pagos con código QR, los pagos automáticos, las facturas y las billeteras externas. Financiero cubre los CDT, las inversiones, los préstamos y los certificados. CRM cubre el chat de soporte, los beneficiarios, las PQRS y las reclamaciones. Notificaciones orquesta el envío de alertas. Y Auditoría registra la actividad y la trazabilidad del sistema. Las validaciones de saldo y cupo que exigen respuesta inmediata viajan por gRPC entre Transacciones, Tarjetas y Cuentas, mientras que el resto de la comunicación entre microservicios es asíncrona a través del Broker de Eventos Kafka: cada servicio publica sus eventos de dominio y Auditoría los consume todos para construir la bitácora del sistema, mientras que CRM y Notificaciones consumen los eventos relevantes para abrir reclamaciones o enviar alertas. La Aplicación Móvil aún consume la API de cada microservicio directamente, sin pasar por un API Gateway.

Los diagramas de componentes de Web (@fig-webpage-component-view) y Móvil (@fig-mobile-component-view) son estructuralmente idénticos entre sí, ya que ambos frontends reutilizan los mismos componentes de negocio desde la librería compartida ui-shared. Se organizan en tres franjas: la primera agrupa Autenticación, Seguridad, Inicio, Tarjetas y Soporte; la segunda agrupa Cuentas, Transacciones, Notificaciones, Billeteras y pagos digitales, y Financiero; y la tercera agrupa Pagos, Documentos, Perfil y Configuración. Cada componente de frontend está coloreado según el microservicio de backend con el que se comunica, y ambos reciben actualizaciones de estado empujadas por WebSocket para reflejar movimientos y alertas sin necesidad de refrescar la pantalla.

= Vista de procesos

#figure(
  caption: "Diagrama dinámico: Programación de ahorro automático (CU-09)",
  align(
    center,
    image(
      "diagrams/processes/programacion-ahorro-automatico.png",
      width: 100%,
    ),
  ),
) <fig-proc-ahorro-automatico>

#figure(
  caption: "Diagrama dinámico: Solicitud de CDT e inversiones (CU-12)",
  align(
    center,
    image(
      "diagrams/processes/solicitud-cdt-inversiones.png",
      width: 100%,
    ),
  ),
) <fig-proc-cdt-inversiones>

#figure(
  caption: "Diagrama dinámico: Solicitud y gestión de préstamos (CU-13)",
  align(
    center,
    image(
      "diagrams/processes/solicitud-gestion-prestamos.png",
      width: 100%,
    ),
  ),
) <fig-proc-gestion-prestamos>

#figure(
  caption: "Diagrama dinámico: Gestión de transferencias internacionales y nacionales (CU-26)",
  align(
    center,
    image(
      "diagrams/processes/gestion-transferencias-internacionales-nacionales.png",
      width: 100%,
    ),
  ),
) <fig-proc-transferencias-internacionales-nacionales>

#figure(
  caption: "Diagrama dinámico: Pago de facturas y servicios (CU-27)",
  align(
    center,
    image(
      "diagrams/processes/pago-facturas-servicios.png",
      width: 100%,
    ),
  ),
) <fig-proc-pago-facturas-servicios>

#figure(
  caption: "Diagrama dinámico: Transferencias entre cuentas propias y a terceros (CU-30)",
  align(
    center,
    image(
      "diagrams/processes/transferencias-cuentas-propias-terceros.png",
      width: 100%,
    ),
  ),
) <fig-proc-transferencias-propias-terceros>

#instruction[
  Describir el comportamiento de las partes más críticas del sistema. No es necesario detallar el comportamiento de todos los elementos del sistema, sino solo aquellos más críticos en relación con los atributos de calidad. \
  *Contenido:* Para cada parte del sistema que lo requiera, un C4 Dynamic Diagram y explicación para cada diagrama.
]

Los seis diagramas dinámicos modelan, en estilo secuencia, los flujos más críticos para los atributos de calidad descritos en la Introducción. Todos comparten un mismo patrón: el componente de dominio valida contra Cuentas por gRPC, persiste el movimiento, publica un evento asíncrono en el Broker de Eventos Kafka sin esperar respuesta, y Auditoría y Notificaciones consumen ese evento en paralelo para registrar la bitácora y avisar al cliente por un canal externo.

La programación de ahorro automático, correspondiente al caso de uso CU-09 (@fig-proc-ahorro-automatico), tiene dos fases. En la primera fase el cliente configura el monto, la frecuencia y las cuentas involucradas. En la segunda fase un disparador interno ejecuta la transferencia programada en la fecha correspondiente; si el saldo es insuficiente, el ciclo se omite y la programación permanece activa para el siguiente intento, en vez de fallar o cancelarse.

La solicitud de CDT e inversiones, correspondiente al caso de uso CU-12 (@fig-proc-cdt-inversiones), valida la sesión, consulta la tasa vigente y el saldo disponible antes de crear el CDT o la inversión; si el saldo es insuficiente, la solicitud se rechaza sin crear el registro. Incluye además una segunda fase de consulta de rendimientos proyectados y actuales.

La solicitud y gestión de préstamos, correspondiente al caso de uso CU-13 (@fig-proc-gestion-prestamos), consulta el historial crediticio en la Central de Riesgo externa antes de aprobar el préstamo; si el score o la capacidad de pago no alcanzan, la solicitud se rechaza. Su segunda fase cubre el pago de cuotas y la actualización del plan de amortización.

La gestión de transferencias internacionales y nacionales, correspondiente al caso de uso CU-26 (@fig-proc-transferencias-internacionales-nacionales), separa la transferencia internacional, que pasa por la Pasarela de Pagos Internacionales, de la transferencia nacional interbancaria, ambas con la misma validación de saldo previa al débito.

El pago de facturas y servicios, correspondiente al caso de uso CU-27 (@fig-proc-pago-facturas-servicios), valida el convenio registrado contra el proveedor de servicios públicos antes de procesar el pago, y cubre además la recarga a operadores móviles en su segunda fase.

Las transferencias entre cuentas propias y a terceros, correspondientes al caso de uso CU-30 (@fig-proc-transferencias-propias-terceros), validan en su primera fase que ambas cuentas sean del mismo cliente; en la segunda fase, hacia un tercero, primero se consultan los beneficiarios registrados en CRM antes de ejecutar la transferencia.

= Vista física
#instruction[
  Para cada ambiente de ejecución (desarrollo, pruebas y producción), describir cómo se desplegarán los contenedores del sistema. \
  *Contenido:* C4 Deployment Diagram, al menos uno por cada ambiente de ejecución, y explicación de cada diagrama.
]

#figure(
  caption: "Diagrama de despliegue",
  align(
    center,
    image(
      "diagrams/deployment.png",
      width: 80%,
    ),
  ),
) <fig-deployment>

= Vista de código

#figure(
  caption: "Vista de código: Back-end de Auditoría",
  align(center, image("diagrams/code/code-backend-auditoria.png", width: 80%)),
) <fig-code-backend-auditoria>

#figure(
  caption: "Vista de código: Financiero (Back-end)",
  align(center, image("diagrams/code/code-financiero(backend).png", width: 80%)),
) <fig-code-financiero-backend>

#figure(
  caption: "Vista de código: Financiero (Móvil)",
  align(center, image("diagrams/code/code-financiero(mobile).png", width: 80%)),
) <fig-code-financiero-mobile>

#figure(
  caption: "Vista de código: Financiero (Web)",
  align(center, image("diagrams/code/code-financiero(web).png", width: 80%)),
) <fig-code-financiero-web>

#figure(
  caption: "Vista de código: Back-end de Transacciones",
  align(center, image("diagrams/code/code-view-backend-transacciones.png", width: 80%)),
) <fig-code-backend-transacciones>

#figure(
  caption: "Vista de código: Pagos (Móvil)",
  align(center, image("diagrams/code/codigo_pagos(mobile).png", width: 80%)),
) <fig-code-pagos-mobile>

#figure(
  caption: "Vista de código: Pagos (Web)",
  align(center, image("diagrams/code/codigo_pagos(web).png", width: 80%)),
) <fig-code-pagos-web>

#instruction[
  C4 Code Diagram (nivel 4) para los componentes de mayor complejidad o criticidad, con explicación de cada uno.
]

Los diagramas de código detallan, a nivel de clases, los componentes backend de Transacciones y Auditoría, y el flujo completo desde la presentación hasta el dominio, pasando por el view-model, el caso de uso y el repositorio, de Financiero y Pagos tanto en Web como en Móvil.

El back-end de Transacciones (@fig-code-backend-transacciones) expone en su controlador las rutas para transferencias, pagos de factura, generación de código QR y transferencias internacionales, cada una delegada a su propio caso de uso. Todos dependen del repositorio de transacciones para persistir y del cliente de Cuentas para validar y actualizar el saldo; los casos de uso de transferencia y pago publican eventos en el cliente de eventos de Kafka en vez de llamar directamente a Auditoría o Notificaciones, coherente con la migración a mensajería asíncrona registrada en la bitácora.

El back-end de Auditoría (@fig-code-backend-auditoria) recibe, en el extremo opuesto del flujo, los eventos publicados por los demás microservicios a través de un consumidor de Kafka, que los delega al caso de uso encargado de registrarlos como eventos de auditoría persistidos. De forma independiente, el controlador de Auditoría expone consultas síncronas sobre el historial y el reporte periódico de cumplimiento hacia el Ente Regulador externo.

Financiero, en su back-end (@fig-code-financiero-backend), tiene un modelo de dominio más rico, con préstamos, cuotas de préstamo, CDT e inversiones orquestados por sus respectivos servicios detrás de un controlador financiero único. Las validaciones de saldo pasan por el servicio de cuentas y la consulta de historial crediticio por el servicio de la Central de Riesgo externa; todos publican eventos de dominio a través del servicio de eventos.

Los cuatro diagramas de frontend de Financiero y Pagos, tanto en Móvil como en Web (@fig-code-financiero-mobile, @fig-code-financiero-web, @fig-code-pagos-mobile, @fig-code-pagos-web), comparten la misma arquitectura en capas: la pantalla invoca un view-model que a su vez invoca el caso de uso correspondiente, este depende de un repositorio, y el repositorio se apoya en la conexión a la API. Son estructuralmente idénticos entre Web y Móvil porque ambos consumen los mismos componentes de la librería compartida ui-shared; solo cambia la capa de presentación, construida en React para la web y en React Native para el móvil.

= Vista de navegación

#figure(
  caption: "Grafo de navegación",
  align(center, image("diagrams/navigation/grafo_navegacion.png", width: 80%)),
) <fig-navigation>

#instruction[
  Diagrama de navegación de las aplicaciones cliente (web/móvil), mostrando las pantallas y los flujos entre ellas.
]

El grafo de navegación (@fig-navigation) parte de las pantallas de registro, inicio de sesión y recuperación de contraseña, que confluyen en la pantalla principal tras autenticarse. Desde ahí, un menú principal despliega ocho módulos: Auditoría, CRM y Atención al Cliente, Cuentas, Financiero, Notificaciones, Seguridad, Tarjetas y Transacciones, cada uno con su propia jerarquía de pantallas hijas. Las flechas sólidas representan la navegación directa desde el menú, mientras que las punteadas representan la navegación cruzada entre módulos, lo que evidencia que varias pantallas, como los comprobantes de pago o el detalle de intereses, son compartidas por más de un caso de uso.

= Modelo de datos

#figure(
  caption: "Modelo E/R: Auditoría",
  align(
    center,
    image(
      "diagrams/er/auditoria_er.png",
      width: 80%,
    ),
  ),
) <fig-er-auditoria>

#figure(
  caption: "Modelo E/R: Autenticación y Seguridad",
  align(
    center,
    image(
      "diagrams/er/authSeguridad_er.png",
      width: 80%,
    ),
  ),
) <fig-er-auth-seguridad>

#figure(
  caption: "Modelo E/R: CRM",
  align(
    center,
    image(
      "diagrams/er/crm_er.png",
      width: 80%,
    ),
  ),
) <fig-er-crm>

#figure(
  caption: "Modelo E/R: Cuentas",
  align(
    center,
    image(
      "diagrams/er/cuentas_er.png",
      width: 80%,
    ),
  ),
) <fig-er-cuentas>

#figure(
  caption: "Modelo E/R: Financiero",
  align(
    center,
    image(
      "diagrams/er/financiero_er.png",
      width: 80%,
    ),
  ),
) <fig-er-financiero>

#figure(
  caption: "Modelo E/R: Notificaciones",
  align(
    center,
    image(
      "diagrams/er/notificaciones_er.png",
      width: 80%,
    ),
  ),
) <fig-er-notificaciones>

#figure(
  caption: "Modelo E/R: Tarjetas",
  align(
    center,
    image(
      "diagrams/er/tarjetas_er.png",
      width: 80%,
    ),
  ),
) <fig-er-tarjetas>

#figure(
  caption: "Modelo E/R: Transacciones",
  align(
    center,
    image(
      "diagrams/er/transacciones_er.png",
      width: 80%,
    ),
  ),
) <fig-er-transacciones>

#instruction[
  Si aplica, esta sección debe mostrar todos los modelos de datos persistentes usados en la aplicación: modelos ER, modelos de entidades, etc. Si es una arquitectura distribuida, indicar claramente a qué componentes o contenedores aplica cada modelo de datos. \
  *Contenido:* diagramas y su correspondiente explicación.
]

Al ser una arquitectura de microservicios con base de datos propia por servicio, cada uno de los ocho diagramas entidad-relación corresponde exactamente a la base de datos de un microservicio. No existen tablas compartidas entre dominios, solo referencias por identificador que se resuelven vía gRPC o eventos en tiempo de ejecución, nunca por llave foránea física entre bases de datos distintas.

En Auditoría (@fig-er-auditoria), el registro de auditoría es la tabla central de eventos, con el detalle de auditoría para el cambio campo a campo, la política de auditoría para las reglas de retención por servicio y entidad, y la exportación de auditoría junto con el sistema externo de auditoría para las exportaciones hacia el ente regulador.

En Autenticación y Seguridad (@fig-er-auth-seguridad), el usuario es la raíz, de la que cuelgan la credencial con el hash, la sal y el segundo factor, la sesión con los tokens activos, el dispositivo y su confianza asociada, el límite de transacción y el esquema de roles del usuario.

En CRM (@fig-er-crm), el cliente centraliza los datos y se relaciona con su dirección, la interacción que agrupa los mensajes de chat por canal, la solicitud de servicio para las PQRS, la disputa para las reclamaciones y la segmentación de campañas. El mensaje de chat se incorporó recientemente para soportar el historial de chat de atención.

En Cuentas (@fig-er-cuentas), la cuenta, tipada por su tipo de cuenta, es dueña de la subcuenta, la meta de ahorro, el titular de cuenta para las cuentas conjuntas y corporativas, y la programación de ahorro automático, que referencia opcionalmente una subcuenta o una meta de ahorro como destino.

En Financiero (@fig-er-financiero), conviven tres líneas de producto independientes bajo un mismo usuario: el préstamo con su plan de cuotas, el CDT y la inversión, además de la tasa de interés como catálogo de tasas vigentes por tipo de producto.

En Notificaciones (@fig-er-notificaciones), la plantilla y el canal de notificación definen el contenido y el medio; la notificación es el envío concreto a un usuario, con la referencia de entrega del proveedor externo y la preferencia de notificación por canal.

En Tarjetas (@fig-er-tarjetas), la tarjeta, catalogada por su producto y su estado, es dueña del límite de tarjeta y del avance de efectivo, con el procesador de tarjeta externo como referencia a la red de pagos.

En Transacciones (@fig-er-transacciones), la transacción es la tabla raíz, especializada según el tipo de operación en transferencia, pago con código QR, pago de factura o referencia a la pasarela externa; el pago programado modela los pagos automáticos recurrentes de forma independiente, antes de materializarse como una transacción.

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

+ *Arquitectura de software*: Estructura fundamental de un sistema informático, compuesta por sus elementos, las relaciones entre ellos y las propiedades de ambos, que sirve de base para su diseño y evolución futura.

+ *Atributo de calidad*: Característica no funcional que evalúa qué tan bien un sistema cumple con los requisitos operativos y de negocio, tales como la disponibilidad, la seguridad o el rendimiento.

+ *Auditoría*: Módulo o proceso encargado de registrar, rastrear y supervisar todas las actividades, transacciones e inicios de sesión realizados en el sistema para garantizar la trazabilidad y seguridad.

+ *Disponibilidad*: Atributo de calidad que mide la capacidad del sistema para mantenerse operativo y accesible de forma continua, asegurando que no se interrumpan transacciones en curso.

+ *Integrabilidad*: Capacidad del sistema para conectarse, comunicarse e intercambiar datos de forma fluida con plataformas externas, tales como billeteras digitales, cajeros automáticos u otras entidades bancarias.

+ *Modelo de dominio*: Representación conceptual de los objetos, entidades y reglas del mundo real dentro del negocio bancario (como cuentas, clientes, transacciones y tarjetas) que forman la lógica central del sistema.

+ *Módulo*: Componente o unidad lógica independiente dentro del sistema software que agrupa una serie de funcionalidades específicas y acotadas.

+ *Notificaciones*: Sistema automatizado encargado de enviar alertas instantáneas a los usuarios a través de canales como mensajes de texto, correos electrónicos o notificaciones emergentes sobre el estado de sus movimientos.

+ *Procesamiento de transacciones*: Mecanismo encargado de recibir, validar, ejecutar y registrar operaciones financieras (como transferencias o pagos) garantizando la consistencia y seguridad del dinero.

+ *Requisito funcional*: Descripción de un comportamiento, servicio o función específica que el sistema debe ser capaz de realizar bajo ciertas condiciones.

+ *Requisitos Arquitectónicamente Significativos (ASR)*: Requisitos del sistema que tienen un impacto directo y profundo en la estructura y diseño de la arquitectura de software.

+ *Seguridad y Protection Operativa (Safety)*: Conjunto de mecanismos orientados a proteger la información confidencial de los usuarios, controlar el acceso a las cuentas y prevenir pérdidas económicas o fraudes derivados de fallos en el sistema.

+ *Sistema bancario*: Plataforma tecnológica integral diseñada para gestionar cuentas, productos financieros, transacciones y servicios de atención a los clientes de una entidad financiera.

+ *Usabilidad*: Medida en la que el sistema y su interfaz gráfica permiten a los usuarios operar de manera intuitiva, rápida y sin fricciones técnicas.

= Referencias
#instruction[
  Referencias bibliográficas en formato APA o IEEE que hayan sido usadas en el documento[cite: 1].
]
