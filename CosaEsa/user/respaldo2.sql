/*!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.8-MariaDB, for debian-linux-gnu (x86_64)
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
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `client_id` int(11) DEFAULT NULL,
  `total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_client_id` (`client_id`),
  CONSTRAINT `fk_client_id` FOREIGN KEY (`client_id`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canasta`
--

LOCK TABLES `canasta` WRITE;
/*!40000 ALTER TABLE `canasta` DISABLE KEYS */;
INSERT INTO `canasta` VALUES
(3,12,0.00),
(4,14,0.00),
(5,15,0.00);
/*!40000 ALTER TABLE `canasta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `canasta_productos`
--

DROP TABLE IF EXISTS `canasta_productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `canasta_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) NOT NULL,
  `id_producto` int(11) DEFAULT NULL,
  `id_canasta` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_canasta_productos_producto` (`id_producto`),
  KEY `fk_canasta_productos_canasta` (`id_canasta`),
  CONSTRAINT `fk_canasta_productos_canasta` FOREIGN KEY (`id_canasta`) REFERENCES `canasta` (`id`),
  CONSTRAINT `fk_canasta_productos_producto` FOREIGN KEY (`id_producto`) REFERENCES `productos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `canasta_productos`
--

LOCK TABLES `canasta_productos` WRITE;
/*!40000 ALTER TABLE `canasta_productos` DISABLE KEYS */;
INSERT INTO `canasta_productos` VALUES
(41,4,81,3);
/*!40000 ALTER TABLE `canasta_productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `categoria` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes`
--

DROP TABLE IF EXISTS `likes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `usuarioid` int(11) DEFAULT NULL,
  `productoid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `usuarioid` (`usuarioid`),
  KEY `productoid` (`productoid`),
  CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`usuarioid`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`productoid`) REFERENCES `productos` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes`
--

LOCK TABLES `likes` WRITE;
/*!40000 ALTER TABLE `likes` DISABLE KEYS */;
/*!40000 ALTER TABLE `likes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `stock` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `tipo` varchar(100) NOT NULL,
  `equipo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES
(81,'descripcion2',100.00,10,'producto2','sweater','cachorros'),
(82,'descripcion3',100.00,10,'producto3','termo','callejeros'),
(83,'descripcion4',100.00,10,'producto4','taza','ziza'),
(84,'descripcion5',100.00,10,'producto5','gorras','tanos'),
(85,'descripcion6',100.00,10,'producto6','camisetan','gambeta'),
(86,'descripcion7',100.00,10,'producto7','camisetaa','amor'),
(87,'descripcion8',100.00,10,'producto8','t-shirt','reta'),
(88,'descripcion9',100.00,10,'producto9','sweater','gloria'),
(89,'descripcion10',100.00,10,'producto10','termo','emperors'),
(90,'descripcion11',100.00,10,'producto11','taza','calvos'),
(91,'descripcion12',100.00,10,'producto12','sweater','cachorros'),
(92,'descripcion13',100.00,10,'producto13','termo','callejeros'),
(93,'descripcion14',100.00,10,'producto14','taza','ziza'),
(94,'descripcion15',100.00,10,'producto15','gorras','tanos'),
(95,'descripcion16',100.00,10,'producto16','camisetan','gambeta'),
(96,'descripcion17',100.00,10,'producto17','camisetaa','amor'),
(97,'descripcion18',100.00,10,'producto18','t-shirt','reta'),
(98,'descripcion19',100.00,10,'producto19','sweater','gloria'),
(99,'descripcion20',100.00,10,'producto20','termo','emperors'),
(100,'descripcion21',100.00,10,'producto21','taza','calvos'),
(101,'descripcion22',100.00,10,'producto22','sweater','cachorros'),
(102,'descripcion23',100.00,10,'producto23','termo','callejeros'),
(103,'descripcion24',100.00,10,'producto24','taza','ziza'),
(104,'descripcion25',100.00,10,'producto25','gorras','tanos'),
(105,'descripcion26',100.00,10,'producto26','camisetan','gambeta'),
(106,'descripcion27',100.00,10,'producto27','camisetaa','amor'),
(107,'descripcion28',100.00,10,'producto28','t-shirt','reta'),
(108,'descripcion29',100.00,10,'producto29','sweater','gloria'),
(109,'descripcion30',100.00,10,'producto30','termo','emperors'),
(110,'descripcion31',100.00,10,'producto31','taza','calvos'),
(111,'descripcion32',100.00,10,'producto32','sweater','cachorros'),
(112,'descripcion33',100.00,10,'producto33','termo','callejeros'),
(113,'descripcion34',100.00,10,'producto34','taza','ziza'),
(114,'descripcion35',100.00,10,'producto35','gorras','tanos'),
(115,'descripcion36',100.00,10,'producto36','camisetan','gambeta'),
(116,'descripcion37',100.00,10,'producto37','camisetaa','amor'),
(117,'descripcion38',100.00,10,'producto38','t-shirt','reta'),
(118,'descripcion39',100.00,10,'producto39','sweater','gloria'),
(119,'descripcion30',100.00,10,'producto30','termo','emperors'),
(120,'descripcion41',100.00,10,'producto41','taza','calvos');
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES
(12,'Sangrael','angeltorralva@hotmail.com','$2a$10$KgE5F/y5Ng7IXXRsJRiAiO1o9ZFjpTk9nTVIZG7nCRHz3bf6AD1I2'),
(14,'Pelushe','atorresa1800@alumno.ipn.mx','$2a$10$6AMrsvTUn7m1wsru1En72Obn3Ou3VewSfCINYy7v2RtHd04.vW./6'),
(15,'xaaww','Angel Torres','$2a$10$nsIA00EyXWhFbcFvOFWtpeSQCesOxg05UXNNfXPL2HS5JeZ5U2nl2');
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
    INSERT INTO canasta (client_id, total)
    VALUES (NEW.id, 0.00);
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

-- Dump completed on 2024-07-25 17:17:29
