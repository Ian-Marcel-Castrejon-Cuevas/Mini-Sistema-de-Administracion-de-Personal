using NominaAPI.Models;
using NominaAPI.DTOs;
using NominaAPI.Services;

namespace NominaAPI.Services.Implementations;

public class NominaService : INominaService
{
    public NominaDTO CalcularNomina(Empleado e)
    {
        var quincenal = Math.Round(e.SalarioMensual / 2, 2);
        var imss = Math.Round(quincenal * 0.03m, 2);

        decimal isr = quincenal switch
        {
            <= 7500 => Math.Round(quincenal * 0.09m, 2),
            <= 15000 => Math.Round(quincenal * 0.16m, 2),
            _ => Math.Round(quincenal * 0.25m, 2)
        };

        var neto = Math.Round(quincenal - imss - isr, 2);

        return new NominaDTO
        {
            NumeroEmpleado = e.NumeroEmpleado,
            Nombre = e.Nombre,
            SalarioQuincenal = quincenal,
            DeduccionIMSS = imss,
            DeduccionISR = isr,
            SalarioNeto = neto
        };
    }
}