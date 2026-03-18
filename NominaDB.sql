/* 1.1 CREACION DE TABLAS */

CREATE TABLE Departamentos (
    Id SERIAL PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Activo BOOLEAN NOT NULL
);

CREATE TABLE Empleados (
    Id SERIAL PRIMARY KEY,
    NumeroEmpleado VARCHAR(10) UNIQUE NOT NULL,
    Nombre VARCHAR(100) NOT NULL,
    FechaIngreso DATE NOT NULL,
    SalarioMensual NUMERIC(12,2) NOT NULL,
    DepartamentoId INT NOT NULL,
    Activo BOOLEAN NOT NULL,
    CONSTRAINT fk_departamento
        FOREIGN KEY (DepartamentoId)
        REFERENCES Departamentos(Id)
);

/* 1.2 INSERCION DE DATOS */

INSERT INTO Departamentos (Nombre, Activo)
VALUES 
('Sistemas', TRUE),
('Recursos Humanos', TRUE);

SELECT * FROM Departamentos
ORDER BY id ASC;

INSERT INTO Empleados 
(NumeroEmpleado, Nombre, FechaIngreso, SalarioMensual, DepartamentoId, Activo)
VALUES
('EMP-0001', 'Camila Hernández', '2022-01-10', 10000, 1, TRUE),
('EMP-0002', 'Miguel Ángel', '2021-06-15', 20000, 2, TRUE),
('EMP-0003', 'Valeria Ramos', '2023-03-01', 40000, 1, TRUE);

SELECT * FROM Empleados
ORDER BY id ASC;

/* 1.3 CONSULTAS */

/* Consulta A */

SELECT 
    e.numeroempleado,
    e.nombre,
    d.nombre AS nombreD,
    e.salariomensual,
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.fechaingreso)) * 12 +
    EXTRACT(MONTH FROM AGE(CURRENT_DATE, e.fechaingreso)) 
    AS antiguedadmeses
FROM empleados e
JOIN departamentos d ON e.departamentoid = d.id
WHERE e.activo = TRUE
ORDER BY antiguedadmeses DESC;


/* Consulta B */

SELECT 
    e.numeroempleado,
    e.nombre,
    e.salariomensual,
    ROUND((e.salariomensual / 2), 2) AS salarioquincenal,
    ROUND((e.salariomensual / 2) * 0.03, 2) AS imss,
    ROUND(
        CASE 
            WHEN (e.salariomensual / 2) <= 7500 THEN (e.salariomensual / 2) * 0.09
            WHEN (e.salariomensual / 2) <= 15000 THEN (e.salariomensual / 2) * 0.16
            ELSE (e.salariomensual / 2) * 0.25
        END, 2
    ) AS isr,
    ROUND(
        (e.salariomensual / 2)
        - ((e.salariomensual / 2) * 0.03)
        - CASE 
            WHEN (e.salariomensual / 2) <= 7500 THEN (e.salariomensual / 2) * 0.09
            WHEN (e.salariomensual / 2) <= 15000 THEN (e.salariomensual / 2) * 0.16
            ELSE (e.salariomensual / 2) * 0.25
        END
    , 2) AS salarioneto
FROM empleados e
WHERE e.activo = TRUE;

/* Consulta C */

SELECT 
    d.nombre AS departamento,
    ROUND(SUM(
        (e.salariomensual / 2)
        - ((e.salariomensual / 2) * 0.03)
        - CASE 
            WHEN (e.salariomensual / 2) <= 7500 THEN (e.salariomensual / 2) * 0.09
            WHEN (e.salariomensual / 2) <= 15000 THEN (e.salariomensual / 2) * 0.16
            ELSE (e.salariomensual / 2) * 0.25
          END
    ), 2) AS totalnomina
FROM empleados e
JOIN departamentos d ON e.departamentoid = d.id
WHERE e.activo = TRUE
GROUP BY d.nombre
ORDER BY d.nombre;

