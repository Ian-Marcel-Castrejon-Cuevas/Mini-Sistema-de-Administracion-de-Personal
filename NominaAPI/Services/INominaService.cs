using NominaAPI.Models;
using NominaAPI.DTOs;

namespace NominaAPI.Services;

public interface INominaService
{
    NominaDTO CalcularNomina(Empleado empleado);
}