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
)
