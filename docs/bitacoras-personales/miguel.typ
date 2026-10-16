#let version = sys.inputs.at("version", default: "main")
#let git_base_url = "https://github.com/javer-ia-nos/Documentacion/tree/" + version

== Bitacora de Miguel Francisco Vargas

#table(
  columns: 4,
  table.header([*n°*], [*Descripción*], [*Fecha*], [*Actividad realizada*]),
  [1],
  [Se realizó un workflow en github actions para el compilado de documentos finales de entrega, #link(git_base_url + "/.github/workflows/doc-generation.yaml", "doc-generation.yaml"). ],
  [2026-08-20],
  [Documentación],

  [2],
  [Se migraron manualmente los contenedores: #link(git_base_url + "/docs/diagrams/container-view.drawio", "container-view.drawio") y #link(git_base_url + "/docs/diagrams/system-view.drawio", "system-view.drawio") desde goa model a drawio debido a problemas de compatibilidad.],
  [2026-08-23],
  [Diagramas],

  [3],
  [Se añadio al workflow en github actions para el compilado de las imagenes finales de entrega, #link(git_base_url + "/.github/workflows/doc-generation.yaml", "doc-generation.yaml").],
  [2026-08-23],
  [Diagramas],

  [4],
  [Se agrego duocumentación interna para el equipo en los readme del repo y se mejoró la calidad de las imagenes generadas por el workflow e incrustadas en el documento final.],
  [2026-08-25],
  [Documentación y diagramas],

  [5],
  [Se revisaron los casos de uso y modificaron para especificar mejor algunos puntos importantes.
    - *CU-14 ( Notificaciones )*: Se agregan algunos tipos importantes de notificaciones.
    - *CU-21 ( Gestión de TC )*: Se agregan consultas importantes para el usuario.
    - *CU-26 ( transferencias )*: Se generaliza este caso de uso para permitir transacciones internas y nacionales.
    - *CU-31 ( info intereses e impuestos)*: Información clara para los usuarios.
    - *CU-32 ( facturas y servicios )*: Para poder pagar facturas y servicios.
  ],
  [2026-08-30],
  [Casos de uso],

  [6],
  [Se comenzo a editar el documento de arquitectura y se creo el repo de prueba para el servicio de transacciones, este incluye una plantila para trabajar sobre Elysia y sistema básico (por ahora) de pruebas unitarias.],
  [2026-09-03],
  [Repos y documentación],

  [7], [Ordenar archivos de diagrama de componentes], [2026-09-12], [Repo y documentación],

  [8], [Revisión y re-organización de diagramas], [2026-09-12], [Repo y documentación],

  [9],
  [Cu-32 estaba duplicado, entonces se elimino y agrego la información extra al CU-27],
  [2026-09-12],
  [Repo y documentación],

  [10],
  [Se desarrolla parte del docker y la db para el servicio de cuentas a modo de plantilla para el desarrollo de los demás servicios.],
  [2026-09-12],
  [Servicios y código],

  [11],
  [Revisión y ajuste de los casos de uso y responsabilidades arquitectónicas asignadas al servicio de CRM, actualizando tanto la especificación arquitectónica como el README del repositorio.],
  [2026-09-18],
  [Documentación y arquitectura],

  [12],
  [Estandarización y alineación arquitectónica de casos de uso y responsabilidades en los README de todos los microservicios (Auditoría, CRM, Cuentas, Financiero, Notificaciones, Seguridad, Tarjetas y Transacciones). Adicionalmente en la documentación general:
    - Inclusión de la entidad ChatMessage en el modelo E/R de CRM (CU-02).
    - Actualización de la arquitectura de pruebas en `dev.typ`.
    - Creación de la tabla maestra de responsables de pruebas de integración (INT-01 a INT-18).
  ],
  [2026-09-20],
  [Documentación y arquitectura],

  [13],
  [Creación desde cero del repositorio y servicio de API Gateway (`api-gateway`) con ElysiaJS y Bun: configuración de la arquitectura base, proxy inverso hacia los microservicios, middleware de auditoría, endpoints de healthcheck y documentación de responsabilidades y rutas en su README.],
  [2026-09-20],
  [Servicios y código],

  [14],
  [Creación desde cero del repositorio de integración E2E (`integracion`), configurando la orquestación multi-servicio mediante Docker Compose y la suite de pruebas automatizadas con Bun Test para validar la comunicación e interoperabilidad de todo el sistema.],
  [2026-09-20],
  [Infraestructura y pruebas],

  [15],
  [Implementación de casos de uso asignados en los microservicios de negocio:
    - *ms-cuentas*: Gestión de beneficiarios y contactos frecuentes (CU-03), y programación/ejecución de ahorro automático en bolsillos (CU-09).
    - *ms-transacciones*: Generación, lectura y procesamiento de cobros/pagos mediante códigos QR dinámicos y estáticos (CU-25).
    - *ms-financiero*: Consulta de saldos, movimientos y extractos bancarios de posición consolidada (CU-11), además de corrección en scripts de seed.
  ],
  [2026-09-21],
  [Servicios y backend],

  [16],
  [Estandarización transversal del modelo canónico de usuario y sesión (User / UserSession / LoginResult): corrección y serialización de fechas en SQLite y constraints en ms-seguridad, actualización de tipos compartidos en ui-shared y adaptación del consumo de sesión en el frontend web.],
  [2026-09-21],
  [Servicios y frontend],

  [17],
  [Desarrollo de pruebas de integración E2E automatizadas para los flujos asignados: INT-07 (Beneficiarios), INT-08 (Pagos QR) e INT-09 (Ahorro automático). Se corrigieron condiciones de arranque en servidores Docker (ms-crm, ms-notificaciones, ms-tarjetas) y se implementó el workflow en GitHub Actions para ejecución continua de pruebas de integración.],
  [2026-09-21],
  [Pruebas e integración],

  [18],
  [Implementación en `ms-transacciones` de validación de dispositivos confiables (INT-03) y validación de topes transaccionales por operación en JWT (ASR-02). Eliminación de bypasses de prueba en clientes de producción y aislamiento de tests para ejecución autónoma en CI sin dependencias externas.],
  [2026-09-21],
  [Servicios y seguridad],

  [19],
  [Integración del flujo de auditoría entre el API Gateway y `ms-auditoria`: reenvío asíncrono/HTTP de intenciones de auditoría desde el gateway hacia `ms-auditoria`, inclusión de detalles en la consulta de historial por servicio, y corrección del consumidor de eventos Kafka y manejo de puertos efímeros en servidores.],
  [2026-09-21],
  [Servicios y auditoría],

  [20],
  [Implementación de pruebas de integración E2E para INT-03 (dispositivos confiables y validación de topes), configuración de red e interconexión multi-servicio en Docker Compose, y restauración de aserciones contables de saldo con aprovisionamiento real de cuentas.],
  [2026-09-21],
  [Pruebas e integración],

  [21],
  [Revisión y actualización de textos y guías de documentación arquitectónica en Typst, auditoría del repositorio y preparación de entregables para sustentación.],
  [2026-09-22],
  [Documentación y auditoría],

  [22],
  [Reestructuración arquitectónica mayor para la entrega final (v2): creación del repositorio unificado `ms-core` (PostgreSQL, Dockerfile y scripts de migración), incorporación de la rama `v2` en todos los repositorios, y actualización de dependencias reproducibles con `bun.lock`.],
  [2026-10-08],
  [Arquitectura e infraestructura],

  [23],
  [Actualización de asignación formal de casos de uso en `arch-description.typ` (asumiendo CU-15, CU-16, CU-21, CU-23 y cediendo CU-03, CU-09, CU-25). Desarrollo del Splash Screen animado y sistema de notificaciones/toasts flotantes en el frontend web.],
  [2026-10-08],
  [Casos de uso y frontend],

  [24],
  [Implementación completa del backend de autenticación en `ms-seguridad` (CU-15): registro con hashing seguro, inicio de sesión con JWT firmado (15 min), cierre de sesión con revocación de tokens en BD y endpoint de perfil `/me`.],
  [2026-10-09],
  [Seguridad y backend],

  [25],
  [Implementación del API Gateway v2 con seguridad perimetral: validación de tokens JWT en `/auth/validar` contra `ms-seguridad`, enrutamiento gRPC hacia `ms-core` para operaciones críticas, proxy inverso HTTP hacia microservicios y eliminación de cabeceras de suplantación de identidad.],
  [2026-10-11],
  [API Gateway y seguridad],

  [26],
  [Estandarización transversal de CI en microservicios mediante GitHub Actions con PostgreSQL y precarga de `seed.sql`. Implementación del frontend de autenticación (CU-15) en Astro/React y suite de pruebas E2E automatizadas con `Bun.WebView` y Chrome DevTools Protocol (CDP) en `integracion`.],
  [2026-10-11],
  [Pruebas E2E y CI],

  [27],
  [Implementación completa del módulo de Gestión de Tarjetas (CU-21 y CU-23): endpoints de emisión, consulta, estados y borrado lógico en `ms-tarjetas`, componente reactivo `CardsManager.tsx` y vista de tarjetas en frontend web. Formalización de casos de uso administrativos CU-32 a CU-36 en la documentación arquitectónica.],
  [2026-10-12],
  [Backend, frontend y arquitectura],

  [28],
  [Asociación obligatoria de tarjetas débito a cuentas bancarias existentes en `ms-tarjetas` y `CardsManager.tsx`. Estandarización institucional del nombre del banco en `infra`, `ms-core`, `integracion` y `web`. Corrección y estabilización de pruebas E2E para el flujo de bienvenida (`/welcome`) y ajustes de paleta y limpieza en frontend.],
  [2026-10-13],
  [Backend, frontend y pruebas],

  [29],
  [Incorporación transversal del campo de nombre completo (`nombre_completo`): actualización de esquema relacional y seed en `ms-seguridad`, soporte en endpoints y pruebas unitarias de autenticación, adaptación de formularios de registro y visualización en perfil y bienvenida en el frontend web (`AuthForm.tsx`, `profile.astro`, `home.astro`), y actualización de helpers de integración E2E.],
  [2026-10-14],
  [Seguridad, backend y frontend],

  [30],
  [Implementación completa del módulo de consulta de movimientos de cuentas bancarias: servicio, endpoints con soporte de filtros y paginación en `ms-core`, y desarrollo de su suite de pruebas unitarias (`cuentas-movimientos.test.ts`). En frontend web, desarrollo del carrusel de cuentas (`AccountsOverflow.tsx`), vista detallada (`/cuenta/[id]`) y componentes reactivos de saldo, filtros y transacciones (`AccountDetailsAndMovements.tsx`, `AccountBalanceCard.tsx`, `AccountMovementItem.tsx`).],
  [2026-10-15],
  [Backend y frontend],

  [31],
  [Estandarización transversal de pruebas unitarias y de integración en todos los microservicios (`ms-core`, `ms-financiero`, `ms-notificaciones`, `ms-seguridad`, `ms-tarjetas`), migrando a llamadas tipadas estrictas mediante Elysia Treaty (`treaty(app)`). Desacoplamiento condicional del levantamiento de servidores en sus puntos de entrada (`index.ts`) para prevenir colisiones de puertos en entornos de test.],
  [2026-10-16],
  [Arquitectura y pruebas],

  [32],
  [Refactorización y optimización de UX/UI en la plataforma web: mejoras de robustez en el proveedor de notificaciones (`NotificationsProvider.astro`), emisión simplificada de tarjetas infiriendo el nombre del titular automáticamente sin entrada manual en `ms-tarjetas` y `CardsManager.tsx`, ajustes visuales de responsividad en pantallas, y estabilización de la suite de pruebas E2E en `integracion`.],
  [2026-10-16],
  [Backend, frontend y pruebas],
)
