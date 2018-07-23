-- MySQL dump 10.13  Distrib 5.7.15, for Linux (x86_64)
--
-- Host: localhost    Database: mxhero
-- ------------------------------------------------------
-- Server version	5.7.15-0ubuntu0.16.04.1

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
-- Table structure for table `account_aliases`
--

DROP TABLE IF EXISTS `account_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_aliases` (
  `account_alias` varchar(100) NOT NULL,
  `domain_alias` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `data_source` varchar(255) NOT NULL,
  `account` varchar(100) NOT NULL,
  `domain_id` varchar(255) NOT NULL,
  PRIMARY KEY (`account_alias`,`domain_alias`),
  KEY `FK_account_aliases_domain` (`domain_id`),
  KEY `FK_account_aliases_domains_aliases` (`domain_id`,`domain_alias`),
  KEY `FK_account_aliases_email_accounts` (`account`,`domain_id`),
  CONSTRAINT `FK_account_aliases_domain` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_account_aliases_domains_aliases` FOREIGN KEY (`domain_id`, `domain_alias`) REFERENCES `domains_aliases` (`domain`, `alias`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_account_aliases_email_accounts` FOREIGN KEY (`account`, `domain_id`) REFERENCES `email_accounts` (`account`, `domain_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_aliases`
--

LOCK TABLES `account_aliases` WRITE;
/*!40000 ALTER TABLE `account_aliases` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `app_users`
--

DROP TABLE IF EXISTS `app_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `app_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `creation` datetime NOT NULL,
  `enabled` bit(1) NOT NULL,
  `last_name` varchar(30) DEFAULT NULL,
  `last_password_update` datetime DEFAULT NULL,
  `locale` varchar(255) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `notify_email` varchar(512) DEFAULT NULL,
  `password` varchar(100) NOT NULL,
  `sounds_enabled` bit(1) NOT NULL,
  `user_name` varchar(100) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `account` varchar(255) DEFAULT NULL,
  `account_domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name_idx` (`user_name`),
  KEY `FK_app_users_domain` (`domain`),
  KEY `FK_app_users_email_accounts` (`account`,`account_domain`),
  CONSTRAINT `FK_app_users_domain` FOREIGN KEY (`domain`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_app_users_email_accounts` FOREIGN KEY (`account`, `account_domain`) REFERENCES `email_accounts` (`account`, `domain_id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1397 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users`
--

LOCK TABLES `app_users` WRITE;
/*!40000 ALTER TABLE `app_users` DISABLE KEYS */;
INSERT INTO `app_users` VALUES (1,'2016-11-09 14:54:59','','MyLastName',NULL,'pt_BR','mxHero Admin','',MD5('GLOBAL_ADMIN_PASSWORD'),'\0','admin',NULL,NULL,NULL);
/*!40000 ALTER TABLE `app_users` ENABLE KEYS */;
UNLOCK TABLES;

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
  KEY `FK_app_users_authorities_app_users` (`app_users_id`),
  KEY `FK_app_users_authorities_authorities` (`authorities_id`),
  CONSTRAINT `FK_app_users_authorities_app_users` FOREIGN KEY (`app_users_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_app_users_authorities_authorities` FOREIGN KEY (`authorities_id`) REFERENCES `authorities` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `app_users_authorities`
--

LOCK TABLES `app_users_authorities` WRITE;
/*!40000 ALTER TABLE `app_users_authorities` DISABLE KEYS */;
INSERT INTO `app_users_authorities` VALUES (1,1),(1,2);
/*!40000 ALTER TABLE `app_users_authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authorities`
--

DROP TABLE IF EXISTS `authorities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authorities` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authority` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authorities`
--

LOCK TABLES `authorities` WRITE;
/*!40000 ALTER TABLE `authorities` DISABLE KEYS */;
INSERT INTO `authorities` VALUES (1,'ROLE_ADMIN'),(2,'ROLE_DOMAIN_ADMIN'),(3,'ROLE_DOMAIN_ACCOUNT');
/*!40000 ALTER TABLE `authorities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `catchall`
--

DROP TABLE IF EXISTS `catchall`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `catchall` (
  `domain_id` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  PRIMARY KEY (`domain_id`),
  KEY `FK_DOMAIN` (`domain_id`),
  CONSTRAINT `FK_DOMAIN` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `catchall`
--

LOCK TABLES `catchall` WRITE;
/*!40000 ALTER TABLE `catchall` DISABLE KEYS */;
/*!40000 ALTER TABLE `catchall` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_of_service`
--

DROP TABLE IF EXISTS `class_of_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `class_of_service` (
  `cos` varchar(255) NOT NULL,
  `edition` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`cos`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_of_service`
--

LOCK TABLES `class_of_service` WRITE;
/*!40000 ALTER TABLE `class_of_service` DISABLE KEYS */;
/*!40000 ALTER TABLE `class_of_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain`
--

DROP TABLE IF EXISTS `domain`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain` (
  `domain` varchar(100) NOT NULL,
  `creation` datetime NOT NULL,
  `server` varchar(100) NOT NULL,
  `updated` datetime NOT NULL,
  `cos` varchar(255) DEFAULT NULL,
  `allowed_ip_masks` text,
  `allowed_transport_agents` text,
  PRIMARY KEY (`domain`),
  KEY `FK_domain_class_of_service` (`cos`),
  CONSTRAINT `FK_domain_class_of_service` FOREIGN KEY (`cos`) REFERENCES `class_of_service` (`cos`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain`
--

LOCK TABLES `domain` WRITE;
/*!40000 ALTER TABLE `domain` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain_adldap`
--

DROP TABLE IF EXISTS `domain_adldap`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_adldap` (
  `domain` varchar(255) NOT NULL DEFAULT '',
  `address` varchar(255) DEFAULT NULL,
  `base` varchar(255) DEFAULT NULL,
  `directory_type` varchar(100) DEFAULT NULL,
  `last_error` varchar(255) DEFAULT NULL,
  `filter` varchar(255) DEFAULT NULL,
  `last_update` datetime DEFAULT NULL,
  `next_update` datetime DEFAULT NULL,
  `override_flag` bit(1) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `port` bigint(20) DEFAULT NULL,
  `ssl_flag` bit(1) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  `dn_authenticate` longtext,
  `period_in_hours` int(11) DEFAULT NULL,
  `metadata` text,
  PRIMARY KEY (`domain`),
  KEY `FK_domain_adldap_domain` (`domain`),
  CONSTRAINT `FK_domain_adldap_domain` FOREIGN KEY (`domain`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain_adldap`
--

LOCK TABLES `domain_adldap` WRITE;
/*!40000 ALTER TABLE `domain_adldap` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_adldap` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domain_adldap_properties`
--

DROP TABLE IF EXISTS `domain_adldap_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domain_adldap_properties` (
  `property_name` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `property_key` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`property_name`,`domain`),
  KEY `FK_domain_adldap_properties_domain_adldap` (`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domain_adldap_properties`
--

LOCK TABLES `domain_adldap_properties` WRITE;
/*!40000 ALTER TABLE `domain_adldap_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `domain_adldap_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `domains_aliases`
--

DROP TABLE IF EXISTS `domains_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `domains_aliases` (
  `alias` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `domain` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`alias`),
  KEY `FK_domains_aliases_domin` (`domain`),
  CONSTRAINT `FK_domains_aliases_domin` FOREIGN KEY (`domain`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `domains_aliases`
--

LOCK TABLES `domains_aliases` WRITE;
/*!40000 ALTER TABLE `domains_aliases` DISABLE KEYS */;
/*!40000 ALTER TABLE `domains_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_accounts`
--

DROP TABLE IF EXISTS `email_accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_accounts` (
  `account` varchar(100) NOT NULL,
  `domain_id` varchar(255) NOT NULL DEFAULT '',
  `created` datetime NOT NULL,
  `data_source` varchar(255) NOT NULL,
  `updated` datetime NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `is_mail_list` bit(1) DEFAULT NULL,
  PRIMARY KEY (`account`,`domain_id`),
  KEY `FK_email_accounts_domain` (`domain_id`),
  KEY `FK_email_accounts_groups` (`domain_id`,`group_name`),
  CONSTRAINT `FK_email_accounts_domain` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_email_accounts_groups` FOREIGN KEY (`domain_id`, `group_name`) REFERENCES `groups` (`domain_id`, `name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_accounts`
--

LOCK TABLES `email_accounts` WRITE;
/*!40000 ALTER TABLE `email_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_accounts_properties`
--

DROP TABLE IF EXISTS `email_accounts_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_accounts_properties` (
  `account` varchar(255) NOT NULL,
  `domain_id` varchar(255) NOT NULL,
  `property_name` varchar(255) NOT NULL,
  `property_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`property_name`,`domain_id`,`account`),
  KEY `FK_email_accounts` (`account`,`domain_id`),
  CONSTRAINT `FK_email_accounts` FOREIGN KEY (`account`, `domain_id`) REFERENCES `email_accounts` (`account`, `domain_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_accounts_properties`
--

LOCK TABLES `email_accounts_properties` WRITE;
/*!40000 ALTER TABLE `email_accounts_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_accounts_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features`
--

DROP TABLE IF EXISTS `features`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `base_priority` bigint(20) NOT NULL,
  `component` varchar(100) NOT NULL,
  `default_admin_order` varchar(20) DEFAULT NULL,
  `description_key` varchar(50) NOT NULL,
  `explain_key` varchar(50) DEFAULT NULL,
  `label_key` varchar(50) NOT NULL,
  `module_report_url` varchar(100) NOT NULL,
  `module_url` varchar(100) NOT NULL,
  `version` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `enabled` bit(1) NOT NULL DEFAULT b'1',
  `module_ico_url` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `component` (`component`,`version`),
  KEY `FK_features_features_categories` (`category_id`),
  CONSTRAINT `FK_features_features_categories` FOREIGN KEY (`category_id`) REFERENCES `features_categories` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features`
--

LOCK TABLES `features` WRITE;
/*!40000 ALTER TABLE `features` DISABLE KEYS */;
INSERT INTO `features` VALUES (1,1800000,'org.mxhero.feature.attachmentblock','before','attachment.block.description','attachment.block.explain','attachment.block.label','org/mxhero/feature/attachmentblock/Report.swf','org/mxhero/feature/attachmentblock/AttachmentBlock.swf',1,1,'','org/mxhero/feature/attachmentblock/ico.png'),(3,200000,'org.mxhero.feature.redirect','before','redirect.description','redirect.explain','redirect.label','org/mxhero/feature/redirect/Report.swf','org/mxhero/feature/redirect/Redirect.swf',1,1,'','org/mxhero/feature/redirect/ico.png'),(5,1500000,'org.mxhero.feature.clamav','before','clamav.description','clamav.explain','clamav.label','org/mxhero/feature/clamav/Report.swf','org/mxhero/feature/clamav/Clamav.swf',1,2,'','org/mxhero/feature/clamav/ico.png'),(6,100000,'org.mxhero.feature.backupcopy','before','backup.copy.description','backup.copy.explain','backup.copy.label','org/mxhero/feature/backupcopy/Report.swf','org/mxhero/feature/backupcopy/BackupCopy.swf',1,2,'','org/mxhero/feature/backupcopy/ico.png'),(10,800000,'org.mxhero.feature.wiretapcontent','before','wiretap.content.description','wiretap.content.explain','wiretap.content.label','org/mxhero/feature/wiretapcontent/Report.swf','org/mxhero/feature/wiretapcontent/WiretapContent.swf',1,3,'','org/mxhero/feature/wiretapcontent/ico.png'),(11,700000,'org.mxhero.feature.wiretapsenderreceiver','before','wiretap.sender.receiver.description','wiretap.sender.receiver.explain','wiretap.sender.receiver.label','org/mxhero/feature/wiretapsenderreceiver/Report.swf','org/mxhero/feature/wiretapsenderreceiver/WiretapSenderReceiver.swf',1,3,'','org/mxhero/feature/wiretapsenderreceiver/ico.png'),(13,2000000,'org.mxhero.feature.emailsizelimiter','before','email.size.limiter.description','email.size.limiter.explain','email.size.limiter.label','org/mxhero/feature/emailsizelimiter/Report.swf','org/mxhero/feature/emailsizelimiter/EmailSizeLimiter.swf',1,1,'','org/mxhero/feature/emailsizelimiter/ico.png'),(14,1700000,'org.mxhero.feature.limituserdestinations','before','limit.user.destination.description','limit.user.destination.explain','limit.user.destination.label','org/mxhero/feature/limituserdestination/Report.swf','org/mxhero/feature/limituserdestination/LimitUserDestination.swf',1,1,'','org/mxhero/feature/limituserdestination/ico.png'),(15,1400000,'org.mxhero.feature.externalantispam','before','external.antispam.description','external.antispam.explain','external.antispam.label','org/mxhero/feature/externalantispam/Report.swf','org/mxhero/feature/externalantispam/ExternalAntispam.swf',1,2,'','org/mxhero/feature/externalantispam/ico.png'),(16,1900000,'org.mxhero.feature.blocklist','before','block.list.description','block.list.explain','block.list.label','org/mxhero/feature/blocklist/Report.swf','org/mxhero/feature/blocklist/BlockList.swf',1,1,'','org/mxhero/feature/blocklist/ico.png'),(17,1600000,'org.mxhero.feature.restricteddelivery','before','restricted.delivery.description','restricted.delivery.explain','restricted.delivery.label','org/mxhero/feature/restricteddelivery/Report.swf','org/mxhero/feature/restricteddelivery/RestrictedDelivery.swf',1,1,'','org/mxhero/feature/restricteddelivery/ico.png'),(18,400000,'org.mxhero.feature.attachmentlink','after','attachment.link.description','attachment.link.explain','attachment.link.label','org/mxhero/feature/attachmentlink/Report.swf','org/mxhero/feature/attachmentlink/AttachmentLink.swf',1,5,'','org/mxhero/feature/attachmentlink/ico.png'),(19,1000000,'org.mxhero.feature.bccpolicy','before','bccpolicy.description','bccpolicy.explain','bccpolicy.label','org/mxhero/feature/bccpolicy/Report.swf','org/mxhero/feature/bccpolicy/BCCPolicy.swf',1,1,'','org/mxhero/feature/bccpolicy/ico.png'),(20,500000,'org.mxhero.feature.attachmenttrack','after','attachmenttrack.description','attachmenttrack.explain','attachmenttrack.label','org/mxhero/feature/attachmenttrack/Report.swf','org/mxhero/feature/attachmenttrack/AttachmentTrack.swf',1,5,'','org/mxhero/feature/attachmenttrack/ico.png'),(21,300000,'org.mxhero.feature.instantalias','after','instantalias.description','instantalias.explain','instantalias.label','org/mxhero/feature/instantalias/Report.swf','org/mxhero/feature/instantalias/InstantAlias.swf',1,5,'','org/mxhero/feature/instantalias/ico.png'),(22,1100000,'org.mxhero.feature.bccusagedetection','before','bccusagedetection.description','bccusagedetection.explain','bccusagedetection.label','org/mxhero/feature/bccusagedetection/Report.swf','org/mxhero/feature/bccusagedetection/BCCUsageDetection.swf',1,3,'','org/mxhero/feature/bccusagedetection/ico.png'),(23,600000,'org.mxhero.feature.replytimeout','after','replytimeout.description','replytimeout.explain','replytimeout.label','org/mxhero/feature/replytimeout/Report.swf','org/mxhero/feature/replytimeout/ReplyTimeout.swf',1,5,'','org/mxhero/feature/replytimeout/ico.png'),(24,900000,'org.mxhero.feature.addressprotection','before','address.protection.description','address.protection.explain','address.protection.label','org/mxhero/feature/addressprotection/Report.swf','org/mxhero/feature/addressprotection/AddressProtection.swf',1,1,'','org/mxhero/feature/addressprotection/ico.png'),(25,1200000,'org.mxhero.feature.enhancedbcc','before','enhancedbcc.description','enhancedbcc.explain','enhancedbcc.label','org/mxhero/feature/enhancedbcc/Report.swf','org/mxhero/feature/enhancedbcc/EnhancedBcc.swf',1,5,'','org/mxhero/feature/enhancedbcc/ico.png'),(26,1650000,'org.mxhero.feature.usagehours','before','usagehours.description','usagehours.explain','usagehours.label','org/mxhero/feature/usagehours/Report.swf','org/mxhero/feature/usagehours/UsageHours.swf',1,1,'','org/mxhero/feature/usagehours/ico.png'),(27,90000,'org.mxhero.feature.disclaimer','before','disclaimer.description','disclaimer.explain','disclaimer.label','org/mxhero/feature/disclaimer/Report.swf','org/mxhero/feature/disclaimer/Disclaimer.swf',1,1,'','org/mxhero/feature/disclaimer/ico.png'),(28,95000,'org.mxhero.feature.signature','before','signature.description','signature.explain','signature.label','org/mxhero/feature/signature/Report.swf','org/mxhero/feature/signature/Signature.swf',1,1,'','org/mxhero/feature/signature/ico.png'),(29,85005,'org.mxhero.feature.sendaspersonal','before','sendaspersonal.description','sendaspersonal.explain','sendaspersonal.label','org/mxhero/feature/sendaspersonal/Report.swf','org/mxhero/feature/sendaspersonal/SendAsPersonal.swf',1,1,'','org/mxhero/feature/sendaspersonal/ico.png'),(30,700000,'org.mxhero.feature.readonce','before','readonce.description','readonce.explain','readonce.label','org/mxhero/feature/readonce/Report.swf','org/mxhero/feature/readonce/ReadOnce.swf',1,2,'','org/mxhero/feature/readonce/ico.png'),(31,350000,'com.mxhero.application.secureemail','after','secureemail.description','secureemail.explain','secureemail.label','org/mxhero/feature/secureemail/Report.swf','org/mxhero/feature/secureemail/SecureEmail.swf',1,2,'','org/mxhero/feature/secureemail/ico.png');
/*!40000 ALTER TABLE `features` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features_categories`
--

DROP TABLE IF EXISTS `features_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `icon_source` varchar(200) NOT NULL,
  `label_key` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features_categories`
--

LOCK TABLES `features_categories` WRITE;
/*!40000 ALTER TABLE `features_categories` DISABLE KEYS */;
INSERT INTO `features_categories` VALUES (1,'images/features/categories/policies.png','policies'),(2,'images/features/categories/security.png','security'),(3,'images/features/categories/monitoring.png','monitoring'),(4,'images/features/categories/unclassified.png','unclassified'),(5,'images/features/categories/enhancements.png','enhancements');
/*!40000 ALTER TABLE `features_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features_rules`
--

DROP TABLE IF EXISTS `features_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features_rules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `admin_order` varchar(20) DEFAULT NULL,
  `created` datetime NOT NULL,
  `enabled` bit(1) NOT NULL,
  `label` varchar(100) DEFAULT NULL,
  `two_ways` bit(1) NOT NULL,
  `updated` datetime NOT NULL,
  `domain_id` varchar(100) DEFAULT NULL,
  `feature_id` int(11) NOT NULL,
  `from_direction_id` int(11) DEFAULT NULL,
  `to_direction_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_features_rule_features` (`feature_id`),
  KEY `FK_features_rules_domain` (`domain_id`),
  CONSTRAINT `FK_features_rule_features` FOREIGN KEY (`feature_id`) REFERENCES `features` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_features_rules_domain` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8313 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features_rules`
--

LOCK TABLES `features_rules` WRITE;
/*!40000 ALTER TABLE `features_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `features_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features_rules_directions`
--

DROP TABLE IF EXISTS `features_rules_directions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features_rules_directions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(100) DEFAULT NULL,
  `directiom_type` varchar(100) NOT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `free_value` varchar(100) NOT NULL,
  `group_name` varchar(100) DEFAULT NULL,
  `rule_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_features_rules_directions_features_rules` (`rule_id`),
  CONSTRAINT `FK_features_rules_directions_features_rules` FOREIGN KEY (`rule_id`) REFERENCES `features_rules` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features_rules_directions`
--

LOCK TABLES `features_rules_directions` WRITE;
/*!40000 ALTER TABLE `features_rules_directions` DISABLE KEYS */;
/*!40000 ALTER TABLE `features_rules_directions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `features_rules_properties`
--

DROP TABLE IF EXISTS `features_rules_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `features_rules_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `property_key` varchar(50) NOT NULL,
  `property_value` text NOT NULL,
  `rule_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_features_rules_properties_features_rules` (`rule_id`),
  CONSTRAINT `FK_features_rules_properties_features_rules` FOREIGN KEY (`rule_id`) REFERENCES `features_rules` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `features_rules_properties`
--

LOCK TABLES `features_rules_properties` WRITE;
/*!40000 ALTER TABLE `features_rules_properties` DISABLE KEYS */;
/*!40000 ALTER TABLE `features_rules_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `domain_id` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(100) NOT NULL,
  `created` datetime NOT NULL,
  `description` varchar(200) DEFAULT NULL,
  `updated` datetime NOT NULL,
  PRIMARY KEY (`domain_id`,`name`),
  KEY `FK_groups_domain` (`domain_id`),
  CONSTRAINT `FK_groups_domain` FOREIGN KEY (`domain_id`) REFERENCES `domain` (`domain`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `system_properties`
--

DROP TABLE IF EXISTS `system_properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `system_properties` (
  `property_key` varchar(100) NOT NULL,
  `property_value` text,
  PRIMARY KEY (`property_key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `system_properties`
--

LOCK TABLES `system_properties` WRITE;
/*!40000 ALTER TABLE `system_properties` DISABLE KEYS */;
INSERT INTO `system_properties` VALUES ('api.password','6x5ItobNGPW31x4'),('api.username','apiuser'),('commercial.version','true'),('default.user.language','pt'),('documentation.url','http://wiki.mxhero.com:8080/display/docs/mxHero+User+Manual'),('external.logo.path',NULL),('feature.category.unclassified.id','4'),('license.data',''),('mail.admin','admin@mxhero.com'),('mail.smtp.auth','false'),('mail.smtp.host','localhost'),('mail.smtp.password',NULL),('mail.smtp.port','25'),('mail.smtp.ssl.enable','false'),('mail.smtp.user',NULL),('news.feed.enabled','false'),('preauth.expires','300000'),('preauth.key','4e2816f16c44fab20ecdee39fb850c3b0bb54d03f1d8e073aaea376a4f407f0c'),('quarantine_url','/roundcube/?_user=MXHERO_USERNAME'),('zimbra.bandwidth.cost','0.555'),('zimbra.currency.symbol','R$'),('zimbra.installation','true'),('zimbra.ldap.host',''),('zimbra.private.key',''),('zimbra.storage.cost','0.061');
/*!40000 ALTER TABLE `system_properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zimbra_provider_data`
--

DROP TABLE IF EXISTS `zimbra_provider_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zimbra_provider_data` (
  `insert_date` date NOT NULL,
  `account` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `totalQuota` bigint(20) DEFAULT NULL,
  `usedQuota` bigint(20) DEFAULT NULL,
  `accountType` varchar(255) DEFAULT NULL,
  `bandwidth` bigint(20) DEFAULT NULL,
  `cos` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`insert_date`,`account`,`domain`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
/*!50100 PARTITION BY KEY (domain)
PARTITIONS 10 */;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zimbra_provider_data`
--

LOCK TABLES `zimbra_provider_data` WRITE;
/*!40000 ALTER TABLE `zimbra_provider_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `zimbra_provider_data` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-29 17:52:12
