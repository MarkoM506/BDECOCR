
Create table Usuarios(
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    foto_perfil VARCHAR(255),
    id_canton INT,
    id_distrito INT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    rol ENUM('usuario') DEFAULT 'usuario'
);

-- =====================================
--           TABLAS DE UBICACIÓN
-- =====================================

CREATE TABLE Cantones (
    id_canton INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Distritos (
    id_distrito INT AUTO_INCREMENT PRIMARY KEY,
    id_canton INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_canton) REFERENCES Cantones(id_canton)
);


-- =====================================
--           TABLAS DE CAMIONES
-- =====================================


CREATE TABLE Camiones (
    id_camion INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(20),
    descripcion VARCHAR(200)
);

-- Esta es para recoger la ubicacion en tiempo real del camión
CREATE TABLE Camion_Ubicacion_Actual (
    id_camion INT PRIMARY KEY,
    latitud DECIMAL(10,7),   
    longitud DECIMAL(10,7),
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
                               ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion)
); 

-- Historial de posciciones del Camion

CREATE TABLE Camion_Historial_Posiciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_camion INT NOT NULL,
    latitud DECIMAL(10,7),
    longitud DECIMAL(10,7),
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_camion) REFERENCES Camiones(id_camion)
);


          





