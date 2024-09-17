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
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `client_id` int(11), NOT NULL,
  `subtotal` decimal(10,2), DEFAULT NULL,
  `iva` decimal(10,2), DEFAULT NULL,
  `total` decimal(20,6), DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),,
  PRIMARY KEY (`id`),,
  KEY `client_id` (`client_id`),,
  CONSTRAINT `canasta_ibfk_1` FOREIGN KEY (`client_id`), REFERENCES `usuario` (`id`),
), ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta: ~0 rows (aproximadamente),
DELETE FROM `canasta`;

-- Volcando estructura para tabla ventaspeople.canasta_productos
DROP TABLE IF EXISTS `canasta_productos`;
CREATE TABLE IF NOT EXISTS `canasta_productos` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `cantidad` int(11), NOT NULL,
  `id_producto` int(11), DEFAULT NULL,
  `id_canasta` int(11), NOT NULL,
  `precio` int(11), DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),,
  PRIMARY KEY (`id`),,
  KEY `fk_canasta_productos_producto` (`id_producto`),,
  KEY `fk_canasta_productos_canasta` (`id_canasta`),,
  CONSTRAINT `fk_canasta_productos_canasta` FOREIGN KEY (`id_canasta`), REFERENCES `canasta` (`id`),,
  CONSTRAINT `fk_canasta_productos_producto` FOREIGN KEY (`id_producto`), REFERENCES `producto` (`id`),
), ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.canasta_productos: ~0 rows (aproximadamente),
DELETE FROM `canasta_productos`;

-- Volcando estructura para tabla ventaspeople.cliente
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11), NOT NULL,
  `idUsuario` int(11), NOT NULL,
  `nombre` varchar(50), DEFAULT NULL,
  `primerApellido` varchar(50), DEFAULT NULL,
  `segundoApellido` varchar(50), DEFAULT NULL,
  `Activo` bit(1), DEFAULT b'1',
  `calle` varchar(100), DEFAULT NULL,
  `numeroExterior` varchar(50), DEFAULT NULL,
  `numeroInterior` varchar(50), DEFAULT NULL,
  `colonia` varchar(100), DEFAULT NULL,
  `codigoPostal` varchar(6), DEFAULT NULL,
  `municipio` varchar(100), DEFAULT NULL,
  `entidadFederativa` varchar(50), DEFAULT NULL,
  `pais` varchar(50), DEFAULT NULL,
  `fechaInicio` datetime DEFAULT current_timestamp(),,
  `fechaModificacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),,
  PRIMARY KEY (`id`),
), ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.cliente: ~0 rows (aproximadamente),
DELETE FROM `cliente`;

-- Volcando estructura para tabla ventaspeople.equipo
DROP TABLE IF EXISTS `equipo`;
CREATE TABLE IF NOT EXISTS `equipo` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150), NOT NULL,
  `activo` bit(1), DEFAULT b'0',
  `fechaAlta` datetime NOT NULL DEFAULT current_timestamp(),,
  `fechaModifcacion` datetime NOT NULL,
  PRIMARY KEY (`id`),,
  UNIQUE KEY `nombre_activo` (`nombre`,`activo`),
), ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.equipo: ~2 rows (aproximadamente),
DELETE FROM `equipo`;
INSERT INTO `equipo` (`id`, `nombre`, `activo`, `fechaAlta`, `fechaModifcacion`), 
	(1, 'CALVOS FC', b'1', '2024-07-15 00:48:05', '2024-07-15 00:48:11'),,
	(2, 'CACHORROS', b'1', '2024-07-15 00:48:36', '2024-07-15 00:48:37'),;

-- Volcando estructura para tabla ventaspeople.jugador
DROP TABLE IF EXISTS `jugador`;
CREATE TABLE IF NOT EXISTS `jugador` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `idEquipo` int(11), NOT NULL DEFAULT 0,
  `nombre` varchar(60), DEFAULT NULL,
  `numero` varchar(3), DEFAULT NULL,
  `activo` bit(1), DEFAULT b'1',
  `fechaAlta` datetime DEFAULT current_timestamp(),,
  `fechaModificacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),,
  PRIMARY KEY (`id`), USING BTREE
), ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.jugador: ~20 rows (aproximadamente),
DELETE FROM `jugador`;
INSERT INTO `jugador` (`id`, `idEquipo`, `nombre`, `numero`, `activo`, `fechaAlta`, `fechaModificacion`), 
	(1, 1, 'ALBERTO ARMANDO MENDEZ', NULL, b'1', '2024-07-15 00:49:30', '2024-07-15 00:54:28'),,
	(2, 1, 'JOSE EDUARDO MORENO', NULL, b'1', '2024-07-15 00:50:23', '2024-07-15 00:54:31'),,
	(3, 1, 'CESAR GIOVANNY PALACIOS', NULL, b'1', '2024-07-15 00:50:44', '2024-07-15 00:54:32'),,
	(4, 2, 'LUIS DIEGO GOMEZ', NULL, b'1', '2024-07-15 00:54:21', '2024-07-15 00:54:33'),,
	(5, 2, 'RAMON', NULL, b'1', '2024-07-15 00:55:38', '2024-07-15 00:55:45'),,
	(6, 1, 'CESAR GIOVANNY PALACIOS', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(7, 1, 'JOSE EDUARDO MORENO', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(8, 1, 'JOHAN MEJORADA', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(9, 1, 'DIEGo VELAZQUEZ', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(10, 1, 'BOGAR GUADALUPE MORENO', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(11, 1, 'ALBERTO ARMANDO MENDEZ', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(12, 1, 'OSCAR DANIEL PATIÑO', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(13, 1, 'LUIS MANUEL MAGAÑA', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(14, 1, 'FERNANDO MORALES', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(15, 2, 'MOISES', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(16, 2, 'LUIS DIEGO GOMEZ', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(17, 2, 'JONATHAN MOYA', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(18, 2, 'ISAI CALLEJAS', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(19, 2, 'DIEGO MORENO', NULL, b'1', '2024-07-15 01:04:55', NULL),,
	(20, 2, 'ALEXIS ARATH VALDES', NULL, b'1', '2024-07-15 01:04:55', NULL),;

-- Volcando estructura para tabla ventaspeople.producto
DROP TABLE IF EXISTS `producto`;
CREATE TABLE IF NOT EXISTS `producto` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100), NOT NULL,
  `idEquipo` int(11), NOT NULL DEFAULT 0,
  `idJugador` int(11), NOT NULL DEFAULT 0,
  `numero` int(11), NOT NULL,
  `precio` decimal(10,2), NOT NULL,
  `stock` int(11), NOT NULL,
  `numeroLikes` int(11), DEFAULT NULL,
  PRIMARY KEY (`id`),
), ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.producto: ~15 rows (aproximadamente),
DELETE FROM `producto`;
INSERT INTO `producto` (`id`, `descripcion`, `idEquipo`, `idJugador`, `numero`, `precio`, `stock`, `numeroLikes`), 
	(1, 'CESAR GIOVANNY PALACIOS', 1, 1, 1, 100.00, 15, NULL),,
	(2, 'JOSE EDUARDO MORENO', 1, 2, 2, 150.00, 11, NULL),,
	(3, 'JOHAN MEJORADA', 1, 3, 3, 250.00, 20, NULL),,
	(4, 'DIEGo VELAZQUEZ', 1, 4, 4, 100.00, 20, NULL),,
	(5, 'BOGAR GUADALUPE MORENO', 1, 5, 5, 100.00, 20, NULL),,
	(6, 'ALBERTO ARMANDO MENDEZ', 1, 6, 6, 100.00, 20, NULL),,
	(7, 'OSCAR DANIEL PATIÑO', 1, 7, 7, 100.00, 20, NULL),,
	(8, 'LUIS MANUEL MAGAÑA', 1, 8, 8, 100.00, 20, NULL),,
	(9, 'FERNANDO MORALES', 1, 9, 9, 100.00, 20, NULL),,
	(10, 'MOISES', 2, 10, 1, 100.00, 20, NULL),,
	(11, 'LUIS DIEGO GOMEZ', 2, 11, 2, 100.00, 20, NULL),,
	(12, 'JONATHAN MOYA', 2, 12, 3, 100.00, 20, NULL),,
	(13, 'ISAI CALLEJAS', 2, 13, 4, 100.00, 20, NULL),,
	(14, 'DIEGO MORENO', 2, 14, 5, 100.00, 20, NULL),,
	(15, 'ALEXIS ARATH VALDES', 2, 15, 6, 100.00, 20, NULL),;

-- Volcando estructura para tabla ventaspeople.productousuario
DROP TABLE IF EXISTS `productousuario`;
CREATE TABLE IF NOT EXISTS `productousuario` (
  `idProducto` int(11), NOT NULL,
  `idUsuario` int(11), NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),,
  `like` bit(1), DEFAULT b'1',
  PRIMARY KEY (`idProducto`,`idUsuario`),
), ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.productousuario: ~0 rows (aproximadamente),
DELETE FROM `productousuario`;

-- Volcando estructura para tabla ventaspeople.sesion
DROP TABLE IF EXISTS `sesion`;
CREATE TABLE IF NOT EXISTS `sesion` (
  `id` bigint(20), NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11), NOT NULL,
  `fecha` date DEFAULT current_timestamp(),,
  `horaInicio` datetime DEFAULT current_timestamp(),,
  `horaTermino` datetime DEFAULT NULL,
  `IP` varchar(50), DEFAULT NULL,
  `navegador` varchar(1024), DEFAULT NULL,
  PRIMARY KEY (`id`),,
  KEY `idUsuario` (`idUsuario`),
), ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.sesion: ~0 rows (aproximadamente),
DELETE FROM `sesion`;

-- Volcando estructura para tabla ventaspeople.usuario
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE IF NOT EXISTS `usuario` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `name` varchar(100), NOT NULL,
  `email` varchar(100), NOT NULL,
  `password` varchar(255), NOT NULL,
  `Activo` bit(1), NOT NULL DEFAULT b'1',
  `Nombres` varchar(150), NOT NULL DEFAULT '',
  `ApellidoPrimero` varchar(150), NOT NULL DEFAULT '',
  `ApellidoSegundo` varchar(150), NOT NULL DEFAULT '',
  `fechaNacimiento` date DEFAULT NULL,
  `fechaAlta` datetime DEFAULT current_timestamp(),,
  `fechaModificacion` datetime DEFAULT NULL ON UPDATE current_timestamp(),,
  PRIMARY KEY (`id`),
), ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Volcando datos para la tabla ventaspeople.usuario: ~0 rows (aproximadamente),
DELETE FROM `usuario`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system'), */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, ''), */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1), */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1), */;
