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
)
