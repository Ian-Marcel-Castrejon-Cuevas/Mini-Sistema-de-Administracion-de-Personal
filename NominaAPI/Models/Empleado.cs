using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace NominaAPI.Models;

[Table("empleados")]
public class Empleado
{
    [Column("id")]
    public int Id { get; set; }

    [Column("numeroempleado")]
    public string NumeroEmpleado { get; set; } = string.Empty;

    [Column("nombre")]
    public string Nombre { get; set; } = string.Empty;

    [Column("fechaingreso")]
    public DateTime FechaIngreso { get; set; }

    [Column("salariomensual")]
    public decimal SalarioMensual { get; set; }

    [Column("departamentoid")]
    public int DepartamentoId { get; set; }

    [Column("activo")]
    public bool Activo { get; set; }
}