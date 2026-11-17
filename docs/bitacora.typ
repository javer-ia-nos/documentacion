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
  [Todos],

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

  [6],
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
    - Miguel Vargas va a redactar las decisiones tomadas hasta el momento en el documento de arquitectura.
  ],
  [
    Todos
  ],

  [7],
  [Reunión],
  [07-09-2026],
  [
    - Se revisa el progreso individual de cada persona.
    - Se revisan las maquinas virtuales.
      - Juliana, Miguel y Arantxa necesitan preguntar por más maquinas virtuales para la clase.
    - Preguntas para el profesor
      - Preguntar si estan bien los stakeholders o toca añadir más.
      - Revisar los diagramas.
      - Preguntar si hay que tener desinstalado kubernetes para la sustentación de deployment.
      - Hay que hacer un code diagrama por cada componente?
    - Se define fecha para tener primer borrador del documento para el jueves.
  ],
  [
    - Miguel Francisco Vargas
    - Sara Rodriguez Urueña
    - Juliana Sofia Novoa Solano
    - Salomon Alfredo Avila Larrotta
    - Arantxa Marian Espejo Malagon
  ],

  [8],
  [Trabajo de equipo y avances],
  [08-09-2026 a 12-09-2026],
  [
    - Revisión de diagramas de código (Arantxa: código transacciones y vista física).
    - Ordenamiento y re-organización de archivos de diagramas (Miguel).
    - Eliminación de CU-32 duplicado y fusión con CU-27 (Miguel).
    - Desarrollo de plantilla Docker y DB para ms-cuentas (Miguel).
    - Mejora de diagrama de componentes móvil (Juliana).
  ],
  [
    - Miguel Francisco Vargas
    - Arantxa Marian Espejo Malagon
    - Juliana Sofia Novoa Solano
    - Sara Rodriguez Urueña
    - Samuel Beltrán Martínez
  ],

  [9],
  [Implementación e integración],
  [15-09-2026 a 21-09-2026],
  [
    - Implementación masiva de CUs asignados individualmente.
    - Intercambio de CUs entre Juliana y Sara (CU-20 a CU-23 van a Sara; CU-06 a CU-08 van a Juliana).
    - Estandarización de READMEs y modelos E/R en todos los microservicios.
    - Creación del API Gateway y repositorio de integración E2E.
    - Implementación de tests unitarios y de integración.
    - Configuración de CI/CD con GitHub Actions y publicación a GHCR.
    - Corrección de diagramas E/R de CRM y Tarjetas.
    - Inclusión de entidad ChatMessage en modelo E/R de CRM.
  ],
  [Todos],

  [10],
  [Auditoría y cierre],
  [22-09-2026],
  [
    - Revisión final de entregables y auditoría del proyecto.
    - Correcciones de documentación y bitácoras.
    - Preparación para sustentación.
  ],
  [Todos],

  [11],
  [Reglas],
  [07-10-2026],
  [
    Se define una serie de reglas a cumplir para la entrega final del proyecto de arquitectura de software. Comprende las semanas desde la 9 hasta la ultima de clase.

    Todos los integrantes aceptan por unanimidad.

    En general es cada semana realizar al menos un CU y exponerlo el lunes siguiente en una reunión. 8PM lunes.
  ],
  [Todos],

  [12],
  [Repos],
  [08-10-2026],
  [Se define con el profesor modificaciones importantes en los servicios. Se elimina ms-cuentas y ms-transacciones para crear un nuevo ms-core. Se elimina ui-shared y mobile para reducir un poco el alcance del proyecto sin afectar partes importantes del sistema.],
  [Todos],

  [13],
  [Reunión],
  [12-10-2026],
  [
    Se revisa que cada persona tenga el entorno de trabajo funcional.

    Samuel queda pendiente de revisión para el día siguiente, 13 de octubre.

    Se empieza oficialmente el desarrollo del primer sprint. De todas formas Miguel, Salomón, Arantxa y Juliana ya han empezado sus casos.
  ],
  [
    - Miguel Francisco Vargas
    - Arantxa Marian Espejo Malagon
    - Juliana Sofia Novoa Solano
    - Sara Rodriguez Urueña
    - Samuel Beltrán Martínez
  ],

  [14],
  [Reunión],
  [19-10-2026],
  [
    Reunión semanal de seguimiento y exposición de avances de la semana (8:00 PM):
    - Miguel expuso el flujo completo de consulta de saldo y movimientos (CU-11 en `ms-core` y `web`), la vinculación obligatoria de tarjetas débito a cuentas, el campo `nombre_completo` en autenticación/perfil y la estandarización de pruebas unitarias tipadas con Elysia Treaty (`treaty(app)`) en los microservicios.
    - Juliana presentó las primeras iteraciones de beneficiarios (CU-03) y cuentas corrientes (CU-06).
    - Samuel expuso la entrega de CDT e inversiones (CU-12) y el avance en pruebas de integración.
    - Sara presentó los avances en notificaciones (CU-14) y tarjetas débito/bloqueo (CU-20, CU-22).
    - Arantxa presentó la implementación de límites por cuenta (CU-19), y Salomón expuso el motor ISO 20022 para transferencias externas (CU-26), el programador de pagos automáticos (CU-24), los reportes de pruebas en HTML/PDF y los ajustes de Kafka/HPA en Kubernetes.
    - Compromisos de la semana: iniciar el módulo de roles y permisos RBAC (CU-16), avanzar en préstamos (CU-13) e intereses/impuestos (CU-31), y estabilizar las semillas de base de datos en `infra`.
  ],
  [Todos],

  [15],
  [Reunión],
  [26-10-2026],
  [
    Reunión semanal de seguimiento y exposición de avances (8:00 PM):
    - Arantxa expuso el flujo de ahorro automático programado (CU-09) y Samuel presentó la primera entrega de préstamos (CU-13) e intereses e impuestos (CU-31).
    - Se revisó el estado de los reportes automatizados de pruebas y la sincronización de esquemas y seeds en las bases de datos de producción.
    - Miguel presentó la arquitectura propuesta para el control de acceso basado en roles (RBAC, CU-16) y conmutación dinámica de rol (CU-32) entre `ms-seguridad`, `api-gateway` y el portal administrativo en `web`, definiendo su implementación prioritaria para esa semana.
    - Se acordó iniciar la construcción del repositorio de demostración automatizada (`demo`) y preparar el cierre de dispositivos confiables (CU-17) y seguridad de cuenta (CU-18).
  ],
  [Todos],

  [16],
  [Reunión],
  [02-11-2026],
  [
    Reunión semanal de seguimiento y exposición de avances (8:00 PM):
    - Miguel expuso la implementación transversal de RBAC (CU-16) y conmutación de rol (CU-32) en `ms-seguridad`, `api-gateway`, `ms-core`, `ms-financiero`, `ms-tarjetas` y el nuevo portal administrativo (`AdminPortal.tsx` y `RoleSwitcher.tsx`) en `web`, junto con el script `scripts/assign-role.ts`.
    - Salomón presentó dispositivos confiables (CU-17), pagos presenciales en ventanilla (CU-28) y la primera versión en vivo del proyecto `demo`.
    - Arantxa expuso la gestión de seguridad de la cuenta (CU-18) y se ajustaron permisos de roles entre cliente y funcionarios.
    - Compromisos de la semana: desarrollar gestión de cuentas de ahorros y subcuentas (CU-07, CU-08), implementar PQRS (CU-04), ejecutar la estandarización global de formato (`bun format`) y verificación de estilo en CI, y actualizar los ADRs de arquitectura.
  ],
  [Todos],

  [17],
  [Reunión],
  [09-11-2026],
  [
    Reunión semanal de seguimiento y exposición de avances (8:00 PM):
    - Miguel presentó la estandarización transversal de formato (`bun format`) y la integración de verificación automática de estilo en los workflows de GitHub Actions de todos los repositorios, así como los scripts operativos de mantenimiento.
    - Juliana expuso las primeras iteraciones de cuentas de ahorros (CU-07) y subcuentas (CU-08); Sara presentó el módulo de PQRS (CU-04); Arantxa expuso historial de actividad (CU-01) y pagos con código QR (CU-25); y Samuel presentó la primera entrega de pago de facturas de servicios (CU-27).
    - Se acordó la hoja de ruta para la semana final de desarrollo: evaluación de tarjetas (CU-33), chat de soporte (CU-02), certificados bancarios (CU-10), avances de tarjeta de crédito (CU-23), pagos con tarjetas y ampliación de pruebas E2E e imágenes en GHCR.
  ],
  [Todos],

  [18],
  [Reunión],
  [16-11-2026],
  [
    Reunión semanal de cierre técnico y preparación de entrega final (8:00 PM):
    - Miguel expuso avances de tarjeta de crédito (CU-23), compras/pagos con tarjetas (`ComercioDemo`), filtros administrativos en `ms-core`/`web` y la limpieza de referencias internas en la interfaz; presentó además el cargador masivo de datos bancarios para Kubernetes (`db-loading/`), la renovación de la CLI interactiva de `demo` con Playwright y la ejecución de la suite de pruebas de carga y rendimiento (`performance/`) para validar el ASR-02 en `https://fpe.acha.dev`.
    - Sara expuso el chat de soporte y FAQs en `ms-crm` (CU-02); Juliana presentó certificados bancarios (CU-10); Samuel presentó evaluación de tarjetas (CU-33), billeteras externas (CU-29) y cierre de CU-12/CU-27; Arantxa expuso incremento de cupo (CU-34), idempotencia y la definición del atributo de calidad *Safety* (chequeo de sanidad en `ms-core`); y Salomón presentó las correcciones de seguridad/OWASP, monitoreo con Prometheus y estabilización del entorno de integración.
    - Compromisos finales: consolidar los resultados de rendimiento (`ASR-02`) en `arch-description.typ`, afinar los flujos en vivo de `demo` y actualizar las bitácoras individuales y grupal para la sustentación.
  ],
  [Todos],
)

= Bitacoras personales
#include "bitacoras-personales/miguel.typ"
#include "bitacoras-personales/arantxa.typ"
#include "bitacoras-personales/juliana.typ"
#include "bitacoras-personales/salomon.typ"
#include "bitacoras-personales/samuel.typ"
#include "bitacoras-personales/sara.typ"
