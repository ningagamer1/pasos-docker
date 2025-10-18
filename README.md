# pasos-docker
1.crear una red compartida
docker network create servilimar-net
verificar que si se creo la red
docker network ls

2. comando levantar Docker contendor
docker run --name servilimar-db --network servilimar-net -e POSTGRES_USER=ulimar -e POSTGRES_PASSWORD=ex4men_db -p 5432:5432 -d postgres:14
(opconal) si deseas verificar si quedo funcional 
docker ps

3. comando para levantar el pgamdin v4
docker run --name servilimar-pgadmin --network servilimar-net -e PGADMIN_DEFAULT_EMAIL=usuario@servilimar.com -e PGADMIN_DEFAULT_PASSWORD=limar#123 -p 5050:80 -d dpage/pgadmin4
(opcional) si deseas verificar si quedo funcional 
docker ps


4. Abre tu navegador web.

Ingresa a tu local host con tu puerto que idicaste http://localhost:5050

Inicia sesión con:

Email: usuario@servilimar.com

Contraseña: limar#123

5. Dentro de pgAdmin:

En el panel izquierdo, clic derecho en Servers → Register → Server...

En la pestaña General, pon:

Name: servilimar-db

En la pestaña Connection, pon:

Host name / address: servilimar-db

Port: 5432

Username: ulimar

Password: ex4men_db

Marca la casilla Save password

Clic en Save (guardar)


6. Crear la base de datos servilimar

En pgAdmin:

Abre el servidor.

Clic derecho en Databases → Create → Database...

Nombre: servilimar

Clic en Save (guardar)

7. según tu enunciado crea tus tablas las cuales usaremos para hacer el código ddl y dml

en mi caso usaremos este contexto
Servicios  LiMar  requiere  un  sistema  de  generación  de  turnos  para  sus  clientes  debido  a  la  alta  demanda  de sus  usuarios.  El  sistema  debe  organizar  y  administrar  la  asignación  de  personas  a  los  servicios  ofrecidos por  la  entidad.  En  este  sistema  los  empleados,  clientes,  proveedores  y  todos  los  que  requieran  un  servicio deben  registrarse.  Durante  el  registro  se  debe  indicar  si  tiene  una  condición  especial  (embarazo,  requiere silla  de  ruedas,  adulto  mayor,  entre  otras).  Después  de  notificarle  su  ingreso  al  sistema  a  través  de  todos sus  medios  de  contacto,  el  usuario  podrá  obtener  un  turno  (correo,  teléfono,  sms,  etc).  Para  la  asignación  de turnos,  los  usuarios  deberán  seleccionar/elegir  el  servicio  que  requieren  del  listado  predefinido  en  el sistema,  entre  los  que  se  encuentran  despacho,  entrega  y/o  recepción  artículos,  atención  al  cliente, consultoría  y  muchos  más.  Cada  turno  tiene  una  fecha,  hora_inicio,  hora_fin,  estado  y  el  encargado  que atenderá el turno. 

En el árbol del lado izquierdo, haz clic en:
Servers → servilimar-db → Databases → servilimar
Luego, en la parte superior, haz clic en el ícono de SQL o en el menú:
Abre el Query Tool y ejecuta:
Tools → Query Tool


[ código ddl ]

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



Luego presiona F5 o haz clic en el botón  (Execute) para ejecutar las sentencias.

Si todo sale bien, verás el mensaje:

Query returned successfully


[ código dml]

-- =============================================
--   DML Base de Datos: Sistema de Turnos LiMar
-- =============================================

-- 1️Insertar datos en Ciudad
INSERT INTO Ciudad (nombre_ciudad, codigo_postal)
VALUES 
('Cali', '760001'),
('Bogotá', '110111'),
('Medellín', '050021'),
('Palmira', '763531'),
('Popayán', '190001'),
('Buga', '763041'),
('Tuluá', '763022'),
('Cartago', '762021'),
('Manizales', '170001'),
('Pereira', '660001');

--  Insertar datos en Usuario
INSERT INTO Usuario (nombre, apellido, tipo_usuario, condicion_especial, ciudad_id, codigo_postal)
VALUES 
('Ana', 'Lopez', 'Cliente', 'Embarazo', 1, '760001'),
('Carlos', 'Mora', 'Empleado', NULL, 2, '110111'),
('Sofia', 'Perez', 'Cliente', 'Adulto mayor', 3, '050021'),
('David', 'Torres', 'Proveedor', NULL, 4, '763531'),
('Julian', 'Rojas', 'Cliente', 'Silla de ruedas', 5, '190001'),
('Maria', 'Gomez', 'Empleado', NULL, 6, '763041'),
('Andres', 'Ruiz', 'Cliente', NULL, 7, '763022'),
('Luisa', 'Fernandez', 'Empleado', NULL, 8, '762021'),
('Mateo', 'Diaz', 'Cliente', NULL, 9, '170001'),
('Laura', 'Restrepo', 'Cliente', NULL, 10, '660001');

-- Insertar datos en Servicio
INSERT INTO Servicio (nombre, descripcion, estado)
VALUES 
('Atención al cliente', 'Soporte presencial en oficinas', 'Activo'),
('Consultoría', 'Asesorías especializadas para clientes', 'Activo'),
('Despacho', 'Gestión y envío de productos', 'Activo'),
('Recepción de artículos', 'Control de ingreso de mercancía', 'Activo'),
('Entrega', 'Entrega de pedidos a domicilio', 'Activo'),
('Capacitación', 'Formación para nuevos empleados', 'Activo'),
('Reparaciones', 'Mantenimiento y soporte técnico', 'Activo'),
('Logística', 'Gestión de transporte y rutas', 'Activo'),
('Teleasistencia', 'Atención remota al cliente', 'Activo'),
('Control de calidad', 'Supervisión de procesos internos', 'Activo');

--  Insertar datos en Empleado
INSERT INTO Empleado (usuario_id, cargo, departamento)
VALUES
(2, 'Asesor', 'Atención al cliente'),
(6, 'Técnico', 'Soporte'),
(8, 'Supervisor', 'Logística'),
(2, 'Consultor', 'Consultoría'),
(6, 'Capacitador', 'Formación'),
(8, 'Operador', 'Recepción'),
(2, 'Encargado', 'Despacho'),
(6, 'Reparador', 'Taller'),
(8, 'Verificador', 'Calidad'),
(2, 'Analista', 'Consultoría');

-- Insertar datos en Turno
INSERT INTO Turno (usuario_id, servicio_id, empleado_id, fecha, hora_inicio, hora_fin, estado)
VALUES 
(1, 1, 1, '2025-10-16', '08:00', '08:30', 'Activo'),
(3, 2, 4, '2025-10-16', '09:00', '09:30', 'Activo'),
(5, 3, 7, '2025-10-16', '10:00', '10:30', 'Activo'),
(7, 4, 6, '2025-10-16', '11:00', '11:30', 'Activo'),
(9, 5, 10, '2025-10-16', '12:00', '12:30', 'Activo'),
(1, 6, 5, '2025-10-16', '13:00', '13:30', 'Activo'),
(3, 7, 8, '2025-10-16', '14:00', '14:30', 'Activo'),
(5, 8, 3, '2025-10-16', '15:00', '15:30', 'Activo'),
(7, 9, 9, '2025-10-16', '16:00', '16:30', 'Activo'),
(9, 10, 2, '2025-10-16', '17:00', '17:30', 'Activo');

-- Insertar datos en Notificacion
INSERT INTO Notificacion (usuario_id, medio, mensaje, fecha_envio, estado)
VALUES 
(1, 'Correo', 'Su turno fue creado exitosamente.', NOW(), 'Enviado'),
(3, 'SMS', 'Recordatorio de su cita para hoy.', NOW(), 'Enviado'),
(5, 'Correo', 'Su pedido está en camino.', NOW(), 'Enviado'),
(7, 'Notificación App', 'Su turno fue reagendado.', NOW(), 'Pendiente'),
(9, 'Correo', 'Encuesta de satisfacción disponible.', NOW(), 'Enviado'),
(1, 'SMS', 'Confirmación de servicio recibido.', NOW(), 'Enviado'),
(3, 'Correo', 'Gracias por usar LiMar.', NOW(), 'Enviado'),
(5, 'App', 'Notificación de nuevo servicio.', NOW(), 'Pendiente'),
(7, 'Correo', 'Actualización de horario.', NOW(), 'Enviado'),
(9, 'SMS', 'Recordatorio de visita técnica.', NOW(), 'Enviado');


Luego presiona F5 o haz clic en el botón  (Execute) para ejecutar las sentencias.

Si todo sale bien, verás el mensaje:

Query returned successfully

Para ver el contenido de una tabla:

Databases → servilimar → Schemas → public → Tables

De manera manual puedes usar estos pasos:

Haz clic derecho sobre la tabla (por ejemplo cliente)

Selecciona View/Edit Data → All Rows

Se abrirá una pestaña abajo con todos los registros que insertaste 


comando que podría necesitar
| Acción                          | Comando                     |
| ------------------------------- | --------------------------- |
| Ver contenedores activos        | `docker ps`                 |
| Ver todos (incluidos detenidos) | `docker ps -a`              |
| Detener un contenedor           | `docker stop servilimar-db` |
| Eliminar un contenedor          | `docker rm servilimar-db`   |
| Ver redes                       | `docker network ls`         |
| Eliminar redes no usadas        | `docker network prune`      |


vamos a cerrar el contenedor 

primero detenemos el contenedor ya que solo se puede remover cuando el contenedor no esta en uso
