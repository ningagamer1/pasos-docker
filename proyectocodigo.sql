-- Ciudad
INSERT INTO Ciudad (nombre_ciudad, codigo_postal)
VALUES ('Cali', '760001'), ('Bogotá', '110111'), ('Medellín', '050021'),
       ('Palmira', '763531'), ('Popayán', '190001'),
       ('Buga', '763041'), ('Tuluá', '763022'),
       ('Cartago', '762021'), ('Manizales', '170001'), ('Pereira', '660001');

-- Usuario
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

-- Servicio
INSERT INTO Servicio (nombre, descripcion, estado)
VALUES 
('Atención al cliente', 'Soporte presencial', 'Activo'),
('Consultoría', 'Asesorías especializadas', 'Activo'),
('Despacho', 'Envío de productos', 'Activo'),
('Recepción de artículos', 'Recepción de pedidos', 'Activo'),
('Entrega', 'Entrega de productos', 'Activo'),
('Capacitación', 'Formación al personal', 'Activo'),
('Reparaciones', 'Mantenimiento técnico', 'Activo'),
('Logística', 'Gestión de entregas', 'Activo'),
('Teleasistencia', 'Atención virtual', 'Activo'),
('Control calidad', 'Supervisión de procesos', 'Activo');

-- Empleado
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

-- Turno
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
