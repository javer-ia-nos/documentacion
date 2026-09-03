#import "@preview/datify:1.3.0": display-date
#set page(paper: "us-letter", numbering: "1", margin: (x: 2.5cm, y: 2.5cm))
#set text(font: "Times New Roman", size: 11pt, lang: "es")
#set heading(numbering: "1.1.")
#set par(justify: true)
#let version = sys.inputs.at("version", default: "No asignada")

#align(center)[
  #v(4cm)
  #text(size: 24pt, weight: "bold")[Bitacora Grupal]
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

= Bitácora Arquitectónica

#table(
  columns: 5,
  table.header([*n°*], [*Entrada*], [*Fecha*], [*Actividad realizada*], [*Nombres*]),

  [1],
  [Trabajo en Clase],
  [18-08-2026],
  [
    - Se revisa la técnología a usar para el desarrollo de los diagramas C4, la cual será la librería #link("https://github.com/goadesign/model/tree/main/examples/nested", "goa/model").
    - Se realizo la definición y categorización final de los casos de uso.
    - Se implemento un test original de los creadores de la libreria para aprender su uso.
    - Se hizo la configuración para el uso de la libreria #link("https://github.com/goadesign/model/tree/main/examples/nested", "goa/model").
  ],
  [
    - Miguel Francisco Vargas
    - Sara Rodriguez Urueña
    - Juliana Sofia Novoa Solano
    - Salomon Alfredo Avila Larrotta
    - Arantxa Marian Espejo Malagon
  ],

  [2],
  [Trabajo en Clase],
  [20-08-2026],
  [
    - Se revisa con el profesor el avance actual.
    - Se repartieron los casos de uso y asr's entre los integrantes del grupo.
    - Arantxa Marian Espejo Malagon va a hacer el diagrama de contexto y sobre eso luego nos separaremos los diagramas.
    - Se inicio con la bitácora formal del grupo y de cada participante.
  ],
  [Todos],

  [3],
  [Trabajo en Clase],
  [25-08-2026],
  [
    - Se definen dos lideres de arquitectura, Miguel para microservicios y Salomón para monolito modular para intentar convencer a los demás integrantes del equipo por que su arquitectura es mejor.
    - Se revisan los diagramas en conjunto con el profesor y se toman sus comentarios para posterior mejora.
    - Correción de typos en diagrama.
    - Se define el horario de reuniones para los lunes a las 8pm.
  ],
  [Todos],

  [4],
  [Trabajo en clase],
  [27-08-2026],
  [
    Se definen los puntos de disponibilidad:
    + Detección de fallos
      - monitoreo
      - heartbeat
      - detección de excepciones
    + Recuperación de fallos
      - rollback
      - manejo de excepciones
      - actualización de software
      - reconfiguración
      - reintroducción
    + Prevención de fallos
      - transacciones/SAGA
      - prevención de excepciones
    + Patrones para disponibilidad
      - circuit breaker
      - cold spare

    Se define el uso de terraform y se designa a Salomón para revisar terraform.
  ],
  [5],

  [Trabajo en clase],
  [01-09-2026],
  [
    Se definen los criterios de desplegabilidad del sistema:
    - Se usara kubernetes para la gestión de la caga.
    - Se empaquetara la aplicación en una imagen docker para cada servicio/microservicio.
    - Kill switch se usará pero no se ha definido la herramienta o forma de hacerlo.
    - Vamos a reemplazar parcialmente los servicios usando kubernetes.
    - Testing tendremos pruebas:
      - Unitarias
      - Integración
      - Sistema
    - Se usara git flow para los repos de código fuente.

    Se cambia el repo para que ahora tenga las imagenes en el repo.
  ],
  [
    - Miguel Francisco Vargas
    - Juliana Sofia Novoa Solano
    - Salomon Alfredo Avila Larrotta
    - Arantxa Marian Espejo Malagon
    - Samuel Beltrán Martínez
  ],

  [Trabajo en clase],
  [03-09-2026],
  [
    Se revisan los diagramas con el profesor, y se aplican los cambios solicitados.

    Se crea un repo para testear la herramienta y lenguaje elegidos como primera prueba, Elysia y Typescript.

    Se define que:
    - Juliana Sofia Novoa Solano realizará el diagrama de componente para la App movil.
    - Salomón va a revisar los cambios propuestos por el profesor.
    - Sara Rodriguez va a realizar el diagrama de componente para el SPA.
    - Los demás revisarán tecnologías de base de datos para cada servicio. Además de investigar kubernetes.
    - Cuando esten los diagramas, cada persona va a revisar sus casos de uso y contrastarlos con el diagrama para validar.
  ],
  [
    Todos
  ],
)

= Bitacoras personales
#include "bitacoras-personales/miguel.typ"
#include "bitacoras-personales/arantxa.typ"
#include "bitacoras-personales/juliana.typ"
#include "bitacoras-personales/salomon.typ"
#include "bitacoras-personales/samuel.typ"
#include "bitacoras-personales/sara.typ"
