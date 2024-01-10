-- ***************************************************************************************************************************
--                               PROCEDIMIENTOS ALMACENADO PARA MI SISTEMA DE ASISTENCIA
-- ***************************************************************************************************************************

-- ----------------------------------------------------
-- | PROCEDIMIENTO PARA OBTENER DATOS DEL COLABORADOR |
-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_obtener_datos_colaborador(IN p_numerodocumento CHAR(15))
BEGIN
    SELECT c.foto, c.apellidos, c.nombres, c.rol, dh.nomcategoria
    FROM colaboradores c
    LEFT JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
    WHERE c.numerodocumento = p_numerodocumento
    LIMIT 1;
END $$
CALL spu_obtener_datos_colaborador('70616072');

-- ------------------------------------------------
-- | PROCEDIMIENTO PARA REGISTRAR HORA DE ENTRADA |
-- ------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_registrar_hora_entrada(IN p_numerodocumento CHAR(15))
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
    SELECT idcolaborador, apellidos, nombres, rol INTO v_idcolaborador, v_apellidos, v_nombres, v_rol
    FROM colaboradores 
    WHERE numerodocumento = p_numerodocumento AND estado = '1';

    -- Obtener la hora de entrada del colaborador para el día actual, si hay un registro
    SELECT COUNT(*) INTO v_entradas_registradas
    FROM asistencias
    WHERE idcolaborador = v_idcolaborador AND fecha = CURDATE() AND horaentrada IS NOT NULL;

    IF v_entradas_registradas > 0 THEN
        -- Obtener la hora de entrada registrada para el día actual
        SELECT horaentrada INTO v_hora_actual
        FROM asistencias
        WHERE idcolaborador = v_idcolaborador AND fecha = CURDATE()
        ORDER BY fecha DESC, horaentrada DESC
        LIMIT 1;

        -- Obtener el horario de ingreso del colaborador para calcular la tardanza
        SELECT horaentrada, nomcategoria INTO v_horaentrada, v_categoria
        FROM detalle_horarios
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
        INSERT INTO asistencias (idcolaborador, fecha, horaentrada) 
        VALUES (v_idcolaborador, v_fecha_actual, v_hora_actual);

        -- Obtener el horario de ingreso del colaborador para calcular la tardanza
        SELECT horaentrada, nomcategoria INTO v_horaentrada, v_categoria
        FROM detalle_horarios
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
END $$
CALL spu_registrar_hora_entrada('72159736');

-- PRUEBAS
SELECT * FROM detalle_horarios WHERE idcolaborador = 1
-- SELECT DATE_FORMAT(CURDATE(), '%W') AS dia_semana
SELECT UPPER(LEFT(DATE_FORMAT(CURDATE(), '%W'), 3)) AS dia_semana

/*SELECT TIMEDIFF(horasalida, horaentrada) AS horas_trabajadas
FROM detalle_horarios
WHERE idcolaborador = 2;*/

-- -----------------------------------------------
-- | PROCEDIMIENTO PARA REGISTRAR HORA DE SALIDA |
-- -----------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_registrar_salida(IN p_numerodocumento CHAR(15))
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
  -- DECLARE v_hora_salida_registrada TIME;
  -- Obtener el ID del colaborador a partir de su número de documento
  SELECT idcolaborador INTO v_colaborador_id FROM colaboradores WHERE numerodocumento = p_numerodocumento LIMIT 1;
  
  -- Verificar si el colaborador tiene una hora de entrada registrada en el día
  SELECT horaentrada INTO v_hora_entrada FROM asistencias WHERE idcolaborador = v_colaborador_id AND fecha = CURDATE() LIMIT 1;
  
  IF v_hora_entrada IS NULL THEN
    SELECT "El colaborador no tiene una hora de entrada registrada hoy" AS mensaje;
  ELSE
    -- Verificar si el colaborador ya tiene una hora de salida registrada en el día
    SELECT horasalida INTO v_hora_salida FROM asistencias WHERE idcolaborador = v_colaborador_id AND fecha = CURDATE() LIMIT 1;
  
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
			INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
			WHERE c.numerodocumento = p_numerodocumento AND a.fecha = CURDATE() LIMIT 1;

      
      -- Devolver los datos del colaborador y su hora de salida registrada
      SELECT v_apellidos AS apellidos, v_nombres AS nombres, v_rol AS rol, v_hora_salida AS horasalida, v_nota AS nota;
    ELSE
      -- Obtener el ID del horario del colaborador y su hora de salida
      SELECT idhorario, horasalida INTO v_horario_id, v_horario_hora_salida FROM detalle_horarios WHERE idcolaborador = v_colaborador_id AND diasemana = UPPER(LEFT(DATE_FORMAT(CURDATE(), '%W'), 3));
  
		
      SET v_fecha_actual = CURDATE();
      SET v_hora_salida = NOW();
    
      -- Actualizar la hora de salida del colaborador
      UPDATE asistencias SET horasalida = v_hora_salida WHERE idcolaborador = v_colaborador_id AND fecha = v_fecha_actual;
      
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
			INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
			WHERE c.numerodocumento = p_numerodocumento AND a.fecha = CURDATE() LIMIT 1;
      
      -- Devolver los datos del colaborador y su hora de salida registrada
      SELECT v_apellidos AS apellidos, v_nombres AS nombres, v_rol AS rol, v_hora_salida AS horasalida, v_nota AS nota;
      END IF;
      END IF;
END $$
CALL spu_registrar_salida('74530241');

-- ----------------------------------------
-- | PROCEDIMIENTO PARA OBTENER HISTORIAL |
-- ----------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_obtener_historial()
BEGIN
    SELECT CONCAT(colaboradores.nombres, ' ', colaboradores.apellidos) AS nombre_completo,
        'Ingreso' AS tipo_registro,
        ingresos.horaentrada AS hora_registro,
        DATE(asistencias.fecha) AS fecha_registro
    FROM asistencias
    INNER JOIN colaboradores ON asistencias.idcolaborador = colaboradores.idcolaborador
    LEFT JOIN asistencias AS ingresos ON asistencias.idcolaborador = ingresos.idcolaborador 
        AND asistencias.fecha = ingresos.fecha 
        AND ingresos.horaentrada IS NOT NULL
    WHERE DATE(asistencias.fecha) = CURDATE()
    UNION
    SELECT CONCAT(colaboradores.nombres, ' ', colaboradores.apellidos) AS nombre_completo,
        'Salida' AS tipo_registro,
        (SELECT MAX(horasalida) FROM asistencias AS s WHERE s.idcolaborador = asistencias.idcolaborador AND s.fecha = asistencias.fecha AND s.horasalida IS NOT NULL) AS hora_registro,
        DATE(asistencias.fecha) AS fecha_registro
    FROM asistencias
    INNER JOIN colaboradores ON asistencias.idcolaborador = colaboradores.idcolaborador
    WHERE DATE(asistencias.fecha) = CURDATE() AND asistencias.horasalida IS NOT NULL
    ORDER BY fecha_registro DESC, hora_registro DESC, nombre_completo ASC;

END $$
CALL spu_obtener_historial();

-- -------------------------------
-- | PROCEDIMIENTO LOGIN USUARIO |
-- -------------------------------
/*DELIMITER $$
CREATE PROCEDURE spu_usuarios_login(IN nombreusuario_ VARCHAR(30))
BEGIN
	SELECT idusuario, idcolaborador, nombreusuario, claveacceso
	FROM usuarios
	WHERE nombreusuario = nombreusuario_ AND estado = '1';
END $$
CALL spu_usuarios_login('YorghetF');*/

-- ---------------------------------------------
-- | PROCEDIMIENTO OFICIAL PARA USUARIOS LOGIN |
-- ---------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_usuarios_login(IN nombreusuario_ VARCHAR(30))
BEGIN
	SELECT 	idusuario, nombreusuario, claveacceso,
				apellidos, nombres
	FROM usuarios
	WHERE nombreusuario = nombreusuario_ AND estado = '1';
END $$
CALL spu_usuarios_login('YorghetF');

-- --------------------------------------
-- | PROCEDIMIENTO LISTAR COLABORADORES |
-- --------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_colaboradores()
BEGIN 
	SELECT * FROM colaboradores;
END $$
CALL spu_listar_colaboradores();

-- ----------------------------------------------------
-- | PROCEDIMIENTO PARA LISTAR COLABORADORRES ACTIVOS |
-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_listar_colaboradores_activos()
BEGIN
	SELECT * FROM colaboradores WHERE estado ='1';
END $$
CALL spu_listar_colaboradores_activos();

-- ---------------------------------------------
-- | PROCEDIMIENTO PARA INSERTAR COLABORADORES |
-- ---------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_insertar_colaboradores
(
	IN apellidos_ 			VARCHAR(40),
	IN nombres_				VARCHAR(40),
	IN tipodocumento_ 		VARCHAR(20),
	IN numerodocumeto_ 		CHAR(15),
	IN email_				VARCHAR(50),
	IN direccion_    		VARCHAR(50),
	IN rol_					VARCHAR(20),
	IN telefono_			CHAR(9),
	IN foto_					VARCHAR(200)
)
BEGIN
	-- Validar el contenido de fotografía (CAMPO NULL)
	IF foto_ = '' THEN 
		SET foto_ = NULL;
	END IF;
	INSERT INTO colaboradores(apellidos, nombres, tipodocumento, numerodocumento, email, direccion, rol, telefono, foto)
	VALUES (apellidos_, nombres_, tipodocumento_, numerodocumeto_, email_, direccion_, rol_, telefono_, foto_);
END $$

-- ----------------------------------------------
-- | PROCEDIMIENTO PARA MODIFICAR COLABORADORES |
-- ----------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_modificar_colaboradores
(
	IN idcolaborador_			INT,
	IN apellidos_  			VARCHAR(40),
	IN nombres_					VARCHAR(40),
	IN tipodocumento_			VARCHAR(20),
	IN numerodocumento_		CHAR(15),
	IN email_					VARCHAR(50),
	IN direccion_				VARCHAR(50),
	IN rol_						VARCHAR(20),
	IN telefono_				CHAR(9),
	IN foto_						VARCHAR(200)
)
BEGIN
	UPDATE colaboradores SET
	apellidos 				= apellidos_,
	nombres 					= nombres_,
	tipodocumento 			= tipodocumento_,
	numerodocumento 		= numerodocumento_,
	email 					= email_,
	direccion  				= direccion_,
	rol 						= rol_,
	telefono   				= telefono_,
	foto 						= foto_,
	fecha_modificacion		= NOW()
	WHERE idcolaborador 	= idcolaborador_;
END $$

-- -------------------------------------------
-- | PROCEDIMIENTO PARA ELIMINAR COLABORADOR |
-- -------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_eliminar_colaborador
(
	IN idcolaborador_ 		INT
)
BEGIN
	DELETE FROM colaboradores WHERE idcolaborador = idcolaborador_;
END $$

-- ---------------------------------------------------
-- | PROCEDIMIENTO PARA OBTENER FOTO DEL COLABORADOR |
-- ---------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_obtener_foto(IN idcolaborador_ INT)
BEGIN
	SELECT foto FROM colaboradores WHERE idcolaborador = idcolaborador_;
END $$
CALL spu_obtener_foto(1);

-- -----------------------------------------------------
-- | PROCEDIMIENTO PARA RECUPERAR COLABORADORES POR ID |
-- -----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_colaboradores_recuperar_id(IN idcolaborador_ INT)
BEGIN
	SELECT * FROM colaboradores WHERE idcolaborador = idcolaborador_;
END $$
CALL spu_colaboradores_recuperar_id(35);

-- -------------------------------------
-- | PROCEDIMIENTO LISTAR LOS USUARIOS |
-- -------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_usuarios_listar()
BEGIN
    SELECT 	idusuario,
				nombreusuario,
				apellidos,
				nombres,
				fecha_registro
	FROM usuarios
	WHERE estado = '1'
	ORDER BY idusuario DESC;
END $$
CALL spu_usuarios_listar();

-- -----------------------------------
-- | PROCEDIMIENTO REGISTRAR USUARIO |
-- -----------------------------------
DELIMITER $$
CREATE PROCEDURE spu_registrar_usuarios(
IN nombreusuario_ 	VARCHAR(30),
IN claveacceso_ 		VARCHAR(90),
IN apellidos_			VARCHAR(30),
IN nombres_				VARCHAR(30)

)
BEGIN
	INSERT INTO usuarios(nombreusuario, claveacceso, apellidos, nombres) 
	VALUES (nombreusuario_, claveacceso_, apellidos_, nombres_);
END $$
CALL spu_registrar_usuarios('AnaG','Hola123#','Galindo Izaguirre','Ana Edith');  -- FALTA ENCRIPTAR

-- ----------------------------------
-- | PROCEDIMIENTO ELIMINAR USUARIO |
-- ----------------------------------
DELIMITER $$
CREATE PROCEDURE spu_usuarios_eliminar(IN idusuario_ INT)
BEGIN
	UPDATE usuarios SET estado = '0' 
	WHERE idusuario = idusuario_;
END $$
CALL spu_usuarios_eliminar(3);

-- ------------------------------------
-- | PROCEDIMIENTO RECUPERAR USUARIOS |
-- ------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_usuarios_recuperar_id(IN idusuario_ INT)
BEGIN
	SELECT * FROM usuarios WHERE idusuario = idusuario_;
END $$
CALL spu_usuarios_recuperar_id(1);

-- -------------------------------------
-- | PROCEDIMIENTO USUARIOS ACTUALIZAR |
-- -------------------------------------
DELIMITER $$
CREATE PROCEDURE spu_usuarios_actualizar(
	IN idusuario_				INT,
	IN nombreusuario_ 		VARCHAR(30),
	IN claveacceso_			VARCHAR(90),
	IN apellidos_				VARCHAR(30),
	IN nombres_					VARCHAR(30)
)
BEGIN
	UPDATE usuarios SET
	nombreusuario					= nombreusuario_,
	claveacceso 					= claveacceso_,
	apellidos						= apellidos_,
	nombres 							= nombres_,
	fecha_modificacion			= NOW()
	WHERE idusuario 				= idusuario_;
END $$

-- --------------------------------------------
-- | PROCEDIMIENTO PARA HORA EXTRAS (DIARIAS) |
-- --------------------------------------------
/*DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_diarias(IN fecha_consulta DATE)
BEGIN
    SELECT
  c.idcolaborador,
  CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
  a.fecha,
  SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada)))) AS total_horas_trabajadas,
  SEC_TO_TIME(SUM(
    CASE
      WHEN a.horasalida > dh.horasalida THEN
        TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
      ELSE
        0
    END
  )) AS total_horas_extras
FROM colaboradores c
INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
WHERE a.fecha = fecha_consulta
  AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(CURDATE(), '%W'), 3)) -- Consideramos el día de la semana correspondiente
GROUP BY c.idcolaborador, c.nombres, c.apellidos, a.fecha;
END $$
CALL generar_reporte_horas_extras_diarias('2023-05-18');*/
/* prueba 2
DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_diarias(IN fecha_consulta DATE)
BEGIN
SELECT
    c.idcolaborador,
    CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
    SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(
        CASE
            WHEN a.horasalida > dh.horasalida THEN dh.horasalida
            ELSE a.horasalida
        END,
        CASE
            WHEN a.horaentrada < dh.horaentrada THEN dh.horaentrada
            ELSE a.horaentrada
        END
    )))) AS horas_laboradas,
    SEC_TO_TIME(SUM(
        CASE
            WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
            ELSE 0
        END
    )) AS horas_extras,
     SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada)))) AS total_horas_trabajadas
FROM colaboradores c
INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
WHERE a.fecha = fecha_consulta
    AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(fecha_consulta, '%W'), 3))
GROUP BY c.idcolaborador, c.nombres, c.apellidos;
END $$*/

DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_diarias(IN fecha_consulta DATE)
BEGIN
    SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        SEC_TO_TIME(SUM(
            CASE
                WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                ELSE 0
            END
        )) AS horas_extras,
        SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada)))) AS total_horas_trabajadas
    FROM colaboradores c
    INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
    INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
    WHERE a.fecha = fecha_consulta
        AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(fecha_consulta, '%W'), 3))
    GROUP BY c.idcolaborador, c.nombres, c.apellidos;
END $$
CALL generar_reporte_horas_extras_diarias('2023-05-18');

-- ---------------------------------------------
-- | PROCEDIMIENTO PARA HORAS EXTRAS SEMANALES |
-- ---------------------------------------------
/* PRUEBA
DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_semanales(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    IF DATEDIFF(fecha_fin, fecha_inicio) = 5 THEN
        SELECT
            c.idcolaborador,
            CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
            a.fecha,
            SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(
                CASE
                    WHEN a.horasalida > dh.horasalida THEN dh.horasalida
                    ELSE a.horasalida
                END,
                CASE
                    WHEN a.horaentrada < dh.horaentrada THEN dh.horaentrada
                    ELSE a.horaentrada
                END
            ))) AS horas_laboradas,
            SEC_TO_TIME(
                CASE
                    WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                    ELSE 0
                END
            ) AS horas_extras,
            SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada))) AS total_horas_trabajadas
        FROM colaboradores c
        INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
        INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
        WHERE a.fecha BETWEEN fecha_inicio AND fecha_fin
            AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
        GROUP BY c.idcolaborador, c.nombres, c.apellidos, a.fecha;
    ELSE
        SELECT 'El rango de fechas debe ser de 5 días' AS mensaje;
    END IF;
END $$
CALL generar_reporte_horas_extras_semanales('2023-05-18', '2023-05-25');*/

/* PRUEBA OPCIONAL
-- PRUEBA OPCIONAL 1
DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_semanales(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    IF DATEDIFF(fecha_fin, fecha_inicio) = 7 THEN
        SELECT
				c.idcolaborador,
            CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
            CONCAT('Semana del ', DATE_FORMAT(fecha_inicio, '%Y-%m-%d'), ' al ', DATE_FORMAT(fecha_fin, '%Y-%m-%d')) AS fecha_semana,
            SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(
                CASE
                    WHEN a.horasalida > dh.horasalida THEN dh.horasalida
                    ELSE a.horasalida
                END,
                CASE
                    WHEN a.horaentrada < dh.horaentrada THEN dh.horaentrada
                    ELSE a.horaentrada
                END
            )))) AS horas_laboradas,
            SEC_TO_TIME(SUM(
                CASE
                    WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                    ELSE 0
                END
            )) AS horas_extras,
            SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada)))) AS total_horas_trabajadas
        FROM colaboradores c
        INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
        INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
        WHERE a.fecha BETWEEN fecha_inicio AND fecha_fin
            AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
        GROUP BY c.idcolaborador, c.nombres, c.apellidos;
    ELSE
        SELECT 'El rango de fechas debe ser de 7 días' AS mensaje;
    END IF;
END $$
CALL generar_reporte_horas_extras_semanales('2023-05-18', '2023-05-25');*/
DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_semanales(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    IF DATEDIFF(fecha_fin, fecha_inicio) = 4 THEN
        SELECT
            c.idcolaborador,
            CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
            SEC_TO_TIME(
                CASE
                    WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                    ELSE 0
                END
            ) AS horas_extras,
            SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada))) AS total_horas_trabajadas
        FROM colaboradores c
        INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
        INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
        WHERE a.fecha BETWEEN fecha_inicio AND fecha_fin
            AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
        GROUP BY c.idcolaborador, c.nombres, c.apellidos;
    ELSE
        SELECT 'El rango de fechas debe ser de 5 días' AS mensaje;
    END IF;
END $$
CALL generar_reporte_horas_extras_semanales('2023-05-15', '2023-05-19');

-- --------------------------------------------
-- |PROCEDIMIENTO PARA HORAS EXTRAS MENSUALES |
-- --------------------------------------------
/* PRUEBA
DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_mensuales(IN year_consulta INT, IN month_consulta INT)
BEGIN
    SET @fecha_consulta = CONCAT(year_consulta, '-', LPAD(month_consulta, 2, '0'), '-01');
    
    SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        a.fecha,
        SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(
            CASE
                WHEN a.horasalida > dh.horasalida THEN dh.horasalida
                ELSE a.horasalida
            END,
            CASE
                WHEN a.horaentrada < dh.horaentrada THEN dh.horaentrada
                ELSE a.horaentrada
            END
        ))) AS horas_laboradas,
        SEC_TO_TIME(
            CASE
                WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                ELSE 0
            END
        ) AS horas_extras,
        SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada))) AS total_horas_trabajadas
    FROM colaboradores c
    INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
    INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
    WHERE MONTH(a.fecha) = month_consulta
        AND YEAR(a.fecha) = year_consulta
        AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
    ORDER BY c.idcolaborador, a.fecha;
END $$
CALL generar_reporte_horas_extras_mensuales(2023,5);*/

 /* PRUEBA
pruebassssssssssssssss 
 SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(
            CASE
                WHEN a.horasalida > dh.horasalida THEN dh.horasalida
                ELSE a.horasalida
            END,
            CASE
                WHEN a.horaentrada < dh.horaentrada THEN dh.horaentrada
                ELSE a.horaentrada
            END
        )))) AS horas_laboradas,
        SEC_TO_TIME(SUM(
            CASE
                WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                ELSE 0
            END
        )) AS horas_extras,
        SEC_TO_TIME(SUM(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada)))) AS total_horas_trabajadas
    FROM colaboradores c
    INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
    INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
    WHERE MONTH(a.fecha) = MONTH('2023-05-30')
        AND YEAR(a.fecha) = YEAR('2023-05-30')
        AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
    GROUP BY c.idcolaborador, c.nombres, c.apellidos;

SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        a.fecha,
        SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(
            CASE
                WHEN a.horasalida > dh.horasalida THEN dh.horasalida
                ELSE a.horasalida
            END,
            CASE
                WHEN a.horaentrada < dh.horaentrada THEN dh.horaentrada
                ELSE a.horaentrada
            END
        ))) AS horas_laboradas,
        SEC_TO_TIME(
            CASE
                WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                ELSE 0
            END
        ) AS horas_extras,
        SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada))) AS total_horas_trabajadas
    FROM colaboradores c
    INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
    INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
    WHERE MONTH(a.fecha) = MONTH('2023-05-30')
        AND YEAR(a.fecha) = YEAR('2023-05-30')
        AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
    ORDER BY c.idcolaborador, a.fecha;*/
DELIMITER $$
CREATE PROCEDURE generar_reporte_horas_extras_mensuales(IN year_consulta INT, IN month_consulta INT)
BEGIN
    SET @fecha_consulta = CONCAT(year_consulta, '-', LPAD(month_consulta, 2, '0'), '-01');
    
    SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        a.fecha,
        SEC_TO_TIME(
            CASE
                WHEN a.horasalida > dh.horasalida THEN TIME_TO_SEC(TIMEDIFF(a.horasalida, dh.horasalida))
                ELSE 0
            END
        ) AS horas_extras,
        SEC_TO_TIME(TIME_TO_SEC(TIMEDIFF(a.horasalida, a.horaentrada))) AS total_horas_trabajadas
    FROM colaboradores c
    INNER JOIN asistencias a ON c.idcolaborador = a.idcolaborador
    INNER JOIN detalle_horarios dh ON c.idcolaborador = dh.idcolaborador
    WHERE MONTH(a.fecha) = month_consulta
        AND YEAR(a.fecha) = year_consulta
        AND dh.diasemana = UPPER(LEFT(DATE_FORMAT(a.fecha, '%W'), 3))
    ORDER BY c.idcolaborador, a.fecha;
END $$
CALL generar_reporte_horas_extras_mensuales(2023, 5);

-- ----------------------------------------------------
-- | PROCEDIMIENTO PARA REPORTE DE AUSENCIAS - DIARIO |
-- ----------------------------------------------------
DELIMITER $$
CREATE PROCEDURE generar_reporte_ausencia_diario(IN fecha_consulta DATE)
BEGIN
   SELECT
    c.idcolaborador,
    CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
    'Ausente' AS estado,
    fecha_consulta AS fecha
FROM colaboradores c
LEFT JOIN asistencias a ON c.idcolaborador = a.idcolaborador AND a.fecha = fecha_consulta
WHERE a.idasistencia IS NULL
ORDER BY c.idcolaborador;

END $$
CALL generar_reporte_ausencia_diario('2023-05-18');

-- -------------------------------------------------------
-- | PROCEDIMIENTO PARA REPORTE DE AUSENCIAS - SEMANALES |
-- -------------------------------------------------------
/*DELIMITER $$
CREATE PROCEDURE generar_reporte_ausencias_semanales(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    IF DATEDIFF(fecha_fin, fecha_inicio) = 7 THEN
        SELECT
            c.idcolaborador,
            CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
            a.fecha
        FROM colaboradores c
        LEFT JOIN asistencias a ON c.idcolaborador = a.idcolaborador AND a.fecha BETWEEN fecha_inicio AND fecha_fin
        WHERE a.idasistencia IS NULL
        GROUP BY c.idcolaborador, c.nombres, c.apellidos, a.fecha;
    ELSE
        SELECT 'El rango de fechas debe ser de 7 días' AS mensaje;
    END IF;
END $$*/


DELIMITER $$
CREATE PROCEDURE generar_reporte_ausencias_semanales(IN fecha_inicio DATE, IN fecha_fin DATE)
BEGIN
    IF DATEDIFF(fecha_fin, fecha_inicio) = 4 THEN
        SELECT
            c.idcolaborador,
            CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
            d.fecha AS fecha_ausencia,
            UPPER(LEFT(DATE_FORMAT(d.fecha, '%W'), 3)) AS dia_semana
        FROM colaboradores c
        CROSS JOIN (
            SELECT fecha_inicio + INTERVAL m DAY AS fecha
            FROM (
                SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4
            ) m
            WHERE fecha_inicio + INTERVAL m DAY BETWEEN fecha_inicio AND fecha_fin
        ) d
        LEFT JOIN asistencias a ON c.idcolaborador = a.idcolaborador AND a.fecha = d.fecha
        WHERE a.idasistencia IS NULL
        GROUP BY c.idcolaborador, c.nombres, c.apellidos, d.fecha;
    ELSE
        SELECT 'El rango de fechas debe ser de 5 días' AS mensaje;
    END IF;
END $$
CALL generar_reporte_ausencias_semanales('2023-05-15', '2023-05-19');

/* PRUEBA 1
DELIMITER $$
CREATE PROCEDURE generar_reporte_ausencias_mensuales(IN year_consulta INT, IN month_consulta INT)
BEGIN
    SET @fecha_consulta = CONCAT(year_consulta, '-', LPAD(month_consulta, 2, '0'), '-01');
    
    SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        d.fecha AS fecha_ausencia,
        UPPER(LEFT(DATE_FORMAT(d.fecha, '%W'), 3)) AS dia_semana
    FROM colaboradores c
    CROSS JOIN (
        SELECT DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY AS fecha
        FROM (
            SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
            SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
            SELECT 10 AS m UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL
            SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL
            SELECT 20 AS m UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL
            SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL
            SELECT 30 AS m UNION ALL SELECT 31
        ) m
        WHERE MONTH(DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY) = month_consulta
    ) d
    LEFT JOIN (
        SELECT idcolaborador, DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_ausencia
        FROM asistencias
    ) a ON c.idcolaborador = a.idcolaborador AND a.fecha_ausencia = d.fecha
    WHERE a.idcolaborador IS NULL
    GROUP BY c.idcolaborador, c.nombres, c.apellidos, d.fecha;
END $$*/


/* PRUEBA 2
DELIMITER $$
CREATE PROCEDURE generar_reporte_ausencias_mensuales(IN year_consulta INT, IN month_consulta INT)
BEGIN
    SET @fecha_consulta = CONCAT(year_consulta, '-', LPAD(month_consulta, 2, '0'), '-01');
    
    SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        d.fecha AS fecha_ausencia,
        UPPER(LEFT(DATE_FORMAT(d.fecha, '%W'), 3)) AS dia_semana
    FROM colaboradores c
    CROSS JOIN (
        SELECT DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY AS fecha
        FROM (
            SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
            SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
            SELECT 10 AS m UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL
            SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL
            SELECT 20 AS m UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL
            SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL
            SELECT 30 AS m UNION ALL SELECT 31
        ) m
        WHERE MONTH(DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY) = month_consulta
            AND WEEKDAY(DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY) < 5 -- Excluir días sábado (5) y domingo (6)
    ) d
    LEFT JOIN (
        SELECT idcolaborador, DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_ausencia
        FROM asistencias
    ) a ON c.idcolaborador = a.idcolaborador AND a.fecha_ausencia = d.fecha
    WHERE a.idcolaborador IS NULL
    GROUP BY c.idcolaborador, c.nombres, c.apellidos, d.fecha;
END $$*/

DELIMITER $$
CREATE PROCEDURE generar_reporte_ausencias_mensuales(IN year_consulta INT, IN month_consulta INT)
BEGIN
    SET @fecha_consulta = CONCAT(year_consulta, '-', LPAD(month_consulta, 2, '0'), '-01');
    
    SELECT
        c.idcolaborador,
        CONCAT(c.nombres, ' ', c.apellidos) AS nombre_colaborador,
        COUNT(d.fecha) AS dias_ausencia
    FROM colaboradores c
    CROSS JOIN (
        SELECT DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY AS fecha
        FROM (
            SELECT 0 AS m UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL
            SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
            SELECT 10 AS m UNION ALL SELECT 11 UNION ALL SELECT 12 UNION ALL SELECT 13 UNION ALL SELECT 14 UNION ALL
            SELECT 15 UNION ALL SELECT 16 UNION ALL SELECT 17 UNION ALL SELECT 18 UNION ALL SELECT 19 UNION ALL
            SELECT 20 AS m UNION ALL SELECT 21 UNION ALL SELECT 22 UNION ALL SELECT 23 UNION ALL SELECT 24 UNION ALL
            SELECT 25 UNION ALL SELECT 26 UNION ALL SELECT 27 UNION ALL SELECT 28 UNION ALL SELECT 29 UNION ALL
            SELECT 30 AS m UNION ALL SELECT 31
        ) m
        WHERE MONTH(DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY) = month_consulta
            AND WEEKDAY(DATE_FORMAT(@fecha_consulta, '%Y-%m-%d') + INTERVAL m DAY) < 5 -- Excluir días sábado (5) y domingo (6)
    ) d
    LEFT JOIN (
        SELECT idcolaborador, DATE_FORMAT(fecha, '%Y-%m-%d') AS fecha_ausencia
        FROM asistencias
    ) a ON c.idcolaborador = a.idcolaborador AND a.fecha_ausencia = d.fecha
    WHERE a.idcolaborador IS NULL
    GROUP BY c.idcolaborador, c.nombres, c.apellidos;
END $$
CALL generar_reporte_ausencias_mensuales(2023, 8);