-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.4.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para ventaspeople
CREATE DATABASE IF NOT EXISTS `ventaspeople` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `ventaspeople`;

-- Volcando estructura para procedimiento ventaspeople.actualizarCliente
DELIMITER //
CREATE PROCEDURE `actualizarCliente`(
 	IN p_idUsuario int(11),
	IN p_nombre varchar(50),
	IN p_primerApellido varchar(50),
	IN p_segundoApellido varchar(50),
	IN p_calle varchar(100),
	IN p_numeroExterior varchar(50),
	IN p_numeroInterior varchar(50),
	IN p_colonia varchar(100),
	IN p_codigoPostal varchar(6),
	IN p_municipio varchar(100),
	IN p_entidadFederativa varchar(50),
	IN p_pais varchar(50),
	IN p_card varchar(150),
	IN p_fecha date
	)
BEGIN
		IF EXISTS (SELECT 1 FROM cliente WHERE idUsuario = p_idUsuario ) THEN
		
			DELETE  FROM cliente WHERE idUsuario = p_idUsuario;
			DELETE  FROM metodos_pago WHERE idUsuario = p_idUsuario;
			
		END IF; 
		
			INSERT INTO cliente (
				idUsuario, nombre, primerApellido, segundoApellido, 
				calle, numeroExterior, numeroInterior, colonia, codigoPostal, municipio, 
				entidadFederativa, pais
			) VALUES (
				p_idUsuario, p_nombre, p_primerApellido, p_segundoApellido,
				p_calle, p_numeroExterior, p_numeroInterior, p_colonia, p_codigoPostal, 
				p_municipio, p_entidadFederativa, p_pais
			);
		
			INSERT INTO metodos_pago (
				idUsuario, cardNumber, fechaExpiracion
			) VALUES (
				p_idUsuario, p_card, p_fecha
			);
	END//
DELIMITER ;

-- Volcando estructura para tabla ventaspeople.canasta
CREATE TABLE IF NOT EXISTS `canasta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `subtotal` decimal(20,6) DEFAULT NULL,
  `iva` decimal(20,6) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),
  `pagado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_id` (`usuario_id`),
  CONSTRAINT `canasta_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta: ~4 rows (aproximadamente)
DELETE FROM `canasta`;
INSERT INTO `canasta` (`id`, `usuario_id`, `subtotal`, `iva`, `total`, `fechaAlta`, `pagado`) VALUES
	(1, 12, 0.000000, 0.000000, 0.000000, '2024-07-27 00:42:02', NULL),
	(2, 13, 0.000000, 0.000000, 0.000000, '2024-07-28 18:13:00', NULL),
	(4, 14, 1034.482764, 165.517236, 1200.000000, '2024-08-05 01:26:42', NULL),
	(5, 15, 0.000000, 0.000000, 0.000000, '2024-08-14 00:30:49', NULL);

-- Volcando estructura para tabla ventaspeople.canasta_productos
CREATE TABLE IF NOT EXISTS `canasta_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_canasta` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `cantidad` int(11) NOT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `etiqueta` varchar(50) DEFAULT NULL,
  `precio` decimal(20,6) DEFAULT NULL,
  `iva` decimal(20,6) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `pagado` bit(1) DEFAULT b'0',
  `fechaAlta` datetime DEFAULT current_timestamp(),
  `porPagar` bit(1) DEFAULT b'0',
  `id_medida` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_canasta_productos_producto` (`id_producto`),
  KEY `fk_canasta_productos_canasta` (`id_canasta`),
  KEY `fk_medida` (`id_medida`),
  CONSTRAINT `fk_canasta_productos_canasta` FOREIGN KEY (`id_canasta`) REFERENCES `canasta` (`id`),
  CONSTRAINT `fk_canasta_productos_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`),
  CONSTRAINT `fk_medida` FOREIGN KEY (`id_medida`) REFERENCES `medida` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta_productos: ~2 rows (aproximadamente)
DELETE FROM `canasta_productos`;
INSERT INTO `canasta_productos` (`id`, `id_canasta`, `id_producto`, `cantidad`, `numero`, `etiqueta`, `precio`, `iva`, `total`, `pagado`, `fechaAlta`, `porPagar`, `id_medida`) VALUES
	(57, 1, 1, 1, NULL, NULL, 86.206897, 13.793103, 100.000000, b'0', '2024-08-01 23:31:39', b'0', 3),
	(58, 1, 1, 1, NULL, NULL, 86.206897, 13.793103, 100.000000, b'0', '2024-08-01 23:32:03', b'0', 3),
	(129, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:18', b'0', 1),
	(130, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:18', b'0', 1),
	(131, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:19', b'0', 1),
	(132, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:19', b'0', 1),
	(133, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:19', b'0', 1),
	(134, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:19', b'0', 1),
	(135, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:19', b'0', 1),
	(136, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:20', b'0', 1),
	(137, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:20', b'0', 1),
	(138, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:30', b'0', 1),
	(139, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:30', b'0', 1),
	(140, 4, 1, 1, '', '', 86.206897, 13.793103, 100.000000, b'0', '2024-08-14 02:13:30', b'0', 1);

-- Volcando estructura para tabla ventaspeople.catalogotramite
CREATE TABLE IF NOT EXISTS `catalogotramite` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `orden` int(11) DEFAULT 0,
  `activo` bit(1) DEFAULT b'1',
  `fechaAlta` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Catalo de tramite';

-- Volcando datos para la tabla ventaspeople.catalogotramite: ~0 rows (aproximadamente)
DELETE FROM `catalogotramite`;

-- Volcando estructura para tabla ventaspeople.cliente
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `primerApellido` varchar(50) DEFAULT NULL,
  `segundoApellido` varchar(50) DEFAULT NULL,
  `Activo` bit(1) DEFAULT b'1',
  `calle` varchar(100) DEFAULT NULL,
  `numeroExterior` varchar(50) DEFAULT NULL,
  `numeroInterior` varchar(50) DEFAULT NULL,
  `colonia` varchar(100) DEFAULT NULL,
  `codigoPostal` varchar(6) DEFAULT NULL,
  `municipio` varchar(100) DEFAULT NULL,
  `entidadFederativa` varchar(50) DEFAULT NULL,
  `pais` varchar(50) DEFAULT NULL,
  `fechaInicio` datetime DEFAULT current_timestamp(),
  `fechaModificacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.cliente: ~3 rows (aproximadamente)
DELETE FROM `cliente`;
INSERT INTO `cliente` (`id`, `idUsuario`, `nombre`, `primerApellido`, `segundoApellido`, `Activo`, `calle`, `numeroExterior`, `numeroInterior`, `colonia`, `codigoPostal`, `municipio`, `entidadFederativa`, `pais`, `fechaInicio`, `fechaModificacion`) VALUES
	(18, 13, 'Sigismund', 'Blanco', 'Alvarez', b'1', 'Felipe', '22', '33', 'Sagitario', '92895', 'Atizapan', 'CDMX', 'Mexico', '2024-08-13 22:50:24', NULL),
	(19, 15, 'Maria de Jesús', 'Torres', 'Garcia', b'1', 'Callesita', '7', '', 'Rolando Mota', '12345', 'Municipio Libre', 'CDMX', 'Mexico', '2024-08-14 00:36:28', NULL),
	(25, 14, 'Saul', 'Torres', 'GARCIA', b'1', 'Carmelo', '220', '', 'Vicente', '55710', 'NEZA', 'CDMX', 'Mexico', '2024-08-14 01:34:58', NULL);

-- Volcando estructura para procedimiento ventaspeople.cnsProductos
DELIMITER //
CREATE PROCEDURE `cnsProductos`(
	IN `ppag` INT,
	IN `prws` INT
)
    READS SQL DATA
BEGIN


SELECT * 
FROM (
  SELECT pp.*, @rownum:=@rownum + 1 AS Fila, round( (Total/rwsPag)+.5 ) pagTotales
  FROM ( 
		   Select prod.*, case prod.estado when 1 then 'Preventa' when 11 then 'Agotado' End as Estatus , r.*
			From producto prod  
			   , ( SELECT @rownum := 0 , @pag:=ppag as numPagina, @rws:=prws as rwsPag
				         , @rtotal := (SELECT count(1) FRom producto p Where activo = 1
											   -- And 1=1
							             ) AS Total ) r  
		   Where activo = 1 
		   -- And 1=1
			Order by descripcion DESC 
		 )  pp
	  ) pagina  
where Fila BETWEEN ((@pag-1)*@rws)+1 AND ((@pag)*@rws);

END//
DELIMITER ;

-- Volcando estructura para tabla ventaspeople.colonia
CREATE TABLE IF NOT EXISTS `colonia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPais` int(11) DEFAULT NULL,
  `idEstado` int(11) DEFAULT NULL,
  `idMunicipio` int(11) DEFAULT NULL,
  `d_codigo` int(11) DEFAULT NULL,
  `d_asenta` varchar(150) DEFAULT NULL,
  `d_tipo_asenta` varchar(150) DEFAULT NULL,
  `d_mnpio` varchar(150) DEFAULT NULL,
  `d_estado` varchar(150) DEFAULT NULL,
  `d_ciudad` varchar(150) DEFAULT NULL,
  `d_CP` varchar(5) DEFAULT NULL,
  `c_oficina` varchar(5) DEFAULT NULL,
  `c_CP` varchar(5) DEFAULT NULL,
  `c_tipo_asenta` varchar(5) DEFAULT NULL,
  `c_mnpio` varchar(5) DEFAULT NULL,
  `id_asenta_cpcons` varchar(5) DEFAULT NULL,
  `d_zona` varchar(50) DEFAULT NULL,
  `c_cve_ciudad` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `idPais_idEstado_idMunicipio_d_asenta` (`idPais`,`idEstado`,`idMunicipio`,`d_asenta`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.colonia: ~0 rows (aproximadamente)
DELETE FROM `colonia`;

-- Volcando estructura para procedimiento ventaspeople.compraCanasta
DELIMITER //
CREATE PROCEDURE `compraCanasta`(
	IN `idSesion` INT
)
    DETERMINISTIC
BEGIN

   INSERT INTO venta (idCliente, fechaPAgo, FormaPAgo, subtotal, iva, total)

	INSERT INTO venta (idCliente, fechaPAgo, FormaPAgo, subtotal, iva, total)
	SELECT c.id, CURRENT_DATE(), 'API-pago', ca.subtotal, ca.iva, ca.total
	FROM canasta ca
	JOIN cliente c ON c.idUsuario = ca.usuario_id
	WHERE ca.usuario_id = (SELECT idUsuario FROM sesion WHERE id = idSesion);

   INSERT INTO ventadetalle (idVenta, idProducto, cantidad, numero, etiqueta, precio, iva, total, fechaAlta, idMedida)

	SELECT LAST_INSERT_ID(), id_producto, cantidad, numero, etiqueta, precio, iva, total, fechaAlta, id_medida
	FROM   canasta_productos 
	WHERE  id_canasta = (Select id FROM canasta WHERE usuario_id = (Select idUsuario FROM sesion WHERE id = idSesion));
	

	DELETE 	
	FROM   canasta_productos 
	WHERE  id_canasta = (Select id FROM canasta WHERE usuario_id = (Select idUsuario FROM sesion WHERE id = idSesion));



END//
DELIMITER ;

-- Volcando estructura para tabla ventaspeople.equipo
CREATE TABLE IF NOT EXISTS `equipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `activo` bit(1) DEFAULT b'0',
  `orden` int(11) NOT NULL DEFAULT 0,
  `fechaAlta` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaModifcacion` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_activo` (`nombre`,`activo`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.equipo: ~12 rows (aproximadamente)
DELETE FROM `equipo`;
INSERT INTO `equipo` (`id`, `nombre`, `activo`, `orden`, `fechaAlta`, `fechaModifcacion`) VALUES
	(1, 'Calvos FC', b'1', 1, '2024-07-15 00:48:05', '2024-07-15 00:48:11'),
	(2, 'Cachorros', b'1', 10, '2024-07-15 00:48:36', '2024-07-15 00:48:37'),
	(3, 'Callejeros', b'1', 3, '2024-07-24 00:11:49', '2024-07-24 08:10:48'),
	(4, 'Ziza FC', b'1', 4, '2024-07-24 00:13:52', '2024-07-24 08:10:48'),
	(5, 'Tanos FC', b'1', 5, '2024-07-24 00:14:10', '2024-07-24 08:10:48'),
	(6, 'Gambeta', b'1', 6, '2024-07-24 00:14:39', '2024-07-24 08:10:48'),
	(7, 'Amor', b'1', 7, '2024-07-24 00:15:26', '2024-07-24 08:10:48'),
	(8, 'Reta FC', b'1', 8, '2024-07-24 00:15:42', '2024-07-24 08:10:48'),
	(9, 'La Gloria FC', b'1', 9, '2024-07-24 00:15:58', '2024-07-24 08:10:48'),
	(10, 'Emperors FC', b'1', 2, '2024-07-24 00:16:33', '2024-07-24 08:10:48'),
	(18, 'La Gloria FC2', b'0', 11, '2024-07-25 19:41:55', '2024-07-25 19:41:51'),
	(19, 'La People\'s', b'1', 0, '2024-07-24 00:29:18', '2024-07-24 00:29:21');

-- Volcando estructura para tabla ventaspeople.estado
CREATE TABLE IF NOT EXISTS `estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idPais` int(11) DEFAULT NULL,
  `Clave` varchar(5) DEFAULT NULL,
  `Siglas` varchar(10) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idPais_Nombre` (`idPais`,`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.estado: ~0 rows (aproximadamente)
DELETE FROM `estado`;

-- Volcando estructura para procedimiento ventaspeople.ingresar_producto_canasta
DELIMITER //
CREATE PROCEDURE `ingresar_producto_canasta`(
	IN `pid_canasta` INT,
	IN `pid_producto` INT,
	IN `pcantidad` INT
)
    DETERMINISTIC
BEGIN

	INSERT INTO canasta_productos (cantidad, id_producto, id_canasta
	        , precio, iva, total) 
	VALUES (pcantidad, pid_producto, pid_canasta
	        , IFNULL(( SELECT precio 	   FROM   Producto	WHERE  id = id_producto), 123)
			  , IFNULL(( SELECT precio*0.16 	FROM   Producto	WHERE  id = id_producto), 123)
			  , IFNULL(( SELECT precio*1.16 	FROM   Producto	WHERE  id = id_producto), 123)
			  );
	
END//
DELIMITER ;

-- Volcando estructura para tabla ventaspeople.jugador
CREATE TABLE IF NOT EXISTS `jugador` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idEquipo` int(11) NOT NULL DEFAULT 0,
  `apodo` varchar(60) DEFAULT NULL,
  `nombre` varchar(60) DEFAULT NULL,
  `numero` varchar(3) DEFAULT NULL,
  `activo` bit(1) DEFAULT b'1',
  `fechaAlta` datetime DEFAULT current_timestamp(),
  `fechaModificacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=208 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.jugador: ~113 rows (aproximadamente)
DELETE FROM `jugador`;
INSERT INTO `jugador` (`id`, `idEquipo`, `apodo`, `nombre`, `numero`, `activo`, `fechaAlta`, `fechaModificacion`) VALUES
	(1, 1, NULL, 'ALBERTO ARMANDO MENDEZ', NULL, b'1', '2024-07-15 00:49:30', '2024-07-15 00:54:28'),
	(2, 1, NULL, 'JOSE EDUARDO MORENO', NULL, b'1', '2024-07-15 00:50:23', '2024-07-15 00:54:31'),
	(3, 1, NULL, 'CESAR GIOVANNY PALACIOS', NULL, b'1', '2024-07-15 00:50:44', '2024-07-15 00:54:32'),
	(4, 2, NULL, 'LUIS DIEGO GOMEZ', NULL, b'1', '2024-07-15 00:54:21', '2024-07-15 00:54:33'),
	(5, 2, NULL, 'RAMON', NULL, b'1', '2024-07-15 00:55:38', '2024-07-15 00:55:45'),
	(6, 1, NULL, 'CESAR GIOVANNY PALACIOS', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(7, 1, NULL, 'JOSE EDUARDO MORENO', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(8, 1, NULL, 'JOHAN MEJORADA', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(9, 1, NULL, 'DIEGo VELAZQUEZ', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(10, 1, NULL, 'BOGAR GUADALUPE MORENO', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(11, 1, NULL, 'ALBERTO ARMANDO MENDEZ', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(12, 1, NULL, 'OSCAR DANIEL PATIÑO', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(13, 1, NULL, 'LUIS MANUEL MAGAÑA', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(14, 1, NULL, 'FERNANDO MORALES', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(15, 2, NULL, 'MOISES', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(16, 2, NULL, 'LUIS DIEGO GOMEZ', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(17, 2, NULL, 'JONATHAN MOYA', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(18, 2, NULL, 'ISAI CALLEJAS', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(19, 2, NULL, 'DIEGO MORENO', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(20, 2, NULL, 'ALEXIS ARATH VALDES', NULL, b'1', '2024-07-15 01:04:55', NULL),
	(115, 7, 'ALAN', 'ALANARENAS', '1', b'1', '2024-08-04 15:21:13', NULL),
	(116, 7, 'SERGIO', 'SERGIOANTUNEZ', '2', b'1', '2024-08-04 15:21:13', NULL),
	(117, 7, 'LUIS', 'LUISJAZIEL', '3', b'1', '2024-08-04 15:21:13', NULL),
	(118, 7, 'DIEGO', 'DIEGOCORDOBA', '4', b'1', '2024-08-04 15:21:13', NULL),
	(119, 7, 'LUIS', 'LUISANGEL', '5', b'1', '2024-08-04 15:21:13', NULL),
	(120, 7, 'FRANCISCO', 'FRANCISCOBECERRIL', '6', b'1', '2024-08-04 15:21:13', NULL),
	(121, 7, 'MARCO', 'MARCOLOPEZ', '7', b'1', '2024-08-04 15:21:13', NULL),
	(122, 7, 'IVAN', 'IVANGIORGANA', '8', b'1', '2024-08-04 15:21:13', NULL),
	(123, 7, 'JOEL', 'JOELNAVARRETE', '9', b'1', '2024-08-04 15:21:13', NULL),
	(124, 7, 'DAVID', 'DAVIDACUNA', '10', b'1', '2024-08-04 15:21:13', NULL),
	(125, 7, 'RODRIGO', 'RODRIGOSANCHEZ', '11', b'1', '2024-08-04 15:21:13', NULL),
	(126, 7, 'RONALDO', 'RONALDOHERRERA', '12', b'1', '2024-08-04 15:21:13', NULL),
	(127, 2, 'DIEGO', 'DIEGOMORENO', '2', b'1', '2024-08-04 15:21:13', NULL),
	(128, 2, 'ALEXIS', 'ALEXISVALDES', '3', b'1', '2024-08-04 15:21:13', NULL),
	(129, 2, 'MOISES', 'MOISESCALVARIO', '6', b'1', '2024-08-04 15:21:13', NULL),
	(130, 2, 'JONATHAN', 'JONATHANMOYA', '7', b'1', '2024-08-04 15:21:13', NULL),
	(131, 2, 'DIEGO', 'DIEGOGOMEZ', '16', b'1', '2024-08-04 15:21:13', NULL),
	(132, 3, 'VICTOR', 'VICTORQUIROZ', '1', b'1', '2024-08-04 15:21:13', NULL),
	(133, 3, 'CESAR', 'CESARALESSANDRO', '7', b'1', '2024-08-04 15:21:13', NULL),
	(134, 3, 'EDDIE', 'EDDIEGABRIEL', '8', b'1', '2024-08-04 15:21:13', NULL),
	(135, 3, 'PABLO', 'PABLOMEDINA', '9', b'1', '2024-08-04 15:21:13', NULL),
	(136, 1, 'BOGAR', 'BOGARMORENO', '1', b'1', '2024-08-04 15:21:13', NULL),
	(137, 1, 'ALBERTO', 'ALBERTOMENDEZ', '2', b'1', '2024-08-04 15:21:13', NULL),
	(138, 1, 'DIEGO', 'DIEGOVELAZQUEZ', '3', b'1', '2024-08-04 15:21:13', NULL),
	(139, 1, 'JOSE', 'JOSEMORENO', '4', b'1', '2024-08-04 15:21:13', NULL),
	(140, 1, 'DANIEL', 'DANIELMARTINEZ', '5', b'1', '2024-08-04 15:21:13', NULL),
	(141, 1, 'CESAR', 'CESARPALACIOS', '7', b'1', '2024-08-04 15:21:13', NULL),
	(142, 1, 'LUIS', 'LUISMAGANA', '9', b'1', '2024-08-04 15:21:13', NULL),
	(143, 10, 'MIGUEL', 'MIGUELBENITEZ', '1', b'1', '2024-08-04 15:21:13', NULL),
	(144, 10, 'GUSTAVO', 'GUSTAVOVARGAS', '2', b'1', '2024-08-04 15:21:13', NULL),
	(145, 10, 'JESUS', 'JESUSSANCHEZ', '3', b'1', '2024-08-04 15:21:13', NULL),
	(146, 10, 'BRANDON', 'BRANDONOCELO', '4', b'1', '2024-08-04 15:21:13', NULL),
	(147, 10, 'CHRISTIAN', 'CHRISTIANLAGUNAS', '5', b'1', '2024-08-04 15:21:13', NULL),
	(148, 10, 'FRANCISCO', 'FRANCISCOSANCHEZ', '6', b'1', '2024-08-04 15:21:13', NULL),
	(149, 10, 'YEUDIEL', 'YEUDIELESCOBEDO', '7', b'1', '2024-08-04 15:21:13', NULL),
	(150, 10, 'BRAYAN', 'BRAYANBARRERA', '8', b'1', '2024-08-04 15:21:13', NULL),
	(151, 10, 'BENJAMIN', 'BENJAMINDE LA CRUZ', '9', b'1', '2024-08-04 15:21:13', NULL),
	(152, 10, 'ALEJANDRO', 'ALEJANDROLOPEZ', '10', b'1', '2024-08-04 15:21:13', NULL),
	(153, 10, 'HUMBERTO', 'HUMBERTOGIL', '11', b'1', '2024-08-04 15:21:13', NULL),
	(154, 6, 'JESUS', 'JESUSMENDEZ', '1', b'1', '2024-08-04 15:21:13', NULL),
	(155, 6, 'KEVIN', 'KEVINGOMEZ', '2', b'1', '2024-08-04 15:21:13', NULL),
	(156, 6, 'JORDAN', 'JORDANMORENO', '3', b'1', '2024-08-04 15:21:13', NULL),
	(157, 6, 'HUGO', 'HUGORODRIGUEZ', '4', b'1', '2024-08-04 15:21:13', NULL),
	(158, 6, 'SALVADOR', 'SALVADORNAVARRO', '5', b'1', '2024-08-04 15:21:13', NULL),
	(159, 6, 'GERARDO', 'GERARDORAMIREZ', '6', b'1', '2024-08-04 15:21:13', NULL),
	(160, 6, 'DIEGO', 'DIEGOCALDERON', '7', b'1', '2024-08-04 15:21:13', NULL),
	(161, 6, 'CHRISTIAN', 'CHRISTIANPACHECO', '8', b'1', '2024-08-04 15:21:13', NULL),
	(162, 6, 'GIOVANNI', 'GIOVANNIRODRIGUEZ', '9', b'1', '2024-08-04 15:21:13', NULL),
	(163, 6, 'JAIR', 'JAIRVERDE', '10', b'1', '2024-08-04 15:21:13', NULL),
	(164, 6, 'ABRAHAM', 'ABRAHAMMORALES', '11', b'1', '2024-08-04 15:21:13', NULL),
	(165, 6, 'GUSTAVO', 'GUSTAVOGUTIERREZ', '12', b'1', '2024-08-04 15:21:13', NULL),
	(166, 9, 'MIXTLI', 'MIXTLICRUZ', '1', b'1', '2024-08-04 15:21:13', NULL),
	(167, 9, 'DIEGO', 'DIEGOCUETO', '2', b'1', '2024-08-04 15:21:13', NULL),
	(168, 9, 'MIGUEL', 'MIGUELBEAS', '3', b'1', '2024-08-04 15:21:13', NULL),
	(169, 9, 'JAIR', 'JAIRVELAZQUEZ', '4', b'1', '2024-08-04 15:21:13', NULL),
	(170, 9, 'DIEGO', 'DIEGOMUNOZ', '5', b'1', '2024-08-04 15:21:13', NULL),
	(171, 9, 'PABLO', 'PABLOQUINTOS', '6', b'1', '2024-08-04 15:21:13', NULL),
	(172, 9, 'ROBERTO', 'ROBERTOHERNANDEZ', '7', b'1', '2024-08-04 15:21:13', NULL),
	(173, 9, 'JONATHAN', 'JONATHANGARDUNO', '8', b'1', '2024-08-04 15:21:13', NULL),
	(174, 9, 'JEANCOB', 'JEANCOBRAMIREZ', '9', b'1', '2024-08-04 15:21:13', NULL),
	(175, 9, 'IVAN', 'IVANMONROY', '10', b'1', '2024-08-04 15:21:13', NULL),
	(176, 9, 'FAUSTO', 'FAUSTOALEMAN', '11', b'1', '2024-08-04 15:21:13', NULL),
	(177, 9, 'MIGUEL', 'MIGUELMORALES', '12', b'1', '2024-08-04 15:21:13', NULL),
	(178, 19, 'GUSTAVO', 'GUSTAVORAMOS', '1', b'1', '2024-08-04 15:21:13', NULL),
	(179, 19, 'CARLOS', 'CARLOSPICHARDO', '3', b'1', '2024-08-04 15:21:13', NULL),
	(180, 19, 'LUIS', 'LUISAMEZOLA', '4', b'1', '2024-08-04 15:21:13', NULL),
	(181, 19, 'LUIS', 'LUISRAMIREZ', '6', b'1', '2024-08-04 15:21:13', NULL),
	(182, 19, 'IRVING', 'IRVINGURBAN', '7', b'1', '2024-08-04 15:21:13', NULL),
	(183, 19, 'DIEGO', 'DIEGOOSWALDO', '8', b'1', '2024-08-04 15:21:13', NULL),
	(184, 19, 'CARLOS', 'CARLOSALBERTO', '10', b'1', '2024-08-04 15:21:13', NULL),
	(185, 19, 'OSCAR', 'OSCARGOMEZ', '11', b'1', '2024-08-04 15:21:13', NULL),
	(186, 19, 'OSCAR', 'OSCARGALLARDO', '12', b'1', '2024-08-04 15:21:13', NULL),
	(187, 5, 'JORGE', 'JORGEGUARNEROS', '2', b'1', '2024-08-04 15:21:13', NULL),
	(188, 5, 'DIEGO', 'DIEGOVILCHIS', '3', b'1', '2024-08-04 15:21:13', NULL),
	(189, 5, 'IAN DE JESUS', 'IAN DE JESUS', '5', b'1', '2024-08-04 15:21:13', NULL),
	(190, 5, 'LUIS', 'LUISCARLOS', '6', b'1', '2024-08-04 15:21:13', NULL),
	(191, 5, 'LUIS', 'LUISROJAS', '7', b'1', '2024-08-04 15:21:13', NULL),
	(192, 5, 'EDER', 'EDERIVAN', '8', b'1', '2024-08-04 15:21:13', NULL),
	(193, 5, 'MARCOS', 'MARCOSBENITES', '9', b'1', '2024-08-04 15:21:13', NULL),
	(194, 5, 'CARLOS', 'CARLOSADRIAN', '10', b'1', '2024-08-04 15:21:13', NULL),
	(195, 5, 'ABEL', 'ABELVEGA', '11', b'1', '2024-08-04 15:21:13', NULL),
	(196, 5, 'MIGUEL', 'MIGUELGIORGANA', '12', b'1', '2024-08-04 15:21:13', NULL),
	(197, 4, 'IVAN', 'IVANDIAZ', '1', b'1', '2024-08-04 15:21:13', NULL),
	(198, 4, 'MARLON', 'MARLONCASTILLO', '2', b'1', '2024-08-04 15:21:13', NULL),
	(199, 4, 'JARED', 'JAREDSANCHEZ', '4', b'1', '2024-08-04 15:21:13', NULL),
	(200, 4, 'GEOVANNI', 'GEOVANNIANGELES', '6', b'1', '2024-08-04 15:21:13', NULL),
	(201, 4, 'ALEXIS', 'ALEXISCASTILLO', '7', b'1', '2024-08-04 15:21:13', NULL),
	(202, 4, 'ERICK', 'ERICKFRAIRE', '8', b'1', '2024-08-04 15:21:13', NULL),
	(203, 4, 'LUIS', 'LUISMONTOYA', '9', b'1', '2024-08-04 15:21:13', NULL),
	(204, 4, 'JOSE', 'JOSECARLOS', '10', b'1', '2024-08-04 15:21:13', NULL),
	(205, 4, 'JOSE', 'JOSEMARIANO', '11', b'1', '2024-08-04 15:21:13', NULL),
	(206, 4, 'CARLOS', 'CARLOSMARTOS', '9', b'1', '2024-08-04 15:21:13', NULL),
	(207, 4, 'JOHAN', 'JOHANMEJORADA', '11', b'1', '2024-08-04 15:21:13', NULL);

-- Volcando estructura para tabla ventaspeople.medida
CREATE TABLE IF NOT EXISTS `medida` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(10) NOT NULL DEFAULT '0',
  `activo` bit(1) NOT NULL DEFAULT b'1',
  `descipcion` varchar(50) NOT NULL DEFAULT '0',
  `fechaAlta` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre_activo` (`nombre`,`activo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Catalogos de medidas';

-- Volcando datos para la tabla ventaspeople.medida: ~6 rows (aproximadamente)
DELETE FROM `medida`;
INSERT INTO `medida` (`id`, `nombre`, `activo`, `descipcion`, `fechaAlta`) VALUES
	(1, 'XS', b'1', 'Extra chica', '2024-07-25 20:39:12'),
	(2, 'S', b'1', 'China', '2024-07-25 20:39:17'),
	(3, 'M', b'1', 'Mediana', '2024-07-25 20:39:28'),
	(4, 'L', b'1', 'Grande', '2024-07-25 20:39:34'),
	(5, 'XL', b'1', 'Extra Grande', '2024-07-25 20:39:39'),
	(7, 'S/M', b'1', 'Sin Medida', '2024-07-25 20:41:52');

-- Volcando estructura para tabla ventaspeople.metodos_pago
CREATE TABLE IF NOT EXISTS `metodos_pago` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `cardNumber` varchar(150) NOT NULL,
  `fechaExpiracion` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`),
  CONSTRAINT `fk_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.metodos_pago: ~2 rows (aproximadamente)
DELETE FROM `metodos_pago`;
INSERT INTO `metodos_pago` (`id`, `idUsuario`, `cardNumber`, `fechaExpiracion`) VALUES
	(13, 13, '5555555555555555', '2026-01-01'),
	(14, 15, '1234 5678 1357 9876', '2026-12-01'),
	(20, 14, '-XXX-XXXX-XXXX-XXXX', '2025-05-01');

-- Volcando estructura para tabla ventaspeople.municipio
CREATE TABLE IF NOT EXISTS `municipio` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idEstado` int(11) DEFAULT NULL,
  `idPais` int(11) DEFAULT NULL,
  `Clave` varchar(5) DEFAULT NULL,
  `Siglas` varchar(10) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idEstado_Nombre` (`idEstado`,`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.municipio: ~0 rows (aproximadamente)
DELETE FROM `municipio`;

-- Volcando estructura para tabla ventaspeople.pais
CREATE TABLE IF NOT EXISTS `pais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Clave` varchar(5) DEFAULT NULL,
  `Siglas` varchar(10) DEFAULT NULL,
  `Nombre` varchar(100) DEFAULT NULL,
  `Orden` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `Nombre` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.pais: ~0 rows (aproximadamente)
DELETE FROM `pais`;

-- Volcando estructura para tabla ventaspeople.playera_personalizada
CREATE TABLE IF NOT EXISTS `playera_personalizada` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `canastapid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_canastap` (`canastapid`),
  CONSTRAINT `fk_canastap` FOREIGN KEY (`canastapid`) REFERENCES `canasta_productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.playera_personalizada: ~0 rows (aproximadamente)
DELETE FROM `playera_personalizada`;

-- Volcando estructura para tabla ventaspeople.producto
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idTipo` int(11) DEFAULT 0,
  `descripcion` varchar(100) NOT NULL,
  `idEquipo` int(11) NOT NULL DEFAULT 0,
  `idJugador` int(11) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL DEFAULT 0.00,
  `stock` int(11) DEFAULT 0,
  `numeroLikes` int(11) DEFAULT 0,
  `estado` int(11) NOT NULL,
  `activo` bit(1) DEFAULT b'1',
  PRIMARY KEY (`id`),
  CONSTRAINT `chk_estado` CHECK (`estado` in (0,1,11))
) ENGINE=InnoDB AUTO_INCREMENT=540 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.producto: ~28 rows (aproximadamente)
DELETE FROM `producto`;
INSERT INTO `producto` (`id`, `idTipo`, `descripcion`, `idEquipo`, `idJugador`, `numero`, `precio`, `stock`, `numeroLikes`, `estado`, `activo`) VALUES
	(1, 9, 'Camiseta Oficial 2024 Juvenil', 7, 1, 1, 100.00, 15, 0, 1, b'1'),
	(2, 9, 'Hummbro Soffball', 6, 2, 2, 150.00, 11, 0, 11, b'1'),
	(3, 6, 'Gorra bordada', 6, 3, 3, 250.00, 20, 0, 0, b'1'),
	(4, 9, 'Pants oficial del cachorros', 5, 4, 4, 100.00, 20, 0, 1, b'1'),
	(5, 9, 'Pants ligero', 5, 5, 5, 100.00, 20, 0, 11, b'1'),
	(6, 9, 'Short oficial', 4, 6, 6, 100.00, 20, 0, 0, b'1'),
	(7, 9, 'Conjunto deportivo', 4, 7, 7, 100.00, 20, 0, 1, b'1'),
	(8, 4, 'Playera Verde', 1, 8, 8, 100.00, 20, 0, 11, b'1'),
	(9, 4, 'Playera Blanca', 1, 9, 9, 100.00, 20, 0, 0, b'1'),
	(10, 4, 'Playera Roja', 3, 10, 1, 100.00, 0, 0, 1, b'1'),
	(11, 2, 'Camiseta Oficial Hombre', 3, 11, 2, 100.00, 20, 0, 11, b'1'),
	(12, 1, 'Camiseta Oficial Mujer', 2, 12, 3, 100.00, 20, 0, 0, b'1'),
	(13, 8, 'Addida torsion', 2, 13, 4, 100.00, 0, 0, 1, b'1'),
	(14, 6, 'Vaso termico ', 0, 14, 5, 100.00, 0, 0, 11, b'1'),
	(15, 9, 'Camiseta Oficial 2024 Juvenil', 0, 15, 6, 100.00, 0, 0, 0, b'1'),
	(16, 8, 'Nike air one', 0, 0, 0, 12345.00, 10, 0, 1, b'1'),
	(17, 5, 'People-Lindro', 0, 0, 0, 123.00, 0, 0, 11, b'1'),
	(529, 9, 'Camiseta Oficial  Amor 2024 Juvenil', 7, 0, 0, 0.01, 1024, 0, 0, b'1'),
	(530, 9, 'Camiseta Oficial  Cachorros 2024 Juvenil', 2, 0, NULL, 0.01, 1024, 0, 1, b'1'),
	(531, 9, 'Camiseta Oficial  Callejeros 2024 Juvenil', 3, 0, NULL, 0.03, 1024, 0, 0, b'1'),
	(532, 9, 'Camiseta Oficial  Calvos FC 2024 Juvenil', 1, 0, NULL, 466.00, 1024, 0, 1, b'1'),
	(533, 9, 'Camiseta Oficial  Emperors FC 2024 Juvenil', 10, 0, NULL, 0.00, 1024, 0, 0, b'1'),
	(534, 9, 'Camiseta Oficial  Gambeta 2024 Juvenil', 6, 0, NULL, 0.00, 1024, 0, 1, b'1'),
	(535, 9, 'Camiseta Oficial  La Gloria FC 2024 Juvenil', 9, 0, NULL, 0.00, 1024, 0, 0, b'1'),
	(536, 9, 'Camiseta Oficial  La Gloria FC2 2024 Juvenil', 18, 0, NULL, 0.00, 1024, 0, 1, b'1'),
	(537, 9, 'Camiseta Oficial  Reta FC 2024 Juvenil', 8, 0, NULL, 0.00, 1024, 0, 0, b'1'),
	(538, 9, 'Camiseta Oficial  Tanos FC 2024 Juvenil', 5, 0, NULL, 0.00, 1024, 0, 1, b'1'),
	(539, 9, 'Camiseta Oficial  Ziza FC 2024 Juvenil', 4, 0, NULL, 0.00, 1024, 0, 0, b'1');

-- Volcando estructura para tabla ventaspeople.productomedidas
CREATE TABLE IF NOT EXISTS `productomedidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProducto` int(11) DEFAULT NULL,
  `idMedida` int(11) DEFAULT NULL,
  `activo` bit(1) DEFAULT b'1',
  `fechaAlta` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `idProducto_idMedida` (`idProducto`,`idMedida`)
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Que medidas Tienen los productos';

-- Volcando datos para la tabla ventaspeople.productomedidas: ~85 rows (aproximadamente)
DELETE FROM `productomedidas`;
INSERT INTO `productomedidas` (`id`, `idProducto`, `idMedida`, `activo`, `fechaAlta`) VALUES
	(1, 1, 1, b'1', '2024-07-25 20:47:25'),
	(2, 1, 2, b'1', '2024-07-25 20:47:25'),
	(3, 1, 3, b'1', '2024-07-25 20:47:25'),
	(4, 1, 4, b'1', '2024-07-25 20:47:25'),
	(5, 1, 5, b'1', '2024-07-25 20:47:25'),
	(6, 2, 1, b'1', '2024-07-25 20:47:25'),
	(7, 2, 2, b'1', '2024-07-25 20:47:25'),
	(8, 2, 3, b'1', '2024-07-25 20:47:25'),
	(9, 2, 4, b'1', '2024-07-25 20:47:25'),
	(10, 2, 5, b'1', '2024-07-25 20:47:25'),
	(11, 3, 1, b'1', '2024-07-25 20:47:25'),
	(12, 3, 2, b'1', '2024-07-25 20:47:25'),
	(13, 3, 3, b'1', '2024-07-25 20:47:25'),
	(14, 3, 4, b'1', '2024-07-25 20:47:25'),
	(15, 3, 5, b'1', '2024-07-25 20:47:25'),
	(16, 4, 1, b'1', '2024-07-25 20:47:25'),
	(17, 4, 2, b'1', '2024-07-25 20:47:25'),
	(18, 4, 3, b'1', '2024-07-25 20:47:25'),
	(19, 4, 4, b'1', '2024-07-25 20:47:25'),
	(20, 4, 5, b'1', '2024-07-25 20:47:25'),
	(21, 5, 1, b'1', '2024-07-25 20:47:25'),
	(22, 5, 2, b'1', '2024-07-25 20:47:25'),
	(23, 5, 3, b'1', '2024-07-25 20:47:25'),
	(24, 5, 4, b'1', '2024-07-25 20:47:25'),
	(25, 5, 5, b'1', '2024-07-25 20:47:25'),
	(26, 6, 1, b'1', '2024-07-25 20:47:25'),
	(27, 6, 2, b'1', '2024-07-25 20:47:25'),
	(28, 6, 3, b'1', '2024-07-25 20:47:25'),
	(29, 6, 4, b'1', '2024-07-25 20:47:25'),
	(30, 6, 5, b'1', '2024-07-25 20:47:25'),
	(31, 7, 1, b'1', '2024-07-25 20:47:25'),
	(32, 7, 2, b'1', '2024-07-25 20:47:25'),
	(33, 7, 3, b'1', '2024-07-25 20:47:25'),
	(34, 7, 4, b'1', '2024-07-25 20:47:25'),
	(35, 7, 5, b'1', '2024-07-25 20:47:25'),
	(36, 8, 1, b'1', '2024-07-25 20:47:25'),
	(37, 8, 2, b'1', '2024-07-25 20:47:25'),
	(38, 8, 3, b'1', '2024-07-25 20:47:25'),
	(39, 8, 4, b'1', '2024-07-25 20:47:25'),
	(40, 8, 5, b'1', '2024-07-25 20:47:25'),
	(41, 9, 1, b'1', '2024-07-25 20:47:25'),
	(42, 9, 2, b'1', '2024-07-25 20:47:25'),
	(43, 9, 3, b'1', '2024-07-25 20:47:25'),
	(44, 9, 4, b'1', '2024-07-25 20:47:25'),
	(45, 9, 5, b'1', '2024-07-25 20:47:25'),
	(46, 10, 1, b'1', '2024-07-25 20:47:25'),
	(47, 10, 2, b'1', '2024-07-25 20:47:25'),
	(48, 10, 3, b'1', '2024-07-25 20:47:25'),
	(49, 10, 4, b'1', '2024-07-25 20:47:25'),
	(50, 10, 5, b'1', '2024-07-25 20:47:25'),
	(51, 11, 1, b'1', '2024-07-25 20:47:25'),
	(52, 11, 2, b'1', '2024-07-25 20:47:25'),
	(53, 11, 3, b'1', '2024-07-25 20:47:25'),
	(54, 11, 4, b'1', '2024-07-25 20:47:25'),
	(55, 11, 5, b'1', '2024-07-25 20:47:25'),
	(56, 12, 1, b'1', '2024-07-25 20:47:25'),
	(57, 12, 2, b'1', '2024-07-25 20:47:25'),
	(58, 12, 3, b'1', '2024-07-25 20:47:25'),
	(59, 12, 4, b'1', '2024-07-25 20:47:25'),
	(60, 12, 5, b'1', '2024-07-25 20:47:25'),
	(61, 13, 1, b'1', '2024-07-25 20:47:25'),
	(62, 13, 2, b'1', '2024-07-25 20:47:25'),
	(63, 13, 3, b'1', '2024-07-25 20:47:25'),
	(64, 13, 4, b'1', '2024-07-25 20:47:25'),
	(65, 13, 5, b'1', '2024-07-25 20:47:25'),
	(66, 14, 1, b'1', '2024-07-25 20:47:25'),
	(67, 14, 2, b'1', '2024-07-25 20:47:25'),
	(68, 14, 3, b'1', '2024-07-25 20:47:25'),
	(69, 14, 4, b'1', '2024-07-25 20:47:25'),
	(70, 14, 5, b'1', '2024-07-25 20:47:25'),
	(71, 15, 1, b'1', '2024-07-25 20:47:25'),
	(72, 15, 2, b'1', '2024-07-25 20:47:25'),
	(73, 15, 3, b'1', '2024-07-25 20:47:25'),
	(74, 15, 4, b'1', '2024-07-25 20:47:25'),
	(75, 15, 5, b'1', '2024-07-25 20:47:25'),
	(76, 16, 1, b'1', '2024-07-25 20:47:25'),
	(77, 16, 2, b'1', '2024-07-25 20:47:25'),
	(78, 16, 3, b'1', '2024-07-25 20:47:25'),
	(79, 16, 4, b'1', '2024-07-25 20:47:25'),
	(80, 16, 5, b'1', '2024-07-25 20:47:25'),
	(81, 17, 1, b'1', '2024-07-25 20:47:25'),
	(82, 17, 2, b'1', '2024-07-25 20:47:25'),
	(83, 17, 3, b'1', '2024-07-25 20:47:25'),
	(84, 17, 4, b'1', '2024-07-25 20:47:25'),
	(85, 17, 5, b'1', '2024-07-25 20:47:25');

-- Volcando estructura para tabla ventaspeople.productousuario
CREATE TABLE IF NOT EXISTS `productousuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idProducto` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `like` bit(1) DEFAULT b'1',
  PRIMARY KEY (`idProducto`,`idUsuario`),
  KEY `id` (`id`),
  KEY `fk_producto_like` (`idProducto`),
  KEY `fk_usuario_like` (`idUsuario`),
  CONSTRAINT `fk_producto_like` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`id`),
  CONSTRAINT `fk_usuario_like` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.productousuario: ~10 rows (aproximadamente)
DELETE FROM `productousuario`;
INSERT INTO `productousuario` (`id`, `idProducto`, `idUsuario`, `fecha`, `like`) VALUES
	(27, 1, 14, '2024-08-12 13:13:53', b'1'),
	(37, 2, 14, '2024-08-12 18:07:34', b'1'),
	(6, 4, 12, '2024-07-28 22:19:13', b'1'),
	(7, 5, 12, '2024-07-29 22:36:31', b'1'),
	(40, 14, 14, '2024-08-12 18:09:22', b'1'),
	(15, 16, 14, '2024-08-04 16:21:48', b'1'),
	(29, 533, 14, '2024-08-12 18:05:03', b'1'),
	(30, 535, 14, '2024-08-12 18:05:15', b'1'),
	(39, 536, 14, '2024-08-12 18:07:53', b'1'),
	(43, 537, 14, '2024-08-12 18:09:42', b'1');

-- Volcando estructura para procedimiento ventaspeople.registraLike
DELIMITER //
CREATE PROCEDURE `registraLike`(
	IN `p_usuario` INT,
	IN `p_producto` INT,
	IN `p_like` BIT
)
BEGIN

	DECLARE rowsNum INT;
	-- DECLARE p_usuario INT;	
	-- SELECT s.idUsuario into p_usuario FROM sesion s WHERE s.cerrado = 0 And s.id = p_sesion AND s.horaTermino IS null;
	
if p_like IS NOT NULL then
 	UPDATE productousuario SET `like` = case when p_like=1 then 1 ELSE 0 end WHERE idUsuario = p_usuario AND idProducto = p_producto;
 	
 	IF (SELECT COUNT(1) FROM productousuario WHERE idUsuario = p_usuario AND idProducto = p_producto) < 1 THEN 
 	
	 	INSERT INTO productousuario (idUsuario, idProducto, `like`) VALUES (p_usuario, p_producto, 1);
 	
	END IF;
END IF;

 	SELECT *
	 FROM  productousuario 
	 WHERE idUsuario = p_usuario AND idProducto = p_producto;

END//
DELIMITER ;

-- Volcando estructura para tabla ventaspeople.sesion
CREATE TABLE IF NOT EXISTS `sesion` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `fecha` date DEFAULT current_timestamp(),
  `horaInicio` datetime DEFAULT current_timestamp(),
  `horaTermino` datetime DEFAULT NULL,
  `IP` varchar(50) DEFAULT NULL,
  `navegador` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idUsuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.sesion: ~52 rows (aproximadamente)
DELETE FROM `sesion`;
INSERT INTO `sesion` (`id`, `idUsuario`, `fecha`, `horaInicio`, `horaTermino`, `IP`, `navegador`) VALUES
	(13, 12, '2024-07-27', '2024-07-27 17:28:23', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(14, 12, '2024-07-27', '2024-07-27 17:32:24', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(15, 12, '2024-07-27', '2024-07-27 17:32:47', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(16, 12, '2024-07-27', '2024-07-27 17:34:06', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(17, 12, '2024-07-27', '2024-07-27 17:35:12', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(18, 12, '2024-07-27', '2024-07-27 17:53:35', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(19, 12, '2024-07-27', '2024-07-27 17:54:41', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(20, 12, '2024-07-27', '2024-07-27 17:55:15', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(21, 12, '2024-07-27', '2024-07-27 17:55:33', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(22, 12, '2024-07-27', '2024-07-27 17:55:53', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(23, 12, '2024-07-27', '2024-07-27 17:56:02', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(24, 12, '2024-07-27', '2024-07-27 17:56:29', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(25, 12, '2024-07-27', '2024-07-27 17:57:21', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(26, 12, '2024-07-27', '2024-07-27 17:58:04', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(27, 12, '2024-07-27', '2024-07-27 17:58:41', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(28, 12, '2024-07-27', '2024-07-27 17:59:25', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(29, 12, '2024-07-27', '2024-07-27 18:00:18', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(30, 12, '2024-07-27', '2024-07-27 18:00:45', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(31, 12, '2024-07-27', '2024-07-27 18:01:19', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(32, 12, '2024-07-27', '2024-07-27 18:02:02', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(33, 12, '2024-07-27', '2024-07-27 18:02:56', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(34, 12, '2024-07-27', '2024-07-27 18:04:13', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(35, 12, '2024-07-27', '2024-07-27 18:04:52', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(36, 12, '2024-07-27', '2024-07-27 18:05:27', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(37, 12, '2024-07-27', '2024-07-27 18:06:12', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(38, 12, '2024-07-27', '2024-07-27 18:07:04', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(39, 12, '2024-07-27', '2024-07-27 18:07:16', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(40, 12, '2024-07-27', '2024-07-27 18:07:54', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(41, 12, '2024-07-27', '2024-07-27 18:08:15', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(42, 12, '2024-07-27', '2024-07-27 18:09:56', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(43, 12, '2024-07-27', '2024-07-27 18:15:41', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(44, 12, '2024-07-27', '2024-07-27 18:16:07', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(45, 12, '2024-07-27', '2024-07-27 18:31:13', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(46, 12, '2024-07-27', '2024-07-27 18:31:24', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(47, 12, '2024-07-27', '2024-07-27 18:31:40', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(48, 12, '2024-07-27', '2024-07-27 18:32:01', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(49, 12, '2024-07-27', '2024-07-27 18:34:44', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(50, 12, '2024-07-27', '2024-07-27 18:53:41', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(51, 13, '2024-07-28', '2024-07-28 18:13:24', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(52, 12, '2024-07-28', '2024-07-28 19:03:09', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(53, 12, '2024-08-02', '2024-08-02 14:18:58', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(54, 12, '2024-08-02', '2024-08-02 14:42:22', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(55, 14, '2024-08-02', '2024-08-02 18:22:41', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(56, 14, '2024-08-02', '2024-08-02 18:41:30', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(57, 14, '2024-08-02', '2024-08-02 18:52:49', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(58, 14, '2024-08-04', '2024-08-04 12:23:54', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(59, 14, '2024-08-04', '2024-08-04 12:39:49', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(60, 14, '2024-08-04', '2024-08-04 20:48:02', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(61, 12, '2024-08-13', '2024-08-13 20:44:21', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(62, 13, '2024-08-13', '2024-08-13 20:46:08', NULL, NULL, 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36'),
	(63, 14, '2024-08-14', '2024-08-14 00:15:15', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(64, 15, '2024-08-14', '2024-08-14 00:30:58', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(65, 14, '2024-08-14', '2024-08-14 01:30:19', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(66, 14, '2024-08-14', '2024-08-14 02:12:18', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(67, 14, '2024-08-14', '2024-08-14 02:12:41', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36');

-- Volcando estructura para tabla ventaspeople.tipoproducto
CREATE TABLE IF NOT EXISTS `tipoproducto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `activo` bit(1) NOT NULL DEFAULT b'1',
  `Orden` int(11) NOT NULL DEFAULT 0,
  `fechaAlta` datetime NOT NULL DEFAULT current_timestamp(),
  `fechaModificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Categorias de Producto';

-- Volcando datos para la tabla ventaspeople.tipoproducto: ~9 rows (aproximadamente)
DELETE FROM `tipoproducto`;
INSERT INTO `tipoproducto` (`id`, `nombre`, `activo`, `Orden`, `fechaAlta`, `fechaModificacion`) VALUES
	(1, 'Camiseta Oficial (M)', b'1', 1, '2024-07-25 19:56:47', NULL),
	(2, 'Camiseta Oficial (H)', b'1', 2, '2024-07-25 19:57:10', NULL),
	(3, 'T-Shirt', b'1', 3, '2024-07-25 19:57:25', NULL),
	(4, 'Sweater', b'1', 4, '2024-07-25 19:57:40', NULL),
	(5, 'Termo', b'1', 5, '2024-07-25 19:57:55', NULL),
	(6, 'Taza', b'1', 6, '2024-07-25 19:58:05', NULL),
	(7, 'Gorra', b'1', 7, '2024-07-25 19:58:19', NULL),
	(8, 'Tennis', b'1', 8, '2024-07-25 19:58:32', NULL),
	(9, 'Camiseta Oficial Juvenil', b'1', 0, '2024-07-25 20:07:50', NULL);

-- Volcando estructura para tabla ventaspeople.tokens
CREATE TABLE IF NOT EXISTS `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `sesionid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `fk_sesion` (`sesionid`),
  CONSTRAINT `fk_sesion` FOREIGN KEY (`sesionid`) REFERENCES `sesion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.tokens: ~23 rows (aproximadamente)
DELETE FROM `tokens`;
INSERT INTO `tokens` (`id`, `token`, `sesionid`) VALUES
	(1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNTM5NiwiZXhwIjoxNzIyMTI4OTk2fQ.bPICvYd0AhpEutiYddTnI2yYSDpS7nW8KSBbN8_46s4', 42),
	(2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNTc0MSwiZXhwIjoxNzIyMTI5MzQxfQ.VZgTpuOn5njqeWA9drO1G2wy_q8Yl8NAqZhLkWkh7_0', 43),
	(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNTc2NywiZXhwIjoxNzIyMTI5MzY3fQ.4-KSXmRK3FFmHkMvZCZniVchyPKsUMCMpduLj3S7ivQ', 44),
	(4, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNjY3MywiZXhwIjoxNzIyMTMwMjczfQ.UWtqWL9Yi2VJ1XFrEzUteEMv_ckKGY_YIelwglnAjnM', 45),
	(5, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNjY4NCwiZXhwIjoxNzIyMTMwMjg0fQ.V02B_JiGjkNwtVyorh5AiIm5qNRSW-XJnA3uj4ejCv4', 46),
	(6, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNjcwMCwiZXhwIjoxNzIyMTMwMzAwfQ.fM6deeOV3Nbf_33d1dbI3Y7RIWiDUEc92RJ593hywMg', 47),
	(7, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNjcyMSwiZXhwIjoxNzIyMTMwMzIxfQ.4p04SLKjXPxgV5-LyO6R9ZhfE-PTPryfVdc-a-frkxo', 48),
	(8, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyNjg4NCwiZXhwIjoxNzIyMTMwNDg0fQ.a_ZVz-bI5dWUSCR5dAB7jDAQhSBAYXNI1gopH31wqhA', 49),
	(9, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjEyODAyMSwiZXhwIjoxNzIyMTMxNjIxfQ.ElW3Pl4evN-az8D6PG2Z2A9g7UUfglSg9Kxsi34fotc', 50),
	(10, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoyLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjIxMjAwNCwiZXhwIjoxNzIyMjE1NjA0fQ.SKi2lqXz7OjgrrxFcGnrWulOwWao7P7D-WgjmcUu460', 51),
	(11, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjIxNDk4OSwiZXhwIjoxNzIyMjE4NTg5fQ.9PGAfr_Y-y3s1Gux3x54oJ21ArQyra2EsXjwK1QPS9Q', 52),
	(12, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjYyOTkzOCwiZXhwIjoxNzIyNjMzNTM4fQ.pbdoSvQpFebTeYVYpxHaStWzgrLSkp2Z5DoaYdIQhgs', 53),
	(13, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMjYzMTM0MiwiZXhwIjoxNzIyNjM0OTQyfQ.5iNw8uYDNi-DheJOmGeB2YZdTB27xhIBoeiyNdpWYWE', 54),
	(14, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyNjQ0NTYxLCJleHAiOjE3MjI2NDgxNjF9.dWGdomYX4ij-E31S45-01ykdVSrEnGQJ8DqQ4q4QVXc', 55),
	(15, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyNjQ1NjkwLCJleHAiOjE3MjI2NDkyOTB9.ffPzoOJ7p5njnEp-v7oO7OoRyn3nZai-wO7gbg5cjJU', 56),
	(16, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyNjQ2MzY5LCJleHAiOjE3MjI2NDk5Njl9.v1JZBr2P7tjtHjriWxxfdf9wXDTRlP3mOHyYl_lXGZE', 57),
	(17, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyNzk1ODM0LCJleHAiOjE3MjI3OTk0MzR9.Cdn3tTM5a9VCvJkeiTP2h91Krfs0z0pNRG_KkHxQrPc', 58),
	(18, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyNzk2Nzg5LCJleHAiOjE3MjI4MDAzODl9.SRFTypnBwHhxWpIvjVHayRvUOKhtCarGoMNWxOsmuhw', 59),
	(19, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyODI2MDgyLCJleHAiOjE3MjI4Mjk2ODJ9.xLA3NrIo_AEBH32XIqo4lIGgi48_bHcSTCW-Cp8EBPA', 60),
	(20, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEyLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoxLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMzYwMzQ2MSwiZXhwIjoxNzIzNjA3MDYxfQ.CRJUh7thDO3g145yJl0GqhkoHGmeODWGC3hnqXv418E', 61),
	(21, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEzLCJ1c2VyTmFtZSI6IlNhbmdyYWVsIiwiY2FuYXN0YUlkIjoyLCJwZXBlIjoicGVwZSIsImlhdCI6MTcyMzYwMzU2OCwiZXhwIjoxNzIzNjA3MTY4fQ.3DHiA0seHxb6TVQXDPfjyyTtWekvw2XVD_S57WoVOJg', 62),
	(22, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjQsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIzNjE2MTE1LCJleHAiOjE3MjM2MTk3MTV9.oNFZ_eSdTiq1EZY1KBybGz0-Iqak75S70jZZNmT2TBo', 63),
	(23, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE1LCJ1c2VyTmFtZSI6Im1hamVzdXMiLCJjYW5hc3RhSWQiOjUsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIzNjE3MDU4LCJleHAiOjE3MjM2MjA2NTh9.cxrGXx2wT2Idfp7BUdn2U59qMYkrUglcPtZG47_Jy0A', 64),
	(24, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjQsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIzNjIwNjE5LCJleHAiOjE3MjM2MjQyMTl9.BsxuqUaUYMz8-EASQ8e7JNw9eq4COUZ2bqKDpXoXfyA', 65),
	(25, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjQsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIzNjIzMTM4LCJleHAiOjE3MjM2MjY3Mzh9.NwuWhGWrGs9ZBkBE82uj8_L5Dz70NmymKRicd6K-nUA', 66),
	(26, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjQsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIzNjIzMTYxLCJleHAiOjE3MjM2MjY3NjF9.LFvSeUJnrCxkSgubLvF2kuzPorrFZHwLR0moGna_apI', 67);

-- Volcando estructura para tabla ventaspeople.usuario
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `Activo` bit(1) NOT NULL DEFAULT b'1',
  `Nombres` varchar(150) NOT NULL DEFAULT '',
  `ApellidoPrimero` varchar(150) NOT NULL DEFAULT '',
  `ApellidoSegundo` varchar(150) NOT NULL DEFAULT '',
  `fechaNacimiento` date DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),
  `fechaModificacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `role` varchar(100) NOT NULL DEFAULT 'cliente',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.usuario: ~4 rows (aproximadamente)
DELETE FROM `usuario`;
INSERT INTO `usuario` (`id`, `name`, `email`, `password`, `Activo`, `Nombres`, `ApellidoPrimero`, `ApellidoSegundo`, `fechaNacimiento`, `fechaAlta`, `fechaModificacion`, `role`) VALUES
	(12, 'Sangrael', 'angeltorralva@hotmail.com', '$2a$10$TuLImkkLuGdKZtvzxUCLj.yDmLO6WDd118rEk0UKd.90iZKlwfcui', b'1', 'Angel', 'Torres', 'Alvarez', '2003-01-01', '2024-07-27 00:42:02', NULL, 'cliente'),
	(13, 'Sangrael', 'torres.alvarez.angel18@gmail.com', '$2a$10$h9Gl.LpcmWhZl6NfnmrmlOOTRkZz65dZb/4.4oH3FBegwLV8jUs3.', b'1', 'Angel', 'Torres', 'Alvarez', '2003-03-03', '2024-07-28 18:13:00', NULL, 'cliente'),
	(14, 'storres', 'saultorresg@gmail.com', '$2a$10$Zly7cdgPGZ96MDTeQiPAquRFFqH6BDyYNCXQMjKK8X2wUfKcTvI0q', b'1', 'Saul', 'Torres', 'García', '1993-02-01', '2024-08-02 18:22:35', NULL, 'cliente'),
	(15, 'majesus', 'matoga@hotmail.com', '$2a$10$07waXcFy8BvweEF/yUOoh.hU12JlenyVVBhOKCk7XHazoXGKUWJiu', b'1', 'Maria', 'de', 'Jesus', '1998-04-02', '2024-08-14 00:30:49', NULL, 'cliente');

-- Volcando estructura para tabla ventaspeople.venta
CREATE TABLE IF NOT EXISTS `venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `fechaPago` datetime NOT NULL DEFAULT current_timestamp(),
  `formaPago` varchar(50) DEFAULT NULL,
  `Subtotal` decimal(20,6) NOT NULL,
  `IVA` decimal(20,6) DEFAULT NULL,
  `Total` decimal(20,6) NOT NULL,
  `noPedido` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Acumulado de la venta';

-- Volcando datos para la tabla ventaspeople.venta: ~14 rows (aproximadamente)
DELETE FROM `venta`;
INSERT INTO `venta` (`id`, `idCliente`, `fechaPago`, `formaPago`, `Subtotal`, `IVA`, `Total`, `noPedido`) VALUES
	(1, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(2, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(3, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(4, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(5, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(6, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(7, 1, '2024-08-05 00:00:00', 'API-pago', 732.758622, 117.241378, 850.000000, NULL),
	(8, 1, '2024-08-05 00:00:00', 'API-pago', 86.206897, 13.793103, 100.000000, NULL),
	(9, 1, '2024-08-05 00:00:00', 'API-pago', 172.413794, 27.586206, 200.000000, NULL),
	(10, 1, '2024-08-05 00:00:00', 'API-pago', 172.413794, 27.586206, 200.000000, NULL),
	(11, 1, '2024-08-05 00:00:00', 'API-pago', 172.413794, 27.586206, 200.000000, NULL),
	(12, 1, '2024-08-05 00:00:00', 'API-pago', 172.413794, 27.586206, 200.000000, NULL),
	(13, 1, '2024-08-05 00:00:00', 'API-pago', 172.413794, 27.586206, 200.000000, NULL),
	(14, 1, '2024-08-05 00:00:00', 'API-pago', 258.620691, 41.379309, 300.000000, NULL);

-- Volcando estructura para tabla ventaspeople.ventadetalle
CREATE TABLE IF NOT EXISTS `ventadetalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVenta` int(11) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `cantidad` int(11) DEFAULT 1,
  `numero` varchar(50) DEFAULT NULL,
  `etiqueta` varchar(50) DEFAULT NULL,
  `precio` decimal(20,6) DEFAULT NULL,
  `iva` decimal(20,6) DEFAULT NULL,
  `descuento` decimal(20,6) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `estadoEnvio` int(11) DEFAULT NULL,
  `fechaAlta` datetime DEFAULT NULL,
  `idMedida` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Listado de articulos a cobrar';

-- Volcando datos para la tabla ventaspeople.ventadetalle: ~38 rows (aproximadamente)
DELETE FROM `ventadetalle`;
INSERT INTO `ventadetalle` (`id`, `idVenta`, `idProducto`, `cantidad`, `numero`, `etiqueta`, `precio`, `iva`, `descuento`, `total`, `estadoEnvio`, `fechaAlta`, `idMedida`) VALUES
	(1, 4, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-02 18:24:01', 4),
	(2, 4, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-04 17:15:39', 1),
	(3, 4, 3, 1, NULL, NULL, 215.517241, 34.482759, NULL, 250.000000, NULL, '2024-08-05 01:02:54', 1),
	(4, 4, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-05 01:09:32', 1),
	(5, 4, 4, 2, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:10:06', 4),
	(6, 4, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:12:05', 1),
	(8, 5, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-02 18:24:01', 4),
	(9, 5, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-04 17:15:39', 1),
	(10, 5, 3, 1, NULL, NULL, 215.517241, 34.482759, NULL, 250.000000, NULL, '2024-08-05 01:02:54', 1),
	(11, 5, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-05 01:09:32', 1),
	(12, 5, 4, 2, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:10:06', 4),
	(13, 5, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:12:05', 1),
	(15, 6, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-02 18:24:01', 4),
	(16, 6, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-04 17:15:39', 1),
	(17, 6, 3, 1, NULL, NULL, 215.517241, 34.482759, NULL, 250.000000, NULL, '2024-08-05 01:02:54', 1),
	(18, 6, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-05 01:09:32', 1),
	(19, 6, 4, 2, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:10:06', 4),
	(20, 6, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:12:05', 1),
	(22, 7, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-02 18:24:01', 4),
	(23, 7, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-04 17:15:39', 1),
	(24, 7, 3, 1, NULL, NULL, 215.517241, 34.482759, NULL, 250.000000, NULL, '2024-08-05 01:02:54', 1),
	(25, 7, 2, 1, NULL, NULL, 129.310345, 20.689655, NULL, 150.000000, NULL, '2024-08-05 01:09:32', 1),
	(26, 7, 4, 2, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:10:06', 4),
	(27, 7, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:12:05', 1),
	(29, 8, 11, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:27:23', 1),
	(30, 9, 11, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:27:23', 1),
	(31, 9, 10, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:31:10', 1),
	(33, 10, 11, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:27:23', 1),
	(34, 10, 10, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:31:10', 1),
	(36, 11, 11, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:27:23', 1),
	(37, 11, 10, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:31:10', 1),
	(39, 12, 11, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:27:23', 1),
	(40, 12, 10, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:31:10', 1),
	(42, 13, 11, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:27:23', 1),
	(43, 13, 10, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:31:10', 1),
	(45, 14, 1, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:46:47', 1),
	(46, 14, 5, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:46:50', 1),
	(47, 14, 4, 1, NULL, NULL, 86.206897, 13.793103, NULL, 100.000000, NULL, '2024-08-05 01:46:52', 1);

-- Volcando estructura para disparador ventaspeople.canasta_productos_before_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `canasta_productos_before_delete` AFTER DELETE ON `canasta_productos` FOR EACH ROW BEGIN

	UPDATE canasta 
	SET subtotal = IFNULL((SELECT sum(precio)   FROM canasta_productos WHERE id_canasta = OLD.id_canasta),0)
	   , iva     = IFNULL((SELECT sum(iva)      FROM canasta_productos WHERE id_canasta = OLD.id_canasta),0)
	   , total   = IFNULL((SELECT sum(total)    FROM canasta_productos WHERE id_canasta = OLD.id_canasta),0)
	WHERE  id = OLD.id_canasta;
	
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ventaspeople.canasta_productos_before_insert
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `canasta_productos_before_insert` AFTER INSERT ON `canasta_productos` FOR EACH ROW BEGIN

	UPDATE canasta 
	SET subtotal = (SELECT sum(precio) FROM canasta_productos WHERE id_canasta = NEW.id_canasta)
	   , iva     = (SELECT sum(iva)      FROM canasta_productos WHERE id_canasta = NEW.id_canasta)
	   , total   = (SELECT sum(total)    FROM canasta_productos WHERE id_canasta = NEW.id_canasta)
	WHERE  id = NEW.id_canasta;

END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Volcando estructura para disparador ventaspeople.crear_canasta_usuario
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='IGNORE_SPACE,STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER crear_canasta_usuario
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO canasta (usuario_id, subtotal, iva, total)
    VALUES (NEW.id, 0.00, 0.00, 0.00);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
