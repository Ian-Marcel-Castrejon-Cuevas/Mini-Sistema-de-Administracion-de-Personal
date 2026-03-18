const API = "http://localhost:5109/api/empleados";

function formatoMoneda(valor) {
  return `$${parseFloat(valor).toLocaleString("en-US", {
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  })}`;
}

async function cargarEmpleados() {
  try {
    const res = await fetch(API);
    const data = await res.json();

    const tabla = document.getElementById("tablaEmpleados");
    tabla.innerHTML = "";

    data.forEach((emp) => {
      tabla.innerHTML += `
                <tr>
                    <td><span class="badge bg-secondary">${emp.numeroEmpleado}</span></td>
                    <td class="fw-semibold">${emp.nombre}</td>
                    <td>
                        <span class="badge text-dark">
                            Departamento ${emp.departamentoId}
                        </span>
                    </td>
                    <td class="text-success fw-bold">
                        ${formatoMoneda(emp.salarioMensual)}
                    </td>
                    <td>
                        <button class="btn btn-primary btn-sm rounded-pill px-3"
                            onclick="verNomina(${emp.id})">
                            Ver Nómina
                        </button>
                    </td>
                </tr>
            `;
    });
  } catch (error) {
    console.error("Error cargando empleados:", error);
  }
}

async function verNomina(id) {
  try {
    const res = await fetch(`${API}/${id}/nomina`);
    const data = await res.json();

    document.getElementById("contenidoNomina").innerHTML = `
            <div class="text-center mb-3">
                <h5 class="fw-bold">${data.nombre}</h5>
                <span class="badge bg-secondary">${data.numeroEmpleado}</span>
            </div>

            <div class="list-group">

                <div class="list-group-item d-flex justify-content-between">
                    <span>💰 Salario Quincenal</span>
                    <strong>${formatoMoneda(data.salarioQuincenal)}</strong>
                </div>

                <div class="list-group-item d-flex justify-content-between">
                    <span>🏥 IMSS</span>
                    <strong class="text-danger">
                        - ${formatoMoneda(data.deduccionIMSS)}
                    </strong>
                </div>

                <div class="list-group-item d-flex justify-content-between">
                    <span>📊 ISR</span>
                    <strong class="text-danger">
                        - ${formatoMoneda(data.deduccionISR)}
                    </strong>
                </div>

                <div class="list-group-item d-flex justify-content-between bg-light">
                    <span class="fw-bold">💵 Neto</span>
                    <strong class="text-success fs-5">
                        ${formatoMoneda(data.salarioNeto)}
                    </strong>
                </div>

            </div>
        `;

    const modal = new bootstrap.Modal(document.getElementById("modalNomina"));
    modal.show();
  } catch (error) {
    console.error("Error obteniendo nómina:", error);
  }
}

cargarEmpleados();
