CREATE DATABASE SistemaAsistencia
USE SistemaAsistencia

DROP DATABASE SistemaAsistencia;
-- CREACION DE LA TABLA COLABORADORES (col)
CREATE TABLE colaboradores(
	idcolaborador 				INT AUTO_INCREMENT 	PRIMARY KEY,
	apellidos					VARCHAR(40)				NOT NULL,
	nombres 						VARCHAR(40)				NOT NULL,
	tipodocumento				VARCHAR(20)				NOT NULL, 
	numerodocumento			CHAR(15)					NOT NULL, -- UNIQUE
	email							VARCHAR(50)				NULL,
	direccion					VARCHAR(50)				NULL,
	rol 							VARCHAR(20) 			NULL,
	telefono						CHAR(9)					NULL, -- CHECK
	foto 							VARCHAR(200) 			NULL,
	fecha_registro				DATETIME					NOT NULL DEFAULT NOW(),
	fecha_modificacion		DATETIME					NULL,
	estado						CHAR(1)					NOT NULL DEFAULT '1',
	CONSTRAINT uk_numerodocumento_col 				UNIQUE(numerodocumento)
)ENGINE=INNODB;



-- INSERTANDO DATOS
INSERT INTO colaboradores (apellidos, nombres, tipodocumento, numerodocumento, email, direccion,rol, telefono) VALUES 
	(
		'Hernandez Yeren', 
		'Yorghet Fernanda', 
		'DNI', 
		'72159736', 
		'yorghetyauri123@gmail.com', 
		'Av.Centenario Mz10 LT01 TUPAC',
		'Practicante', 
		'946989937'
	);
	
	INSERT INTO colaboradores (apellidos, nombres, tipodocumento, numerodocumento, email, direccion,rol, telefono) VALUES 
	(
		'Francia Fuentes', 
		'Joel Alexander', 
		'DNI', 
		'12345678', 
		'joelfrancia123@gmail.com', 
		'Los Alamos',
		'Administrador', 
		'962662710'
	);
	
	INSERT INTO colaboradores (apellidos, nombres, tipodocumento, numerodocumento, email, direccion,rol, telefono) VALUES 
	(
		'Galindos Izaguirre', 
		'Ana Edith', 
		'DNI', 
		'70616072', 
		'annagalindoz0@gmail.com', 
		'Upis Felix Amoretti',
		'Practicante', 
		'922324503'
	);
	
	INSERT INTO colaboradores (apellidos, nombres, tipodocumento, numerodocumento, email, direccion,rol, telefono) VALUES 
	(
		'Lurita Zúñiga', 
		'Crisálida Rosa Alejandro', 
		'DNI', 
		'74530241', 
		'crisalidaluritazuñiga@hotmail.com', 
		'Av. Simón Bolivar N°500',
		'Practicante', 
		'924980645'
	);
	
SELECT * FROM colaboradores;


-- CREACION DE LA TABLA HORARIOS (hr)
CREATE TABLE horarios(
	idhorario					INT AUTO_INCREMENT 	PRIMARY KEY,
	idcolaborador				INT 						NOT NULL, -- FOREIGN KEY
	fechainicio					DATE 						NOT NULL,
	fechafin						DATE 						NULL,
	comentario					TEXT						NULL,
	modalidadtrabajo			CHAR(11)					NULL,
	fecha_registro				DATETIME					NOT NULL DEFAULT NOW(),
	fecha_modificacion		DATETIME					NULL,
	estado						CHAR(1)					NOT NULL DEFAULT '1',
	CONSTRAINT fk_idcolaborador_hr 					FOREIGN KEY(idcolaborador) REFERENCES colaboradores (idcolaborador)
)ENGINE=INNODB;

-- INSERTANDO DATOS
INSERT INTO horarios (idcolaborador, fechainicio, fechafin, comentario, modalidadtrabajo) VALUES 
	(
		1,
		'2023-05-01', 
		'2023-05-31', 
		'Horario de trabajo regular', 
		'Presencial'
	);
	
-- INSERTANDO DATOS
INSERT INTO horarios (idcolaborador, fechainicio, fechafin, comentario, modalidadtrabajo) VALUES 
	(
		2,
		'2023-05-01', 
		'2023-05-31', 
		'Horario de trabajo regular', 
		'Presencial'
	);
	
	-- INSERTANDO DATOS
INSERT INTO horarios (idcolaborador, fechainicio, fechafin, comentario, modalidadtrabajo) VALUES 
	(
		3,
		'2023-05-01', 
		'2023-05-31', 
		'Horario de trabajo regular', 
		'Presencial'
	);
	
-- INSERTANDO DATOS
INSERT INTO horarios (idcolaborador, fechainicio, fechafin, comentario, modalidadtrabajo) VALUES 
	(
		4,
		'2023-05-01', 
		'2023-05-31', 
		'Horario de trabajo regular', 
		'Presencial'
	);
	SELECT * FROM horarios;

-- CREACION DE LAS TABLA DETALLE_HORARIOS (dth)
CREATE TABLE detalle_horarios(
	iddetallehorario			INT AUTO_INCREMENT 	PRIMARY KEY,
	idcolaborador				INT 						NOT NULL, -- FOREIGN KEY
	idhorario					INT 						NOT NULL, -- FOREIGN KEY
	nomcategoria				VARCHAR(20)          NULL,
	diasemana 					CHAR(5)					NOT NULL,
	horaentrada					TIME 						NOT NULL,
	horainiciobreak			TIME 						NULL,
	horafinbreak 				TIME 						NULL,
	horasalida					TIME 						NULL,
	tolerancia 					INT 						NOT NULL DEFAULT '0',
	fecha_registro				DATETIME					NOT NULL DEFAULT NOW(),
	fecha_modificacion		DATETIME					NULL,
	estado						CHAR(1)					NOT NULL DEFAULT '1',
	CONSTRAINT fk_idcolaborador 						FOREIGN KEY(idcolaborador) REFERENCES colaboradores (idcolaborador),
	CONSTRAINT fk_idhorario_dth 						FOREIGN KEY(idhorario) 		REFERENCES horarios (idhorario)
)ENGINE=INNODB;

-- INSERTANDO DATOS
INSERT INTO detalle_horarios (idcolaborador, idhorario, nomcategoria, diasemana, horaentrada, horainiciobreak, horafinbreak, horasalida, tolerancia) VALUES
	(1, 1, 'MAÑANA', 'MON', '09:00:00', NULL, NULL, '13:30:00', 0),
	(1, 1, 'MAÑANA', 'TUE', '09:00:00', NULL, NULL, '13:30:00', 0),
	(1, 1, 'MAÑANA', 'WED', '09:00:00', NULL, NULL, '13:30:00', 0),
	(1, 1, 'MAÑANA', 'THU', '09:00:00', NULL, NULL, '13:30:00', 0),
	(1, 1, 'MAÑANA', 'FRI', '09:00:00', NULL, NULL, '13:30:00', 0);

-- INSERTANDO DATOS
INSERT INTO detalle_horarios (idcolaborador, idhorario, nomcategoria, diasemana, horaentrada, horainiciobreak, horafinbreak, horasalida, tolerancia) VALUES
	(2, 2, 'TARDE', 'MON', '14:00:00', NULL, NULL, '18:00:00', 0),
	(2, 2, 'TARDE', 'TUE', '14:00:00', NULL, NULL, '18:00:00', 0),
	(2, 2, 'TARDE', 'WED', '14:00:00', NULL, NULL, '18:00:00', 0),
	(2, 2, 'TARDE', 'THU', '14:00:00', NULL, NULL, '18:00:00', 0),
	(2, 2, 'TARDE', 'FRI', '14:00:00', NULL, NULL, '18:00:00', 0);
	
-- INSERTANDO DATOS
INSERT INTO detalle_horarios (idcolaborador, idhorario, nomcategoria, diasemana, horaentrada, horainiciobreak, horafinbreak, horasalida, tolerancia) VALUES
	(3, 3, 'MAÑANA', 'MON', '09:00:00', NULL, NULL, '13:30:00', 0),
	(3, 3, 'MAÑANA', 'TUE', '09:00:00', NULL, NULL, '13:30:00', 0),
	(3, 3, 'MAÑANA', 'WED', '09:00:00', NULL, NULL, '13:30:00', 0),
	(3, 3, 'MAÑANA', 'THU', '09:00:00', NULL, NULL, '13:30:00', 0),
	(3, 3, 'MAÑANA', 'FRI', '09:00:00', NULL, NULL, '13:30:00', 0);

-- INSERTANDO DATOS
INSERT INTO detalle_horarios (idcolaborador, idhorario, nomcategoria, diasemana, horaentrada, horainiciobreak, horafinbreak, horasalida, tolerancia) VALUES
	(4, 4, 'MAÑANA', 'MON', '09:00:00', NULL, NULL, '13:30:00', 0),
	(4, 4, 'MAÑANA', 'TUE', '09:00:00', NULL, NULL, '13:30:00', 0),
	(4, 4, 'MAÑANA', 'WED', '09:00:00', NULL, NULL, '13:30:00', 0),
	(4, 4, 'MAÑANA', 'THU', '09:00:00', NULL, NULL, '13:30:00', 0),
	(4, 4, 'MAÑANA', 'FRI', '09:00:00', NULL, NULL, '13:30:00', 0);
SELECT * FROM detalle_horarios;

-- CREACION DE LA TABLA CATEGORIA HORARIOS  
/*CREATE TABLE categoria_horarios(
	idcategoriahorario 			INT AUTO_INCREMENT 	PRIMARY KEY,
	iddetallehorario				INT 						NOT NULL,
	idhorario						INT 						NOT NULL, -- FOREIGN KEY
	nomcategoria					VARCHAR(20) 			NOT NULL, -- MAÑANA O TARDE
	diasemana 						CHAR(1)					NOT NULL,
	horaentrada						TIME 						NOT NULL,
	horainiciobreak				TIME 						NULL,
	horafinbreak 					TIME 						NULL,
	horasalida						TIME 						NULL,
	tolerancia 						INT 						NOT NULL DEFAULT '0',
	fecha_registro					DATETIME					NOT NULL DEFAULT NOW(),
	fecha_modificacion			DATETIME					NULL,
	estado							CHAR(1)					NOT NULL DEFAULT '1',
	CONSTRAINT fk_iddetallehorario_ch 					FOREIGN KEY(iddetallehorario) REFERENCES detalle_horarios (iddetallehorario), 
	CONSTRAINT fk_idhorario_ch 							FOREIGN KEY(idhorario) 			REFERENCES horarios (idhorario)
)ENGINE = INNODB;


-- INSERTANDO DATOS
INSERT INTO categoria_horarios (iddetallehorario, idhorario, nomcategoria, diasemana, horaentrada, horainiciobreak, horafinbreak, horasalida, tolerancia) VALUES
	(1, 1, 'DIA', 'L', '09:00:00', NULL, NULL, '13:30:00', 10),
	(1, 1, 'DIA', 'M', '09:00:00', NULL, NULL, '13:30:00', 10),
	(1, 1, 'DIA', 'X', '09:00:00', NULL, NULL, '13:30:00', 10),
	(1, 1, 'DIA', 'J', '09:00:00', NULL, NULL, '13:30:00', 10),
	(1, 1, 'DIA', 'V', '09:00:00', NULL, NULL, '13:30:00', 10),
	(2, 2, 'TARDE', 'L', '14:00:00', NULL, NULL, '18:00:00', 10),
	(2, 2, 'TARDE', 'M', '14:00:00', NULL, NULL, '18:00:00', 10),
	(2, 2, 'TARDE', 'X', '14:00:00', NULL, NULL, '18:00:00', 10),
	(2, 2, 'TARDE', 'J', '14:00:00', NULL, NULL, '18:00:00', 10),
	(2, 2, 'TARDE', 'V', '14:00:00', NULL, NULL, '18:00:00', 10);
	select * from categoria_horarios;*/

-- CREACION DE LA TABLA USUARIOS (usr)
CREATE TABLE usuarios(
	idusuario					INT AUTO_INCREMENT 	PRIMARY KEY,
	idcolaborador				INT 						NOT NULL, -- FOREIGN KEY
	nombreusuario 				VARCHAR(20)				NOT NULL, -- UNIQUE
	claveacceso 				VARCHAR(90) 			NOT NULL,
	fecha_registro				DATETIME					NOT NULL DEFAULT NOW(),
	fecha_modificacion		DATETIME					NULL,
	estado						CHAR(1)					NOT NULL DEFAULT '1',
	CONSTRAINT fk_idcolaborador_usr 					FOREIGN KEY(idcolaborador) REFERENCES colaboradores (idcolaborador),
	CONSTRAINT uk_nombreusuario_usr					UNIQUE(nombreusuario)
)ENGINE=INNODB;

-- INSERTANDO DATOS
INSERT INTO usuarios (idcolaborador, nombreusuario, claveacceso) VALUES 
	(
		1, 
		'YorghetF',
		'Hola123#'
	);
	
	-- INSERTANDO DATOS
INSERT INTO usuarios (idcolaborador, nombreusuario, claveacceso) VALUES 
	(
		2, 
		'JoelF',
		'Hola123#'
	);
	SELECT * FROM usuarios;

UPDATE usuarios SET
	claveacceso = '$2y$10$fDP07HzlrfMG3T0C6tO2J.9xyETBX0cibozBxQelv6feVhlVAp5VW' -- Yorghet123#
	WHERE idusuario = 1;
	
	UPDATE usuarios SET
	claveacceso = '$2y$10$VYUwgcdvtWlJzZ2MiVQI.uM5ERgUEWBwIObm4CVhswk/luJ8HO886' -- Agencia123#
	WHERE idusuario = 2;

-- CREACION DE LA TABLA ASISTENCIAS (as)
CREATE TABLE asistencias(
	idasistencia 				INT AUTO_INCREMENT 	PRIMARY KEY,
	idcolaborador				INT 						NOT NULL, -- FOREIGN KEY
	fecha 						DATE 						NOT NULL,
	horaentrada					TIME 						NOT NULL,
	horainiciobreak 			TIME 						NULL,
	horafinbreak 				TIME  					NULL,
	horasalida   				TIME     				NULL,
	horastrabajadas  			TIME  					NULL,
	horasextras 				TIME						NULL,
	motivopermiso	 			TEXT 						NULL,
	nota							TEXT 			 			NULL,
	CONSTRAINT fk_idusuario_as 						FOREIGN KEY(idcolaborador)		REFERENCES colaboradores (idcolaborador)
)ENGINE=INNODB;
SELECT * FROM asistencias;
-- INSERTANDO DATOS
INSERT INTO asistencias (idusuario, fecha, horaentrada, horainiciobreak, horafinbreak, horasalida, horastrabajadas, horasextras, motivopermiso) VALUES 
	(
		1,
		CURRENT_DATE(), 
		'09:00:00', 
		NULL, 
		NULL, 
		'13:30:00', 
		'04:30:00', 
		'00:00:00', 
		NULL
	);
	SELECT * FROM asistencias;
	SELECT NOW();