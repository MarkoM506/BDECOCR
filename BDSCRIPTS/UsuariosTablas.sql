
--Tablas de la base de datos parte de usuarios


-- =====================================
--           TABLA: USUARIOS
-- =====================================
CREATE TABLE Usuarios( 
    id_usuario INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    foto_perfil VARCHAR(255),
    id_canton INT,
    id_distrito INT,
    fecha_registro DATETIME DEFAULT GETDATE(),
    rol VARCHAR(20) NOT NULL DEFAULT 'usuario'
        CHECK (rol IN ('usuario'))
);


-- =====================================
--           TABLAS DE UBICACIÓN
-- =====================================

CREATE TABLE Cantones (
    id_canton INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Distritos (
    id_distrito INT IDENTITY(1,1) PRIMARY KEY,
    id_canton INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_canton) REFERENCES Cantones(id_canton)
);

-- =====================================
--           TABLAS DE CAMIONES
-- =====================================

CREATE TABLE Camiones (
    id_camion INT IDENTITY(1,1) PRIMARY KEY,
    placa VARCHAR(20),
    descripcion VARCHAR(200)
);

-- Esta es para recoger la ubicacion en tiempo real del camión
CREATE TABLE Camion_Ubicacion_Actual (
    id_camion INT PRIMARY KEY,
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7),
    ultima_actualizacion DATETIME DEFAULT GETDATE(),  -- Hay que acualizarlo desde la Api
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion)
);

-- Historial de posciciones del Camion

CREATE TABLE Camion_Historial_Posiciones (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_camion INT NOT NULL,
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7),
    fecha_hora DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion)
);

-- =====================================
--           TABLAS DE RUTAS
-- =====================================
CREATE TABLE Rutas (
    id_ruta INT IDENTITY(1,1) PRIMARY KEY,
    id_canton INT,
    id_distrito INT,
    hora_recoleccion TIME,
    descripcion VARCHAR(200),
    FOREIGN KEY (id_canton) REFERENCES Cantones(id_canton),
    FOREIGN KEY (id_distrito) REFERENCES Distritos(id_distrito)
);

-- RUTA EN TIEMPO REAL (Recoge las cordenadas)
CREATE TABLE Ruta_Coordenadas (
    id_punto INT IDENTITY(1,1) PRIMARY KEY,
    id_ruta INT NOT NULL,
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7),
    orden_punto INT,
    FOREIGN KEY (id_ruta) REFERENCES Rutas(id_ruta)
);


-- =====================================
--           TABLAS DE SCANEO
-- =====================================

CREATE TABLE Productos (
    id_producto INT IDENTITY(1,1) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    tipo VARCHAR(20) NOT NULL
        CHECK (tipo IN ('reciclable','organico','no_reciclable')),
    material VARCHAR(100),
    descripcion VARCHAR(MAX),
    imagen_url VARCHAR(255),
    anos_descomponerse INT
);

-- REGISTRO DE SCANEO DE USUARIO
CREATE TABLE Escaneos (
    id_escaneo INT IDENTITY(1,1) PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_producto INT NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    puntos_obtenidos INT DEFAULT 0,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_producto) REFERENCES Productos(id_producto)
);

-- Misiones 
CREATE TABLE Misiones (
    id_mision INT IDENTITY(1,1) PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    descripcion VARCHAR(MAX) NOT NULL,
    puntos INT NOT NULL,
    tipo VARCHAR(20) NOT NULL
        CHECK (tipo IN ('escaneo','rutas','compartir','ecovoluntariado')),
    estado VARCHAR(20) NOT NULL DEFAULT 'activa'
        CHECK (estado IN ('activa','inactiva'))
);
--progreso del usuario y misiones

CREATE TABLE Usuario_Mision (
    id_usuario INT NOT NULL,
    id_mision INT NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'pendiente'
        CHECK (estado IN ('pendiente','completada')),
    fecha_completada DATETIME NULL,
    PRIMARY KEY (id_usuario, id_mision),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_mision) REFERENCES Misiones(id_mision)
);

--puntos y nivel de usuario
CREATE TABLE Usuario_Puntos (
    id_usuario INT PRIMARY KEY,
    puntos_totales INT DEFAULT 0,
    nivel_actual INT DEFAULT 1,
    fecha_ultima_actualizacion DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);


          





