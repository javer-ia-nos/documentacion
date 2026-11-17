== Bitácora de Juliana Sofía Novoa Solano

#box(
  fill: rgb("#f8fafc"),
  inset: 12pt,
  radius: 6pt,
  width: 100%,
  stroke: 0.8pt + rgb("#cbd5e1"),
)[
  #grid(
    columns: (1.1fr, 0.9fr),
    gutter: 12pt,
    [
      *Estudiante:* Juliana Sofía Novoa Solano \
      *Rol:* Desarrolladora de Software / Diseño Arquitectónico \
      *Requisitos No Funcionales (RNF):* Usabilidad e Integrabilidad
    ],
    [
      *Casos de Uso Asignados:* \
      - *CU-03:* Gestión de Beneficiarios \
      - *CU-06:* Cuentas Corrientes \
      - *CU-07:* Cuentas de Ahorros \
      - *CU-08:* Subcuentas y Bolsillos de Ahorro \
      - *CU-10:* Certificados Bancarios y Validación Pública
    ],
  )
]

#v(8pt)

#table(
  columns: (26pt, 2.3fr, 74pt, 1.4fr),
  stroke: (x, y) => if y == 0 { (bottom: 1.5pt + rgb("#2563eb"), top: 0.5pt + rgb("#cbd5e1")) } else { 0.4pt + rgb("#e2e8f0") },
  fill: (col, row) => if row == 0 { rgb("#eff6ff") } else if calc.even(row) { rgb("#f8fafc") } else { none },
  align: (col, row) => if row == 0 { center + horizon } else if col == 0 or col == 2 { center + horizon } else { left + horizon },
  table.header(
    [*N°*],
    [*Descripción detallada*],
    [*Fecha*],
    [*Actividad realizada*],
  ),
  [1],
  [Diseño y elaboración del diagrama de contenedores bajo el modelo C4, mapeando las fronteras de los microservicios a partir de los casos de uso y el diagrama de contexto inicial.],
  [2026-08-23],
  [Diagrama de Contenedores (C4)],

  [2],
  [Elaboración del diagrama de componentes (C4 nivel 3) para la aplicación móvil bancaria, definiendo módulos de autenticación, cuentas y pagos.],
  [2026-09-07],
  [Diagrama de Componentes - Móvil],

  [3],
  [Refinamiento y actualización del diagrama de componentes móviles tras la retroalimentación del equipo de arquitectura para desacoplar servicios.],
  [2026-09-12],
  [Diagrama de Componentes (Mejora)],

  [4],
  [Construcción de la primera iteración del diagrama de código (C4 nivel 4) enfocado en la orquestación y flujo del módulo de pagos móviles.],
  [2026-09-14],
  [Diagrama de Código - Pagos Móvil],

  [5],
  [Diseño del diagrama de código para el componente financiero de la aplicación móvil, detallando modelos de consulta y balance.],
  [2026-09-14],
  [Diagrama de Código - Componente Financiero],

  [6],
  [Diseño e iteración del grafo de navegación de la aplicación web, estructurando las transiciones entre el portal de clientes, administración y servicios.],
  [2026-09-15],
  [Grafo de Navegación - Aplicación Web],

  [7],
  [Implementación inicial de la lógica de negocio para cuentas (CU-06, CU-07 y CU-08) en el microservicio `ms-core` (cuentas), y colaboración con Sara Rodríguez en CU-21 y CU-22.],
  [2026-09-19],
  [Implementación CU-06, CU-07, CU-08, CU-21 y CU-22],

  [8],
  [Implementación inicial del caso de uso #10 correspondiente a la generación y verificación de certificados bancarios.],
  [2026-09-19],
  [Implementación CU-10 - Certificados Bancarios],

  [9],
  [Desarrollo de las suites de pruebas de integración para los flujos 10, 11 y 12 de forma individual, y coautoría con Miguel Vargas en las pruebas de integración 4, 5 y 6.],
  [2026-09-21],
  [Pruebas de Integración E2E],

  [10],
  [Preparación y estructuración de diapositivas preliminares para la sustentación y entrega del proyecto.],
  [2026-09-22],
  [Diapositivas de Presentación Final],

  [11],
  [Primera iteración en código del caso de uso #06: creación del módulo de Cuentas Corrientes, definición de contratos, estados y reglas de negocio.],
  [2026-10-13],
  [Código CU-06 - Cuentas Corrientes],

  [12],
  [Primera iteración en código del caso de uso #03: gestión de beneficiarios bancarios y verificación de titularidad.],
  [2026-10-13],
  [Código CU-03 - Gestión de Beneficiarios],

  [13],
  [Primera iteración en código del caso de uso #07: gestión de cuentas de ahorros, parametrización de tasa EA vigente y liquidación de rendimientos.],
  [2026-11-03],
  [Código CU-07 - Cuentas de Ahorros],

  [14],
  [Primera iteración en código del caso de uso #08: creación y administración de subcuentas/bolsillos de ahorro con abonos y retiros protegidos.],
  [2026-11-03],
  [Código CU-08 - Subcuentas y Bolsillos],

  [15],
  [Implementación completa del caso de uso #10 (Certificados Bancarios y Validación Pública) en `ms-financiero`: validación de código único, hash SHA-256, exposición perimetral en `api-gateway`, interfaz web y pruebas automatizadas.],
  [2026-11-15],
  [Implementación Integral CU-10],

  [16],
  [Estructuración y diseño de las diapositivas oficiales de la presentación final del proyecto para la sustentación académica.],
  [2026-11-15],
  [Presentación Final - Diapositivas],

  [17],
  [Documentación, diseño de diagramas arquitectónicos y guion técnico de los Requisitos No Funcionales asignados: Usabilidad (diseño responsive, carga progresiva con feedback visual) e Integrabilidad (mediación REST/gRPC y propagación de identidad perimetral).],
  [2026-11-16],
  [Requisitos No Funcionales - Usabilidad e Integrabilidad],

  [18],
  [Mejoras de experiencia de usuario (UX) en la aplicación web: eliminación de placeholders fijos y reemplazo por componentes visuales tipo esqueleto (skeleton loaders) durante la carga de cuentas corrientes y de ahorros.],
  [2026-11-16],
  [Mejora de UX - Componentes Skeleton],

  [19],
  [Diagnóstico, corrección y estabilización del caso de uso #10: soporte de deserialización gRPC/HTTP en frontend web, preselección automática de cuentas activas, resolución multi-cuenta y fallback resiliente en `ms-financiero`, y habilitación de endpoint `GET /cuentas` en `ms-core`.],
  [2026-11-16],
  [Estabilización y Fix Caso de Uso #10],
)
