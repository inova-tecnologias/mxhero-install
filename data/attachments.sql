-- MySQL dump 10.13  Distrib 5.7.16, for Linux (x86_64)
--
-- Host: localhost    Database: attachments
-- ------------------------------------------------------
-- Server version	5.7.16-0ubuntu0.16.04.1

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
-- Table structure for table `attach`
--

DROP TABLE IF EXISTS `attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attach` (
  `attach_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `md5_checksum` varchar(255) CHARACTER SET latin1 NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `size` bigint(20) NOT NULL,
  `mime_type` varchar(255) CHARACTER SET latin1 NOT NULL,
  `path` varchar(255) NOT NULL,
  PRIMARY KEY (`attach_id`),
  UNIQUE KEY `md5_checksum` (`md5_checksum`)
) ENGINE=InnoDB AUTO_INCREMENT=3002875 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `history_access_attach`
--

DROP TABLE IF EXISTS `history_access_attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_access_attach` (
  `history_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_attach_id` bigint(20) DEFAULT NULL,
  `access_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `could_download` tinyint(4) NOT NULL,
  PRIMARY KEY (`history_id`),
  KEY `message_attach_id` (`message_attach_id`),
  CONSTRAINT `FK_history_access_attach_message_attach` FOREIGN KEY (`message_attach_id`) REFERENCES `message_attach` (`message_attach_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1112978 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message` (
  `message_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_platform_id` text CHARACTER SET latin1 NOT NULL,
  `processed` tinyint(4) NOT NULL DEFAULT '1',
  `sender_email` varchar(512) DEFAULT NULL,
  `process_ack_download` tinyint(4) NOT NULL,
  `msg_ack_download` text CHARACTER SET latin1,
  `subject` text,
  `msg_ack_download_html` text,
  `email_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`message_id`),
  UNIQUE KEY `un_msg_msg_id` (`message_platform_id`(255))
) ENGINE=InnoDB AUTO_INCREMENT=4347977 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `message_attach`
--

DROP TABLE IF EXISTS `message_attach`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `message_attach` (
  `message_attach_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `message_id` bigint(20) DEFAULT NULL,
  `attach_id` bigint(20) DEFAULT NULL,
  `recipient_email` varchar(512) DEFAULT NULL,
  `enable_to_download` tinyint(4) NOT NULL DEFAULT '1',
  `was_access_first_time` tinyint(4) NOT NULL DEFAULT '0',
  `creation_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `download_tries_remaining` int(11) DEFAULT NULL,
  PRIMARY KEY (`message_attach_id`),
  UNIQUE KEY `message_id` (`message_id`,`attach_id`,`recipient_email`(100)),
  KEY `attach_id` (`attach_id`),
  KEY `message_id_2` (`message_id`),
  CONSTRAINT `FK_message_attach_attach` FOREIGN KEY (`attach_id`) REFERENCES `attach` (`attach_id`),
  CONSTRAINT `FK_message_attach_message` FOREIGN KEY (`message_id`) REFERENCES `message` (`message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5197936 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-09 16:30:04