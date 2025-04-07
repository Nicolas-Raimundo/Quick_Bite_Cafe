USE FastFoodDB;

--SE SUMAN NUEVOS VALORES ALEATORIOS A LA TABLA ORDENES Y A LA TABLA PRODUCTOS.

INSERT INTO Ordenes 
(ClienteID, EmpleadoID, SucursalID, MensajeroID, TipoPagoID, OrigenID, 
HorarioVenta, TotalCompra, KilometrosRecorrer, FechaDespacho, FechaEntrega, 
FechaOrdenTomada, FechaOrdenLista) 
VALUES
(8, 8, 8, 8, 8, 1, 'Mañana', 1120.00, 5.0, '2023-11-01 08:30:00', '2023-11-01 09:00:00', '2023-11-01 08:00:00', '2023-11-01 08:15:00'),
(9, 9, 9, 9, 9, 2, 'Tarde', 1150.00, 8.0, '2023-11-15 14:30:00', '2023-11-15 15:00:00', '2023-11-15 13:30:00', '2023-11-15 14:00:00'),
(3, 3, 3, 3, 3, 3, 'Noche', 1080.00, 6.5, '2023-12-05 19:30:00', '2023-12-05 20:00:00', '2023-12-05 19:00:00', '2023-12-05 19:15:00'),
(3, 3, 3, 3, 3, 3, 'Mañana', 1230.00, 4.5, '2023-11-05 08:30:00', '2023-11-05 09:00:00', '2023-11-05 08:00:00', '2023-11-05 08:15:00'),
(4, 4, 4, 4, 4, 4, 'Tarde', 1105.00, 7.0, '2023-11-10 14:30:00', '2023-11-10 15:00:00', '2023-11-10 13:30:00', '2023-11-10 14:00:00'),
(5, 5, 5, 5, 5, 5, 'Noche', 1170.00, 6.0, '2023-11-20 19:30:00', '2023-11-20 20:00:00', '2023-11-20 19:00:00', '2023-11-20 19:15:00'),
(3, 3, 3, 3, 3, 3, 'Mañana', 1225.00, 5.0, '2023-12-01 08:30:00', '2023-12-01 09:00:00', '2023-12-01 08:00:00', '2023-12-01 08:15:00'),
(4, 4, 4, 4, 4, 4, 'Tarde', 1155.00, 8.0, '2023-12-10 14:30:00', '2023-12-10 15:00:00', '2023-12-10 13:30:00', '2023-12-10 14:00:00')
;

INSERT INTO Productos (Nombre, CategoriaID, Precio) 
VALUES
('Tacos al Pastor', 5, 8.49),
('Sushi Rolls', 6, 14.99),
('Mochi de Té Verde', 6, 3.49),
('Croissant de Mantequilla', 8, 2.49),
('Baguette Integral', 8, 1.99),
('Café Americano', 9, 2.49),
('Café Latte', 9, 3.49),
('Frappuccino de Fresa', 9, 4.49),
('Limonada Casera', 5, 2.79),
('Wrap de Pollo', 4, 7.49)
;

SELECT * FROM Productos;

-- SE REALIZAN NUEVAMENTE LAS CONSULTAS DEL AVANCE 5

SELECT 
    AVG(DATEDIFF(MINUTE,FechaDespacho,FechaEntrega)) AS TiempoPromedioDespacho
FROM Ordenes;


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


SELECT 
    E.Nombre AS NOMBRE,
    O.EmpleadoID AS ID,
    SUM(O.TotalCompra) AS IngresoGenerado
FROM Ordenes O
JOIN Empleados E
ON E.EmpleadoID = O.EmpleadoID
GROUP BY E.Nombre,O.EmpleadoID
ORDER BY IngresoGenerado DESC
;
SELECT 
    D.OrdenID AS OrdenNumero,
    O.HorarioVenta AS Horario,
    D.Cantidad AS Cantidad
FROM DetalleOrdenes D
JOIN Ordenes O
ON O.OrdenID = D.OrdenID;

SELECT 
    MONTH(FechaOrdenLista) AS Mes,
    AVG(ROUND(TotalCompra,2)) AS Ingreso 
    FROM Ordenes
    GROUP BY MONTH(FechaOrdenLista)
;

SELECT
    COUNT(O.OrdenID) AS CantidadOrdenes,
    MONTH(FechaOrdenLista) AS Mes,
    O.ClienteID AS IDCliente,
    C.Nombre AS NombreCliente 
FROM Ordenes O
JOIN Clientes C
ON O.ClienteID = C.ClienteID
GROUP BY O.ClienteID,Nombre,MONTH(FechaOrdenLista)
ORDER BY CantidadOrdenes DESC
;

--SE CREAN ÍNDICES EN LA TABLA ORDENES, YA QUE ES LA MAS UTILIZADA EN LAS CONSULTAS.
CREATE INDEX idx_clienteid_ordenes ON Ordenes(ClienteID);
CREATE INDEX idx_empleadoid_ordenes ON Ordenes(EmpleadoID);
CREATE INDEX idx_sucursalid_ordenes ON Ordenes(SucursalID);
CREATE INDEX idx_mensajeroid_ordenes ON Ordenes(MensajeroID);
CREATE INDEX idx_tipopagoid_ordenes ON Ordenes(TipoPagoID);
CREATE INDEX idx_origenid_ordenes ON Ordenes(OrigenID);