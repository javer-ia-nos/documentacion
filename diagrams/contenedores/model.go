package model

import . "goa.design/model/dsl"

var _ = Design("Sistema de Banca Digital", "Diagrama de Contenedores del Sistema", func() {

	// ==========================================
	// 1. SISTEMAS EXTERNOS
	// ==========================================
	var PasarelaPagos = SoftwareSystem("Pasarela de Pagos Internacionales",
		"Procesa transferencias internacionales y liquidaciones interbancarias.",
		func() {
			External()
			Tag("externo")
		})

	var BilleterasExternas = SoftwareSystem("Billeteras Digitales Externas",
		"Apple Pay, Google Wallet y otras billeteras vinculadas a tarjetas del banco.",
		func() {
			External()
			Tag("externo")
		})

	var ConveniosServicios = SoftwareSystem("Proveedores de Servicios Públicos",
		"Empresas con convenio de recaudo para pago de facturas.",
		func() {
			External()
			Tag("externo")
		})

	var SistemaNotificaciones = SoftwareSystem("Proveedor de Notificaciones",
		"Servicio externo de envío de SMS, correo electrónico y push.",
		func() {
			External()
			Tag("externo")
		})

	var BurCredito = SoftwareSystem("Central de Riesgo - Bureau de Crédito",
		"Consulta de score crediticio para aprobación de préstamos.",
		func() {
			External()
			Tag("externo")
		})

	var EnteRegulador = SoftwareSystem("Ente Regulador Financiero",
		"Organismo de supervisión que recibe reportes de auditoría y cumplimiento.",
		func() {
			External()
			Tag("externo")
		})

	// ==========================================
	// 2. SISTEMA INTERNO Y CONTENEDORES
	// ==========================================
	var SistemaBancario = SoftwareSystem("Sistema de Banca Digital",
		"Permite a los clientes gestionar cuentas, tarjetas, transacciones, préstamos e inversiones de forma segura.",
		func() {
			Tag("interno")

			// Contenedor 1: Mobile App
			Container("Aplicación Móvil",
				"Proporciona acceso a los servicios de banca digital desde dispositivos móviles.",
				"React Native",
				func() {
					Tag("mobile")
					Uses("Sistema de Banca Digital/API Backend Principal", "Realiza llamadas a la API", "JSON/HTTPS")
				})

			// Contenedor 2: Web SPA
			Container("Single-Page Application (SPA)",
				"Proporciona la funcionalidad de banca por internet a los clientes vía navegador web.",
				"React / TypeScript",
				func() {
					Tag("web")
					Uses("Sistema de Banca Digital/API Backend Principal", "Realiza llamadas a la API", "JSON/HTTPS")
				})

			// Contenedor 3: Portal Backoffice
			Container("Portal de Atención y Backoffice",
				"Permite a los agentes atender chats de soporte, gestionar PQRS y procesar reclamaciones.",
				"React / Admin Template",
				func() {
					Tag("web")
					Uses("Sistema de Banca Digital/API Backend Principal", "Realiza llamadas a la API de administración", "JSON/HTTPS")
				})

			// Contenedor 5: Base de Datos Relacional
			var Database = Container("Base de Datos Transaccional",
				"Almacena la información de usuarios, cuentas, tarjetas, transacciones, créditos y auditoría.",
				"PostgreSQL / Database Schema",
				func() {
					Tag("database")
				})

			// Contenedor 6: Almacén de Documentos
			var DocumentStore = Container("Almacén de Documentos",
				"Almacena los extractos bancarios, comprobantes en PDF y certificados generados.",
				"Amazon S3 / Object Storage",
				func() {
					Tag("database")
				})

			// Contenedor 4: Backend API
			Container("API Backend Principal",
				"Procesa la lógica de negocio bancaria, autenticación, transacciones y orquestación de servicios.",
				"Go / REST API",
				func() {
					Tag("backend")
					Uses(PasarelaPagos, "Envía y recibe fondos de transferencias internacionales", "API REST / SWIFT")
					Uses(BilleterasExternas, "Sincroniza y valida tarjetas vinculadas", "API REST")
					Uses(ConveniosServicios, "Envía pagos de facturas registradas", "API REST")
					Uses(SistemaNotificaciones, "Envía alertas de movimientos y eventos de seguridad", "API REST")
					Uses(BurCredito, "Consulta historial crediticio del solicitante", "API REST")
					Uses(EnteRegulador, "Reporta eventos de auditoría y cumplimiento normativo", "SFTP / API")
					Uses(Database, "Lee y escribe información transaccional", "SQL/TCP")
					Uses(DocumentStore, "Almacena y recupera extractos y certificados en PDF", "HTTPS/AWS SDK")
				})
		})

	// ==========================================
	// 3. PERSONAS Y SUS RELACIONES
	// ==========================================
	Person("Cliente Bancario",
		"Usuario que accede a los servicios de banca digital para gestionar sus productos financieros.",
		func() {
			Uses("Sistema de Banca Digital/Aplicación Móvil", "Gestiona cuentas, transferencias y pagos desde su smartphone", "HTTPS")
			Uses("Sistema de Banca Digital/Single-Page Application (SPA)", "Consulta saldos, realiza transferencias y gestiona tarjetas vía web", "HTTPS")
			Tag("persona")
		})

	Person("Agente de Atención al Cliente",
		"Empleado del banco que atiende chats de soporte y gestiona PQRS.",
		func() {
			Uses("Sistema de Banca Digital/Portal de Atención y Backoffice", "Gestiona PQRS, atiende chat de soporte y reclamos", "HTTPS")
			Tag("persona")
		})

	// ==========================================
	// 4. VISTAS Y ESTILOS
	// ==========================================
	Views(func() {
		ContainerView(SistemaBancario, "ContainerView", "Diagrama de Contenedores del Sistema de Banca Digital.", func() {
			AddAll()
			AutoLayout(RankTopBottom)
		})

		Styles(func() {
			ElementStyle("persona", func() {
				Shape(ShapePerson)
				Background("#08427b")
				Color("#ffffff")
			})
			ElementStyle("interno", func() {
				Background("#1168bd")
				Color("#ffffff")
			})
			ElementStyle("externo", func() {
				Background("#999999")
				Color("#ffffff")
			})
			ElementStyle("mobile", func() {
				Shape(ShapeMobileDevicePortrait)
				Background("#438dd5")
				Color("#ffffff")
			})
			ElementStyle("web", func() {
				Shape(ShapeWebBrowser)
				Background("#438dd5")
				Color("#ffffff")
			})
			ElementStyle("backend", func() {
				Shape(ShapeHexagon)
				Background("#85bbf0")
				Color("#000000")
			})
			ElementStyle("database", func() {
				Shape(ShapeCylinder)
				Background("#85bbf0")
				Color("#000000")
			})
		})
	})
})