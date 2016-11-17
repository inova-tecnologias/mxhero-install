-- MySQL dump 10.13  Distrib 5.1.73, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: statistics
-- ------------------------------------------------------
-- Server version	5.1.73-0ubuntu0.10.04.1
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping events for database 'statistics'
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE EVENT IF NOT EXISTS `add_records_parts` ON SCHEDULE EVERY 1 DAY STARTS '2016-10-21 20:48:45' ON COMPLETION NOT PRESERVE ENABLE DO CALL partition_add (CURRENT_DATE()+INTERVAL 7 DAY, 'mail_records','statistics') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE EVENT IF NOT EXISTS `add_stats_parts` ON SCHEDULE EVERY 1 DAY STARTS '2016-10-21 20:48:45' ON COMPLETION NOT PRESERVE ENABLE DO CALL partition_add(CURRENT_DATE()+INTERVAL 7 DAY,'mail_stats','statistics') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE EVENT IF NOT EXISTS `drop_records_parts` ON SCHEDULE EVERY 1 DAY STARTS '2016-10-21 20:48:45' ON COMPLETION NOT PRESERVE ENABLE DO CALL partition_drop(CURRENT_DATE()-INTERVAL 20 DAY,'mail_records','statistics') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;;
/*!50003 SET character_set_client  = latin1 */ ;;
/*!50003 SET character_set_results = latin1 */ ;;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;;
/*!50003 SET @saved_time_zone      = @@time_zone */ ;;
/*!50003 SET time_zone             = 'SYSTEM' */ ;;
/*!50106 CREATE EVENT IF NOT EXISTS `drop_stats_parts` ON SCHEDULE EVERY 1 DAY STARTS '2016-10-21 20:48:45' ON COMPLETION NOT PRESERVE ENABLE DO CALL partition_drop(CURRENT_DATE()-INTERVAL 20 DAY,'mail_stats','statistics') */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
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
/*!50106 CREATE EVENT IF NOT EXISTS `group_all_stats` ON SCHEDULE EVERY 5 MINUTE STARTS '2016-10-21 20:48:45' ON COMPLETION NOT PRESERVE ENABLE DO call group_statistics(now()) */ ;;
/*!50003 SET time_zone             = @saved_time_zone */ ;;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;;
/*!50003 SET character_set_client  = @saved_cs_client */ ;;
/*!50003 SET character_set_results = @saved_cs_results */ ;;
/*!50003 SET collation_connection  = @saved_col_connection */ ;;
DELIMITER ;
/*!50106 SET TIME_ZONE= @save_time_zone */ ;

--
-- Dumping routines for database 'statistics'
--
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = latin1 */ ;
/*!50003 SET character_set_results = latin1 */ ;
/*!50003 SET collation_connection  = latin1_swedish_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 DROP PROCEDURE IF EXISTS `group_statistics`*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `group_statistics`(IN P_DATE DATETIME)
BEGIN



DELETE FROM `statistics`.`mail_stats_grouped` 

WHERE insert_date < DATE_ADD(P_DATE, INTERVAL -30 DAY);





DELETE FROM `statistics`.`mail_stats_grouped` 

WHERE insert_date >=  DATE_FORMAT(P_DATE, '%Y-%m-%d 00:00:00');



INSERT INTO mail_stats_grouped

SELECT insert_date, sender_domain_id, recipient_domain_id, stat_key, stat_value, count(*) amount 

FROM

(SELECT DATE_FORMAT(s.insert_date, '%Y-%m-%d %H:00:00') insert_date, if(r.flow='both' or r.flow='out',r.sender_domain_id,'') sender_domain_id, if(r.flow='both' or r.flow='in',r.recipient_domain_id,'') recipient_domain_id, s.record_sequence , s.stat_key, s.stat_value

FROM `statistics`.mail_stats s

INNER JOIN `statistics`.mail_records r 

ON r.insert_date = s.insert_date 

AND r.record_sequence = s.record_sequence

INNER JOIN `statistics`.mail_stats_grouped_keys k

ON s.stat_key = k.stat_key 

AND s.stat_value like k.stat_value

WHERE s.insert_date >=  DATE_FORMAT(P_DATE, '%Y-%m-%d 00:00:00')

GROUP BY DATE_FORMAT(s.insert_date, '%Y-%m-%d %H:00:00') , if(r.flow='both' or r.flow='out',r.sender_domain_id,''), if(r.flow='both' or r.flow='in',r.recipient_domain_id,''), s.record_sequence, s.stat_key, s.stat_value) c_stats

GROUP BY insert_date, sender_domain_id, recipient_domain_id, stat_key, stat_value;



INSERT INTO mail_stats_grouped

SELECT DATE_FORMAT(r.insert_date, '%Y-%m-%d %H:00:00'), if(r.flow='both' or r.flow='out',r.sender_domain_id,''), if(r.flow='both' or r.flow='in',r.recipient_domain_id,''), 'email.count','count(*)', count(*)

FROM mail_records r

WHERE r.insert_date >=  DATE_FORMAT(P_DATE, '%Y-%m-%d 00:00:00')

GROUP BY DATE_FORMAT(r.insert_date, '%Y-%m-%d %H:00:00') , if(r.flow='both' or r.flow='out',r.sender_domain_id,''), if(r.flow='both' or r.flow='in',r.recipient_domain_id,'');



INSERT INTO mail_stats_grouped

SELECT DATE_FORMAT(r.insert_date, '%Y-%m-%d %H:00:00'), if(r.flow='both' or r.flow='out',r.sender_domain_id,''), if(r.flow='both' or r.flow='in',r.recipient_domain_id,''), 'email.size','sum(r.bytes_size)', sum(r.bytes_size)

FROM mail_records r

WHERE r.insert_date >=  DATE_FORMAT(P_DATE, '%Y-%m-%d 00:00:00')

GROUP BY DATE_FORMAT(r.insert_date, '%Y-%m-%d %H:00:00') , if(r.flow='both' or r.flow='out',r.sender_domain_id,''), if(r.flow='both' or r.flow='in',r.recipient_domain_id,'');





COMMIT;



END */;;
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
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 DROP PROCEDURE IF EXISTS `partition_add`*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `partition_add`(IN through_date date, IN tbl varchar(64), IN db varchar(64))
BEGIN
DECLARE add_me char(10);
DECLARE max_new_parts,add_cnt smallint unsigned default 0;
SELECT 1024-COUNT(*) AS max_new_parts,
SUM(CASE WHEN
 DATE(PARTITION_NAME)>=through_date then 1 else 0
 END)
INTO max_new_parts, add_cnt
FROM INFORMATION_SCHEMA.PARTITIONS
WHERE  TABLE_SCHEMA = db
 AND TABLE_NAME = tbl;

IF add_cnt=0 THEN
BEGIN
SELECT MAX(DATE(PARTITION_NAME)) INTO add_me
FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME=tbl and TABLE_SCHEMA=db
AND DATE(PARTITION_NAME)<through_date;


IF DATEDIFF(through_date,add_me)+1 < max_new_parts THEN
BEGIN
WHILE add_me<through_date do BEGIN
SET add_me:=DATE_FORMAT(add_me + INTERVAL 1 DAY,"%Y_%m_%d");
SET @alter_stmt:=CONCAT("ALTER TABLE ",db,".",tbl," ADD PARTITION (PARTITION ",add_me," VALUES LESS THAN (TO_DAYS('",add_me+INTERVAL 1 DAY, "')))" );

PREPARE stmt_alter FROM @alter_stmt; EXECUTE stmt_alter; DEALLOCATE PREPARE stmt_alter;

END;
END WHILE;
END;
END IF;
END;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 DROP PROCEDURE IF EXISTS `partition_drop`*/;;
/*!50003 CREATE*/ /*!50020 DEFINER=`root`@`localhost`*/ /*!50003 PROCEDURE `partition_drop`(IN through_date date, IN tbl varchar(64), IN db varchar(64))
BEGIN
DECLARE delete_me varchar(64);
DECLARE notfound BOOL DEFAULT FALSE;
DECLARE pname CURSOR FOR SELECT PARTITION_NAME
FROM INFORMATION_SCHEMA.PARTITIONS WHERE TABLE_NAME=tbl AND TABLE_SCHEMA=db
AND DATE(PARTITION_NAME)!= 0
AND DATE(PARTITION_NAME) IS NOT NULL
AND DATE(PARTITION_NAME)<=through_date;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET notfound:=TRUE;
OPEN pname;

cursor_loop: LOOP
FETCH pname INTO delete_me;
IF notfound THEN LEAVE cursor_loop; END IF;
SET @alter_stmt:=CONCAT("ALTER TABLE ",db,".",tbl," DROP PARTITION ",delete_me);



PREPARE stmt_alter FROM @alter_stmt; EXECUTE stmt_alter; DEALLOCATE PREPARE stmt_alter;

END LOOP;
CLOSE pname;
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

-- Dump completed on 2016-11-11 14:52:29
