== Bitacora de Samuel Beltrán Martínez

#table(
  columns: 4,
  table.header([*n°*], [*Descripción*], [*Fecha*], [*Actividad realizada*]),
  [1],
  [Se realizó las modificaciones correspondientes al diagrama de contexto, desglosando los principales actores presentes en el sistema bancario y teniendo en cuenta el personal específico asociado a personas jurídicas y personas naturales.],
  [2026-09-07],
  [Diagramas],

  [2],
  [Se realizó el diagrama de clases del backend financiero en donde se alinearon las entidades con el modelo E/R en inglés, se agregaron DTOs, se aplicó inyección de dependencias y se integraron los servicios externos clave (Auditoría, Central de Riesgo).],
  [2026-09-15],
  [Diagramas],

  [3],
  [Se implementaron los casos de uso CU-12, CU-13, CU-27 y CU-29 en el microservicio financiero, incluyendo la creación de CDT e inversiones, gestión de préstamos y amortización, pago de facturas y recargas móviles, y vinculación de billeteras externas.],
  [2026-09-15],
  [Desarrollo],

  [4],
  [Se diseñaron los contratos, controladores, casos de uso, repositorios y esquemas de persistencia necesarios para cada funcionalidad, tomando como referencia la estructura y buenas prácticas del microservicio de transacciones.],
  [2026-09-15],
  [Desarrollo],

  [5],
  [Se configuró Bun en el entorno de desarrollo y se elaboraron pruebas automatizadas para validar flujos exitosos, reglas de negocio y validaciones de los cuatro casos de uso. Se verificó la ejecución correcta de 14 pruebas y la validación de tipos con TypeScript.],
  [2026-09-15],
  [Pruebas],

  [6],
  [Se construyeron y ejecutaron exitosamente las pruebas de integración automatizadas INT-13, INT-14 e INT-15 en Bun, validando la comunicación HTTP punto a punto y el flujo transaccional entre ms-cuentas, ms-financiero y ms-transacciones.],
  [2026-09-22],
  [Pruebas],

  [7],
  [Se implementó y ajustó el módulo de CDT e inversiones (CU-12) en `ms-financiero`, `ms-core` y `web` en la arquitectura v2, incorporando reintentos seguros, liquidación y su suite de pruebas de integración aisladas (`tests/cu12.integration.test.ts`).],
  [2026-10-19],
  [Desarrollo y pruebas],

  [8],
  [Se implementaron y entregaron en v2 la gestión de préstamos y tabla de amortización (CU-13) y la visualización clara de intereses e impuestos aplicados (CU-31) en `ms-financiero`, `ms-core`, `web` e `integracion` (`tests/cu13.integration.test.ts` y `tests/cu31.integration.test.ts`).],
  [2026-10-26],
  [Desarrollo y pruebas],

  [9],
  [Se implementó el pago de facturas de servicios públicos y recargas móviles con desglose tributario (CU-27) en `ms-core`, `web`, `infra` (tabla `service_payments`) y su prueba de integración (`tests/cu27.integration.test.ts`).],
  [2026-11-09],
  [Desarrollo y pruebas],

  [10],
  [Se implementó la vinculación de billeteras externas (CU-29) en el backend de `ms-tarjetas` con su respectivo módulo, persistencia y pruebas automatizadas.],
  [2026-11-15],
  [Desarrollo],

  [11],
  [Se completó el flujo de evaluación de riesgo y aprobación administrativa de solicitudes de tarjetas de crédito (CU-33) entre `ms-financiero`, `ms-tarjetas`, `web`, `infra` e `integracion` (`tests/cu33.integration.test.ts`), cerrando las entregas finales y formato en los repositorios.],
  [2026-11-16],
  [Desarrollo y pruebas],
)
