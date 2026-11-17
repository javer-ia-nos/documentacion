# Cierre verificable de un caso de uso

Esta lista evita que un flujo quede implementado en un repositorio pero ausente de la entrega final.

## Antes de abrir el PR

- [ ] La rama parte de la base vigente (`v2` para aplicación e integración; `main` para infraestructura y documentación).
- [ ] Las tablas, columnas, índices y migraciones PostgreSQL usan nombres en minúscula.
- [ ] Se ejecutaron formatter, type-check y pruebas unitarias del servicio dueño.
- [ ] La ruta se probó desde `http://localhost:3000` con un resultado exitoso y uno rechazado.
- [ ] Las dependencias externas, tiempo y aleatoriedad se pueden controlar en pruebas mediante un puerto, doble o dato determinista.

## Integración y evidencia

- [ ] Existe una prueba de integración en `integracion/tests/` que levanta los servicios y la base necesarios.
- [ ] La prueba comprueba postcondiciones: respuesta HTTP, estado persistido, saldo/cupo si aplica, idempotencia y evento/outbox cuando corresponda.
- [ ] La ejecución de GitHub Actions pasa y conserva reporte/logs suficientes para diagnosticar una falla.
- [ ] Existe un recorrido E2E de navegador en Playwright, o se dejó explícitamente registrado como pendiente con dueño y fecha antes de declarar el CU cerrado.
- [ ] La demostración visual muestra el resultado para la sustentación sin alterar datos productivos.

## Documentación y entrega

- [ ] Se actualizó `docs/arch-description.typ` y la matriz `docs/testability.typ` con el dueño real V2, flujo y evidencia.
- [ ] El diagrama dinámico representa los servicios y rutas actuales; `ms-core` se usa para los módulos fusionados de Cuentas/Transacciones.
- [ ] La bitácora personal y el plan de integración no atribuyen CU-27/CU-29/CU-31 a servicios antiguos.
- [ ] El PR tiene una descripción del flujo, evidencia de pruebas y no incluye secretos, credenciales ni artefactos locales.
