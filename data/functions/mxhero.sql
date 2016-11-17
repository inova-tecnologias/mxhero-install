-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mxhero
-- ------------------------------------------------------
-- Server version	5.1.73-0ubuntu0.10.04.1
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'mxhero'
--
/*!50106 SET @save_time_zone= @@TIME_ZONE */ ;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = '' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE EVENT IF NOT EXISTS `update_bandwidth_event` ON SCHEDULE EVERY 1 DAY STARTS '2016-10-21 20:48:45' ON COMPLETION NOT PRESERVE ENABLE DO CALL update_bandwidth(CURRENT_DATE()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'mxhero'
--
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 DROP FUNCTION IF EXISTS `strSplit` */;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 FUNCTION `strSplit`(x varchar(255), delim varchar(12), pos int) RETURNS varchar(255) CHARSET latin1
return replace(substring(substring_index(x, delim, pos), length(substring_index(x, delim, pos - 1)) + 1), delim, '') */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 DROP PROCEDURE IF EXISTS `update_bandwidth` */;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `update_bandwidth`(IN dateto Date)
BEGIN
        DECLARE domain_var VARCHAR(255);
        DECLARE done INT DEFAULT FALSE;
        DECLARE zimbraInstallation INT DEFAULT FALSE;
        DECLARE cur_domain CURSOR FOR SELECT domain FROM mxhero.domain;
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

        SELECT IF(LOWER(property_value) = 'true', TRUE, FALSE) 
        INTO zimbraInstallation
        FROM system_properties 
        WHERE property_key = 'zimbra.installation';
    
    IF zimbraInstallation THEN    
                
        OPEN cur_domain;
        read_loop: LOOP
    FETCH cur_domain INTO domain_var;
        IF done THEN
                LEAVE read_loop;
        END IF;

                INSERT INTO mxhero.zimbra_provider_data (insert_date,account,domain,totalQuota,usedQuota,accountType,bandwidth)
                        (SELECT dateto, strSplit(sender_id,"@",1), sender_domain_id, null, null, null, SUM(bytes_size) as bandwidth
                        FROM statistics.mail_records r
                        WHERE sender_domain_id = domain_var
                        AND insert_date >= dateto
                        AND insert_date < DATE_ADD(dateto, INTERVAL 1 DAY)
                        GROUP BY sender_domain_id,sender_id)
                ON DUPLICATE KEY UPDATE bandwidth=VALUES(bandwidth);
                COMMIT;
                INSERT INTO mxhero.zimbra_provider_data (insert_date,account,domain,totalQuota,usedQuota,accountType,bandwidth)
                        (SELECT dateto, strSplit(recipient_id,"@",1), recipient_domain_id, null, null, null, SUM(bytes_size) as bandwidth
                        FROM statistics.mail_records r
                        WHERE recipient_domain_id = domain_var
                        AND insert_date >= dateto
                        AND insert_date < DATE_ADD(dateto, INTERVAL 1 DAY)
                        GROUP BY recipient_domain_id,recipient_id)
                ON DUPLICATE KEY UPDATE bandwidth=bandwidth+VALUES(bandwidth);
                COMMIT;

        END LOOP;

  CLOSE cur_domain;
  
  END IF;

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
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-11-11 14:52:28
