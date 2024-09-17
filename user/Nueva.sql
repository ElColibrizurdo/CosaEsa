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
  `iva` decimal(10,2) DEFAULT NULL,
  `subtotal` decimal(10,2) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `client_id` (`usuario_id`) USING BTREE,
  CONSTRAINT `canasta_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta: ~2 rows (aproximadamente)
DELETE FROM `canasta`;
INSERT INTO `canasta` (`id`, `usuario_id`, `iva`, `subtotal`, `total`, `fechaAlta`) VALUES
	(1, 14, 0.00, 0.00, 0.000000, '2024-07-28 18:47:24'),
	(2, 15, 0.00, 0.00, 0.000000, '2024-07-28 21:17:27');

-- Volcando estructura para tabla ventaspeople.canasta_productos
DROP TABLE IF EXISTS `canasta_productos`;
CREATE TABLE IF NOT EXISTS `canasta_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_producto` int(11) DEFAULT NULL,
  `id_canasta` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  `precio` decimal(20,6) DEFAULT NULL,
  `iva` decimal(20,6) DEFAULT NULL,
  `total` decimal(20,6) DEFAULT NULL,
  `pagado` bit(1) DEFAULT b'0',
  `fechaAlta` datetime DEFAULT current_timestamp(),
  `porPagar` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_canasta_productos_producto` (`id_producto`),
  KEY `fk_canasta_productos_canasta` (`id_canasta`),
  CONSTRAINT `fk_canasta_productos_canasta` FOREIGN KEY (`id_canasta`) REFERENCES `canasta` (`id`),
  CONSTRAINT `fk_canasta_productos_producto` FOREIGN KEY (`id_producto`) REFERENCES `producto` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



-- Volcando datos para la tabla ventaspeople.canasta_productos: ~8 rows (aproximadamente)
DELETE FROM `canasta_productos`;
INSERT INTO `canasta_productos` (`id`, `id_producto`, `id_canasta`, `cantidad`, `precio`, `iva`, `total`, `pagado`, `fechaAlta`, `porPagar`) VALUES
	(2, 1, 1, 1, NULL, NULL, NULL, b'0', '2024-07-28 19:02:28', NULL),
	(4, 4, 1, 1, NULL, NULL, NULL, b'0', '2024-07-28 19:15:30', NULL),
	(5, 6, 1, 1, NULL, NULL, NULL, b'0', '2024-07-28 19:18:18', NULL),
	(6, 5, 1, 1, NULL, NULL, NULL, b'0', '2024-07-28 21:16:00', NULL),
	(7, 2, 2, 3, NULL, NULL, NULL, b'0', '2024-07-28 21:22:06', NULL),
	(8, 17, 2, 3, NULL, NULL, NULL, b'0', '2024-07-28 21:22:30', NULL),
	(9, 10, 2, 47, NULL, NULL, NULL, b'0', '2024-07-28 21:23:33', NULL),
	(10, 9, 2, 20, NULL, NULL, NULL, b'0', '2024-07-28 21:25:26', NULL);

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

-- Volcando datos para la tabla ventaspeople.catalogotramite: ~5 rows (aproximadamente)
DELETE FROM `catalogotramite`;
INSERT INTO `catalogotramite` (`id`, `nombre`, `orden`, `activo`, `fechaAlta`) VALUES
	(1, 'Registro Paqueteria', 0, b'1', '2024-07-25 21:05:36'),
	(2, 'Envio en proceso', 1, b'1', '2024-07-25 21:05:51'),
	(3, 'Por Entregar', 2, b'1', '2024-07-25 21:06:32'),
	(4, 'Entregado', 4, b'1', '2024-07-25 21:06:44'),
	(5, 'No recibido', 3, b'1', '2024-07-25 21:07:06');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.cliente: ~0 rows (aproximadamente)
DELETE FROM `cliente`;
DROP TABLE cliente;
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
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.equipo: ~12 rows (aproximadamente)
DELETE FROM `equipo`;
INSERT INTO `equipo` (`id`, `nombre`, `activo`, `orden`, `fechaAlta`, `fechaModifcacion`) VALUES
	(0, 'La People\'s', b'1', 0, '2024-07-24 00:29:18', '2024-07-24 00:29:21'),
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
	(18, 'La Gloria FC2', b'1', 11, '2024-07-25 19:41:55', '2024-07-25 19:41:51');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Catalogos de medidas';

-- Volcando datos para la tabla ventaspeople.medida: ~6 rows (aproximadamente)
DELETE FROM `medida`;
INSERT INTO `medida` (`id`, `nombre`, `activo`, `descipcion`, `fechaAlta`) VALUES
	(0, 'S/M', b'1', 'Sin Medida', '2024-07-25 20:41:52'),
	(1, 'XS', b'1', 'Extra chica', '2024-07-25 20:39:12'),
	(2, 'S', b'1', 'China', '2024-07-25 20:39:17'),
	(3, 'M', b'1', 'Mediana', '2024-07-25 20:39:28'),
	(4, 'L', b'1', 'Grande', '2024-07-25 20:39:34'),
	(5, 'XL', b'1', 'Extra Grande', '2024-07-25 20:39:39');

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
  `Preventa` bit(1) NOT NULL DEFAULT b'0',
  `activo` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.producto: ~17 rows (aproximadamente)
DELETE FROM `producto`;
INSERT INTO `producto` (`id`, `idTipo`, `descripcion`, `idEquipo`, `idJugador`, `numero`, `precio`, `stock`, `numeroLikes`, `Preventa`, `activo`) VALUES
	(1, 9, 'Camiseta Oficial Amor 2024 Juvenil', 7, 1, 1, 100.00, 15, 0, b'0', b'1'),
	(2, 9, 'Hummbro Soffball', 6, 2, 2, 150.00, 11, 0, b'0', b'1'),
	(3, 6, 'Gorra bordada', 6, 3, 3, 250.00, 20, 0, b'0', b'1'),
	(4, 9, 'Pants oficial del cachorros', 5, 4, 4, 100.00, 20, 0, b'0', b'1'),
	(5, 9, 'Pants ligero', 5, 5, 5, 100.00, 20, 0, b'0', b'1'),
	(6, 9, 'Short oficial', 4, 6, 6, 100.00, 20, 0, b'0', b'1'),
	(7, 9, 'Conjunto deportivo', 4, 7, 7, 100.00, 20, 0, b'0', b'1'),
	(8, 4, 'Playera Verde', 1, 8, 8, 100.00, 20, 0, b'0', b'1'),
	(9, 4, 'Playera Blanca', 1, 9, 9, 100.00, 20, 0, b'0', b'1'),
	(10, 4, 'Playera Roja', 3, 10, 1, 100.00, 0, 0, b'0', b'1'),
	(11, 2, 'Camiseta Oficial Hombre', 3, 11, 2, 100.00, 20, 0, b'0', b'1'),
	(12, 1, 'Camiseta Oficial Mujer', 2, 12, 3, 100.00, 20, 0, b'0', b'1'),
	(13, 8, 'Addida torsion', 2, 13, 4, 100.00, 0, 0, b'1', b'1'),
	(14, 6, 'Vaso termico ', 0, 14, 5, 100.00, 0, 0, b'1', b'1'),
	(15, 9, 'Camiseta Oficial Cachorros 2024 Juvenil', 0, 15, 6, 100.00, 0, 0, b'0', b'1'),
	(16, 8, 'Nike air one', 0, 0, 0, 12345.00, 10, 0, b'1', b'1'),
	(17, 5, 'People-Lindro', 0, 0, NULL, 123.00, 0, 0, b'0', b'1');

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
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.productousuario: ~0 rows (aproximadamente)
DELETE FROM `productousuario`;

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.sesion: ~15 rows (aproximadamente)
DELETE FROM `sesion`;
INSERT INTO `sesion` (`id`, `idUsuario`, `fecha`, `horaInicio`, `horaTermino`, `IP`, `navegador`) VALUES
	(1, 3, '2024-07-25', '2024-07-25 08:34:13', NULL, '127.0.0.1', 'Nose el navigador'),
	(2, 3, '2024-07-25', '2024-07-25 08:34:48', NULL, '127.0.0.1', 'Nose el navigador'),
	(3, 3, '2024-07-25', '2024-07-25 08:36:07', NULL, '127.0.0.1', 'Nose el navigador'),
	(4, 3, '2024-07-25', '2024-07-25 09:36:07', NULL, '127.0.0.1', 'Nose el navigador'),
	(5, 3, '2024-07-25', '2024-07-25 09:43:23', NULL, '127.0.0.1', 'Nose el navigador'),
	(6, 3, '2024-07-25', '2024-07-25 12:58:01', NULL, '127.0.0.1', 'Nose el navigador'),
	(7, 5, '2024-07-25', '2024-07-25 12:59:14', NULL, '127.0.0.1', 'Nose el navigador'),
	(8, 5, '2024-07-25', '2024-07-25 12:59:38', NULL, '127.0.0.1', 'Nose el navigador'),
	(9, 5, '2024-07-25', '2024-07-25 13:01:50', NULL, '127.0.0.1', 'Nose el navigador'),
	(10, 5, '2024-07-25', '2024-07-25 13:02:19', NULL, '127.0.0.1', 'Nose el navigador'),
	(11, 5, '2024-07-25', '2024-07-25 13:03:41', NULL, '127.0.0.1', 'Nose el navigador'),
	(12, 5, '2024-07-25', '2024-07-25 13:04:20', NULL, '127.0.0.1', 'Nose el navigador'),
	(13, 14, '2024-07-28', '2024-07-28 18:50:31', NULL, NULL, 'Mozilla/5.0 (X11; Linux aarch64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/88.0.4324.188 Safari/537.36 CrKey/1.54.250320'),
	(14, 14, '2024-07-28', '2024-07-28 18:53:48', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36'),
	(15, 15, '2024-07-28', '2024-07-28 21:17:34', NULL, NULL, 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/107.0.0.0 Safari/537.36');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.tokens: ~3 rows (aproximadamente)
DELETE FROM `tokens`;
INSERT INTO `tokens` (`id`, `token`, `sesionid`) VALUES
	(1, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjEsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyMjE0MjMxLCJleHAiOjE3MjIyMTc4MzF9._19VRu37aX5i576LIA_H77OX2ix58CWK0rFuDBeRfVc', 13),
	(2, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE0LCJ1c2VyTmFtZSI6InN0b3JyZXMiLCJjYW5hc3RhSWQiOjEsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyMjE0NDI4LCJleHAiOjE3MjIyMTgwMjh9.kWC6B32HhgPZ_Rwga0CLxWQhwQs0Z0INpmwJ3Oxaatg', 14),
	(3, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjE1LCJ1c2VyTmFtZSI6Im1hamVzdXMiLCJjYW5hc3RhSWQiOjIsInBlcGUiOiJwZXBlIiwiaWF0IjoxNzIyMjIzMDU0LCJleHAiOjE3MjIyMjY2NTR9.LkOZYvoEllrjv8kBOuMY9gyZKKA2GCK0DERxHkktXt4', 15);

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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.usuario: ~4 rows (aproximadamente)
DELETE FROM `usuario`;
INSERT INTO `usuario` (`id`, `name`, `email`, `password`, `Activo`, `Nombres`, `ApellidoPrimero`, `ApellidoSegundo`, `fechaNacimiento`, `fechaAlta`, `fechaModificacion`) VALUES
	(1, 'storres', 'storres', '123', b'1', 'Saul Torres Garcia', '', '', NULL, '2024-07-25 07:42:03', NULL),
	(2, 'jorge_tp@hotmail.com', 'jorge_tp@hotmail.com', '12345', b'1', 'Jorge tellez', '', '', NULL, '2024-07-25 07:53:32', NULL),
	(14, 'storres', 'saultorresg@gmail.com', '$2a$10$q.2pZOvIrp6bQ8.xE3OQ4u0AaBM6CGfdi6Du3SNmcWwrWgYOGUMuy', b'1', 'Saul', 'Torres', 'García', '1993-02-01', '2024-07-28 18:47:24', NULL),
	(15, 'majesus', 'matoga@hotmail.com', '$2a$10$o48RDG57nM2Mvihm9zMu7uzvp9ab4SRPhN/iiYIVaPNsNRPCcL11G', b'1', 'Maria', 'de', 'Jesus', '1994-03-02', '2024-07-28 21:17:27', NULL);

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
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `crear_canasta_usuario` AFTER INSERT ON `usuario` FOR EACH ROW BEGIN
    INSERT INTO canasta (usuario_id, subtotal, iva, total)
    VALUES (NEW.id, 0.00, 0.00, 0.00);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


SELECT * FROM colonia WHERE d_codigo = 52985
SELECT * FROM estado WHERE idPais = 151

SELECT  c.d_asenta, e.Nombre, e.Clave, c.d_codigo, c.idPais FROM colonia c 
INNER JOIN estado e ON e.id = c.idEstado 
WHERE c.d_codigo = 52985

SELECT p.descripcion, p.precio, p.estado, p.id, COUNT(c.id) AS variantes
FROM producto p 
LEFT JOIN colores_producto c ON p.id = c.idProducto GROUP BY p.id
SELECT * FROM colores_producto cp 
SELECT * FROM estado e 
SELECT * FROM pais p 
SELECT * FROM colonia c 
SELECT * FROM tipoproducto t ;
SELECT * FROM productomedidas p ;
	SELECT * FROM medida m ;
	SELECT * FROM productousuario p ;
SELECT * FROM producto p ;
SELECT * FROM canasta_productos cp ;
SELECT * FROM playera_personalizada pp ;
SELECT * FROM usuario u 
SELECT COUNT(*) AS total FROM sesion WHERE horaInicio >= NOW() -INTERVAL 2 DAY
DELETE FROM usuario
SELECT * FROM canasta c ;
SELECT * FROM producto p ;
SELECT * FROM medida m 
SELECT * FROM sesion s  where s.idUsuario = 12  ORDER BY  horaInicio DESC LIMIT 1;
{ CALL ventaspeople.compraCanasta(:idSesion) }
CALL ventaspeople.compraCanasta(74)
{ CALL ventaspeople.compraCanasta(72) }
SELECT * FROM medida m 
SELECT * FROM cliente c;
DELETE FROM cliente;
SELECT id FROM cliente WHERE idUsuario = 12
SELECT * FROM metodos_pago mp ;
SELECT * FROM venta v;
SELECT COUNT(*) FROM venta WHERE idCliente = 18;
SELECT * FROM ventadetalle v ;
DELETE FROM venta ;
DELETE FROM metodos_pago WHERE id IN (1,2,3,4,5,6,7);
DELETE FROM ventadetalle WHERE idVenta IN (15,16)
DELETE FROM venta WHERE id IN (15,16);
DELETE FROM sesion;
DELETE FROM canasta_productos ;
SELECT * FROM tokens;
DROP TABLE tokens;
{ CALL ventaspeople.compraCanasta(:idSesion) }
SELECT EXISTS (SELECT s.idUsuario 
FROM sesion s 
JOIN cliente c 
ON s.idUSuario = c.idUsuario 
WHERE s.id = 116)
DELETE FROM canasta_productos cp ;
DELETE FROM metodos_pago WHERE id IN (9, 10, 11)

INSERT INTO metodos_pago (idUsuario, cardNumber, fechaExpiracion) VALUES (14, 6666666666666666, 2026-01-01)

SELECT COUNT(id) AS total FROM usuario WHERE fechaAlta >= CURDATE() - INTERVAL 0 DAY

DELETE FROM canasta_productos;
SELECT id FROM canasta WHERE usuario_id = 58;

INSERT INTO productomedidas (idProducto, idMedida) VALUES 
(539,1),
(539,2),
(539,3),
(539,4),
(539,5)

CREATE TABLE `playera_personalizada` (
	
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`numero` int(11) NOT NULL,
	`nombre` varchar(150) NOT NULL,
	`canastapid` int(11) NOT NULL,
	PRIMARY KEY (`id`),
	CONSTRAINT `fk_canastap` FOREIGN KEY (`canastapid`) REFERENCES `canasta_productos` (`id`) ON DELETE CASCADE
);

ALTER TABLE producto DROP COLUMN activo ;

ALTER TABLE producto ADD COLUMN estado INT NOT NULL,
ADD CONSTRAINT chk_estado CHECK (estado IN (0, 1, 11));

UPDATE producto SET estado = 1 WHERE id IN (1,4,7,10,13,16);
UPDATE producto SET estado = 11 WHERE id IN (2,5,8,11,14,17);

SELECT * FROM producto p  WHERE p.id LIKE "%" 
JOIN tipoproducto t ON p.idTipo = t.id
AND t.id IN (1)

SELECT * FROM producto WHERE descripcion LIKE ("%Camiseta%") LIMIT 5 OFFSET 10
SELECT p.id, p.idTipo, p.descripcion, p.idEquipo, p.precio, p.numeroLikes, p.estado FROM producto p  WHERE p.id LIKE "%" AND p.estado IN (0)

DELETE FROM productousuario WHERE idUsuario = 12 AND idProducto = 6
DELETE FROM canasta_productos 

ALTER TABLE canasta_productos ADD COLUMN id_medida INT NOT NULL,
ADD CONSTRAINT `fk_medida` FOREIGN KEY (`id_medida`) REFERENCES `medida` (`id`) ON DELETE CASCADE 


CREATE TABLE `metodos_pago` (

	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`idUsuario` INT(11) NOT NULL,
	`cardNumber` VARCHAR(150) NOT NULL,
	`fechaExpiracion` datetime NOT NULL,
	`CVV` VARCHAR(150) NOT NULL
	PRIMARY KEY (`id`),
	KEY (`idUsuario`),
	CONSTRAINT `fk_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE
);

CREATE TABLE `metodos_pago` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `idUsuario` INT(11) NOT NULL,
    `cardNumber` VARCHAR(150) NOT NULL,
    `fechaExpiracion` DATE NOT NULL,  -- Cambié datetime a DATE para la fecha de expiración
    PRIMARY KEY (`id`),
    KEY (`idUsuario`),
    CONSTRAINT `fk_usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE
);

ALTER TABLE usuario ADD COLUMN role VARCHAR(100) NOT NULL DEFAULT 'cliente';


CREATE PROCEDURE actualizarCliente (
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
	IN p_pais varchar(50) 
	)
	BEGIN
		IF EXISTS (SELECT 1 FROM cliente WHERE idUsuario = p_idUsuario ) THEN
		
			DELETE  FROM cliente WHERE idUsuario = p_idUsuario;
			
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
	END

	CALL actualizarCliente (

		14,
		"Luis",
		"Gonzales",
		"Rodriguez",
		"Ǹorte",
		50,
		60,
		"Inter",
		80000,
		"Naucalpan",
		"CDMX",
		"Mexico"
	);
	
SELECT * FROM cliente;

SELECT idUsuario FROM sesion WHERE id = 58;


CREATE PROCEDURE `compraCanasta`(
	IN `idSesion` INT
)
    DETERMINISTIC
BEGIN

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



ENDSELECT descripcion FROM producto WHERE descripcion LIKE "%Camiseta%" LIMIT 5 OFFSET 5;

{ CALL ventaspeople.compraCanasta(:idSesion) }

SELECT p.id, p.idTipo, p.descripcion, p.idEquipo, p.precio, p.numeroLikes, p.estado FROM producto p  WHERE p.descripcion LIKE "%Camisetas%"
SELECT * FROM producto WHERE descripcion LIKE "%Camiseta%" LIMIT 5 OFFSET 11;
SELECT idProducto, COUNT(*) AS cantidad_compras FROM ventadetalle GROUP BY idProducto HAVING COUNT(*) >= 3 LIMIT 5 OFFSET 5;  
SELECT p.* FROM producto p JOIN ventadetalle v on v.idProducto = p.id GROUP BY v.idProducto  HAVING COUNT(*) >= 3 LIMIT 5 OFFSET 5
SELECT * FROM producto WHERE estado = 0

CREATE TABLE colores (
	id INT NOT NULL AUTO_INCREMENT,
	color VARCHAR(150) NOT NULL,
	PRIMARY KEY (id)
)

INSERT INTO colores (color) VALUES
('Rojo'),
('Azul'),
('Verde'),
('Amarillo'),
('Naranja'),
('Morado'),
('Rosa'),
('Marrón'),
('Negro'),
('Blanco');


CREATE TABLE colores_producto (
	id INT NOT NULL AUTO_INCREMENT,
	idProducto INT NOT NULL,
	idColor INT NOT NULL,
	PRIMARY KEY (id),
	KEY fk_colores_producto_producto (idProducto),
	KEY fk_colores_producto_color (idColor),
	CONSTRAINT fk_colores_producto_producto FOREIGN KEY (idProducto) REFERENCES producto (id) ON DELETE CASCADE,
	CONSTRAINT fk_colores_producto_color FOREIGN KEY (idColor) REFERENCES colores (id)
	
);

INSERT INTO colores_producto (idProducto, idColor) VALUES
(2, 1),  -- Rojo
(2, 2),  -- Azul
(2, 3),  -- Verde
(2, 4),  -- Amarillo

(4, 5),  -- Naranja
(4, 6),  -- Morado
(4, 7),  -- Rosa
(4, 8),  -- Marrón

(6, 9),  -- Negro
(6, 10), -- Blanco
(6, 1),  -- Rojo
(6, 2),  -- Azul

(8, 3),  -- Verde
(8, 4),  -- Amarillo
(8, 5),  -- Naranja
(8, 6),  -- Morado

(10, 7), -- Rosa
(10, 8), -- Marrón
(10, 9), -- Negro
(10, 10),-- Blanco

(12, 1), -- Rojo
(12, 2), -- Azul
(12, 3), -- Verde
(12, 4), -- Amarillo

(14, 5), -- Naranja
(14, 6), -- Morado
(14, 7), -- Rosa
(14, 8); -- Marrón


SELECT c.color
FROM colores_producto cp
INNER JOIN colores c ON cp.idColor = c.id
WHERE cp.idProducto = 2;

SELECT * FROM colores c ;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;•••••••••••••••••••••••  
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
