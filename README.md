# Sistema de Nómina

Aplicación fullstack que permite gestionar empleados y calcular su nómina quincenal mediante una API REST desarrollada en .NET y un frontend simple en HTML, CSS y JavaScript.

---

## Tecnologías utilizadas

* Backend: .NET 8 / ASP.NET Core Web API
* Base de datos: PostgreSQL
* ORM: Entity Framework Core
* Frontend: HTML, CSS, JavaScript (Fetch API)
* Estilos: Bootstrap

---

## Funcionalidades

* Listar empleados activos
* Crear empleados
* Calcular nómina quincenal:

  * Salario quincenal
  * Deducción IMSS (3%)
  * Deducción ISR (según rango)
  * Salario neto
* Interfaz con tabla y modal para visualizar la nómina

---

## Arquitectura

El proyecto sigue principios de separación de responsabilidades:

* Controllers → Manejo de endpoints
* Services → Lógica de negocio (cálculo de nómina)
* Models → Entidades
* DTOs → Transferencia de datos

Se implementa inyección de dependencias para desacoplar componentes.

---

## ⚙️ Configuración

---

### 1. Configurar base de datos

Editar `appsettings.json`:

```json
"ConnectionStrings": {
  "DefaultConnection": "Host=localhost;Port=5432;Database=nomina_db;Username=postgres;Password=tu_password"
}
```

---

### 2. Ejecutar backend

```bash
dotnet run
```

---

### 3. Ejecutar frontend

Abrir el archivo:

```text
frontend/index.html
```

---

## 🌐 Endpoints principales

| Método | Endpoint                   | Descripción       |
| ------ | -------------------------- | ----------------- |
| GET    | /api/empleados             | Obtener empleados |
| POST   | /api/empleados             | Crear empleado    |
| GET    | /api/empleados/{id}/nomina | Calcular nómina   |

---

## Interfaz

* Tabla de empleados
* Botón “Ver Nómina”
* Modal con desglose de salario

---

## Buenas prácticas implementadas

* Inyección de dependencias
* Separación por capas
* Validación de datos
* Uso de códigos HTTP correctos
* Formateo de datos monetarios

---

## Mejoras futuras

* Autenticación (JWT)
* Manejo global de errores
* Pruebas unitarias
* Paginación de resultados
* Relación con tabla de departamentos

---

## Autor

Ian Marcel Castrejón Cuevas
Ingeniería en Sistemas Computacionales
