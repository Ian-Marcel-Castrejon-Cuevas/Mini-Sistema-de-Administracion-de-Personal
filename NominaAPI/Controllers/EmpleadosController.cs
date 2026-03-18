using Microsoft.AspNetCore.Mvc;
using NominaAPI.Models;
using NominaAPI.Services;

namespace NominaAPI.Controllers;

[ApiController]
[Route("api/[controller]")]
public class EmpleadosController : ControllerBase
{
    private readonly INominaService _nominaService;
    private readonly AppDbContext _context;

    public EmpleadosController(INominaService nominaService, AppDbContext context)
    {
        _nominaService = nominaService;
        _context = context;
    }

    [HttpGet]
    public IActionResult Get()
    {
        var empleados = _context.Empleados
            .Where(e => e.Activo)
            .OrderBy(e => e.Id)
            .ToList();

        return Ok(empleados);
    }

    [HttpPost]
    public IActionResult Crear(Empleado empleado)
    {
        if (empleado.SalarioMensual <= 0)
            return BadRequest("El salario debe ser mayor a 0");

        empleado.FechaIngreso = DateTime.SpecifyKind(empleado.FechaIngreso, DateTimeKind.Utc);

        _context.Empleados.Add(empleado);
        _context.SaveChanges();

        return Created($"api/empleados/{empleado.Id}", empleado);
    }

    [HttpGet("{id}/nomina")]
    public IActionResult Nomina(int id)
    {
        var emp = _context.Empleados.FirstOrDefault(e => e.Id == id);

        if (emp == null)
            return NotFound();

        var resultado = _nominaService.CalcularNomina(emp);

        return Ok(resultado);
    }
}