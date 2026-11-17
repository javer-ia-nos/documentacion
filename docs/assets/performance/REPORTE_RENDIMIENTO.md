# Reporte de Pruebas de Carga y Rendimiento — ASR-02

> **Sistema:** Banca Digital Javer-IA-nos  
> **Objetivo ASR-02:** Rendimiento en Operaciones Críticas (< 2s bajo alta concurrencia)  
> **Entorno Evaluado:** `https://fpe.acha.dev` (`https://fpe.acha.dev/api`)  
> **Fecha de Ejecución:** `2026-11-17T04:36:25.651Z` → `2026-11-17T04:42:35.489Z` (369.84 s)  
> **Pool de Usuarios Activos:** 40 clientes concurrentes (`db-loading`)  
> **Runtime del Generador:** Bun 1.4.4 (darwin arm64)

---

## 1. Resumen Ejecutivo por Operación Crítica

| Operación | Peticiones | Éxito (%) | Avg (ms) | p50 (ms) | p95 (ms) | p99 (ms) | Max (ms) | Cumple ASR-02 (`p95 <= 2000ms`) |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | :---: |
| `GET /health` | 3888 | 100.00% | 134.0 | 130.6 | 148.7 | 252.4 | 390.7 | **PASS** |
| `GET /cuentas` | 8483 | 100.00% | 186.6 | 148.5 | 340.0 | 488.0 | 963.5 | **PASS** |
| `GET /cuentas/movimientos` | 2712 | 100.00% | 178.3 | 166.5 | 257.6 | 320.4 | 493.4 | **PASS** |
| `POST /transacciones/transferencias` | 6651 | 100.00% | 299.7 | 227.3 | 658.0 | 899.0 | 1397.4 | **PASS** |
| `POST /transacciones/qr` | 502 | 100.00% | 182.1 | 168.4 | 291.3 | 397.8 | 491.4 | **PASS** |
| `POST /transacciones/qr/decodificar` | 764 | 100.00% | 153.1 | 140.5 | 203.1 | 289.6 | 532.8 | **PASS** |
| `POST /transacciones/qr/pagar` | 5835 | 100.00% | 310.4 | 247.8 | 676.0 | 921.7 | 1306.8 | **PASS** |
| `POST /auth/login` | 94 | 90.43% | 3978.3 | 3135.8 | 10167.7 | 10402.4 | 10457.6 | **FAIL** |
| `POST /transferencias (single-user)` | 777 | 99.87% | 194.8 | 172.9 | 288.2 | 314.6 | 5142.9 | **PASS** |
| `POST /transferencias (multi-user)` | 890 | 100.00% | 169.6 | 155.5 | 234.8 | 403.0 | 520.3 | **PASS** |
| `GET /limites/:usuarioId` | 805 | 100.00% | 140.8 | 137.7 | 165.7 | 190.7 | 257.7 | **PASS** |
| `GET /dispositivos` | 805 | 100.00% | 141.2 | 138.2 | 163.8 | 195.1 | 233.3 | **PASS** |
| `GET /notificaciones/historial` | 806 | 100.00% | 141.7 | 138.1 | 171.2 | 200.6 | 273.1 | **PASS** |
| `GET /pqrs/mis-solicitudes` | 804 | 100.00% | 141.6 | 138.6 | 161.3 | 193.6 | 341.0 | **PASS** |
| `GET /tarjetas` | 808 | 100.00% | 142.0 | 138.6 | 169.6 | 200.6 | 223.6 | **PASS** |
| `GET /financiero/prestamos` | 805 | 100.00% | 142.8 | 139.6 | 170.9 | 199.9 | 261.9 | **PASS** |
| `GET /auth/validar` | 2965 | 100.00% | 135.9 | 134.4 | 149.0 | 170.1 | 463.1 | **PASS** |
| `POST /transferencias (idempotency-replay)` | 1335 | 100.00% | 150.8 | 141.9 | 209.1 | 259.7 | 305.9 | **PASS** |
| `GET /cuentas/beneficiarios` | 1025 | 100.00% | 149.2 | 140.2 | 200.7 | 241.4 | 374.6 | **PASS** |
| `GET /transferencias-externas/catalogo` | 1022 | 100.00% | 148.9 | 140.3 | 203.4 | 223.8 | 399.3 | **PASS** |
| `GET /transacciones/pagos-automaticos` | 1021 | 100.00% | 147.1 | 139.1 | 197.9 | 221.0 | 389.9 | **PASS** |
| `GET /transacciones/ahorros-automaticos` | 1017 | 100.00% | 148.5 | 139.3 | 202.4 | 237.6 | 388.6 | **PASS** |

---

## 2. Resultados Detallados por Escenario y Nivel de Concurrencia

| Escenario | Etapa | VUs | Duración (s) | Reqs | RPS Exitoso | Error (%) | p50 (ms) | p95 (ms) | p99 (ms) | ASR-02 |
| :--- | :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: | ---: | :---: |
| Baseline (/health) | `vus_1` | 1 | 6.0 | 43 | 7.13 | 0.00% | 139.1 | 141.1 | 164.7 | **PASS** |
| Baseline (/health) | `vus_10` | 10 | 6.1 | 449 | 73.24 | 0.00% | 132.5 | 148.0 | 163.0 | **PASS** |
| Baseline (/health) | `vus_25` | 25 | 6.1 | 1133 | 184.76 | 0.00% | 130.4 | 148.8 | 260.9 | **PASS** |
| Baseline (/health) | `vus_50` | 50 | 6.1 | 2263 | 370.81 | 0.00% | 130.2 | 148.8 | 251.4 | **PASS** |
| CU-11 Consultas (Saldo/Movs) | `vus_1` | 1 | 9.1 | 61 | 6.69 | 0.00% | 141.9 | 171.9 | 188.0 | **PASS** |
| CU-11 Consultas (Saldo/Movs) | `vus_10` | 10 | 9.1 | 617 | 67.52 | 0.00% | 141.2 | 173.3 | 197.9 | **PASS** |
| CU-11 Consultas (Saldo/Movs) | `vus_25` | 25 | 9.2 | 1506 | 164.60 | 0.00% | 141.8 | 187.7 | 337.4 | **PASS** |
| CU-11 Consultas (Saldo/Movs) | `vus_50` | 50 | 9.2 | 2715 | 296.36 | 0.00% | 154.4 | 248.2 | 297.1 | **PASS** |
| CU-30 Transferencias (gRPC) | `vus_1` | 1 | 9.2 | 55 | 6.01 | 0.00% | 153.5 | 208.8 | 428.7 | **PASS** |
| CU-30 Transferencias (gRPC) | `vus_5` | 5 | 9.1 | 284 | 31.10 | 0.00% | 148.7 | 216.9 | 291.6 | **PASS** |
| CU-30 Transferencias (gRPC) | `vus_10` | 10 | 9.2 | 558 | 60.75 | 0.00% | 151.8 | 214.3 | 281.7 | **PASS** |
| CU-30 Transferencias (gRPC) | `vus_20` | 20 | 9.3 | 948 | 101.69 | 0.00% | 190.8 | 285.6 | 474.8 | **PASS** |
| CU-30 Transferencias (gRPC) | `vus_35` | 35 | 9.3 | 1225 | 131.95 | 0.00% | 239.5 | 406.6 | 473.1 | **PASS** |
| CU-30 Transferencias (gRPC) | `vus_50` | 50 | 9.3 | 1383 | 148.01 | 0.00% | 311.4 | 502.1 | 603.6 | **PASS** |
| CU-25 Pagos QR (gRPC) | `vus_1` | 1 | 9.1 | 55 | 6.07 | 0.00% | 161.6 | 178.8 | 232.3 | **PASS** |
| CU-25 Pagos QR (gRPC) | `vus_5` | 5 | 9.1 | 302 | 33.20 | 0.00% | 146.9 | 177.5 | 195.3 | **PASS** |
| CU-25 Pagos QR (gRPC) | `vus_10` | 10 | 9.2 | 575 | 62.86 | 0.00% | 150.2 | 201.0 | 297.3 | **PASS** |
| CU-25 Pagos QR (gRPC) | `vus_20` | 20 | 9.1 | 997 | 109.07 | 0.00% | 175.3 | 275.5 | 373.9 | **PASS** |
| CU-25 Pagos QR (gRPC) | `vus_35` | 35 | 9.2 | 1243 | 134.61 | 0.00% | 214.9 | 503.9 | 606.2 | **PASS** |
| CU-25 Pagos QR (gRPC) | `vus_50` | 50 | 9.1 | 1462 | 160.29 | 0.00% | 300.9 | 486.9 | 612.0 | **PASS** |
| Carga Mixta Sostenida | `sustained_30` | 30 | 30.2 | 5514 | 182.71 | 0.00% | 151.0 | 228.1 | 330.0 | **PASS** |
| CU-15 Login (Argon2id) | `vus_1` | 1 | 9.2 | 8 | 0.87 | 0.00% | 1141.7 | 1309.8 | 1342.3 | **PASS** |
| CU-15 Login (Argon2id) | `vus_5` | 5 | 10.2 | 21 | 2.06 | 0.00% | 1903.6 | 4536.4 | 4747.8 | **FAIL** |
| CU-15 Login (Argon2id) | `vus_10` | 10 | 11.6 | 28 | 2.40 | 0.00% | 2660.1 | 8914.1 | 8924.8 | **FAIL** |
| CU-15 Login (Argon2id) | `vus_20` | 20 | 12.0 | 37 | 2.33 | 24.32% | 4540.1 | 10388.9 | 10436.3 | **FAIL** |
| Contención Lock Usuario | `single_user_15` | 15 | 10.2 | 777 | 76.13 | 0.13% | 172.9 | 288.2 | 314.6 | **PASS** |
| Contención Lock Usuario | `multi_user_15` | 15 | 10.1 | 890 | 87.74 | 0.00% | 155.5 | 234.8 | 403.0 | **PASS** |
| Ecosistema HTTP (5 MS) | `vus_10` | 10 | 8.1 | 564 | 69.76 | 0.00% | 139.6 | 164.5 | 191.7 | **PASS** |
| Ecosistema HTTP (5 MS) | `vus_25` | 25 | 8.2 | 1424 | 174.24 | 0.00% | 138.1 | 167.2 | 198.2 | **PASS** |
| Ecosistema HTTP (5 MS) | `vus_50` | 50 | 8.1 | 2845 | 349.79 | 0.00% | 138.3 | 167.9 | 193.7 | **PASS** |
| Estrés / Pico Core (75-120 VUs) | `stress_75` | 75 | 8.3 | 1932 | 232.81 | 0.00% | 288.9 | 597.5 | 768.8 | **PASS** |
| Estrés / Pico Core (75-120 VUs) | `stress_100` | 100 | 8.3 | 1938 | 232.70 | 0.00% | 400.2 | 806.6 | 996.0 | **PASS** |
| Estrés / Pico Core (75-120 VUs) | `spike_120` | 120 | 6.6 | 1577 | 239.69 | 0.00% | 437.1 | 868.0 | 1006.9 | **PASS** |
| Validación Sesión & Idempotencia | `auth_validar_50` | 50 | 8.1 | 2965 | 364.57 | 0.00% | 134.4 | 149.0 | 170.1 | **PASS** |
| Validación Sesión & Idempotencia | `idem_replay_25` | 25 | 8.1 | 1335 | 164.33 | 0.00% | 141.9 | 209.1 | 259.7 | **PASS** |
| gRPC Core Extendido | `vus_25` | 25 | 8.1 | 1420 | 174.44 | 0.00% | 139.2 | 171.3 | 195.6 | **PASS** |
| gRPC Core Extendido | `vus_50` | 50 | 8.1 | 2665 | 327.70 | 0.00% | 140.2 | 206.1 | 256.1 | **PASS** |

---

## 3. Gráficas Exportadas

### 3.1 Comparativa ASR-02 en Máxima Concurrencia
![Comparativa ASR-02](./charts/01_asr02_sla_comparativo.png)

### 3.2 Escalado de Latencia (p50 y p95) vs Concurrencia
![Escalado Latencia vs Concurrencia](./charts/02_escalado_concurrencia_latencia.png)

### 3.3 Capacidad de Procesamiento (RPS) y Tasa de Error
![Throughput y Errores](./charts/03_throughput_y_errores_concurrencia.png)

### 3.4 Distribución Estadística (CDF y Boxplot)
![Distribución CDF y Boxplot](./charts/04_distribucion_latencias_cdf_boxplot.png)

### 3.5 Serie Temporal — Carga Mixta Sostenida
![Serie Temporal Carga Mixta](./charts/05_workload_mixto_serie_temporal.png)

### 3.6 Análisis Arquitectónico de Cuellos de Botella
![Cuellos de Botella](./charts/06_analisis_cuellos_botella.png)

### 3.7 Estrés Extremo (75–120 VUs) y Ecosistema de Microservicios
![Estrés Extremo y Ecosistema](./charts/07_stress_pico_y_ecosistema.png)

### 3.8 Seguridad Perimetral (/auth/validar) e Idempotencia Concurrente
![Seguridad e Idempotencia](./charts/08_seguridad_validar_e_idempotencia.png)
