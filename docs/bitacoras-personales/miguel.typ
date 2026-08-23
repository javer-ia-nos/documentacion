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
)
