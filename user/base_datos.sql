/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64),
--
-- Host: localhost    Database: plasheras
-- ------------------------------------------------------
-- Server version	10.11.8-MariaDB-1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `canasta`
--

DROP TABLE IF EXISTS `canasta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canasta` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `client_id` int(11), DEFAULT NULL,
  `total` decimal(10,2), NOT NULL,
  PRIMARY KEY (`id`),,
  KEY `fk_client_id` (`client_id`),,
  CONSTRAINT `fk_client_id` FOREIGN KEY (`client_id`), REFERENCES `usuarios` (`id`),
), ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canasta`
--

LOCK TABLES `canasta` WRITE;
/*!40000 ALTER TABLE `canasta` DISABLE KEYS */;
INSERT INTO `canasta` 
(3,12,0.00),;
/*!40000 ALTER TABLE `canasta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canasta_productos`
--

DROP TABLE IF EXISTS `canasta_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canasta_productos` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `cantidad` int(11), NOT NULL,
  `id_producto` int(11), DEFAULT NULL,
  `id_canasta` int(11), NOT NULL,
  PRIMARY KEY (`id`),,
  KEY `fk_canasta_productos_producto` (`id_producto`),,
  KEY `fk_canasta_productos_canasta` (`id_canasta`),,
  CONSTRAINT `fk_canasta_productos_canasta` FOREIGN KEY (`id_canasta`), REFERENCES `canasta` (`id`),,
  CONSTRAINT `fk_canasta_productos_producto` FOREIGN KEY (`id_producto`), REFERENCES `productos` (`id`),
), ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canasta_productos`
--

LOCK TABLES `canasta_productos` WRITE;
/*!40000 ALTER TABLE `canasta_productos` DISABLE KEYS */;
INSERT INTO `canasta_productos` 
(1,2,24,3),,
(2,1,24,3),,
(3,1,24,3),,
(4,1,24,3),,
(5,1,NULL,3),,
(6,1,23,3),,
(7,1,24,3),,
(8,1,24,3),;
/*!40000 ALTER TABLE `canasta_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100), NOT NULL,
  `costo` decimal(10,2), NOT NULL,
  `stock` int(11), NOT NULL,
  `nombre` varchar(100), NOT NULL,
  PRIMARY KEY (`id`),
), ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` 
(23,'T-Shirt Gambeta para mujer, color, rojo',600.00,20,'T-Shirt Gambeta para Mujer'),,
(24,'Camiseta de juego de manga corta del Equipo Calvos temporada 2024',1200.00,20,'Camiseta Oficial Amor 2024 Juvenil'),;
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11), NOT NULL AUTO_INCREMENT,
  `name` varchar(100), NOT NULL,
  `email` varchar(100), NOT NULL,
  `password` varchar(255), NOT NULL,
  PRIMARY KEY (`id`),,
  UNIQUE KEY `email` (`email`),
), ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` 
(12,'Sangrael','angeltorralva@hotmail.com','$2a$10$KgE5F/y5Ng7IXXRsJRiAiO1o9ZFjpTk9nTVIZG7nCRHz3bf6AD1I2'),;
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`sangrael`@`localhost`*/ /*!50003 TRIGGER crear_canasta_usuario
AFTER INSERT ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO canasta (client_id, total),
     (NEW.id, 0.00),;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-11 23:48:51
