USE FastFoodDB;
--¿Cómo puedo obtener una lista de todos los productos junto con sus categorías?
SELECT 
        P.Nombre AS NombreProducto,
        C.Nombre AS NombreCategoria
FROM [dbo].[Productos] P
INNER JOIN [dbo].[Categorias] C
ON C.CategoriaID = P.CategoriaID
;
--¿Cómo puedo saber a qué sucursal está asignado cada empleado?
SELECT 
    E.Nombre AS NombreEmpleado,
    E.Posicion AS Posicion,
    E.Departamento AS NombreDepartamento,
    S.Nombre AS NombreSucursal
FROM [dbo].[Empleados] E
INNER JOIN [dbo].[Sucursales] S
ON E.SucursalID = S.SucursalID
;
--¿Existen productos que no tienen una categoría asignada?
--RTA: Todos los productos listados tienen una categoría asignada
SELECT 
        P.Nombre,
        C.Nombre
FROM [dbo].[Productos] P
FULL JOIN [dbo].[Categorias] C
ON P.CategoriaID = C.CategoriaID
;

--¿Cómo puedo obtener un detalle completo de las órdenes, incluyendo el Nombre del cliente, 
--Nombre del empleado que tomó la orden, y Nombre del mensajero que la entregó?

SELECT
    O.OrdenID AS OrdenID,
    O.TotalCompra AS TotalCompra,
    O.FechaOrdenTomada AS FechaOrden,
    O.HorarioVenta AS Horario,
    C.Nombre AS NombreCliente,
    E. Nombre AS NombreEmpleado,
    E. Posicion AS PosicionEmpleado,
    M.Nombre AS NombreMensajero
FROM [dbo].[Ordenes] O
INNER JOIN Clientes C ON O.ClienteID = C.ClienteID
INNER JOIN Empleados E ON O.EmpleadoID = E.EmpleadoID
INNER JOIN Mensajero M ON O.MensajeroID = M.MensajeroID
;

--¿Cuántos artículos correspondientes a cada Categoría de Productos se han vendido en cada sucursal?
SELECT
    C.Nombre AS NombreCategoria,
    S.Nombre AS NombreSucursal,
    SUM(D.Cantidad) AS CantidadArticulos
FROM [dbo].[Ordenes] O
INNER JOIN [dbo].[DetalleOrdenes] D ON O.OrdenID = D.OrdenID
INNER JOIN [dbo].[Productos] P ON P.ProductoID = D.ProductoID
INNER JOIN [dbo].[Categorias] C ON P.CategoriaID = C.CategoriaID
INNER JOIN [dbo].[Sucursales] S ON O.SucursalID = S.SucursalID
GROUP BY C.Nombre, S.Nombre
ORDER BY NombreCategoria, NombreSucursal
;


