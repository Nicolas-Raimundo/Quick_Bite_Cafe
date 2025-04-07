USE master;
/*Primer Paso: Creacion de una base de Datos. 
Realizado con una MACOS en Azure Data Studio(SQL SERVER)*/

CREATE DATABASE FastFoodDB
ON
( NAME = 'FastFoodDB',
  FILENAME = '/Users/nicolasraimundo/Applications/SQL_DB/FastfoodDB.mdf',
  SIZE = 50MB,
  MAXSIZE = 1GB,
  FILEGROWTH = 5MB )
LOG ON
( NAME = 'FastFood_Log',
  FILENAME = '/Users/nicolasraimundo/Applications/SQL_DB/FastfoodDB.ldf',
  SIZE = 25MB,
  MAXSIZE = 256MB,
  FILEGROWTH = 5MB );


--Segundo Paso: Creacion de Tablas
USE FastFoodDB;
CREATE TABLE Categorias
( 
    CategoriaID INT PRIMARY KEY IDENTITY (1,1),
    Nombre VARCHAR(100) NOT NULL

);
CREATE TABLE Productos
(
    ProductoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    CategoriaID INT,
    Precio DECIMAL (10,2) NOT NULL
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID)  
);

CREATE TABLE Sucursales
(
    SucursalID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(100) NOT NULL
)
;    
CREATE TABLE Empleados
(
    EmpleadoID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Posicion VARCHAR(100),
    Departamento VARCHAR(100),
    SucursalID INT,
    Rol VARCHAR(50) NOT NULL,
    FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID)
)
;
CREATE TABLE Clientes
(
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nombre VARCHAR(100) NOT NULL,
    Direccion VARCHAR(100)
)
;

CREATE TABLE OrigenOrden
(
    OrigenID INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(250)NOT NULL
)
;

CREATE TABLE TiposPago
(
    TipoPagoID INT PRIMARY KEY IDENTITY(1,1),
    Descripcion VARCHAR(100) NOT NULL
)
;

CREATE TABLE Mensajero 
(
    MensajeroID INT PRIMARY KEY IDENTITY (1,1),
    Nombre VARCHAR(100) NOT NULL,
    EsExterno BIT NOT NULL
)
;
CREATE TABLE Ordenes
(
    OrdenID INT PRIMARY KEY IDENTITY,
    ClienteID INT,
    EmpleadoID INT,
    SucursalID INT,
    MensajeroID INT,
    TipoPagoID INT,
    OrigenID INT,
    HorarioVenta VARCHAR(100) NOT NULL,
    TotalCompra DECIMAL(10,2) NOT NULL,
    KilometrosRecorrer DECIMAL (10,2),
    FechaDespacho DATETIME,
    FechaEntrega DATETIME,
    FechaOrdenTomada DATETIME,
    FechaOrdenLista DATETIME
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteId),
    FOREIGN KEY (EmpleadoID) REFERENCES Empleados(EmpleadoID),
    FOREIGN KEY (SucursalID) REFERENCES Sucursales(SucursalID),
    FOREIGN KEY (MensajeroID) REFERENCES Mensajero(MensajeroID),
    FOREIGN KEY (TipoPagoID) REFERENCES TiposPago(TipoPagoID),
    FOREIGN KEY (OrigenID) REFERENCES OrigenOrden(OrigenID)
)
;

CREATE TABLE DetalleOrdenes
(
    OrdenID INT,
    ProductoID INT,
    Cantidad INT,
    Precio DECIMAL(10,2),
    PRIMARY KEY (OrdenID,ProductoID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID),
    FOREIGN KEY (OrdenID) REFERENCES Ordenes(OrdenID)
)
;