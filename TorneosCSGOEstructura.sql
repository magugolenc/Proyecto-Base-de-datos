-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: torneoscsgo
-- ------------------------------------------------------
-- Server version	8.0.36

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditoria_pedidos`
--

DROP TABLE IF EXISTS `auditoria_pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auditoria_pedidos` (
  `fecha_compra` datetime NOT NULL,
  `accion` varchar(100) DEFAULT NULL,
  `fecha_modificacion` datetime DEFAULT NULL,
  PRIMARY KEY (`fecha_compra`),
  CONSTRAINT `auditoria_pedidos_ibfk_1` FOREIGN KEY (`fecha_compra`) REFERENCES `pedido` (`fecha_Compra`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `comprador`
--

DROP TABLE IF EXISTS `comprador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comprador` (
  `DNI` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `fecha_Nacimiento` date NOT NULL,
  `CP` int NOT NULL,
  `Municipio` varchar(45) NOT NULL,
  `país_Residencia` varchar(45) NOT NULL,
  `correo_Electronico` varchar(45) NOT NULL,
  PRIMARY KEY (`DNI`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entrada`
--

DROP TABLE IF EXISTS `entrada`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entrada` (
  `Tipo_Entrada` varchar(20) NOT NULL,
  `Precio` double NOT NULL,
  `Medio` enum('online','presencial') NOT NULL,
  `Stock` int NOT NULL,
  `Estadio_Sesion` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`Tipo_Entrada`,`Estadio_Sesion`),
  KEY `entrada_sesión_FK` (`Estadio_Sesion`),
  CONSTRAINT `entrada_sesión_FK` FOREIGN KEY (`Estadio_Sesion`) REFERENCES `sesión` (`Estadio`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `id_Equipo` int NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `abreviatura_Nombre` varchar(4) NOT NULL,
  `año_Fundacion` year DEFAULT NULL,
  `CEO` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id_Equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `estadio`
--

DROP TABLE IF EXISTS `estadio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estadio` (
  `id_Estadio` int NOT NULL,
  `país_Ubicación` varchar(45) NOT NULL,
  `provincia_Ubicación` varchar(100) DEFAULT NULL,
  `ciudad_Ubicación` varchar(45) NOT NULL,
  `Aforo` int NOT NULL,
  PRIMARY KEY (`id_Estadio`),
  UNIQUE KEY `ciudad_Ubicación_UNIQUE` (`ciudad_Ubicación`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `ingresos_y_pedidos_totales_por_mes`
--

DROP TABLE IF EXISTS `ingresos_y_pedidos_totales_por_mes`;
/*!50001 DROP VIEW IF EXISTS `ingresos_y_pedidos_totales_por_mes`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `ingresos_y_pedidos_totales_por_mes` AS SELECT 
 1 AS `Mes`,
 1 AS `Dinero_Generado`,
 1 AS `Pedidos_Realizados`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `jugador`
--

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `DNI` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `nombre_Jugador` varchar(45) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `fecha_Nacimiento` date NOT NULL,
  `Nacionalidad` varchar(45) NOT NULL,
  `Edad` int NOT NULL,
  `Equipo` int NOT NULL,
  PRIMARY KEY (`DNI`),
  KEY `fk_Jugador_Equipo1_idx` (`Equipo`),
  CONSTRAINT `fk_Jugador_Equipo1` FOREIGN KEY (`Equipo`) REFERENCES `equipo` (`id_Equipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `partido`
--

DROP TABLE IF EXISTS `partido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partido` (
  `id_Partido` int NOT NULL AUTO_INCREMENT,
  `hora_Inicio` timestamp NULL DEFAULT NULL,
  `hora_Fin` timestamp NULL DEFAULT NULL,
  `ResultadoEquipo1` int NOT NULL DEFAULT '0',
  `ResultadoEquipo2` int NOT NULL DEFAULT '0',
  `Equipo1` int NOT NULL,
  `Equipo2` int NOT NULL,
  `Sesion_Estadio_id_Estadio` int NOT NULL,
  PRIMARY KEY (`id_Partido`),
  KEY `fk_Partido_Sesión1_idx` (`Sesion_Estadio_id_Estadio`),
  KEY `fk_Partido_Equipo1_idx` (`Equipo1`),
  KEY `fk_Partido_Equipo2_idx` (`Equipo2`),
  CONSTRAINT `fk_Partido_Equipo1` FOREIGN KEY (`Equipo1`) REFERENCES `equipo` (`id_Equipo`),
  CONSTRAINT `fk_Partido_Equipo2` FOREIGN KEY (`Equipo2`) REFERENCES `equipo` (`id_Equipo`),
  CONSTRAINT `fk_Partido_Sesión1` FOREIGN KEY (`Sesion_Estadio_id_Estadio`) REFERENCES `sesión` (`Estadio`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pedido`
--

DROP TABLE IF EXISTS `pedido`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedido` (
  `fecha_Compra` datetime NOT NULL,
  `Importe` int NOT NULL,
  `estado_Transacción` enum('Realizado','Procesando','Pendiente') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `NºTarjeta_Débito/Crédito` varchar(19) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Comprador_DNI` varchar(11) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `tipo_entrada` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `cantidad` int DEFAULT NULL,
  `estadio_sesion` int DEFAULT NULL,
  PRIMARY KEY (`fecha_Compra`),
  KEY `fk_Pedido_Comprador1_idx` (`Comprador_DNI`),
  KEY `fk_Pedido_Tipo_Entrada` (`tipo_entrada`,`estadio_sesion`),
  CONSTRAINT `fk_Pedido_Comprador1` FOREIGN KEY (`Comprador_DNI`) REFERENCES `comprador` (`DNI`),
  CONSTRAINT `fk_Pedido_Tipo_Entrada` FOREIGN KEY (`tipo_entrada`, `estadio_sesion`) REFERENCES `entrada` (`Tipo_Entrada`, `Estadio_Sesion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `actualizar_stock` AFTER INSERT ON `pedido` FOR EACH ROW BEGIN



    DECLARE cantidad_comprada INT;



    DECLARE tipo_entrada_online ENUM('online', 'presencial');



    



    SET cantidad_comprada = NEW.cantidad;



    SET tipo_entrada_online = (SELECT Medio FROM entrada WHERE Tipo_Entrada = NEW.tipo_entrada AND Estadio_Sesion = NEW.estadio_sesion);



    



    IF tipo_entrada_online != 'online' THEN



        UPDATE entrada



        SET Stock = Stock - cantidad_comprada



        WHERE Tipo_Entrada = NEW.tipo_entrada AND Estadio_Sesion = NEW.estadio_sesion;



    END IF;



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `audit_pedidos` AFTER UPDATE ON `pedido` FOR EACH ROW BEGIN



    DECLARE accion VARCHAR(100) DEFAULT '';







    IF OLD.estado_Transacción <> NEW.estado_Transacción THEN



        SET accion = CONCAT('Estado cambiado de ', OLD.estado_Transacción, ' a ', NEW.estado_Transacción);



        INSERT INTO auditoria_pedidos (fecha_compra ,accion, fecha_modificacion)



        VALUES (OLD.fecha_Compra , accion, NOW());



    END IF;



END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `región`
--

DROP TABLE IF EXISTS `región`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `región` (
  `Cod_Región` varchar(5) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`Cod_Región`),
  UNIQUE KEY `Nombre_UNIQUE` (`Nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `región del torneo`
--

DROP TABLE IF EXISTS `región del torneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `región del torneo` (
  `nombre_Completo_Torneo` varchar(45) NOT NULL,
  `Cod_Región_Celebra` varchar(4) NOT NULL,
  `fecha_Inicio` date NOT NULL DEFAULT '2023-01-31',
  `fecha_Fin` date NOT NULL DEFAULT '2023-01-31',
  PRIMARY KEY (`nombre_Completo_Torneo`,`Cod_Región_Celebra`),
  KEY `fk_Torneo_has_Región_Región1_idx` (`Cod_Región_Celebra`),
  KEY `fk_Torneo_has_Región_Torneo1_idx` (`nombre_Completo_Torneo`),
  CONSTRAINT `fk_Torneo_has_Región_Región1` FOREIGN KEY (`Cod_Región_Celebra`) REFERENCES `región` (`Cod_Región`),
  CONSTRAINT `fk_Torneo_has_Región_Torneo1` FOREIGN KEY (`nombre_Completo_Torneo`) REFERENCES `torneo` (`nombre_Torneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sesión`
--

DROP TABLE IF EXISTS `sesión`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sesión` (
  `fecha_Hora_Inicio` timestamp NOT NULL,
  `fecha_Hora_Fin` timestamp NOT NULL,
  `ronda` varchar(45) DEFAULT NULL,
  `Torneo` varchar(45) NOT NULL,
  `Estadio` int NOT NULL,
  PRIMARY KEY (`Estadio`),
  KEY `fk_Sesión_Estadio1_idx` (`Estadio`),
  KEY `fk_Sesión_Torneo1` (`Torneo`),
  CONSTRAINT `fk_Sesión_Estadio1` FOREIGN KEY (`Estadio`) REFERENCES `estadio` (`id_Estadio`),
  CONSTRAINT `fk_Sesión_Torneo1` FOREIGN KEY (`Torneo`) REFERENCES `torneo` (`nombre_Torneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `tarifa`
--

DROP TABLE IF EXISTS `tarifa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tarifa` (
  `Tipo_Entrada` varchar(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'Estandar',
  `Fecha_Compra` datetime NOT NULL,
  `Cantidad` int NOT NULL DEFAULT '0',
  `Estadio_Sesion` int NOT NULL,
  PRIMARY KEY (`Fecha_Compra`),
  KEY `fk_Entrada_has_Pedido_Pedido1_idx` (`Fecha_Compra`),
  KEY `fk_Entrada_has_Pedido_Entrada1_idx` (`Tipo_Entrada`),
  KEY `tarifa_entrada_fk` (`Tipo_Entrada`,`Estadio_Sesion`),
  CONSTRAINT `tarifa_entrada_fk` FOREIGN KEY (`Tipo_Entrada`, `Estadio_Sesion`) REFERENCES `entrada` (`Tipo_Entrada`, `Estadio_Sesion`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tarifa_pedido_fk` FOREIGN KEY (`Fecha_Compra`) REFERENCES `pedido` (`fecha_Compra`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `torneo`
--

DROP TABLE IF EXISTS `torneo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `torneo` (
  `nombre_Torneo` varchar(45) NOT NULL,
  `Tipo` enum('Mundial','Continental','Nacional') CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `Modalidad` enum('Mejor de 1','Mejor de 2','Mejor de 5') NOT NULL,
  `Premio` varchar(10) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '0.00 €',
  `clasifica_Para` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`nombre_Torneo`),
  KEY `fk_Torneo_Torneo1_idx` (`clasifica_Para`),
  CONSTRAINT `fk_Torneo_Torneo1` FOREIGN KEY (`clasifica_Para`) REFERENCES `torneo` (`nombre_Torneo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `victorias_de_cada_equipo`
--

DROP TABLE IF EXISTS `victorias_de_cada_equipo`;
/*!50001 DROP VIEW IF EXISTS `victorias_de_cada_equipo`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `victorias_de_cada_equipo` AS SELECT 
 1 AS `InfoEquipo`,
 1 AS `Victorias_Nacionales`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'torneoscsgo'
--

--
-- Final view structure for view `ingresos_y_pedidos_totales_por_mes`
--

/*!50001 DROP VIEW IF EXISTS `ingresos_y_pedidos_totales_por_mes`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `ingresos_y_pedidos_totales_por_mes` AS select concat(month(`p`.`fecha_Compra`),'-',monthname(`p`.`fecha_Compra`)) AS `Mes`,sum(`p`.`Importe`) AS `Dinero_Generado`,count(0) AS `Pedidos_Realizados` from `pedido` `p` group by `Mes` order by `Dinero_Generado` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `victorias_de_cada_equipo`
--

/*!50001 DROP VIEW IF EXISTS `victorias_de_cada_equipo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `victorias_de_cada_equipo` AS select concat('ID: ',`e`.`id_Equipo`,' Nombre: ',`e`.`nombre`) AS `InfoEquipo`,count(`p`.`id_Partido`) AS `Victorias_Nacionales` from (((`equipo` `e` join `partido` `p` on(((`e`.`id_Equipo` = `p`.`Equipo1`) or (`e`.`id_Equipo` = `p`.`Equipo2`)))) join `sesión` `s` on((`p`.`Sesion_Estadio_id_Estadio` = `s`.`Estadio`))) join `torneo` `t` on((`s`.`Torneo` = `t`.`nombre_Torneo`))) where (((`p`.`Equipo1` = `e`.`id_Equipo`) and (`p`.`ResultadoEquipo1` > `p`.`ResultadoEquipo2`)) or ((`p`.`Equipo2` = `e`.`id_Equipo`) and (`p`.`ResultadoEquipo2` > `p`.`ResultadoEquipo1`) and (`t`.`Tipo` = 'Nacional'))) group by `e`.`id_Equipo` order by count(`p`.`id_Partido`) desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-13 14:20:04
