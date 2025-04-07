USE FastFoodDB;

--¿Cuál es el tiempo promedio desde el despacho hasta la entrega?(Minutos)

SELECT 
    AVG(DATEDIFF(MINUTE,FechaDespacho,FechaEntrega)) AS TiempoPromedioDespacho
FROM Ordenes;

--¿Qué canal de ventas genera más ingresos?

SELECT TOP 1
    MAX(O.TotalCompra) AS MayorVenta,
    T.Descripcion AS MedioDePago,
    O.TipoPagoID AS IDPago
FROM Ordenes O
JOIN TiposPago T
ON T.TipoPagoID = O.TipoPagoID
GROUP BY O.TipoPagoID, T.Descripcion
ORDER BY MayorVenta DESC
;

--¿Cuál es el nivel de ingreso generado por Empleado?

SELECT 
    E.Nombre AS NOMBRE,
    O.EmpleadoID AS ID,
    O.TotalCompra AS IngresoGenerado
FROM Ordenes O
JOIN Empleados E
ON E.EmpleadoID = O.EmpleadoID
ORDER BY IngresoGenerado DESC
;

--¿Cómo varía la demanda de productos a lo largo del día?

SELECT 
    D.OrdenID AS OrdenNumero,
    O.HorarioVenta AS Horario,
    D.Cantidad AS Cantidad
FROM DetalleOrdenes D
JOIN Ordenes O
ON O.OrdenID = D.OrdenID

--COMO EN DETALLE DE ORDEN SOLO SE ESPECIFICO ORDENID = 1 , TODO SE DA EN EL HORARIO 'MAÑANA'

;
--¿Cuál es la tendencia de los ingresos generados en cada periodo mensual?

SELECT 
    MONTH(FechaOrdenLista) AS Mes,
    OrdenID,
    AVG(ROUND(TotalCompra,2)) AS Ingreso 
    FROM Ordenes
    GROUP BY OrdenID,FechaOrdenLista
;
--¿Qué porcentaje de clientes son recurrentes versus nuevos clientes cada mes?

SELECT
    COUNT(O.OrdenID) AS CantidadOrdenes,
    MONTH(FechaOrdenLista) AS Mes,
    O.ClienteID AS IDCliente,
    C.Nombre AS NombreCliente 
FROM Ordenes O
JOIN Clientes C
ON O.ClienteID = C.ClienteID
GROUP BY O.ClienteID,Nombre,FechaOrdenLista
ORDER BY CantidadOrdenes DESC
;