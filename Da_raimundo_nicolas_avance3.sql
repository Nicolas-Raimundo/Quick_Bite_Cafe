USE FastfoodDB
;
--1)Total de ventas a nivel global
SELECT
    SUM(TotalCompra) AS VentasTotales
FROM [dbo].[Ordenes]
;

--2)Promedio de precio de los productos de acuerdo a la categoría


SELECT
    CategoriaID,
    CAST(AVG(Precio) AS DECIMAL(10,2)) AS PrecioPromedio
FROM [dbo].[Productos]
GROUP BY CategoriaID
ORDER BY PrecioPromedio DESC
;


--3)Orden mínima y máxima por cada sucursal

SELECT

    TOP 1 MIN(TotalCompra) AS VentaMinima,
    SucursalID
FROM [dbo].[Ordenes]
GROUP BY SucursalID
ORDER BY VentaMinima
;

SELECT

    TOP 1 MAX(TotalCompra) AS VentaMaxima,
    SucursalID
FROM [dbo].[Ordenes]
GROUP BY SucursalID
ORDER BY VentaMaxima DESC
;

--4) Mayor numero de km recorridos para una entrega

SELECT
    TOP 1 KilometrosRecorrer AS KilometrosRecorridos,
    OrdenID
FROM [dbo].[Ordenes]
ORDER BY KilometrosRecorridos DESC
;

--5) Cantidad promedio de productos por orden

SELECT
    AVG(Cantidad) AS CantidadPromedio
FROM [dbo].[DetalleOrdenes]
;

--6)Distribucion por método de pago

SELECT 
    COUNT(O.TotalCompra) AS TotalCompras,
    T.Descripcion AS Metodo
FROM [dbo].[Ordenes] O
JOIN [dbo].[TiposPago] T
ON O.TipoPagoID = T.TipoPagoID
GROUP BY T.Descripcion
;

--7)Sucursal con ingreso promedio más alto
SELECT
    TOP 1 CAST(AVG(O.TotalCompra)  AS DECIMAL (10,2)) AS Total_Compra,
    S.Nombre AS NombreSucursal
FROM [dbo].[Ordenes] O
JOIN [dbo].[Sucursales] S
ON O.SucursalID = S.SucursalID
GROUP BY S.Nombre
ORDER BY Total_Compra DESC
;
--8)Sucursales con ventas por encima de los $1000

SELECT
    SUM(O.TotalCompra) AS TotalVenta,
    S.Nombre AS NombreSucursal
FROM [dbo].[Ordenes] O
JOIN [dbo].[Sucursales] S
ON O.SucursalID = S.SucursalID
GROUP BY S.Nombre
HAVING SUM(O.TotalCompra) > 1000
;


--9)Ventas promedio antes y después de 2023-01-07
SELECT
    OrdenID,
    TotalCompra,
    CONVERT (DATE,FechaOrdenTomada) AS Fecha
FROM [dbo].[Ordenes]
WHERE FechaOrdenTomada < >'2023-07-01'
;

--10)Horario del día en el cual hay mayor cantidad de ventas, ingreso promedio e ingreso maximo

SELECT
    TOP 1 COUNT(HorarioVenta) AS CantidadVentas,
    HorarioVenta,
    CAST(AVG(TotalCompra) AS DECIMAL(10,2)) AS VentaPromedio,
    MAX(TotalCompra) AS MaximaVenta
FROM [dbo].[Ordenes]
GROUP BY HorarioVenta
ORDER BY CantidadVentas DESC
;
