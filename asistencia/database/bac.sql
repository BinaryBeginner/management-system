/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.27-MariaDB : Database - sistemaasistencia
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sistemaasistencia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `sistemaasistencia`;

/*Table structure for table `asistencias` */

DROP TABLE IF EXISTS `asistencias`;

CREATE TABLE `asistencias` (
  `idasistencia` INT(11) NOT NULL AUTO_INCREMENT,
  `idusuario` INT(11) NOT NULL,
  `fecha` DATE NOT NULL,
  `horaentrada` TIME NOT NULL,
  `horainiciobreak` TIME DEFAULT NULL,
  `horafinbreak` TIME DEFAULT NULL,
  `horasalida` TIME DEFAULT NULL,
  `horastrabajadas` TIME DEFAULT NULL,
  `horasextras` TIME DEFAULT NULL,
  `motivopermiso` TEXT DEFAULT NULL,
  `nota` TEXT DEFAULT NULL,
  PRIMARY KEY (`idasistencia`),
  KEY `fk_idusuario_as` (`idusuario`),
  CONSTRAINT `fk_idusuario_as` FOREIGN KEY (`idusuario`) REFERENCES `usuarios` (`idusuario`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `asistencias` */

/*Table structure for table `colaboradores` */

DROP TABLE IF EXISTS `colaboradores`;

CREATE TABLE `colaboradores` (
  `idcolaborador` INT(11) NOT NULL AUTO_INCREMENT,
  `apellidos` VARCHAR(40) NOT NULL,
  `nombres` VARCHAR(40) NOT NULL,
  `tipodocumento` VARCHAR(20) NOT NULL,
  `numerodocumento` CHAR(15) NOT NULL,
  `email` VARCHAR(50) DEFAULT NULL,
  `direccion` VARCHAR(50) DEFAULT NULL,
  `foto` VARCHAR(200) DEFAULT NULL,
  `rol` VARCHAR(20) DEFAULT NULL,
  `telefono` CHAR(9) DEFAULT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `fecha_modificacion` DATETIME DEFAULT NULL,
  `estado` CHAR(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idcolaborador`),
  UNIQUE KEY `uk_numerodocumento_col` (`numerodocumento`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `colaboradores` */

INSERT  INTO `colaboradores`(`idcolaborador`,`apellidos`,`nombres`,`tipodocumento`,`numerodocumento`,`email`,`direccion`,`foto`,`rol`,`telefono`,`fecha_registro`,`fecha_modificacion`,`estado`) VALUES 
(1,'Hernandez Yeren','Yorghet Fernanda','DNI','72159736','yorghetyauri123@gmail.com','Av.Centenario Mz10 LT01 TUPAC',NULL,'Practicante','946989937','2023-05-06 20:00:57',NULL,'1'),
(2,'Francia Fuentes','Joel Alexander','DNI','12345678','joelfrancia123@gmail.com','Los Alamos',NULL,'Administrador','962662710','2023-05-06 20:00:57',NULL,'1');

/*Table structure for table `detalle_horarios` */

DROP TABLE IF EXISTS `detalle_horarios`;

CREATE TABLE `detalle_horarios` (
  `iddetallehorario` INT(11) NOT NULL AUTO_INCREMENT,
  `idcolaborador` INT(11) NOT NULL,
  `idhorario` INT(11) NOT NULL,
  `nomcategoria` VARCHAR(20) DEFAULT NULL,
  `diasemana` CHAR(5) NOT NULL,
  `horaentrada` TIME NOT NULL,
  `horainiciobreak` TIME DEFAULT NULL,
  `horafinbreak` TIME DEFAULT NULL,
  `horasalida` TIME DEFAULT NULL,
  `tolerancia` INT(11) NOT NULL DEFAULT 0,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `fecha_modificacion` DATETIME DEFAULT NULL,
  `estado` CHAR(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`iddetallehorario`),
  KEY `fk_idcolaborador` (`idcolaborador`),
  KEY `fk_idhorario_dth` (`idhorario`),
  CONSTRAINT `fk_idcolaborador` FOREIGN KEY (`idcolaborador`) REFERENCES `colaboradores` (`idcolaborador`),
  CONSTRAINT `fk_idhorario_dth` FOREIGN KEY (`idhorario`) REFERENCES `horarios` (`idhorario`)
) ENGINE=INNODB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detalle_horarios` */

INSERT  INTO `detalle_horarios`(`iddetallehorario`,`idcolaborador`,`idhorario`,`nomcategoria`,`diasemana`,`horaentrada`,`horainiciobreak`,`horafinbreak`,`horasalida`,`tolerancia`,`fecha_registro`,`fecha_modificacion`,`estado`) VALUES 
(1,1,1,'DIA','MON','09:00:00',NULL,NULL,'13:30:00',0,'2023-05-06 20:01:29',NULL,'1'),
(2,1,1,'DIA','TUE','09:00:00',NULL,NULL,'13:30:00',0,'2023-05-06 20:01:29',NULL,'1'),
(3,1,1,'DIA','WED','09:00:00',NULL,NULL,'13:30:00',0,'2023-05-06 20:01:29',NULL,'1'),
(4,1,1,'DIA','THU','09:00:00',NULL,NULL,'13:30:00',0,'2023-05-06 20:01:29',NULL,'1'),
(5,1,1,'DIA','FRI','09:00:00',NULL,NULL,'13:30:00',0,'2023-05-06 20:01:29',NULL,'1'),
(6,2,2,'TARDE','MON','14:00:00',NULL,NULL,'18:00:00',0,'2023-05-06 20:01:29',NULL,'1'),
(7,2,2,'TARDE','TUE','14:00:00',NULL,NULL,'18:00:00',0,'2023-05-06 20:01:29',NULL,'1'),
(8,2,2,'TARDE','WED','14:00:00',NULL,NULL,'18:00:00',0,'2023-05-06 20:01:29',NULL,'1'),
(9,2,2,'TARDE','THU','14:00:00',NULL,NULL,'18:00:00',0,'2023-05-06 20:01:29',NULL,'1'),
(10,2,2,'TARDE','FRI','14:00:00',NULL,NULL,'18:00:00',0,'2023-05-06 20:01:29',NULL,'1');

/*Table structure for table `horarios` */

DROP TABLE IF EXISTS `horarios`;

CREATE TABLE `horarios` (
  `idhorario` INT(11) NOT NULL AUTO_INCREMENT,
  `idcolaborador` INT(11) NOT NULL,
  `fechainicio` DATE NOT NULL,
  `fechafin` DATE DEFAULT NULL,
  `comentario` TEXT DEFAULT NULL,
  `modalidadtrabajo` CHAR(11) DEFAULT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `fecha_modificacion` DATETIME DEFAULT NULL,
  `estado` CHAR(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idhorario`),
  KEY `fk_idcolaborador_hr` (`idcolaborador`),
  CONSTRAINT `fk_idcolaborador_hr` FOREIGN KEY (`idcolaborador`) REFERENCES `colaboradores` (`idcolaborador`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `horarios` */

INSERT  INTO `horarios`(`idhorario`,`idcolaborador`,`fechainicio`,`fechafin`,`comentario`,`modalidadtrabajo`,`fecha_registro`,`fecha_modificacion`,`estado`) VALUES 
(1,1,'2023-05-01','2023-05-31','Horario de trabajo regular','Presencial','2023-05-06 20:01:20',NULL,'1'),
(2,2,'2023-05-01','2023-05-31','Horario de trabajo regular','Presencial','2023-05-06 20:01:20',NULL,'1');

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT,
  `idcolaborador` INT(11) NOT NULL,
  `nombreusuario` VARCHAR(20) NOT NULL,
  `claveacceso` VARCHAR(90) NOT NULL,
  `fecha_registro` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
  `fecha_modificacion` DATETIME DEFAULT NULL,
  `estado` CHAR(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_nombreusuario_usr` (`nombreusuario`),
  KEY `fk_idcolaborador_usr` (`idcolaborador`),
  CONSTRAINT `fk_idcolaborador_usr` FOREIGN KEY (`idcolaborador`) REFERENCES `colaboradores` (`idcolaborador`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `usuarios` */

INSERT  INTO `usuarios`(`idusuario`,`idcolaborador`,`nombreusuario`,`claveacceso`,`fecha_registro`,`fecha_modificacion`,`estado`) VALUES 
(1,1,'YorghetF','$2y$10$fDP07HzlrfMG3T0C6tO2J.9xyETBX0cibozBxQelv6feVhlVAp5VW','2023-05-06 20:01:47',NULL,'1'),
(2,2,'JoelF','$2y$10$VYUwgcdvtWlJzZ2MiVQI.uM5ERgUEWBwIObm4CVhswk/luJ8HO886','2023-05-06 20:01:47',NULL,'1');

/* Procedure structure for procedure `spu_obtener_datos_colaborador` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_datos_colaborador` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_datos_colaborador`(IN p_numerodocumento CHAR(15))
BEGIN
    SELECT c.foto, c.apellidos, c.nombres, c.rol
    FROM colaboradores c
    INNER JOIN usuarios u ON c.idcolaborador = u.idcolaborador
    WHERE c.numerodocumento = p_numerodocumento
    LIMIT 1;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_obtener_historial` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_obtener_historial` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_obtener_historial`()
BEGIN
    SELECT CONCAT(colaboradores.nombres, ' ', colaboradores.apellidos) AS nombre_completo,
        'Ingreso' AS tipo_registro,
        ingresos.horaentrada AS hora_registro,
        DATE(asistencias.fecha) AS fecha_registro
    FROM asistencias
    INNER JOIN usuarios ON asistencias.idusuario = usuarios.idusuario
    INNER JOIN colaboradores ON usuarios.idcolaborador = colaboradores.idcolaborador
    LEFT JOIN asistencias AS ingresos ON asistencias.idusuario = ingresos.idusuario 
        AND asistencias.fecha = ingresos.fecha 
        AND ingresos.horaentrada IS NOT NULL
    WHERE DATE(asistencias.fecha) = CURDATE()
    UNION
    SELECT CONCAT(colaboradores.nombres, ' ', colaboradores.apellidos) AS nombre_completo,
        'Salida' AS tipo_registro,
        (SELECT MAX(horasalida) FROM asistencias AS s WHERE s.idusuario = asistencias.idusuario AND s.fecha = asistencias.fecha AND s.horasalida IS NOT NULL) AS hora_registro,
        DATE(asistencias.fecha) AS fecha_registro
    FROM asistencias
    INNER JOIN usuarios ON asistencias.idusuario = usuarios.idusuario
    INNER JOIN colaboradores ON usuarios.idcolaborador = colaboradores.idcolaborador
    WHERE DATE(asistencias.fecha) = CURDATE() AND asistencias.horasalida IS NOT NULL
    ORDER BY nombre_completo ASC, fecha_registro DESC, hora_registro DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_hora_entrada` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_hora_entrada` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_hora_entrada`(IN p_numerodocumento CHAR(15))
BEGIN
	DECLARE v_idcolaborador INT;
	DECLARE v_fecha_actual DATE;
	DECLARE v_hora_actual TIME;
	DECLARE v_tardanza TIME;
	DECLARE v_apellidos VARCHAR(40);
	DECLARE v_nombres VARCHAR(40);
	DECLARE v_entradas_registradas INT;
	DECLARE v_rol VARCHAR(20);
	DECLARE v_horaentrada TIME;
	DECLARE v_categoria VARCHAR(20);
	-- Obtener el id del colaborador por su numero de documento
	SELECT idcolaborador, apellidos, nombres, rol INTO v_idcolaborador, v_apellidos, v_nombres, v_rol FROM colaboradores 
	WHERE numerodocumento = p_numerodocumento AND estado = '1';
	  
	-- Obtener la hora de entrada del colaborador para el día actual, si hay un registro
	SELECT COUNT(*) INTO v_entradas_registradas FROM asistencias WHERE idusuario IN (SELECT idusuario FROM usuarios WHERE idcolaborador = v_idcolaborador) AND fecha = CURDATE() AND horaentrada IS NOT NULL;

	IF v_entradas_registradas > 0 THEN
		-- Obtener la hora de entrada registrada para el día actual
		SELECT a.horaentrada INTO v_hora_actual FROM usuarios u
			INNER JOIN asistencias a ON u.idusuario = a.idusuario
			WHERE u.idcolaborador = v_idcolaborador AND DATE(a.horaentrada) = CURDATE() ORDER BY a.fecha DESC, a.horaentrada DESC LIMIT 1;
			
			-- Obtener el horario de ingreso del colaborador para calcular la tardanza
		SELECT horaentrada, nomcategoria INTO v_horaentrada, v_categoria FROM detalle_horarios
		WHERE idcolaborador = v_idcolaborador AND diasemana = UPPER(LEFT(DATE_FORMAT(CURDATE(), '%W'), 3));
	
		
		 -- Verificar si llegó a tiempo o tarde
		 IF v_hora_actual <= v_horaentrada THEN
			SET v_tardanza = NULL;
		 ELSE
			-- Calcular la tardanza
			SELECT SEC_TO_TIME(TIMESTAMPDIFF(SECOND, CONCAT(CURDATE(), ' ', v_horaentrada), v_hora_actual)) INTO v_tardanza;
			END IF;
		ELSE
		 -- Registrar la hora de entrada del colaborador
		 SELECT CURDATE() INTO v_fecha_actual;
		 SELECT CURTIME() INTO v_hora_actual;
		 INSERT INTO asistencias (idusuario, fecha, horaentrada) 
		 VALUES ((SELECT idusuario FROM usuarios WHERE idcolaborador = v_idcolaborador), v_fecha_actual, v_hora_actual);
		 
		 	
			-- Obtener el horario de ingreso del colaborador para calcular la tardanza
		SELECT horaentrada, nomcategoria INTO v_horaentrada, v_categoria FROM detalle_horarios
		WHERE idcolaborador = v_idcolaborador AND diasemana = UPPER(LEFT(DATE_FORMAT(CURDATE(), '%W'), 3));
		 
		 -- Verificar si llegó a tiempo o tarde
		 IF v_hora_actual <= v_horaentrada THEN
			SET v_tardanza = NULL;
		 ELSE
			-- Calcular la tardanza
			SELECT SEC_TO_TIME(TIMESTAMPDIFF(SECOND, CONCAT(CURDATE(), ' ', v_horaentrada), v_hora_actual)) INTO v_tardanza;
		 END IF;
	  END IF;
	  
	  -- Devolver los resultados
	  SELECT v_idcolaborador AS id_colaborador, v_apellidos AS apellidos, v_nombres AS nombres, v_rol AS rol, v_hora_actual AS hora_entrada, v_tardanza AS tardanza, v_categoria AS nomcategoria;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_salida` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_salida` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_salida`(IN p_numerodocumento CHAR(15))
BEGIN
  DECLARE v_colaborador_id INT;
  DECLARE v_fecha_actual DATE;
  DECLARE v_hora_salida TIME;
  DECLARE v_hora_entrada TIME;
  DECLARE v_horario_id INT;
  DECLARE v_horario_hora_salida TIME;
  DECLARE v_apellidos VARCHAR(100);
  DECLARE v_nombres VARCHAR(100);
  DECLARE v_rol VARCHAR(50);
  DECLARE v_nota TEXT;
  
  -- Obtener el ID del colaborador a partir de su número de documento
  SELECT idcolaborador INTO v_colaborador_id FROM colaboradores WHERE numerodocumento = p_numerodocumento LIMIT 1;
  
  -- Verificar si el colaborador tiene una hora de entrada registrada en el día
  SELECT horaentrada INTO v_hora_entrada FROM asistencias WHERE idusuario = v_colaborador_id AND fecha = CURDATE() LIMIT 1;
  
  IF v_hora_entrada IS NULL THEN
    SELECT "El colaborador no tiene una hora de entrada registrada hoy" AS mensaje;
  ELSE
    -- Verificar si el colaborador ya tiene una hora de salida registrada en el día
    SELECT horasalida INTO v_hora_salida FROM asistencias WHERE idusuario = v_colaborador_id AND fecha = CURDATE() LIMIT 1;
  
    IF v_hora_salida IS NOT NULL THEN
      -- Seleccionar los datos del colaborador y su hora de salida registrada
      SELECT c.apellidos, c.nombres, c.rol, a.horaentrada, a.horasalida,
		CASE
			WHEN v_hora_salida IS NULL THEN ''
			WHEN v_hora_salida < v_horario_hora_salida THEN CONCAT('El colaborador está saliendo antes de su hora de salida programada (', v_horario_hora_salida, ')')
			WHEN v_hora_salida > v_horario_hora_salida THEN CONCAT('El colaborador está saliendo después de su hora de salida programada (', v_horario_hora_salida, ')')
			ELSE 'El colaborador está saliendo dentro de su horario de salida programado'
			END AS nota
			INTO v_apellidos, v_nombres, v_rol, v_hora_entrada, v_hora_salida, v_nota
			FROM colaboradores c
			INNER JOIN asistencias a ON c.idcolaborador = a.idusuario
			WHERE c.numerodocumento = p_numerodocumento AND a.fecha = CURDATE() LIMIT 1;

      
      -- Devolver los datos del colaborador y su hora de salida registrada
      SELECT v_apellidos AS apellidos, v_nombres AS nombres, v_rol AS rol, v_hora_salida AS horasalida, v_nota AS nota;
    ELSE
      -- Obtener el ID del horario del colaborador y su hora de salida
      SELECT idhorario, horasalida INTO v_horario_id, v_horario_hora_salida FROM detalle_horarios WHERE idcolaborador = v_colaborador_id AND diasemana = UPPER(LEFT(DATE_FORMAT(CURDATE(), '%W'), 3));
  
		
      SET v_fecha_actual = CURDATE();
      SET v_hora_salida = NOW();
    
      -- Actualizar la hora de salida del colaborador en la tabla asistencias
      UPDATE asistencias SET horasalida = v_hora_salida WHERE idusuario = v_colaborador_id AND fecha = v_fecha_actual;
      
      -- Seleccionar los datos del colaborador y su hora de salida registrada
      SELECT c.apellidos, c.nombres, c.rol, a.horaentrada, a.horasalida,
		CASE
			WHEN v_hora_salida IS NULL THEN ''
			WHEN v_hora_salida < v_horario_hora_salida THEN CONCAT('El colaborador está saliendo antes de su hora de salida programada (', v_horario_hora_salida, ')')
			WHEN v_hora_salida > v_horario_hora_salida THEN CONCAT('El colaborador está saliendo después de su hora de salida programada (', v_horario_hora_salida, ')')
			ELSE 'El colaborador está saliendo dentro de su horario de salida programado'
			END AS nota
			INTO v_apellidos, v_nombres, v_rol, v_hora_entrada, v_hora_salida, v_nota
			FROM colaboradores c
			INNER JOIN asistencias a ON c.idcolaborador = a.idusuario
			WHERE c.numerodocumento = p_numerodocumento AND a.fecha = CURDATE() LIMIT 1;
      -- Devolver los datos del colaborador y su hora de salida registrada
      SELECT v_apellidos AS apellidos, v_nombres AS nombres, v_rol AS rol, v_hora_salida AS horasalida, v_nota AS nota;
    END IF;
  END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `spu_usuarios_login` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_usuarios_login` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_usuarios_login`(IN nombreusuario_ VARCHAR(30))
BEGIN
	SELECT idusuario, idcolaborador, nombreusuario, claveacceso
	FROM usuarios
	WHERE nombreusuario = nombreusuario_ AND estado = '1';
END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;


CALL spu_registrar_hora_entrada('12345678');
CALL spu_obtener_historial();
CALL spu_registrar_salida('12345678');
