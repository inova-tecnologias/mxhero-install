-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: statistics
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
-- Table structure for table `app_users_authorities`
--

DROP TABLE IF EXISTS `app_users_authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_users_authorities` (
  `app_users_id` int(11) NOT NULL,
  `authorities_id` int(11) NOT NULL,
  PRIMARY KEY (`app_users_id`,`authorities_id`),
  KEY `FK6EC5B0CC7C644C90` (`app_users_id`),
  KEY `FK6EC5B0CC9EA31A41` (`authorities_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_records`
--

DROP TABLE IF EXISTS `mail_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_records` (
  `insert_date` datetime NOT NULL,
  `record_sequence` bigint(20) NOT NULL,
  `server_name` varchar(255) NOT NULL DEFAULT 'MXHERO',
  `bcc_recipients` longtext,
  `bytes_size` int(11) DEFAULT NULL,
  `cc_recipients` longtext,
  `from_recipients` varchar(512) DEFAULT NULL,
  `message_id` longtext NOT NULL,
  `ng_recipients` longtext,
  `phase` varchar(10) NOT NULL,
  `recipient` varchar(512) DEFAULT NULL,
  `recipient_domain_id` varchar(255) DEFAULT NULL,
  `recipient_id` varchar(512) DEFAULT NULL,
  `sender` varchar(512) DEFAULT NULL,
  `sender_domain_id` varchar(255) DEFAULT NULL,
  `sender_id` varchar(512) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `state_reason` varchar(255) DEFAULT NULL,
  `subject` longtext,
  `to_recipients` longtext,
  `flow` varchar(10) DEFAULT NULL,
  `sender_group` varchar(255) DEFAULT NULL,
  `recipient_group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`insert_date`,`record_sequence`,`server_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE (TO_DAYS(insert_date))
(PARTITION 2016_09_22 VALUES LESS THAN (736595) ENGINE = InnoDB,
 PARTITION 2016_09_23 VALUES LESS THAN (736596) ENGINE = InnoDB,
 PARTITION 2016_09_24 VALUES LESS THAN (736597) ENGINE = InnoDB,
 PARTITION 2016_09_25 VALUES LESS THAN (736598) ENGINE = InnoDB,
 PARTITION 2016_09_26 VALUES LESS THAN (736599) ENGINE = InnoDB,
 PARTITION 2016_09_27 VALUES LESS THAN (736600) ENGINE = InnoDB,
 PARTITION 2016_09_28 VALUES LESS THAN (736601) ENGINE = InnoDB,
 PARTITION 2016_09_29 VALUES LESS THAN (736602) ENGINE = InnoDB,
 PARTITION 2016_09_30 VALUES LESS THAN (736603) ENGINE = InnoDB,
 PARTITION 2016_10_01 VALUES LESS THAN (736604) ENGINE = InnoDB,
 PARTITION 2016_10_02 VALUES LESS THAN (736605) ENGINE = InnoDB,
 PARTITION 2016_10_03 VALUES LESS THAN (736606) ENGINE = InnoDB,
 PARTITION 2016_10_04 VALUES LESS THAN (736607) ENGINE = InnoDB,
 PARTITION 2016_10_05 VALUES LESS THAN (736608) ENGINE = InnoDB,
 PARTITION 2016_10_06 VALUES LESS THAN (736609) ENGINE = InnoDB,
 PARTITION 2016_10_07 VALUES LESS THAN (736610) ENGINE = InnoDB,
 PARTITION 2016_10_08 VALUES LESS THAN (736611) ENGINE = InnoDB,
 PARTITION 2016_10_09 VALUES LESS THAN (736612) ENGINE = InnoDB,
 PARTITION 2016_10_10 VALUES LESS THAN (736613) ENGINE = InnoDB,
 PARTITION 2016_10_11 VALUES LESS THAN (736614) ENGINE = InnoDB,
 PARTITION 2016_10_12 VALUES LESS THAN (736615) ENGINE = InnoDB,
 PARTITION 2016_10_13 VALUES LESS THAN (736616) ENGINE = InnoDB,
 PARTITION 2016_10_14 VALUES LESS THAN (736617) ENGINE = InnoDB,
 PARTITION 2016_10_15 VALUES LESS THAN (736618) ENGINE = InnoDB,
 PARTITION 2016_10_16 VALUES LESS THAN (736619) ENGINE = InnoDB,
 PARTITION 2016_10_17 VALUES LESS THAN (736620) ENGINE = InnoDB,
 PARTITION 2016_10_18 VALUES LESS THAN (736621) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_stats`
--

DROP TABLE IF EXISTS `mail_stats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_stats` (
  `stat_key` varchar(255) NOT NULL,
  `stat_value` longtext,
  `insert_date` datetime NOT NULL,
  `record_sequence` bigint(20) NOT NULL,
  `server_name` varchar(255) NOT NULL DEFAULT 'MXHERO',
  `phase` varchar(10) NOT NULL,
  PRIMARY KEY (`stat_key`,`insert_date`,`record_sequence`,`server_name`,`phase`),
  KEY `FKC656C8173036DEAB` (`insert_date`,`record_sequence`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY RANGE (TO_DAYS(insert_date))
(PARTITION 2016_09_22 VALUES LESS THAN (736595) ENGINE = InnoDB,
 PARTITION 2016_09_23 VALUES LESS THAN (736596) ENGINE = InnoDB,
 PARTITION 2016_09_24 VALUES LESS THAN (736597) ENGINE = InnoDB,
 PARTITION 2016_09_25 VALUES LESS THAN (736598) ENGINE = InnoDB,
 PARTITION 2016_09_26 VALUES LESS THAN (736599) ENGINE = InnoDB,
 PARTITION 2016_09_27 VALUES LESS THAN (736600) ENGINE = InnoDB,
 PARTITION 2016_09_28 VALUES LESS THAN (736601) ENGINE = InnoDB,
 PARTITION 2016_09_29 VALUES LESS THAN (736602) ENGINE = InnoDB,
 PARTITION 2016_09_30 VALUES LESS THAN (736603) ENGINE = InnoDB,
 PARTITION 2016_10_01 VALUES LESS THAN (736604) ENGINE = InnoDB,
 PARTITION 2016_10_02 VALUES LESS THAN (736605) ENGINE = InnoDB,
 PARTITION 2016_10_03 VALUES LESS THAN (736606) ENGINE = InnoDB,
 PARTITION 2016_10_04 VALUES LESS THAN (736607) ENGINE = InnoDB,
 PARTITION 2016_10_05 VALUES LESS THAN (736608) ENGINE = InnoDB,
 PARTITION 2016_10_06 VALUES LESS THAN (736609) ENGINE = InnoDB,
 PARTITION 2016_10_07 VALUES LESS THAN (736610) ENGINE = InnoDB,
 PARTITION 2016_10_08 VALUES LESS THAN (736611) ENGINE = InnoDB,
 PARTITION 2016_10_09 VALUES LESS THAN (736612) ENGINE = InnoDB,
 PARTITION 2016_10_10 VALUES LESS THAN (736613) ENGINE = InnoDB,
 PARTITION 2016_10_11 VALUES LESS THAN (736614) ENGINE = InnoDB,
 PARTITION 2016_10_12 VALUES LESS THAN (736615) ENGINE = InnoDB,
 PARTITION 2016_10_13 VALUES LESS THAN (736616) ENGINE = InnoDB,
 PARTITION 2016_10_14 VALUES LESS THAN (736617) ENGINE = InnoDB,
 PARTITION 2016_10_15 VALUES LESS THAN (736618) ENGINE = InnoDB,
 PARTITION 2016_10_16 VALUES LESS THAN (736619) ENGINE = InnoDB,
 PARTITION 2016_10_17 VALUES LESS THAN (736620) ENGINE = InnoDB,
 PARTITION 2016_10_18 VALUES LESS THAN (736621) ENGINE = InnoDB) */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_stats_grouped`
--

DROP TABLE IF EXISTS `mail_stats_grouped`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_stats_grouped` (
  `insert_date` datetime NOT NULL,
  `sender_domain_id` varchar(255) NOT NULL,
  `recipient_domain_id` varchar(255) NOT NULL,
  `stat_key` varchar(255) NOT NULL,
  `stat_value` varchar(255) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`insert_date`,`sender_domain_id`,`recipient_domain_id`,`stat_key`,`stat_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mail_stats_grouped_keys`
--

DROP TABLE IF EXISTS `mail_stats_grouped_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mail_stats_grouped_keys` (
  `stat_key` varchar(255) NOT NULL,
  `stat_value` varchar(255) NOT NULL,
  PRIMARY KEY (`stat_key`,`stat_value`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-10-12 18:28:08
