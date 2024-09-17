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
DROP DATABASE IF EXISTS `ventaspeople`;
CREATE DATABASE IF NOT EXISTS `ventaspeople` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `ventaspeople`;

-- Volcando estructura para tabla ventaspeople.canasta
DROP TABLE IF EXISTS `canasta`;
CREATE TABLE IF NOT EXISTS `canasta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuario_id` int(11) NOT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `iva` decimal(10,2) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `client_id` (`usuario_id`),
  CONSTRAINT `canasta_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta: ~3 rows (aproximadamente)
DELETE FROM `canasta`;
INSERT INTO `canasta` (`id`, `usuario_id`, `subtotal`, `iva`, `total`, `fechaAlta`) VALUES
	(1, 12, 0.00, 0.00, 0.000000, '2024-07-27 00:42:02'),
	(2, 13, 0.00, 0.00, 0.000000, '2024-07-28 18:13:00'),
	(3, 14, 0.00, 0.00, 0.000000, '2024-08-02 18:22:35');

-- Volcando estructura para tabla ventaspeople.canasta_productos
DROP TABLE IF EXISTS `canasta_productos`;
CREATE TABLE IF NOT EXISTS `canasta_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto` int(11) DEFAULT NULL,
  `id_canasta` int(11) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta_productos: ~5 rows (aproximadamente)
DELETE FROM `canasta_productos`;
INSERT INTO `canasta_productos` (`id`, `id_producto`, `id_canasta`, `cantidad`, `numero`, `etiqueta`, `precio`, `iva`, `total`, `pagado`, `fechaAlta`, `porPagar`, `id_medida`) VALUES
	(57, 1, 1, 1, NULL, NULL, 86.206897, 13.793103, 100.000000, b'0', '2024-08-01 23:31:39', b'0', 3),
	(58, 1, 1, 1, NULL, NULL, 86.206897, 13.793103, 100.000000, b'0', '2024-08-01 23:32:03', b'0', 3),
	(60, 2, 3, 1, NULL, NULL, 129.310345, 20.689655, 150.000000, b'0', '2024-08-02 18:24:01', b'0', 4),
	(61, 4, 3, 2, NULL, NULL, 86.206897, 13.793103, 100.000000, b'0', '2024-08-02 18:24:23', b'0', 5),
	(62, 7, 3, 2, NULL, NULL, 86.206897, 13.793103, 100.000000, b'0', '2024-08-02 18:26:00', b'0', 2);

-- Volcando estructura para tabla ventaspeople.catalogotramite
DROP TABLE IF EXISTS `catalogotramite`;
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
DROP TABLE IF EXISTS `cliente`;
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.cliente: ~1 rows (aproximadamente)
DELETE FROM `cliente`;
INSERT INTO `cliente` (`id`, `idUsuario`, `nombre`, `primerApellido`, `segundoApellido`, `Activo`, `calle`, `numeroExterior`, `numeroInterior`, `colonia`, `codigoPostal`, `municipio`, `entidadFederativa`, `pais`, `fechaInicio`, `fechaModificacion`) VALUES
	(1, 14, 'Saul', NULL, 'garcia', b'1', 'carmelo perez', '220', NULL, 'General Jose Vicente Villada', '57710', 'Nezahualcoyotl', 'Edo. de Mex.', 'México', '2024-08-02 18:55:05', '2024-08-02 18:57:11');

-- Volcando estructura para tabla ventaspeople.equipo
DROP TABLE IF EXISTS `equipo`;
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
	(18, 'La Gloria FC2', b'1', 11, '2024-07-25 19:41:55', '2024-07-25 19:41:51'),
	(19, 'La People\'s', b'1', 0, '2024-07-24 00:29:18', '2024-07-24 00:29:21');

-- Volcando estructura para procedimiento ventaspeople.ingresar_producto_canasta
DROP PROCEDURE IF EXISTS `ingresar_producto_canasta`;
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
DROP TABLE IF EXISTS `jugador`;
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
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.jugador: ~20 rows (aproximadamente)
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
	(20, 2, NULL, 'ALEXIS ARATH VALDES', NULL, b'1', '2024-07-15 01:04:55', NULL);

-- Volcando estructura para tabla ventaspeople.medida
DROP TABLE IF EXISTS `medida`;
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

-- Volcando estructura para tabla ventaspeople.playera_personalizada
DROP TABLE IF EXISTS `playera_personalizada`;
CREATE TABLE IF NOT EXISTS `playera_personalizada` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `numero` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `canastapid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_canastap` (`canastapid`),
  CONSTRAINT `fk_canastap` FOREIGN KEY (`canastapid`) REFERENCES `canasta_productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.playera_personalizada: ~2 rows (aproximadamente)
DELETE FROM `playera_personalizada`;
INSERT INTO `playera_personalizada` (`id`, `numero`, `nombre`, `canastapid`) VALUES
	(5, 75, 'storres', 60),
	(6, 1234, 'aTorres', 62);

-- Volcando estructura para tabla ventaspeople.producto
DROP TABLE IF EXISTS `producto`;
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
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.producto: ~17 rows (aproximadamente)
DELETE FROM `producto`;
INSERT INTO `producto` (`id`, `idTipo`, `descripcion`, `idEquipo`, `idJugador`, `numero`, `precio`, `stock`, `numeroLikes`, `estado`, `activo`) VALUES
	(1, 9, 'Camiseta Oficial Amor 2024 Juvenil', 7, 1, 1, 100.00, 15, 0, 1, b'1'),
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
	(15, 9, 'Camiseta Oficial Cachorros 2024 Juvenil', 0, 15, 6, 100.00, 0, 0, 0, b'1'),
	(16, 8, 'Nike air one', 0, 0, 0, 12345.00, 10, 0, 1, b'1'),
	(17, 5, 'People-Lindro', 0, 0, NULL, 123.00, 0, 0, 11, b'1');

-- Volcando estructura para tabla ventaspeople.productomedidas
DROP TABLE IF EXISTS `productomedidas`;
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
DROP TABLE IF EXISTS `productousuario`;
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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.productousuario: ~2 rows (aproximadamente)
DELETE FROM `productousuario`;
INSERT INTO `productousuario` (`id`, `idProducto`, `idUsuario`, `fecha`, `like`) VALUES
	(6, 4, 12, '2024-07-28 22:19:13', b'1'),
	(7, 5, 12, '2024-07-29 22:36:31', b'1');

-- Volcando estructura para tabla ventaspeople.sesion
DROP TABLE IF EXISTS `sesion`;
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
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.sesion: ~45 rows (aproximadamente)
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
	(57, 14, '2024-08-02', '2024-08-02 18:52:49', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36');

-- Volcando estructura para tabla ventaspeople.tipoproducto
DROP TABLE IF EXISTS `tipoproducto`;
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
DROP TABLE IF EXISTS `tokens`;
CREATE TABLE IF NOT EXISTS `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `sesionid` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `fk_sesion` (`sesionid`),
  CONSTRAINT `fk_sesion` FOREIGN KEY (`sesionid`) REFERENCES `sesion` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.tokens: ~16 rows (aproximadamente)
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
	(16, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjMsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyNjQ2MzY5LCJleHAiOjE3MjI2NDk5Njl9.v1JZBr2P7tjtHjriWxxfdf9wXDTRlP3mOHyYl_lXGZE', 57);

-- Volcando estructura para tabla ventaspeople.usuario
DROP TABLE IF EXISTS `usuario`;
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
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.usuario: ~3 rows (aproximadamente)
DELETE FROM `usuario`;
INSERT INTO `usuario` (`id`, `name`, `email`, `password`, `Activo`, `Nombres`, `ApellidoPrimero`, `ApellidoSegundo`, `fechaNacimiento`, `fechaAlta`, `fechaModificacion`) VALUES
	(12, 'Sangrael', 'angeltorralva@hotmail.com', '$2a$10$TuLImkkLuGdKZtvzxUCLj.yDmLO6WDd118rEk0UKd.90iZKlwfcui', b'1', 'Angel', 'Torres', 'Alvarez', '2003-01-01', '2024-07-27 00:42:02', NULL),
	(13, 'Sangrael', 'torres.alvarez.angel18@gmail.com', '$2a$10$h9Gl.LpcmWhZl6NfnmrmlOOTRkZz65dZb/4.4oH3FBegwLV8jUs3.', b'1', 'Angel', 'Torres', 'Alvarez', '2003-03-03', '2024-07-28 18:13:00', NULL),
	(14, 'storres', 'saultorresg@gmail.com', '$2a$10$Zly7cdgPGZ96MDTeQiPAquRFFqH6BDyYNCXQMjKK8X2wUfKcTvI0q', b'1', 'Saul', 'Torres', 'García', '1993-02-01', '2024-08-02 18:22:35', NULL);

-- Volcando estructura para tabla ventaspeople.venta
DROP TABLE IF EXISTS `venta`;
CREATE TABLE IF NOT EXISTS `venta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idCliente` int(11) NOT NULL,
  `idCanasta` int(11) NOT NULL,
  `fechaPago` datetime NOT NULL DEFAULT current_timestamp(),
  `formaPago` varchar(50) DEFAULT NULL,
  `Subtotal` decimal(20,6) NOT NULL,
  `IVA` decimal(20,6) DEFAULT NULL,
  `Total` decimal(20,6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Acumulado de la venta';

-- Volcando datos para la tabla ventaspeople.venta: ~0 rows (aproximadamente)
DELETE FROM `venta`;

-- Volcando estructura para tabla ventaspeople.ventadetalle
DROP TABLE IF EXISTS `ventadetalle`;
CREATE TABLE IF NOT EXISTS `ventadetalle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVenta` int(11) DEFAULT NULL,
  `idProducto` int(11) DEFAULT NULL,
  `numero` varchar(50) DEFAULT NULL,
  `etiqueta` varchar(50) DEFAULT NULL,
  `precio` decimal(20,6) DEFAULT NULL,
  `iva` decimal(20,6) DEFAULT NULL,
  `descuento` decimal(20,6) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `estadoEnvio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Listado de articulos a cobrar';

-- Volcando datos para la tabla ventaspeople.ventadetalle: ~0 rows (aproximadamente)
DELETE FROM `ventadetalle`;

-- Volcando estructura para disparador ventaspeople.crear_canasta_usuario
DROP TRIGGER IF EXISTS `crear_canasta_usuario`;
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
