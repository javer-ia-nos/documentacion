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
// #instruction[
//   *Propósito:* Describir brevemente los cambios que ha sufrido el documento, con el fin de llevar una adecuada administración de configuración. \
//   *Contenido:* Una tabla que indique los cambios que ha sufrido el documento. Debe incluir, al menos: fecha del cambio, descripción del cambio y persona(s) que realizaron el cambio.
// ]

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

    [2026-09-20],
    [Inclusión de la entidad ChatMessage en el modelo E/R de CRM (CU-02) para el soporte del historial de mensajes en chat de atención.],
    [Equipo de Arquitectura],
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
// #instruction[
//   *Propósito:* que el lector entienda los elementos más generales del documento y determine si vale la pena seguir leyéndolo. \
//   *Contenido:*
//   - Una breve explicación de qué trata el sistema.
//   - Principales objetivos de negocio que el sistema debe cumplir.
//   - Principales atributos de calidad que debe satisfacer la arquitectura.
//   - Cuáles son las principales secciones del documento y de qué trata cada una. \
//   *Tamaño recomendado:* 1-2 páginas
// ]

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
// #instruction[
//   Diagrama que muestra los principales conceptos del sistema y sus relaciones. \
//   *Contenido:* \
//   - Diagramas de clases UML, donde cada clase representa un concepto del sistema (ver https://www.uml-diagrams.org/examples/hospital-domain-diagram.html) \
//   - Tabla con las siguientes columnas: Concepto, Explicación
// ]

El modelo de dominio define los conceptos centrales, entidades de negocio y relaciones fundamentales que gobiernan la lógica del Sistema Bancario Digital Javer-IA-nos. Estos conceptos articulan las operaciones financieras, los productos de ahorro e inversión, la gestión de riesgos y la interacción omnicanal de los clientes con los servicios del banco.

#align(center)[
  _Nota: El diagrama conceptual de clases UML del Modelo de Dominio se encuentra en proceso de diagramación final para su incorporación gráfica._
]

#set text(size: 8.5pt)
#table(
  columns: (1.2fr, 2.8fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Concepto*], [*Explicación*],

  [Usuario / Cliente],
  [Entidad que representa a la persona natural o jurídica titular de productos en el banco. Centraliza el perfil, documento de identidad, nivel de riesgo y canales digitales autorizados.],

  [Cuenta Bancaria],
  [Producto financiero básico de captación (cuenta corriente o de ahorros) asociado a un saldo disponible y contable, divisa, número único y estado de actividad, sobre el cual se aplican débitos y créditos.],

  [Subcuenta / Bolsillo],
  [Segmentación o apartado lógico de fondos dentro de una cuenta bancaria con el propósito de reservar dinero para metas específicas, protegido del saldo transaccional inmediato.],

  [Programación de Ahorro],
  [Regla de automatización periódica (diaria, semanal o mensual) que debita automáticamente un monto parametrizado desde la cuenta principal hacia una meta o subcuenta.],

  [Tarjeta (Débito / Crédito)],
  [Medio de pago plástico o virtual emitido por el banco. La tarjeta débito descuenta directamente del saldo de la cuenta matriz; la de crédito cuenta con cupo rotativo asignado, fecha de corte, fecha límite de pago y soporte para compras diferidas o avances.],

  [Transacción],
  [Registro atómico e inmutable que representa un movimiento de fondos (transferencia propia, a terceros, interbancaria ACH, giro internacional SWIFT, retiro o pago de servicio). Posee estado, comprobante digital y marcas de tiempo.],

  [Beneficiario],
  [Contacto frecuente o cuenta de destino registrada y validada previamente por el cliente dentro del módulo CRM para agilizar transferencias monetarias recurrentes.],

  [Préstamo],
  [Operación de crédito otorgada al cliente que comprende un capital desembolsado, tasa de interés pactada, plazo en meses y una tabla de amortización con detalle de cuotas de capital, interés y seguros.],

  [Certificado de Depósito a Término (CDT)],
  [Instrumento de inversión a plazo fijo donde el cliente inmoviliza un capital durante un periodo determinado a una tasa efectiva anual garantizada para generar rendimientos al vencimiento.],

  [PQRS y Reclamación],
  [Mecanismo formal de atención mediante el cual el cliente radica Peticiones, Quejas, Reclamos o disputas transaccionales ante cargos no reconocidos, gestionado con trazabilidad en el módulo CRM.],

  [Dispositivo Confiable],
  [Terminal física (navegador web o teléfono móvil) enrolada por el usuario y certificada mediante huella digital (fingerprint) criptográfica para evaluar el nivel de riesgo en transacciones críticas.],

  [Notificación],
  [Mensaje transaccional o de alerta despachado de forma multicanal (Push, SMS o correo electrónico) ante eventos relevantes de la cuenta, movimientos de saldo o accesos sospechosos.],

  [Registro de Auditoría],
  [Bitácora inmutable de eventos del sistema generada a partir de los tópicos de streaming, garantizando trazabilidad no repudiable para entes regulatorios y análisis forense de seguridad.],
)
#set text(size: 11pt)

= Stakeholders e intereses
// #instruction[
//   Una tabla que especifique cada stakeholder, su información de contacto y qué intereses o expectativas tiene sobre el sistema que se está desarrollando (cómo espera beneficiarse del mismo).
// ]

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
  [CU-26, CU-27, CU-29],
  [El sistema debe integrarse de manera fluida y estandarizada con plataformas externas como Apple Pay, Google Wallet, pasarelas de pagos internacionales y proveedores de servicios públicos mediante APIs seguras.],
  [Alta],
  [Samuel Beltrán Martínez],

  [ASR-05],
  [Modificabilidad y Gestión de Productos],
  [Modifiability],
  [Extensibilidad],
  [CU-04, CU-05, CU-06, CU-07, CU-08, CU-12, CU-13, CU-21, CU-22],
  [Ante el lanzamiento de una nueva regulación o tipo de producto financiero (crédito, ahorro, CDT, préstamos o tarjetas), los desarrolladores deben poder modificar o añadir la lógica del producto sin alterar los módulos transaccionales centrales.],
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
// #instruction[
//   Indique cualquier restricción que limite la libertad de los ingenieros a la hora de decidir la arquitectura del sistema y las soluciones a los ASR. Las principales categorías de restricciones son: \
//   - *Técnicas:* Directamente relacionadas con las tecnologías, métodos de ingeniería, sistemas de software, etc. \
//   - *Organizacionales/políticas:* Situaciones internas o externas a la organización y de las personas que limiten las decisiones arquitectónicas del sistema. \
//   - *Convencionales:* Necesidades de seguimiento de estándares, guías de codificación, leyes, etc.
// ]

A continuación se consolidan las restricciones técnicas, organizacionales y convencionales que acotan el espacio de diseño y condicionan las decisiones arquitectónicas del sistema bancario:

#set text(size: 8.5pt)
#table(
  columns: (1.2fr, 1fr, 2.5fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Restricción*], [*Categoría*], [*Descripción*],

  [Runtime Bun y TypeScript],
  [Técnica],
  [Todo el ecosistema de microservicios, API Gateway y scripts de pruebas debe implementarse sobre el runtime Bun utilizando TypeScript en modo estricto, garantizando validación estática de tipos y tiempos de inicio ultrarrápidos (< 10 ms).],

  [Framework ElysiaJS y TypeBox],
  [Técnica],
  [Los contratos de API de los ocho microservicios y el gateway deben modelarse con TypeBox y procesarse con ElysiaJS para compilación en tiempo de ejecución de esquemas de validación de alto rendimiento.],

  [Patrón Database-per-Service],
  [Técnica],
  [Cada microservicio debe contar con su propia base de datos relacional PostgreSQL aislada (y SQLite en memoria mediante bun:sql para pruebas). Queda terminantemente prohibido compartir bases de datos o realizar consultas SQL directas entre dominios.],

  [Broker Apache Kafka],
  [Técnica],
  [La comunicación entre microservicios para auditoría, notificaciones y eventos de dominio debe realizarse obligatoriamente de forma asíncrona a través de Apache Kafka (Strimzi Operator), reservando llamadas síncronas solo a validaciones críticas de saldo/cupo vía gRPC o HTTP local.],

  [Despliegue Bare-Metal en Kubernetes],
  [Técnica],
  [El sistema de producción debe desplegarse sobre un clúster Kubernetes bare-metal distribuido en al menos dos máquinas físicas pertenecientes a los integrantes del equipo, orquestado con Ansible y Helm.],

  [Frontend Universal ui-shared],
  [Técnica],
  [La lógica de negocio de frontend y hooks transaccionales deben residir en la librería compartida `@javer-ia-nos/ui-shared` para reutilización simultánea en la Web (Astro + React) y en Móvil (React Native + Expo).],

  [Segregación de Responsabilidades],
  [Organizacional],
  [El equipo se compone de seis ingenieros con asignación de módulos: Transacciones (Salomón/Miguel), Seguridad (Arantxa), Cuentas (Juliana), Tarjetas (Sara), Financiero (Samuel) y Auditoría/DevOps.],

  [Estrategia Multirepositorio],
  [Organizacional],
  [Cada subsistema (los 8 microservicios, API Gateway, ui-shared, web, mobile, infra y documentación) reside en un repositorio Git independiente dentro de la organización de GitHub `javer-ia-nos`, requiriendo flujos de integración continua desacoplados.],

  [Plazos Académicos Fijos],
  [Organizacional],
  [Las fechas de entrega de hitos, sustentaciones de despliegue y entrega final están delimitadas estrictamente por el calendario del periodo académico 2026-30 de la Pontificia Universidad Javeriana.],

  [Gravamen a los Movimientos Financieros],
  [Convencional],
  [Toda transacción financiera de débito debe calcular y reportar explícitamente el impuesto tributario del 4x1000 (GMF) conforme a la legislación tributaria colombiana.],

  [Estándares arc42 y C4 Model],
  [Convencional],
  [El documento de arquitectura debe adherirse fielmente a la estructura formal del estándar arc42 y emplear las cuatro vistas de abstracción jerárquica del C4 Model formulado por Simon Brown.],
)
#set text(size: 11pt)

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

// #instruction[
//   Relación entre el sistema y su entorno (personas y otros sistemas). \
//   *Contenido:* \
//   - C4 Context Diagram o C4 System Landscape Diagram. Debe incluir todos los elementos externos relevantes (Actores, Sistemas externos). \
//   - Explicación del diagrama.
// ]

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

// #instruction[
//   Describir los contenedores y sus relaciones entre sí. \
//   *Contenido:* C4 Container Diagram y explicación del diagrama.
// ]

El diagrama de contenedores (@fig-container-view) describe tres puntos de entrada para los actores humanos. La Single-Page Application, construida en React y TypeScript, atiende a los clientes que operan desde el navegador. La Aplicación Móvil, en React Native, atiende a los clientes desde smartphones y tablets, canalizando sus solicitudes a través del API Gateway perimetral para autenticación, auditoría y enrutamiento seguro. El Portal de Atención y Backoffice, también en React, permite que el Agente de Atención al Cliente gestione PQRS, reclamaciones y chats de soporte. Los tres llaman al dominio de backend, compuesto por los mismos ocho microservicios ya presentados en la Vista de componentes: Autenticación y Seguridad, Cuentas, Tarjetas, Transacciones, Financiero, CRM, Notificaciones y Auditoría. Estos microservicios se comunican entre sí de forma asíncrona a través del Broker de Eventos Kafka, salvo las validaciones de saldo y cupo, que viajan por gRPC directo hacia Cuentas porque requieren respuesta inmediata. Hacia afuera, cada microservicio dueño de la integración correspondiente se comunica directamente con su sistema externo: Transacciones con la Pasarela de Pagos Internacionales, los Proveedores de Servicios Públicos y las Billeteras Digitales; Financiero con la Central de Riesgo; Notificaciones con el Proveedor de Notificaciones; y Auditoría con el Ente Regulador Financiero.

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

// #instruction[
//   Para cada contenedor de la sección anterior, describir sus componentes y relaciones entre sí. \
//   *Contenido:* C4 Component Diagram (al menos uno por cada contenedor de la sección anterior) y explicación de cada diagrama.
// ]

El componente de Back-end (@fig-backend-component-view) descompone el backend en ocho microservicios, cada uno con su propia base de datos PostgreSQL. Autenticación y Seguridad cubre el inicio de sesión, las sesiones, los roles, los dispositivos confiables y los límites de transacción. Cuentas cubre el CRUD de cuentas corrientes y de ahorro, las subcuentas y el ahorro automático. Tarjetas cubre la emisión, el bloqueo y desbloqueo, y los avances de crédito. Transacciones cubre las transferencias, los pagos con código QR, los pagos automáticos, las facturas y las billeteras externas. Financiero cubre los CDT, las inversiones, los préstamos y los certificados. CRM cubre el chat de soporte, los beneficiarios, las PQRS y las reclamaciones. Notificaciones orquesta el envío de alertas. Y Auditoría registra la actividad y la trazabilidad del sistema. Las validaciones de saldo y cupo que exigen respuesta inmediata viajan por gRPC entre Transacciones, Tarjetas y Cuentas, mientras que el resto de la comunicación entre microservicios es asíncrona a través del Broker de Eventos Kafka: cada servicio publica sus eventos de dominio y Auditoría los consume todos para construir la bitácora del sistema, mientras que CRM y Notificaciones consumen los eventos relevantes para abrir reclamaciones o enviar alertas. Tanto la aplicación Web como la Aplicación Móvil canalizan sus peticiones a través del API Gateway perimetral antes de llegar a los microservicios de backend.

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

// #instruction[
//   Describir el comportamiento de las partes más críticas del sistema. No es necesario detallar el comportamiento de todos los elementos del sistema, sino solo aquellos más críticos en relación con los atributos de calidad. \
//   *Contenido:* Para cada parte del sistema que lo requiera, un C4 Dynamic Diagram y explicación para cada diagrama.
// ]

Los seis diagramas dinámicos modelan, en estilo secuencia, los flujos más críticos para los atributos de calidad descritos en la Introducción. Todos comparten un mismo patrón: el componente de dominio valida contra Cuentas por gRPC, persiste el movimiento, publica un evento asíncrono en el Broker de Eventos Kafka sin esperar respuesta, y Auditoría y Notificaciones consumen ese evento en paralelo para registrar la bitácora y avisar al cliente por un canal externo.

La programación de ahorro automático, correspondiente al caso de uso CU-09 (@fig-proc-ahorro-automatico), tiene dos fases. En la primera fase el cliente configura el monto, la frecuencia y las cuentas involucradas. En la segunda fase un disparador interno ejecuta la transferencia programada en la fecha correspondiente; si el saldo es insuficiente, el ciclo se omite y la programación permanece activa para el siguiente intento, en vez de fallar o cancelarse.

La solicitud de CDT e inversiones, correspondiente al caso de uso CU-12 (@fig-proc-cdt-inversiones), valida la sesión, consulta la tasa vigente y el saldo disponible antes de crear el CDT o la inversión; si el saldo es insuficiente, la solicitud se rechaza sin crear el registro. Incluye además una segunda fase de consulta de rendimientos proyectados y actuales.

La solicitud y gestión de préstamos, correspondiente al caso de uso CU-13 (@fig-proc-gestion-prestamos), consulta el historial crediticio en la Central de Riesgo externa antes de aprobar el préstamo; si el score o la capacidad de pago no alcanzan, la solicitud se rechaza. Su segunda fase cubre el pago de cuotas y la actualización del plan de amortización.

La gestión de transferencias internacionales y nacionales, correspondiente al caso de uso CU-26 (@fig-proc-transferencias-internacionales-nacionales), separa la transferencia internacional, que pasa por la Pasarela de Pagos Internacionales, de la transferencia nacional interbancaria, ambas con la misma validación de saldo previa al débito.

El pago de facturas y servicios, correspondiente al caso de uso CU-27 (@fig-proc-pago-facturas-servicios), valida el convenio registrado contra el proveedor de servicios públicos antes de procesar el pago, y cubre además la recarga a operadores móviles en su segunda fase.

Las transferencias entre cuentas propias y a terceros, correspondientes al caso de uso CU-30 (@fig-proc-transferencias-propias-terceros), validan en su primera fase que ambas cuentas sean del mismo cliente; en la segunda fase, hacia un tercero, primero se consultan los beneficiarios registrados en CRM antes de ejecutar la transferencia.

= Vista física
// #instruction[
//   Para cada ambiente de ejecución (desarrollo, pruebas y producción), describir cómo se desplegarán los contenedores del sistema. \
//   *Contenido:* C4 Deployment Diagram, al menos uno por cada ambiente de ejecución, y explicación de cada diagrama.
// ]

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

El diagrama de despliegue (@fig-deployment) ilustra la topología física del ambiente de producción sobre un clúster de Kubernetes bare-metal distribuido entre las máquinas físicas de los integrantes del equipo. El aprovisionamiento y la configuración del clúster se gestionan de manera automatizada mediante playbooks de Ansible (repositorio `infra`), los cuales instalan el runtime de contenedores Containerd (con cgroup v2 en systemd), los paquetes de Kubernetes (kubelet, kubeadm, kubectl) y el plugin de red Flannel CNI sobre el bloque CIDR `10.244.0.0/16`.

El plano de control (`salomon`) coordina la programación de cargas de trabajo hacia los nodos de trabajo (`miguel`, `arantxa`, `juliana`, `samuel` y `sara`). En el perímetro exterior del clúster, un controlador Ingress NGINX expone los puertos de entrada HTTP/HTTPS públicos, canalizando las solicitudes entrantes hacia el API Gateway (`api-gateway`) en el puerto 4860 para inspección de seguridad perimetral, o hacia el servidor de la aplicación Web en Astro.

En la capa de aplicación, cada uno de los ocho microservicios se empaqueta en imágenes de Docker optimizadas que se compilan y publican automáticamente en GitHub Container Registry (`ghcr.io/`javer-ia-nos`/<repo>`) mediante pipelines de GitHub Actions. El despliegue de toda la flota se orquesta con Helm utilizando el chart paraguas `charts/`javer-ia-nos``, el cual parametriza variables de entorno, puertos y resolución interna de nombres DNS entre servicios. Para garantizar la elasticidad y disponibilidad del sistema ante picos de demanda transaccional, cada microservicio cuenta con un Horizontal Pod Autoscaler (HPA) que incrementa o reduce las réplicas de pods de acuerdo con el consumo de recursos de cómputo.

La persistencia de datos se resuelve respetando el principio de base de datos dedicada por microservicio. Cada pod de PostgreSQL se enlaza a un PersistentVolumeClaim (PVC) backed por almacenamiento local mediante `local-path-provisioner`. La mensajería y el intercambio de eventos asíncronos de dominio, auditoría y notificaciones operan sobre un clúster de Apache Kafka administrado por el operador Strimzi en el namespace `kafka`. La gestión de credenciales, contraseñas de bases de datos y tokens de pull de GHCR se realiza de forma segura mediante Kubernetes Secrets, inyectados y cifrados mediante Ansible Vault.

= Vista de código

#figure(
  caption: "Vista de código: Back-end de Auditoría",
  align(center, image("diagrams/code/code-view-backend-auditoria.png", width: 80%)),
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

// #instruction[
//   C4 Code Diagram (nivel 4) para los componentes de mayor complejidad o criticidad, con explicación de cada uno.
// ]

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

// #instruction[
//   Diagrama de navegación de las aplicaciones cliente (web/móvil), mostrando las pantallas y los flujos entre ellas.
// ]

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

// #instruction[
//   Si aplica, esta sección debe mostrar todos los modelos de datos persistentes usados en la aplicación: modelos ER, modelos de entidades, etc. Si es una arquitectura distribuida, indicar claramente a qué componentes o contenedores aplica cada modelo de datos. \
//   *Contenido:* diagramas y su correspondiente explicación.
// ]

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
// #instruction[
//   Detallar la solución a cada ASR de alta prioridad mencionado en la sección "Requisitos Arquitectónicamente Significativos (ASR)". Cada ASR puede tener asociado uno o varios Registros de Decisiones de Diseño (ADR). \
//   *Contenido:* Para cada decisión de alta prioridad, una subsección con los siguientes elementos: \
//   - ID y Título del ADR. \
//   - ID y Título del ASR. \
//   - Problema: Descripción detallada del problema a resolver. \
//   - Solución: Descripción detallada de la decisión. Típicamente requiere referenciar diagramas. Detallar: Tecnologías seleccionadas, Patrones y estilos, Metodologías/procesos. \
//   - Consecuencias: positivas y negativas de dicha decisión.
// ]

A continuación se detallan los Registros de Decisiones Arquitectónicas (ADR) adoptados para satisfacer los Requisitos Arquitectónicamente Significativos (ASR) de alta prioridad establecidos para el Sistema Bancario:

== ADR-01: Patrón SAGA Orquestado para Consistencia Transaccional

- *ID ASR:* ASR-01 (Disponibilidad Transaccional - Tolerancia a fallos).
- *Problema:* Las transferencias entre cuentas bancarias, pagos interbancarios ACH y transacciones internacionales involucran múltiples microservicios independientes (`ms-transacciones`, `ms-cuentas` y pasarelas externas). Emplear un protocolo de bloqueo distribuido tradicional de dos fases (2PC / Two-Phase Commit) bloquearía tablas de base de datos a través de la red, degradando severamente el rendimiento, generando contención de recursos y creando puntos de falla en cascada si un nodo se desconecta.
- *Solución:* Se adoptó el patrón *SAGA Orquestado* liderado por el microservicio `ms-transacciones`. Al solicitarse una transferencia o pago, la transacción se persiste inicialmente en estado `PENDING` y se solicita a `ms-cuentas` (vía gRPC) la retención o débito preventivo del saldo. Luego se intenta la operación en el servicio o entidad de destino (como se ilustra en @fig-proc-transferencias-internacionales-nacionales y @fig-proc-transferencias-propias-terceros). Si cualquier paso falla de manera definitiva (ej. banco destino inaccesible o fondos no recibidos), el orquestador dispara inmediatamente la transacción compensatoria (abono de reversión a la cuenta origen) y publica el evento en Kafka (`saga.compensacion-fallida`) para trazabilidad en auditoría.
- *Consecuencias Positivas:* Garantiza alta disponibilidad transaccional, elimina los bloqueos de base de datos entre microservicios y permite tolerar fallos transitorios en redes externas mediante reintentos exponenciales.
- *Consecuencias Negativas / Trade-offs:* Requiere diseñar e implementar explícitamente la lógica y endpoints de compensación para cada tipo de transacción y aceptar un modelo de consistencia eventual durante la ventana de tiempo en que la compensación surte efecto.

== ADR-02: Runtime Unificado Bun y Framework ElysiaJS

- *ID ASR:* ASR-02 (Rendimiento en Operaciones Críticas - Tiempo de respuesta < 2s).
- *Problema:* El sistema bancario debe procesar operaciones críticas como pagos por código QR, autenticación y transferencias en un tiempo de respuesta inferior a 2 segundos bajo alta concurrencia. Runtimes tradicionales de Node.js con Express o frameworks pesados consumen elevada memoria y presentan latencias de arranque en contenedores Kubernetes que dificultan el autoescalado reactivo.
- *Solución:* Se unificó toda la infraestructura de backend y del API Gateway sobre el runtime *Bun* y el framework web *ElysiaJS*. ElysiaJS compila las definiciones de rutas y los esquemas TypeBox a funciones nativas en tiempo de arranque mediante JIT, reduciendo drásticamente la sobrecarga de validación de esquemas HTTP. Adicionalmente se utiliza `bun:sql` para interacción optimizada con bases de datos relacionales sin la latencia de ORMs tradicionales.
- *Consecuencias Positivas:* Tiempos de arranque de contenedores inferiores a 10 ms, reducción de consumo de memoria en los nodos worker de Kubernetes a menos de 50 MB por pod, throughput superior a Node.js/Express en más de un 300%, y tipado estricto end-to-end garantizado con TypeScript y TypeBox.
- *Consecuencias Negativas / Trade-offs:* Bun es una tecnología relativamente reciente en el ecosistema productivo en comparación con Node.js, lo que requirió verificar cuidadosamente la compatibilidad de paquetes npm y adaptar drivers de conexión.

== ADR-03: Verificación Criptográfica Local de Tokens JWT e Inspección Perimetral

- *ID ASR:* ASR-03 (Seguridad y Protección contra Fraude - Confidencialidad e Integridad).
- *Problema:* En una arquitectura de ocho microservicios, si cada solicitud requiere que el microservicio downstream consulte síncronamente al microservicio `ms-seguridad` para validar el token y sesión del usuario, se genera un cuello de botella crítico, multiplicando la latencia de red interna y convirtiendo a `ms-seguridad` en un punto único de falla (SPOF).
- *Solución:* Se estableció un esquema de seguridad defensivo en dos capas:
  + *Borde Perimetral (API Gateway):* El gateway recibe la petición externa, valida la presencia y estructura del token Bearer, consulta el estado de sesión activa en `ms-seguridad` y enruta al microservicio de destino inyectando cabeceras de contexto (`x-user-id`, `x-user-role`, `x-request-id`).
  + *Verificación Criptográfica Local (Microservicios Core):* Cada microservicio downstream verifica de forma autónoma e instantánea la firma criptográfica del JWT (algoritmo HMAC-SHA256) utilizando la clave simétrica maestra compartida (`JWT_SECRET`), inyectada de forma segura mediante un Kubernetes Secret.
- *Consecuencias Positivas:* La validación criptográfica en cada microservicio toma menos de 0.05 ms por petición y se elimina el 100% del tráfico de red inter-servicio para chequeo de tokens, desacoplando los servicios de la disponibilidad inmediata de `ms-seguridad`.
- *Consecuencias Negativas / Trade-offs:* Exige sincronizar de forma rigurosa la variable `JWT_SECRET` entre todos los deployments de Kubernetes mediante Ansible Vault y no permite invalidar un token de forma atómica en downstream antes de su tiempo de expiración (salvo por consulta explícita de lista negra en eventos críticos).

== ADR-04: Streaming Asíncrono de Eventos con Apache Kafka para Auditoría y Notificaciones

- *ID ASR:* ASR-04 (Integrabilidad con Terceros) y ASR-01 (Disponibilidad Transaccional).
- *Problema:* El registro legal de auditoría y el despacho de notificaciones multicanal (SMS, push, correo) son obligatorios para cada transacción financiera. Si se ejecutaran mediante peticiones HTTP síncronas bloqueantes dentro del hilo principal de la transacción, cualquier caída o lentitud del proveedor de telecomunicaciones o de la base de datos de auditoría ralentizaría o abortaría transferencias válidas.
- *Solución:* Se integró un broker de eventos *Apache Kafka* (desplegado vía Strimzi en el clúster) como columna vertebral de mensajería asíncrona. Los microservicios transaccionales (`ms-transacciones`, `ms-cuentas`, `ms-tarjetas`, `ms-financiero`) publican eventos de dominio (como `transaccion.creada`, `cuenta.debitada`, `tarjeta.bloqueada`) sin esperar confirmación de procesamiento. Los microservicios `ms-auditoria` y `ms-notificaciones` actúan como consumidores independientes en grupos de consumidores separados, procesando las bitácoras y los envíos externos en segundo plano (ver @fig-container-view y diagramas dinámicos).
- *Consecuencias Positivas:* Desacoplamiento temporal completo: las transacciones financieras responden al cliente en milisegundos sin importar la latencia del canal de notificaciones; si `ms-auditoria` o `ms-notificaciones` se reinician, Kafka retiene los mensajes sin pérdida de datos.
- *Consecuencias Negativas / Trade-offs:* Mayor complejidad operativa en la infraestructura de clúster (administración de Kafka y ZooKeeper/KRaft) y necesidad de monitorear el retraso (lag) de los consumidores.

== ADR-05: Frontend Universal con Librería Compartida (`@javer-ia-nos/ui-shared`)

- *ID ASR:* ASR-05 (Modificabilidad y Gestión de Productos - Extensibilidad).
- *Problema:* La plataforma dispone de dos frontends activos: una aplicación Web basada en Astro + React y una aplicación Móvil en React Native + Expo. Duplicar la lógica de negocio, clientes HTTP, validaciones de formularios, formatos contables y modelos de datos en dos proyectos distintos multiplicaría el costo de mantenimiento y generaría divergencias funcionales.
- *Solución:* Se creó el paquete centralizado `@javer-ia-nos/ui-shared`, publicado en el registro de GitHub Packages mediante integración continua. Esta librería desacopla hooks headless de estado y consumo de APIs (`useTransferencia`, `useSesion`, `useInicioCuentas`, `useLimites`) de las primitivas de renderizado visual, permitiendo que tanto la Web como el Móvil compartan la misma lógica de negocio y componentes adaptables a través de componentes compatibles con React Native Web.
- *Consecuencias Positivas:* Máxima modificabilidad: cualquier cambio en las reglas de validación o en los endpoints de backend se actualiza en un único lugar (`ui-shared`) y se propaga automáticamente a ambas aplicaciones clientes.
- *Consecuencias Negativas / Trade-offs:* Requiere mantener un ciclo de versionado y publicación de paquetes mediante CI/CD antes de que los cambios estén disponibles en los repositorios cliente (`web` y `mobile`).

= Riesgos técnicos
// #instruction[
//   Indicar todo lo que puede salir mal producto de cómo ha sido definida la arquitectura. Por ejemplo, componentes que pueden funcionar mal bajo ciertas condiciones, eventos que pueden hacer que se incumplan algunos atributos de calidad, etc. \
//   *Contenido:* Tabla de riesgos ordenados por prioridad (Alta probabilidad + alto impacto = alta prioridad; Baja probabilidad + bajo impacto = baja prioridad). \
//   - *Plan de mitigación:* qué hacer para reducir la probabilidad de que ocurra el riesgo. \
//   - *Plan de contingencia:* qué hacer si el riesgo se materializa ("plan B").
// ]

La tabla a continuación clasifica los riesgos arquitectónicos del sistema en función de su probabilidad e impacto estimado, detallando el plan preventivo de mitigación y el plan de contingencia aplicable si el riesgo llega a materializarse:

#set text(size: 8pt)
#table(
  columns: (1.2fr, 0.7fr, 0.7fr, 0.7fr, 2fr, 2fr),
  fill: (col, row) => if row == 0 { rgb("f0f0f0") } else { none },
  [*Riesgo*], [*Probabilidad*], [*Impacto*], [*Prioridad*], [*Plan de mitigación*], [*Plan de contingencia*],

  [Caída o partición del Broker Kafka],
  [Media],
  [Alto],
  [Alta],
  [Despliegue de clúster Kafka Strimzi con factor de replicación mayor a 1, healthchecks automatizados y monitoreo continuo de recursos en Kubernetes.],
  [Activación de buffer local en memoria y cola de persistencia temporal en disco en cada microservicio emisor para reenviar los eventos pendientes una vez restablecido el broker, garantizando que ninguna transacción bancaria se bloquee.],

  [Desconexión o latencia entre nodos bare-metal],
  [Alta],
  [Alto],
  [Alta],
  [Ajuste de ventanas de tolerancia en kubelet (node-monitor-grace-period) y Flannel CNI, junto con afinidad de nodos para ubicar pods críticos (Cuentas y Transacciones) en máquinas con IP fija.],
  [Evicción automática de pods (Pod Eviction) y reprogramación transparente de réplicas en nodos de trabajo sobrevivientes mediante los Deployments de Kubernetes.],

  [Fallo de compensación en transacciones SAGA],
  [Baja],
  [Crítico],
  [Alta],
  [Diseño idempotente en todas las operaciones transaccionales y de compensación, validación previa de saldo disponible y asignación de identificadores de correlación únicos.],
  [Enrutamiento inmediato a la cola Kafka saga.compensacion-fallida, notificación prioritaria al equipo de CRM para intervención de soporte y ejecución de conciliación contable asistida.],

  [Degradación por volumen de datos en ms-auditoria],
  [Media],
  [Medio],
  [Media],
  [Indexación eficiente sobre identificadores de transacción y usuario, y definición de políticas de retención y particionamiento mensual en PostgreSQL.],
  [Ejecución automatizada de exportaciones periódicas hacia almacenamiento secundario conforme al caso de uso de exportación a entes reguladores.],
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
// #instruction[
//   Referencias bibliográficas en formato APA o IEEE que hayan sido usadas en el documento[cite: 1].
// ]

+ [1] G. Starke and P. Hruschka, _arc42: Template for software architecture documentation and evaluation_, Version 8.2. arc42.org, 2023.
