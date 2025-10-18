-- Tabla Usuario
CREATE TABLE Usuario (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    tipo_usuario VARCHAR(30),
    condicion_especial VARCHAR(100),
    ciudad_id INT,
    codigo_postal VARCHAR(10)
);

-- Tabla Ciudad
CREATE TABLE Ciudad (
    ciudad_id SERIAL PRIMARY KEY,
    nombre_ciudad VARCHAR(50),
    codigo_postal VARCHAR(10)
);

-- Tabla Servicio
CREATE TABLE Servicio (
    servicio_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50),
    descripcion TEXT,
    estado VARCHAR(20)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    empleado_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES Usuario(usuario_id),
    cargo VARCHAR(50),
    departamento VARCHAR(50)
);

-- Tabla Turno
CREATE TABLE Turno (
    turno_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES Usuario(usuario_id),
    servicio_id INT REFERENCES Servicio(servicio_id),
    empleado_id INT REFERENCES Empleado(empleado_id),
    fecha DATE,
    hora_inicio TIME,
    hora_fin TIME,
    estado VARCHAR(20)
);

-- Tabla Notificacion
CREATE TABLE Notificacion (
    notificacion_id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES Usuario(usuario_id),
    medio VARCHAR(30),
    mensaje TEXT,
    fecha_envio TIMESTAMP,
    estado VARCHAR(20)
);

