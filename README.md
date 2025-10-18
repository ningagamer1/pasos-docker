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

CREATE TABLE cliente (
  id_cliente SERIAL PRIMARY KEY,
  nombre VARCHAR(100),
  cedula VARCHAR(20),
  telefono VARCHAR(20)
);

CREATE TABLE turno (
  id_turno SERIAL PRIMARY KEY,
  id_cliente INT REFERENCES cliente(id_cliente),
  fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  estado VARCHAR(20)
);

Luego presiona F5 o haz clic en el botón  (Execute) para ejecutar las sentencias.

Si todo sale bien, verás el mensaje:

Query returned successfully


[ código dml]

INSERT INTO cliente (nombre, cedula, telefono) VALUES
('Juan Pérez', '123456789', '3001234567'),
('Ana Gómez', '987654321', '3019876543'),
('Luis Torres', '555666777', '3021112233'),
('María López', '999888777', '303999888'),
('Carlos Ruiz', '444333222', '3044445555'),
('Elena Díaz', '111222333', '305111222'),
('Ricardo León', '555444333', '306555444'),
('Lucía Vega', '666777888', '307666777'),
('Pedro Cruz', '222111000', '308222111'),
('Valentina Mora', '777888999', '309777888');

INSERT INTO turno (id_cliente, estado) VALUES
(1, 'Pendiente'),
(2, 'Atendido'),
(3, 'Pendiente'),
(4, 'Pendiente'),
(5, 'Atendido'),
(6, 'Pendiente'),
(7, 'Pendiente'),
(8, 'Atendido'),
(9, 'Pendiente'),
(10, 'Pendiente');

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
