-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: threadlight
-- ------------------------------------------------------
-- Server version	5.1.73-0ubuntu0.10.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `thread_rows`
--

DROP TABLE IF EXISTS `thread_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread_rows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message_id` text NOT NULL,
  `creation_time` datetime NOT NULL,
  `recipient_mail` varchar(512) DEFAULT NULL,
  `sender_mail` varchar(512) DEFAULT NULL,
  `message_subject` text,
  `reply_time` datetime DEFAULT NULL,
  `snooze_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_THREAD` (`message_id`(100),`recipient_mail`(100),`sender_mail`(100))
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread_rows`
--

LOCK TABLES `thread_rows` WRITE;
/*!40000 ALTER TABLE `thread_rows` DISABLE KEYS */;
INSERT INTO `thread_rows` VALUES (2,'<1625190875.8726145.1467976387311.JavaMail.zimbra@angra.rj.gov.br>','2016-07-08 11:13:07','sec.gie@angra.rj.gov.br','escola202@angra.rj.gov.br','Pedido de toner e cilindro URGENTE','2016-07-08 11:27:37',NULL);
/*!40000 ALTER TABLE `thread_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thread_rows_followers`
--

DROP TABLE IF EXISTS `thread_rows_followers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thread_rows_followers` (
  `thread_id` int(11) NOT NULL,
  `follower` varchar(255) NOT NULL,
  `follower_parameters` text,
  PRIMARY KEY (`thread_id`,`follower`),
  KEY `fk_thread_rows_id` (`thread_id`),
  CONSTRAINT `fk_thread_rows_id` FOREIGN KEY (`thread_id`) REFERENCES `thread_rows` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thread_rows_followers`
--

LOCK TABLES `thread_rows_followers` WRITE;
/*!40000 ALTER TABLE `thread_rows_followers` DISABLE KEYS */;
INSERT INTO `thread_rows_followers` VALUES (2,'org.mxhero.feature.replytimeout','1468062781000;pt_BR;Reply TimeOut <noreply@angra.rj.gov.br>;Fri, 8 Jul 2016 08:13:07 -0300 (BRT);null');
/*!40000 ALTER TABLE `thread_rows_followers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-28 18:49:53
