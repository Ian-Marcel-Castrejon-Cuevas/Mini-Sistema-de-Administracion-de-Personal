namespace NominaAPI.DTOs;

public class NominaDTO
{
    public string NumeroEmpleado { get; set; } = string.Empty;
    public string Nombre { get; set; } = string.Empty;
    public decimal SalarioQuincenal { get; set; }
    public decimal DeduccionIMSS { get; set; }
    public decimal DeduccionISR { get; set; }
    public decimal SalarioNeto { get; set; }
}