-- MySQL dump 10.13  Distrib 5.5.44, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: sureify
-- ------------------------------------------------------
-- Server version	5.5.44-0ubuntu0.14.04.1

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
-- Table structure for table `challenges_master`
--

DROP TABLE IF EXISTS `challenges_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenges_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key devices_master table',
  `plan_id` int(11) NOT NULL COMMENT 'Primary key of the plans table',
  `name` varchar(255) DEFAULT NULL COMMENT 'Challenge name',
  `type` int(4) DEFAULT NULL COMMENT 'Challenge type links to group_values(steps/weight/other',
  `goal` float(4,2) DEFAULT NULL COMMENT 'Goal value (no of steps or weight value)',
  `discount` float(4,2) DEFAULT NULL COMMENT 'Discount value',
  `start_date` datetime DEFAULT NULL COMMENT 'Challenge start date',
  `end_date` datetime DEFAULT NULL COMMENT 'Challenge end date',
  `frequency` int(4) DEFAULT NULL COMMENT 'frequency linked to group_values (weekly,monthly,yearly)',
  `cheat_days` int(4) DEFAULT NULL COMMENT 'Number of cheat days applicable for a challenge',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `challenges_master_session_fk` (`user_session_id`),
  KEY `challenges_master_plans_fk` (`plan_id`),
  CONSTRAINT `challenges_master_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `challenges_master_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenges_master`
--

LOCK TABLES `challenges_master` WRITE;
/*!40000 ALTER TABLE `challenges_master` DISABLE KEYS */;
INSERT INTO `challenges_master` VALUES (1,2,'sai krishna teja',3001,99.99,0.50,'2015-11-13 00:00:00','2015-11-13 00:00:00',12,25,1,57,'2015-11-09 04:43:28','2015-11-09 12:43:28'),(2,2,'jkhkj',3001,44.00,15.00,'2015-11-19 00:00:00','2015-11-19 00:00:00',15,25,1,57,'2015-11-09 04:45:39','2015-11-09 12:45:39');
/*!40000 ALTER TABLE `challenges_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_challenges_master_after_insert
    AFTER INSERT ON challenges_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_challenges_master
    SET challenges_master_id = new.id,
	plan_id = new.plan_id,
	name = new.name,
	type = new.type,
	goal = new.goal,
	discount = new.discount,
	start_date = new.start_date,
	end_date = new.end_date,
	frequency = new.frequency,
	cheat_days = new.cheat_days,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_challenges_master_before_update
    BEFORE UPDATE ON challenges_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_challenges_master
    SET challenges_master_id = old.id,
	plan_id = old.plan_id,
	name = old.name,
	type = old.type,
	goal = old.goal,
	discount = old.discount,
	start_date = old.start_date,
	end_date = old.end_date,
	frequency = old.frequency,
	cheat_days = old.cheat_days,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_challenges_master_before_delete
    BEFORE Delete ON challenges_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_challenges_master
    SET challenges_master_id = old.id,
	plan_id = old.plan_id,
	name = old.name,
	type = old.type,
	goal = old.goal,
	discount = old.discount,
	start_date = old.start_date,
	end_date = old.end_date,
	frequency = old.frequency,
	cheat_days = old.cheat_days,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `claims`
--

DROP TABLE IF EXISTS `claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `claims` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key claims table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key of the policies table',
  `claim_amount` float(10,2) DEFAULT NULL COMMENT 'Claimed amount',
  `paid_date` datetime DEFAULT NULL COMMENT 'Date of paid',
  `paid_to` int(11) DEFAULT NULL COMMENT 'Primary key of the benificiary table',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `claims_session_fk` (`user_session_id`),
  KEY `claims_fk` (`user_id`),
  KEY `claims_policy_fk` (`policy_id`),
  KEY `claims_paidto_fk` (`paid_to`),
  CONSTRAINT `claims_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `claims_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `claims_ibfk_3` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`id`),
  CONSTRAINT `claims_ibfk_4` FOREIGN KEY (`paid_to`) REFERENCES `policy_benificiaries` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `claims`
--

LOCK TABLES `claims` WRITE;
/*!40000 ALTER TABLE `claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `claims` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_claims_after_insert
    AFTER INSERT ON claims
    FOR EACH ROW BEGIN
 
    INSERT INTO claims
    SET claims_id = new.id,
	user_id = new.user_id,
	policy_id = new.policy_id,
	claim_amount = new.claim_amount,
	paid_date = new.paid_date,
	paid_to = new.paid_to,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_claims_before_update
    BEFORE UPDATE ON claims
    FOR EACH ROW BEGIN
 
    INSERT INTO claims
    SET claims_id = old.id,
	user_id = old.user_id,
	policy_id = old.policy_id,
	claim_amount = old.claim_amount,
	paid_date = old.paid_date,
	paid_to = old.paid_to,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_claims_before_delete
    BEFORE Delete ON claims
    FOR EACH ROW BEGIN
 
    INSERT INTO claims
    SET claims_id = old.id,
	user_id = old.user_id,
	policy_id = old.policy_id,
	claim_amount = old.claim_amount,
	paid_date = old.paid_date,
	paid_to = old.paid_to,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `devices_master`
--

DROP TABLE IF EXISTS `devices_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `devices_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key devices_master table',
  `device_name` varchar(255) DEFAULT NULL COMMENT 'Name of the device',
  `cost` float(10,2) DEFAULT NULL COMMENT 'Cost price of the device',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `devices_master_session_fk` (`user_session_id`),
  CONSTRAINT `devices_master_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `devices_master`
--

LOCK TABLES `devices_master` WRITE;
/*!40000 ALTER TABLE `devices_master` DISABLE KEYS */;
INSERT INTO `devices_master` VALUES (1,'flex',500.00,0,54,'2015-11-05 05:07:25','2015-11-05 13:28:45'),(2,'krish',500.00,0,54,'2015-11-05 05:07:41','2015-11-05 13:23:11'),(3,'flex',505.00,0,54,'2015-11-05 05:28:17','2015-11-05 13:28:36'),(4,'Charge Small',1000.00,0,55,'2015-11-05 22:03:42','2015-11-06 06:04:07'),(5,'Surge',1500.00,0,54,'2015-11-05 05:30:06','2015-11-05 13:34:01'),(6,'Surge',1050.00,0,54,'2015-11-05 05:30:24','2015-11-05 13:34:01'),(7,'Charge Small',123.00,0,55,'2015-11-05 21:59:15','2015-11-06 05:59:23'),(8,'Charge Small',540.00,1,55,'2015-11-05 22:04:20','2015-11-06 06:04:20'),(9,'H23',252.00,1,57,'2015-11-09 04:42:40','2015-11-09 12:42:40');
/*!40000 ALTER TABLE `devices_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_devices_master_after_insert
    AFTER INSERT ON devices_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_devices_master
    SET devices_master_id = new.id,
	device_name = new.device_name,
    cost = new.cost,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_devices_master_before_update
    BEFORE UPDATE ON devices_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_devices_master
    SET devices_master_id = old.id,
	device_name = old.device_name,
    cost = old.cost,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_devices_master_before_delete
    BEFORE Delete ON devices_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_devices_master
    SET devices_master_id = old.id,
	device_name = old.device_name,
    cost = old.cost,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `discounts_master`
--

DROP TABLE IF EXISTS `discounts_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discounts_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key discounts_master table',
  `discount_name` varchar(255) DEFAULT NULL COMMENT 'Name of the discount',
  `discount_type` varchar(255) DEFAULT NULL COMMENT 'Type of the discount',
  `discount_percentage` float(3,2) DEFAULT NULL COMMENT 'Discount percentage value',
  `cheat_days` int(4) DEFAULT NULL COMMENT 'Number of cheat_days',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `dicount_master_session_fk` (`user_session_id`),
  CONSTRAINT `discounts_master_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discounts_master`
--

LOCK TABLES `discounts_master` WRITE;
/*!40000 ALTER TABLE `discounts_master` DISABLE KEYS */;
INSERT INTO `discounts_master` VALUES (1,'diwali bonanzas','1',9.99,25,1,57,'2015-11-09 04:54:29','2015-11-09 12:54:29');
/*!40000 ALTER TABLE `discounts_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_discounts_master_after_insert
    AFTER INSERT ON discounts_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_discounts_master
    SET discounts_master_id = new.id,
	discount_name = new.discount_name,
	discount_type = new.discount_type,
	discount_percentage = new.discount_percentage,
	cheat_days = new.cheat_days,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_discounts_master_before_update
    BEFORE UPDATE ON discounts_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_discounts_master
    SET discounts_master_id = old.id,
	discount_name = old.discount_name,
	discount_type = old.discount_type,
	discount_percentage = old.discount_percentage,
	cheat_days = old.cheat_days,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_discounts_master_before_delete
    BEFORE Delete ON discounts_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_discounts_master
    SET discounts_master_id = old.id,
	discount_name = old.discount_name,
	discount_type = old.discount_type,
	discount_percentage = old.discount_percentage,
	cheat_days = old.cheat_days,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `disease_master`
--

DROP TABLE IF EXISTS `disease_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `disease_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key disease_master table',
  `disease_name` varchar(255) DEFAULT NULL COMMENT 'Name of the disease',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `disease_master_session_fk` (`user_session_id`),
  CONSTRAINT `disease_master_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `disease_master`
--

LOCK TABLES `disease_master` WRITE;
/*!40000 ALTER TABLE `disease_master` DISABLE KEYS */;
INSERT INTO `disease_master` VALUES (1,'Malaria123',0,55,'2015-11-05 21:42:40','2015-11-06 05:42:46'),(2,'Mala',1,57,'2015-11-09 04:42:02','2015-11-09 12:42:02'),(3,'mala1',1,59,'2015-11-11 22:04:02','2015-11-12 06:04:02');
/*!40000 ALTER TABLE `disease_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_disease_master_after_insert
    AFTER INSERT ON disease_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_disease_master
    SET disease_master_id = new.id,
	disease_name = new.disease_name,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_disease_master_before_update
    BEFORE UPDATE ON disease_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_disease_master
    SET disease_master_id = old.id,
	disease_name = old.disease_name,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_disease_master_before_delete
    BEFORE Delete ON disease_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_disease_master
    SET disease_master_id = old.id,
	disease_name = old.disease_name,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `email_log`
--

DROP TABLE IF EXISTS `email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary email_log table',
  `email_to` varchar(255) DEFAULT NULL COMMENT 'To email id',
  `email_from` varchar(255) DEFAULT NULL COMMENT 'From email id',
  `email_subject` text COMMENT 'Email subject',
  `email_body` text COMMENT 'Email body',
  `email_status` tinyint(1) DEFAULT NULL COMMENT '1-successfull 0-Fail',
  `fail_reason` text COMMENT 'Email failed reason',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `email_log_session_fk` (`user_session_id`),
  CONSTRAINT `email_log_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log`
--

LOCK TABLES `email_log` WRITE;
/*!40000 ALTER TABLE `email_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_log` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_email_log_after_insert
    AFTER INSERT ON email_log
    FOR EACH ROW BEGIN
 
    INSERT INTO history_email_log
    SET email_log_id = new.id,
	email_to = new.email_to,
	email_from = new.email_from,
	email_subject = new.email_subject,
	email_body = new.email_body,
	email_status = new.email_status,
	fail_reason = new.fail_reason,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_email_log_before_update
    BEFORE UPDATE ON email_log
    FOR EACH ROW BEGIN
 
    INSERT INTO history_email_log
    SET email_log_id = old.id,
	email_to = old.email_to,
	email_from = old.email_from,
	email_subject = old.email_subject,
	email_body = old.email_body,
	email_status = old.email_status,
	fail_reason = old.fail_reason,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_email_log_before_delete
    BEFORE Delete ON email_log
    FOR EACH ROW BEGIN
 
    INSERT INTO history_email_log
    SET email_log_id = old.id,
	email_to = old.email_to,
	email_from = old.email_from,
	email_subject = old.email_subject,
	email_body = old.email_body,
	email_status = old.email_status,
	fail_reason = old.fail_reason,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary email_templates table',
  `title` varchar(255) DEFAULT NULL COMMENT 'Email title',
  `template_name` varchar(255) DEFAULT NULL COMMENT 'Template name',
  `email_subject` text COMMENT 'Email subject',
  `email_body` text COMMENT 'Email body',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `email_templates_session_fk` (`user_session_id`),
  CONSTRAINT `email_templates_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,'send',NULL,NULL,NULL,0,57,'2015-11-09 00:10:47','2015-11-09 08:13:14'),(2,'send',NULL,NULL,NULL,0,57,'2015-11-09 00:13:36','2015-11-09 08:26:18'),(3,'send123','send','ssssssssss','ssdffffffffffff',0,57,'2015-11-09 00:19:41','2015-11-09 10:04:16'),(4,'send','send','ssssssssss','ssdffffffffffff',0,57,'2015-11-09 00:26:46','2015-11-09 08:27:04'),(5,'send','send','ljs;kdljfljsg','ajsldfksldfasd',0,57,'2015-11-09 00:27:20','2015-11-09 10:04:16'),(6,'send','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:04:42','2015-11-09 10:04:42'),(7,'send123','send','ssfsadfsafd','asfsdfs',0,57,'2015-11-09 02:05:02','2015-11-09 10:09:26'),(8,'send1234','send','ssfsadfsafd','asfsdfs',0,57,'2015-11-09 02:05:26','2015-11-09 10:09:26'),(9,'send1234','send','sfasdfs','asfdsdf',1,57,'2015-11-09 02:09:59','2015-11-09 10:09:59'),(10,'sbhs','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:27:23','2015-11-09 10:27:23');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_email_templates_after_insert
    AFTER INSERT ON email_templates
    FOR EACH ROW BEGIN
 
    INSERT INTO history_email_templates
    SET email_templates_id = new.id,
	title = new.title,
	template_name = new.template_name,
	email_subject = new.email_subject,
	email_body = new.email_body,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_email_templates_before_update
    BEFORE UPDATE ON email_templates
    FOR EACH ROW BEGIN
 
    INSERT INTO history_email_templates
    SET email_templates_id = old.id,
	title = old.title,
	template_name = old.template_name,
	email_subject = old.email_subject,
	email_body =  old.email_body,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_email_templates_before_delete
    BEFORE Delete ON email_templates
    FOR EACH ROW BEGIN
 
    INSERT INTO history_email_templates
    SET email_templates_id = old.id,
	title = old.title,
	template_name = old.template_name,
	email_subject = old.email_subject,
	email_body = old.email_body,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `expenses`
--

DROP TABLE IF EXISTS `expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key expenses table',
  `expense_id` int(11) NOT NULL COMMENT 'Primary key of the expenses master',
  `expense_date` datetime DEFAULT NULL COMMENT 'Date of expense',
  `expense_amount` float(10,2) DEFAULT NULL COMMENT 'Expense Amount',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `expenses_session_fk` (`user_session_id`),
  KEY `expenses__ex_master_fk` (`expense_id`),
  CONSTRAINT `expenses_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `expenses_ibfk_2` FOREIGN KEY (`expense_id`) REFERENCES `expenses_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses`
--

LOCK TABLES `expenses` WRITE;
/*!40000 ALTER TABLE `expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `expenses` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_expenses_after_insert
    AFTER INSERT ON expenses
    FOR EACH ROW BEGIN
 
    INSERT INTO history_expenses
    SET expenses_id = new.id,
	expense_id = new.expense_id,
	expense_date = new.expense_date,
	expense_amount = new.expense_amount,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_expenses_before_update
    BEFORE UPDATE ON expenses
    FOR EACH ROW BEGIN
 
    INSERT INTO history_expenses
    SET expenses_id = old.id,
	expense_id = old.expense_id,
	expense_date = old.expense_date,
	expense_amount = old.expense_amount,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_expenses_before_delete
    BEFORE Delete ON expenses
    FOR EACH ROW BEGIN
 
    INSERT INTO history_expenses
    SET expenses_id = old.id,
	expense_id = old.expense_id,
	expense_date = old.expense_date,
	expense_amount = old.expense_amount,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `expenses_master`
--

DROP TABLE IF EXISTS `expenses_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expenses_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key expenses_master table',
  `expense_name` varchar(255) DEFAULT NULL COMMENT 'Name of the expense',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `expense_master_session_fk` (`user_session_id`),
  CONSTRAINT `expenses_master_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_master`
--

LOCK TABLES `expenses_master` WRITE;
/*!40000 ALTER TABLE `expenses_master` DISABLE KEYS */;
INSERT INTO `expenses_master` VALUES (1,'Salaries',0,57,'2015-11-08 21:53:06','2015-11-09 06:06:49'),(2,'Salarie',0,57,'2015-11-08 21:53:51','2015-11-09 06:06:49'),(3,'Salaries123',0,57,'2015-11-08 22:11:57','2015-11-09 06:17:59'),(4,'Salaries',0,57,'2015-11-08 22:16:58','2015-11-09 06:17:59'),(5,'chairs',0,57,'2015-11-08 22:17:14','2015-11-09 06:17:59'),(6,'Salaries',0,57,'2015-11-08 22:18:11','2015-11-09 06:19:32'),(7,'Salaries123',0,57,'2015-11-08 22:18:48','2015-11-09 06:19:32'),(8,'Salaries',0,57,'2015-11-08 22:19:56','2015-11-09 06:20:10'),(9,'Salaries123',1,57,'2015-11-09 02:07:36','2015-11-09 10:07:36');
/*!40000 ALTER TABLE `expenses_master` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_expenses_master_after_insert
    AFTER INSERT ON expenses_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_expenses_master
    SET expenses_master_id = new.id,
	expense_name = new.expense_name,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_expenses_master_before_update
    BEFORE UPDATE ON expenses_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_expenses_master
    SET expenses_master_id = old.id,
	expense_name = old.expense_name,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_expenses_master_before_delete
    BEFORE Delete ON expenses_master
    FOR EACH ROW BEGIN
 
    INSERT INTO history_expenses_master
    SET expenses_master_id = old.id,
	expense_name = old.expense_name,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `group_values`
--

DROP TABLE IF EXISTS `group_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_values` (
  `id` int(11) NOT NULL COMMENT 'Primary key of group_values table',
  `group_id` int(11) DEFAULT NULL COMMENT 'Primary key of groups table',
  `name` varchar(255) DEFAULT NULL COMMENT 'Group name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Group description',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_values`
--

LOCK TABLES `group_values` WRITE;
/*!40000 ALTER TABLE `group_values` DISABLE KEYS */;
INSERT INTO `group_values` VALUES (1001,1000,'Active','Active User',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(1002,1000,'Inactive','Inactive User',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(1003,1000,'Blocked','Blocked User',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(2001,2000,'Super Admin','Super admin',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(2002,2000,'Admin','Admin',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(2003,2000,'Agent','Agent',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(2004,2000,'Customer','Customer',1,'2015-11-03 11:29:00','2015-11-03 05:59:00'),(3001,3000,'Steps','Steps',1,'2015-11-03 11:29:00','2015-11-03 00:29:00'),(3002,3000,'Weights','Weights',1,'2015-11-03 11:29:00','2015-11-03 00:29:00'),(2005,2000,'Under Writer','Under Writer',1,'2015-11-16 11:46:56','2015-11-16 06:16:56');
/*!40000 ALTER TABLE `group_values` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_group_values_after_insert
    AFTER INSERT ON group_values
    FOR EACH ROW BEGIN
 
    INSERT INTO history_group_values
    SET group_values_id = new.id,
    group_id = new.group_id,
	name = new.name,
	description = new.description,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_group_values_before_update
    BEFORE UPDATE ON group_values
    FOR EACH ROW BEGIN
 
    INSERT INTO history_group_values
    SET group_values_id = old.id,
    group_id = old.group_id,
	name = old.name,
	description = old.description,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_group_values_before_delete
    BEFORE Delete ON group_values
    FOR EACH ROW BEGIN
 
    INSERT INTO history_group_values
    SET group_values_id = old.id,
    group_id = old.group_id,
	name = old.name,
	description = old.description,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `groups`
--

DROP TABLE IF EXISTS `groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `groups` (
  `id` int(11) NOT NULL COMMENT 'Primary key of groups table',
  `name` varchar(255) DEFAULT NULL COMMENT 'Group name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Group description',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `groups`
--

LOCK TABLES `groups` WRITE;
/*!40000 ALTER TABLE `groups` DISABLE KEYS */;
INSERT INTO `groups` VALUES (1000,'User Status','Status of Users',1,'2015-11-03 11:25:00','2015-11-03 05:55:00'),(2000,'User Roles','Roles of Users',1,'2015-11-03 11:25:00','2015-11-03 05:55:00'),(3000,'User Type','Type of Users',1,'2015-11-03 11:25:00','2015-11-03 00:25:00');
/*!40000 ALTER TABLE `groups` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_groups_after_insert
    AFTER INSERT ON groups
    FOR EACH ROW BEGIN
 
    INSERT INTO history_groups
    SET groups_id = new.id,
	name = new.name,
	description = new.description,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_groups_before_update
    BEFORE UPDATE ON groups
    FOR EACH ROW BEGIN
 
    INSERT INTO history_groups
    SET groups_id = old.id,
	name = old.name,
	description = old.description,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_groups_before_delete
    BEFORE Delete ON groups
    FOR EACH ROW BEGIN
 
    INSERT INTO history_groups
    SET groups_id = old.id,
	name = old.name,
	description = old.description,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `height_weight_chart`
--

DROP TABLE IF EXISTS `height_weight_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `height_weight_chart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key height_weight_chart table',
  `height` varchar(255) DEFAULT NULL COMMENT 'Height value',
  `normal_start` int(11) DEFAULT NULL COMMENT 'Normal weight starts',
  `normal_end` int(11) DEFAULT NULL COMMENT 'Normal weight ends',
  `over_weight_start` int(11) DEFAULT NULL COMMENT 'over weight starts',
  `over_weight_end` int(11) DEFAULT NULL COMMENT 'over weight ends',
  `obese_start` int(11) DEFAULT NULL COMMENT 'obese weight starts',
  `obese_end` int(11) DEFAULT NULL COMMENT 'obese weight ends',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `height_weight_session_fk` (`user_session_id`),
  CONSTRAINT `height_weight_chart_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `height_weight_chart`
--

LOCK TABLES `height_weight_chart` WRITE;
/*!40000 ALTER TABLE `height_weight_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `height_weight_chart` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_height_weight_chart_after_insert
    AFTER INSERT ON height_weight_chart
    FOR EACH ROW BEGIN
 
    INSERT INTO history_height_weight_chart
    SET height_weight_chart_id = new.id,
	height = new.height,
	normal_start = new.normal_start,
	normal_end = new.normal_end,
	over_weight_start = new.over_weight_start,
	over_weight_end = new.over_weight_end,
	obese_start = new.obese_start,
	obese_end = new.obese_end,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_height_weight_chart_before_update
    BEFORE UPDATE ON height_weight_chart
    FOR EACH ROW BEGIN
 
    INSERT INTO history_height_weight_chart
    SET height_weight_chart_id = old.id,
	height = old.height,
	normal_start = old.normal_start,
	normal_end = old.normal_end,
	over_weight_start = old.over_weight_start,
	over_weight_end = old.over_weight_end,
	obese_start = old.obese_start,
	obese_end = old.obese_end,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_height_weight_chart_before_delete
    BEFORE Delete ON height_weight_chart
    FOR EACH ROW BEGIN
 
    INSERT INTO history_height_weight_chart
    SET height_weight_chart_id = old.id,
	height = old.height,
	normal_start = old.normal_start,
	normal_end = old.normal_end,
	over_weight_start = old.over_weight_start,
	over_weight_end = old.over_weight_end,
	obese_start = old.obese_start,
	obese_end = old.obese_end,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `history_challenges_master`
--

DROP TABLE IF EXISTS `history_challenges_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_challenges_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key devices_master table',
  `challenges_master_id` int(11) NOT NULL COMMENT 'Primary key parent challenges_master table',
  `plan_id` int(11) NOT NULL COMMENT 'Primary key of the plans table',
  `name` varchar(255) DEFAULT NULL COMMENT 'Challenge name',
  `type` int(4) DEFAULT NULL COMMENT 'Challenge type links to group_values(steps/weight/other',
  `goal` float(4,2) DEFAULT NULL COMMENT 'Goal value (no of steps or weight value)',
  `discount` float(4,2) DEFAULT NULL COMMENT 'Discount value',
  `start_date` datetime DEFAULT NULL COMMENT 'Challenge start date',
  `end_date` datetime DEFAULT NULL COMMENT 'Challenge end date',
  `frequency` int(4) DEFAULT NULL COMMENT 'frequency linked to group_values (weekly,monthly,yearly)',
  `cheat_days` int(4) DEFAULT NULL COMMENT 'Number of cheat days applicable for a challenge',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_challenges_master`
--

LOCK TABLES `history_challenges_master` WRITE;
/*!40000 ALTER TABLE `history_challenges_master` DISABLE KEYS */;
INSERT INTO `history_challenges_master` VALUES (1,1,2,'sai krishna teja',3001,99.99,0.50,'2015-11-13 00:00:00','2015-11-13 00:00:00',12,25,1,57,'2015-11-09 04:43:28','2015-11-09 12:43:28'),(2,2,2,'jkhkj',3001,44.00,15.00,'2015-11-19 00:00:00','2015-11-19 00:00:00',15,25,1,57,'2015-11-09 04:45:39','2015-11-09 12:45:39');
/*!40000 ALTER TABLE `history_challenges_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_claims`
--

DROP TABLE IF EXISTS `history_claims`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_claims` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key claims table',
  `claims_id` int(11) NOT NULL COMMENT 'Primary key parent claims table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key of the policies table',
  `claim_amount` float(10,2) DEFAULT NULL COMMENT 'Claimed amount',
  `paid_date` datetime DEFAULT NULL COMMENT 'Date of paid',
  `paid_to` int(11) DEFAULT NULL COMMENT 'Primary key of the benificiary table',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_claims`
--

LOCK TABLES `history_claims` WRITE;
/*!40000 ALTER TABLE `history_claims` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_claims` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_devices_master`
--

DROP TABLE IF EXISTS `history_devices_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_devices_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key devices_master table',
  `devices_master_id` int(11) NOT NULL COMMENT 'Primary key parent devices_master table',
  `device_name` varchar(255) DEFAULT NULL COMMENT 'Name of the device',
  `cost` float(10,2) DEFAULT NULL COMMENT 'Cost price of the device',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_devices_master`
--

LOCK TABLES `history_devices_master` WRITE;
/*!40000 ALTER TABLE `history_devices_master` DISABLE KEYS */;
INSERT INTO `history_devices_master` VALUES (1,1,'flex',500.00,1,54,'2015-11-05 05:07:25','2015-11-05 13:07:25'),(2,2,'krish',500.00,1,54,'2015-11-05 05:07:41','2015-11-05 13:07:41'),(4,1,'flex',500.00,1,54,'2015-11-05 05:07:25','2015-11-05 13:07:25'),(5,1,'flex',500.00,0,54,'2015-11-05 05:07:25','2015-11-05 13:17:29'),(6,2,'krish',500.00,1,54,'2015-11-05 05:07:41','2015-11-05 13:07:41'),(7,3,'flex',500.00,1,54,'2015-11-05 05:26:03','2015-11-05 13:26:03'),(8,3,'flex',500.00,1,54,'2015-11-05 05:26:03','2015-11-05 13:26:03'),(9,3,'flex',505.00,1,54,'2015-11-05 05:28:17','2015-11-05 13:28:17'),(10,1,'flex',500.00,1,54,'2015-11-05 05:07:25','2015-11-05 13:22:43'),(11,4,'Charge Hr',1000.00,1,54,'2015-11-05 05:29:14','2015-11-05 13:29:14'),(12,5,'Surge',1500.00,1,54,'2015-11-05 05:30:06','2015-11-05 13:30:06'),(13,6,'Surge',1050.00,1,54,'2015-11-05 05:30:24','2015-11-05 13:30:24'),(14,5,'Surge',1500.00,1,54,'2015-11-05 05:30:06','2015-11-05 13:30:06'),(15,6,'Surge',1050.00,1,54,'2015-11-05 05:30:24','2015-11-05 13:30:24'),(16,7,'Charge Small',123.00,1,55,'2015-11-05 21:59:15','2015-11-06 05:59:15'),(17,7,'Charge Small',123.00,1,55,'2015-11-05 21:59:15','2015-11-06 05:59:15'),(18,4,'Charge Hr',1000.00,1,54,'2015-11-05 05:29:14','2015-11-05 13:29:14'),(19,4,'Charge Small',1000.00,1,55,'2015-11-05 22:03:42','2015-11-06 06:03:42'),(20,8,'Charge Small',540.00,1,55,'2015-11-05 22:04:20','2015-11-06 06:04:20'),(21,9,'H22',252.00,1,57,'2015-11-09 04:42:28','2015-11-09 12:42:28'),(22,9,'H22',252.00,1,57,'2015-11-09 04:42:28','2015-11-09 12:42:28');
/*!40000 ALTER TABLE `history_devices_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_discounts_master`
--

DROP TABLE IF EXISTS `history_discounts_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_discounts_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key discounts_master table',
  `discounts_master_id` int(11) NOT NULL COMMENT 'Primary key parent discounts_master table',
  `discount_name` varchar(255) DEFAULT NULL COMMENT 'Name of the discount',
  `discount_type` varchar(255) DEFAULT NULL COMMENT 'Type of the discount',
  `discount_percentage` float(3,2) DEFAULT NULL COMMENT 'Discount percentage value',
  `cheat_days` int(4) DEFAULT NULL COMMENT 'Number of cheat_days',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_discounts_master`
--

LOCK TABLES `history_discounts_master` WRITE;
/*!40000 ALTER TABLE `history_discounts_master` DISABLE KEYS */;
INSERT INTO `history_discounts_master` VALUES (1,1,'diwali bonanza','1',9.99,25,1,57,'2015-11-09 04:54:12','2015-11-09 12:54:12'),(2,1,'diwali bonanza','1',9.99,25,1,57,'2015-11-09 04:54:12','2015-11-09 12:54:12');
/*!40000 ALTER TABLE `history_discounts_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_disease_master`
--

DROP TABLE IF EXISTS `history_disease_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_disease_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key disease_master table',
  `disease_master_id` int(11) NOT NULL COMMENT 'Primary key parent disease_master table',
  `disease_name` varchar(255) DEFAULT NULL COMMENT 'Name of the disease',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_disease_master`
--

LOCK TABLES `history_disease_master` WRITE;
/*!40000 ALTER TABLE `history_disease_master` DISABLE KEYS */;
INSERT INTO `history_disease_master` VALUES (1,1,'Malaria',1,55,'2015-11-05 21:42:28','2015-11-06 05:42:28'),(2,1,'Malaria',1,55,'2015-11-05 21:42:28','2015-11-06 05:42:28'),(3,1,'Malaria123',1,55,'2015-11-05 21:42:40','2015-11-06 05:42:40'),(4,2,'Malaria',1,57,'2015-11-08 22:26:57','2015-11-09 06:26:57'),(5,2,'Malaria',1,57,'2015-11-08 22:26:57','2015-11-09 06:26:57'),(6,2,'Malaria',1,57,'2015-11-08 22:27:06','2015-11-09 06:27:06'),(7,3,'ads',1,59,'2015-11-11 22:03:44','2015-11-12 06:03:44'),(8,3,'ads',1,59,'2015-11-11 22:03:44','2015-11-12 06:03:44');
/*!40000 ALTER TABLE `history_disease_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_email_log`
--

DROP TABLE IF EXISTS `history_email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_email_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary email_log table',
  `email_log_id` int(11) NOT NULL COMMENT 'Primary key parent email_log table',
  `email_to` varchar(255) DEFAULT NULL COMMENT 'To email id',
  `email_from` varchar(255) DEFAULT NULL COMMENT 'From email id',
  `email_subject` text COMMENT 'Email subject',
  `email_body` text COMMENT 'Email body',
  `email_status` tinyint(1) DEFAULT NULL COMMENT '1-successfull 0-Fail',
  `fail_reason` text COMMENT 'Email failed reason',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_email_log`
--

LOCK TABLES `history_email_log` WRITE;
/*!40000 ALTER TABLE `history_email_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_email_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_email_templates`
--

DROP TABLE IF EXISTS `history_email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_email_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary email_templates table',
  `email_templates_id` int(11) NOT NULL COMMENT 'Primary key parent email_templates table',
  `title` varchar(255) DEFAULT NULL COMMENT 'Email title',
  `template_name` varchar(255) DEFAULT NULL COMMENT 'Template name',
  `email_subject` text COMMENT 'Email subject',
  `email_body` text COMMENT 'Email body',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_email_templates`
--

LOCK TABLES `history_email_templates` WRITE;
/*!40000 ALTER TABLE `history_email_templates` DISABLE KEYS */;
INSERT INTO `history_email_templates` VALUES (1,1,'send',NULL,NULL,NULL,1,57,'2015-11-09 00:10:47','2015-11-09 08:10:47'),(2,1,'send',NULL,NULL,NULL,1,57,'2015-11-09 00:10:47','2015-11-09 08:10:47'),(3,2,'send',NULL,NULL,NULL,1,57,'2015-11-09 00:13:36','2015-11-09 08:13:36'),(4,3,'send123','send','ssssssssss','ssdffffffffffff',1,57,'2015-11-09 00:19:41','2015-11-09 08:19:41'),(5,2,'send',NULL,NULL,NULL,1,57,'2015-11-09 00:13:36','2015-11-09 08:13:36'),(6,4,'send','send','ssssssssss','ssdffffffffffff',1,57,'2015-11-09 00:26:46','2015-11-09 08:26:47'),(7,4,'send','send','ssssssssss','ssdffffffffffff',1,57,'2015-11-09 00:26:46','2015-11-09 08:26:47'),(8,5,'send','send','ljs;kdljfljsg','ajsldfksldfasd',1,57,'2015-11-09 00:27:20','2015-11-09 08:27:20'),(9,3,'send123','send','ssssssssss','ssdffffffffffff',1,57,'2015-11-09 00:19:41','2015-11-09 08:19:41'),(10,5,'send','send','ljs;kdljfljsg','ajsldfksldfasd',1,57,'2015-11-09 00:27:20','2015-11-09 08:27:20'),(11,6,'send','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:04:42','2015-11-09 10:04:42'),(12,7,'send123','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:05:02','2015-11-09 10:05:02'),(13,8,'send1234','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:05:26','2015-11-09 10:05:26'),(14,7,'send123','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:05:02','2015-11-09 10:05:02'),(15,8,'send1234','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:05:26','2015-11-09 10:05:26'),(16,9,'send123','send','sfasdfs','asfdsdf',1,57,'2015-11-09 02:09:47','2015-11-09 10:09:47'),(17,9,'send123','send','sfasdfs','asfdsdf',1,57,'2015-11-09 02:09:47','2015-11-09 10:09:47'),(18,10,'sbh','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:26:59','2015-11-09 10:26:59'),(19,10,'sbh','send','ssfsadfsafd','asfsdfs',1,57,'2015-11-09 02:26:59','2015-11-09 10:26:59');
/*!40000 ALTER TABLE `history_email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_expenses`
--

DROP TABLE IF EXISTS `history_expenses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key expenses table',
  `expenses_id` int(11) NOT NULL COMMENT 'Primary key parent expenses table',
  `expense_id` int(11) NOT NULL COMMENT 'Primary key of the expenses master',
  `expense_date` datetime DEFAULT NULL COMMENT 'Date of expense',
  `expense_amount` float(10,2) DEFAULT NULL COMMENT 'Expense Amount',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_expenses`
--

LOCK TABLES `history_expenses` WRITE;
/*!40000 ALTER TABLE `history_expenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_expenses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_expenses_master`
--

DROP TABLE IF EXISTS `history_expenses_master`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_expenses_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key expenses_master table',
  `expenses_master_id` int(11) NOT NULL COMMENT 'Primary key parent expenses_master table',
  `expense_name` varchar(255) DEFAULT NULL COMMENT 'Name of the expense',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_expenses_master`
--

LOCK TABLES `history_expenses_master` WRITE;
/*!40000 ALTER TABLE `history_expenses_master` DISABLE KEYS */;
INSERT INTO `history_expenses_master` VALUES (1,1,'Salaries',1,57,'2015-11-08 21:53:06','2015-11-09 05:53:06'),(2,2,'Salarie',1,57,'2015-11-08 21:53:51','2015-11-09 05:53:51'),(3,1,'Salaries',1,57,'2015-11-08 21:53:06','2015-11-09 05:53:06'),(4,2,'Salarie',1,57,'2015-11-08 21:53:51','2015-11-09 05:53:51'),(5,3,'Salaries',1,57,'2015-11-08 22:07:04','2015-11-09 06:07:04'),(6,3,'Salaries',1,57,'2015-11-08 22:07:04','2015-11-09 06:07:04'),(7,3,'Salaries123',1,57,'2015-11-08 22:07:19','2015-11-09 06:07:19'),(8,4,'Salaries',1,57,'2015-11-08 22:12:18','2015-11-09 06:12:18'),(9,4,'Salaries',1,57,'2015-11-08 22:12:18','2015-11-09 06:12:18'),(10,4,'Salarie',1,57,'2015-11-08 22:16:25','2015-11-09 06:16:25'),(11,5,'chairs',1,57,'2015-11-08 22:17:14','2015-11-09 06:17:14'),(12,3,'Salaries123',1,57,'2015-11-08 22:11:57','2015-11-09 06:11:57'),(13,4,'Salaries',1,57,'2015-11-08 22:16:58','2015-11-09 06:16:58'),(14,5,'chairs',1,57,'2015-11-08 22:17:14','2015-11-09 06:17:14'),(15,6,'Salaries',1,57,'2015-11-08 22:18:11','2015-11-09 06:18:11'),(16,7,'Salaries123',1,57,'2015-11-08 22:18:48','2015-11-09 06:18:48'),(17,6,'Salaries',1,57,'2015-11-08 22:18:11','2015-11-09 06:18:11'),(18,7,'Salaries123',1,57,'2015-11-08 22:18:48','2015-11-09 06:18:48'),(19,8,'Salaries123',1,57,'2015-11-08 22:19:43','2015-11-09 06:19:43'),(20,8,'Salaries123',1,57,'2015-11-08 22:19:43','2015-11-09 06:19:43'),(21,8,'Salaries',1,57,'2015-11-08 22:19:56','2015-11-09 06:19:56'),(22,9,'Salaries',1,57,'2015-11-09 02:07:25','2015-11-09 10:07:25'),(23,9,'Salaries',1,57,'2015-11-09 02:07:25','2015-11-09 10:07:25');
/*!40000 ALTER TABLE `history_expenses_master` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_group_values`
--

DROP TABLE IF EXISTS `history_group_values`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_group_values` (
  `id` int(11) NOT NULL COMMENT 'Primary key of group_values table',
  `group_values_id` int(11) NOT NULL COMMENT 'Primary key parent group_values table',
  `group_id` int(11) DEFAULT NULL COMMENT 'Primary key of groups table',
  `name` varchar(255) DEFAULT NULL COMMENT 'Group name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Group description',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_group_values`
--

LOCK TABLES `history_group_values` WRITE;
/*!40000 ALTER TABLE `history_group_values` DISABLE KEYS */;
INSERT INTO `history_group_values` VALUES (0,3001,3000,'Steps','Steps',1,'2015-11-03 11:29:00','2015-11-03 00:29:00'),(0,3002,3000,'Weights','Weights',1,'2015-11-03 11:29:00','2015-11-03 00:29:00'),(0,2005,2000,'Under Writer','Under Writer',1,'2015-11-16 11:46:56','2015-11-16 06:16:56');
/*!40000 ALTER TABLE `history_group_values` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_groups`
--

DROP TABLE IF EXISTS `history_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_groups` (
  `id` int(11) NOT NULL COMMENT 'Primary key of groups table',
  `groups_id` int(11) NOT NULL COMMENT 'Primary key parent groups table',
  `name` varchar(255) DEFAULT NULL COMMENT 'Group name',
  `description` varchar(255) DEFAULT NULL COMMENT 'Group description',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_groups`
--

LOCK TABLES `history_groups` WRITE;
/*!40000 ALTER TABLE `history_groups` DISABLE KEYS */;
INSERT INTO `history_groups` VALUES (0,3000,'User Type','Type of Users',1,'2015-11-03 11:25:00','2015-11-03 00:25:00');
/*!40000 ALTER TABLE `history_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_height_weight_chart`
--

DROP TABLE IF EXISTS `history_height_weight_chart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_height_weight_chart` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key height_weight_chart table',
  `height_weight_chart_id` int(11) NOT NULL COMMENT 'Primary key parent height_weight_chart table',
  `height` varchar(255) DEFAULT NULL COMMENT 'Height value',
  `normal_start` int(11) DEFAULT NULL COMMENT 'Normal weight starts',
  `normal_end` int(11) DEFAULT NULL COMMENT 'Normal weight ends',
  `over_weight_start` int(11) DEFAULT NULL COMMENT 'over weight starts',
  `over_weight_end` int(11) DEFAULT NULL COMMENT 'over weight ends',
  `obese_start` int(11) DEFAULT NULL COMMENT 'obese weight starts',
  `obese_end` int(11) DEFAULT NULL COMMENT 'obese weight ends',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_height_weight_chart`
--

LOCK TABLES `history_height_weight_chart` WRITE;
/*!40000 ALTER TABLE `history_height_weight_chart` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_height_weight_chart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_medical_info`
--

DROP TABLE IF EXISTS `history_medical_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_medical_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key medical_info table',
  `medical_info_id` int(11) NOT NULL COMMENT 'Primary key parent medical_info table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `disease_id` int(11) DEFAULT NULL COMMENT 'Primary key of diseases master',
  `status` int(4) DEFAULT NULL COMMENT 'Medical status value links to group values',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_medical_info`
--

LOCK TABLES `history_medical_info` WRITE;
/*!40000 ALTER TABLE `history_medical_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_medical_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_migrations`
--

DROP TABLE IF EXISTS `history_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key migrations table',
  `migrations_id` int(11) NOT NULL COMMENT 'Primary key parent migrations table',
  `migration_name` varchar(255) DEFAULT NULL COMMENT 'Name of the migration with timestamp',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_migrations`
--

LOCK TABLES `history_migrations` WRITE;
/*!40000 ALTER TABLE `history_migrations` DISABLE KEYS */;
INSERT INTO `history_migrations` VALUES (1,1,'201511031720_alter_user_info.sql',1,'2015-11-03 17:22:51','2015-11-03 11:52:51'),(2,2,'201511041434_create_users_customers.sql',1,'2015-11-04 16:00:15','2015-11-04 10:30:15'),(3,3,'201511091207_alter_polices.sql',1,'2015-11-09 12:09:34','2015-11-09 06:39:34'),(4,4,'201511091559_alter_polices.sql',1,'2015-11-09 16:03:52','2015-11-09 10:33:52'),(5,5,'201511121235_alter_user_sessions.sql',1,'2015-11-16 10:57:12','2015-11-16 05:27:12');
/*!40000 ALTER TABLE `history_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_plan_age_band_rates`
--

DROP TABLE IF EXISTS `history_plan_age_band_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_plan_age_band_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plan_age_band_rates table',
  `plan_age_band_rates_id` int(11) NOT NULL COMMENT 'Primary key parent plan_age_band_rates table',
  `plan_id` int(11) NOT NULL COMMENT 'Primary key plans table',
  `age_band_start` datetime DEFAULT NULL COMMENT 'Date at which age starts',
  `age_band_end` datetime DEFAULT NULL COMMENT 'Date at which age ends',
  `rate` float(4,2) DEFAULT NULL COMMENT 'Rate at which the premium is charged',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_plan_age_band_rates`
--

LOCK TABLES `history_plan_age_band_rates` WRITE;
/*!40000 ALTER TABLE `history_plan_age_band_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_plan_age_band_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_plan_devices`
--

DROP TABLE IF EXISTS `history_plan_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_plan_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plan_devices table',
  `plan_devices_id` int(11) NOT NULL COMMENT 'Primary key parent plan_devices table',
  `plan_id` int(11) NOT NULL COMMENT 'Primary key of the plans table',
  `device_id` int(11) NOT NULL COMMENT 'Primary key of the devices_master table',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_plan_devices`
--

LOCK TABLES `history_plan_devices` WRITE;
/*!40000 ALTER TABLE `history_plan_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_plan_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_plan_health_rate`
--

DROP TABLE IF EXISTS `history_plan_health_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_plan_health_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plan_health_rate table',
  `plan_health_rate_id` int(11) NOT NULL COMMENT 'Primary key parent plan_health_rate table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `disease_id` int(11) DEFAULT NULL COMMENT 'Primary key of diseases master',
  `rate` float(4,2) DEFAULT NULL COMMENT 'Rate at which the premium is charged',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_plan_health_rate`
--

LOCK TABLES `history_plan_health_rate` WRITE;
/*!40000 ALTER TABLE `history_plan_health_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_plan_health_rate` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_plans`
--

DROP TABLE IF EXISTS `history_plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plans table',
  `plans_id` int(11) NOT NULL COMMENT 'Primary key parent plans table',
  `plan_name` varchar(255) DEFAULT NULL COMMENT 'Plan name',
  `plan_start_date` datetime DEFAULT NULL COMMENT 'Plan start date',
  `plan_end_date` datetime DEFAULT NULL COMMENT 'Plan end date',
  `base_premium` float(6,2) DEFAULT NULL COMMENT 'Base premium value of the plan',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_plans`
--

LOCK TABLES `history_plans` WRITE;
/*!40000 ALTER TABLE `history_plans` DISABLE KEYS */;
INSERT INTO `history_plans` VALUES (1,1,'Me Seva','2015-11-11 00:00:00','2015-11-26 00:00:00',500.00,1,53,'2015-11-05 01:18:59','2015-11-05 09:18:59'),(2,1,'Me Seva','2015-11-11 00:00:00','2015-11-26 00:00:00',500.00,1,53,'2015-11-05 01:18:59','2015-11-05 09:18:59'),(3,2,'Me Seva','2015-11-14 00:00:00','2015-11-14 00:00:00',150.00,1,57,'2015-11-09 04:41:17','2015-11-09 12:41:17'),(4,2,'Me Seva','2015-11-14 00:00:00','2015-11-14 00:00:00',150.00,1,57,'2015-11-09 04:41:17','2015-11-09 12:41:17');
/*!40000 ALTER TABLE `history_plans` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_policies`
--

DROP TABLE IF EXISTS `history_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_policies` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key policies table',
  `policies_id` int(11) NOT NULL COMMENT 'Primary key parent policies table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `policy_number` varchar(255) DEFAULT NULL COMMENT 'Policy number',
  `term` int(3) DEFAULT NULL COMMENT 'Policy term',
  `issue_date` datetime DEFAULT NULL COMMENT 'Policy issued date',
  `initial_premium` float(10,2) DEFAULT NULL COMMENT 'Initial premium of the policy',
  `policies_health` int(11) DEFAULT NULL COMMENT 'Linked to groups table',
  `policy_status` int(4) DEFAULT NULL COMMENT 'Policy status - Group values-',
  `under_writer` int(11) DEFAULT NULL COMMENT 'Under writer user id references to users table',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `plan_id` int(11) DEFAULT NULL COMMENT 'Primary key of the plans table',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_policies`
--

LOCK TABLES `history_policies` WRITE;
/*!40000 ALTER TABLE `history_policies` DISABLE KEYS */;
INSERT INTO `history_policies` VALUES (1,3,7,'90522-0856-123',3,'2015-08-08 00:00:00',170.00,NULL,NULL,11,1,2,'0000-00-00 00:00:00','2015-11-16 06:57:44',NULL),(2,3,7,'90522-0856-123',3,'2015-08-08 00:00:00',170.00,NULL,NULL,11,1,2,'0000-00-00 00:00:00','2015-11-16 06:57:44',NULL),(3,1,7,'90522-0856-123',3,'2015-08-08 00:00:00',170.00,NULL,NULL,11,1,2,'2015-11-16 12:48:46','2015-11-16 07:18:46',NULL);
/*!40000 ALTER TABLE `history_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_policy_benificiaries`
--

DROP TABLE IF EXISTS `history_policy_benificiaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_policy_benificiaries` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key policy_benificiaries table',
  `policy_benificiaries_id` int(11) NOT NULL COMMENT 'Primary key parent policy_benificiaries table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key policies table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `type` int(11) DEFAULT NULL COMMENT 'Type of benificiary - Group values',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'Benificiary first name',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Benificiary last name',
  `age` int(3) DEFAULT NULL COMMENT 'Benificiary age',
  `gender` int(4) DEFAULT NULL COMMENT 'Gender-Group values-',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_policy_benificiaries`
--

LOCK TABLES `history_policy_benificiaries` WRITE;
/*!40000 ALTER TABLE `history_policy_benificiaries` DISABLE KEYS */;
INSERT INTO `history_policy_benificiaries` VALUES (1,3,1,7,NULL,'Kendall','Yoder',25,2,1,2,'2015-11-16 12:49:09','2015-11-16 07:19:09');
/*!40000 ALTER TABLE `history_policy_benificiaries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_premium_discounts`
--

DROP TABLE IF EXISTS `history_premium_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_premium_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key premium_discounts table',
  `premium_discounts_id` int(11) NOT NULL COMMENT 'Primary key parent premiums_discounts table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key policies table',
  `discount_id` int(11) DEFAULT NULL COMMENT 'Primary key discounts_master table',
  `discount_type` varchar(255) DEFAULT NULL COMMENT 'Discount type available in discounts_master table',
  `discount_percentage` float(3,2) DEFAULT NULL COMMENT 'Discount percentage value',
  `month` int(2) NOT NULL COMMENT 'Month number',
  `year` int(4) NOT NULL COMMENT 'Year number',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_premium_discounts`
--

LOCK TABLES `history_premium_discounts` WRITE;
/*!40000 ALTER TABLE `history_premium_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_premium_discounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_premiums`
--

DROP TABLE IF EXISTS `history_premiums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_premiums` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key premiums table',
  `premiums_id` int(11) NOT NULL COMMENT 'Primary key parent premiums table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key policies table',
  `month` int(2) NOT NULL COMMENT 'Specifies month',
  `year` int(4) NOT NULL COMMENT 'Specifies year',
  `premium` float(6,2) DEFAULT NULL COMMENT 'Policy premium value',
  `lifetime_savings` float(10,2) DEFAULT NULL COMMENT 'Policy life time value',
  `status` int(11) DEFAULT NULL COMMENT 'Premium Payment status - Linked to Group values',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction id which comes from stripe',
  `under_writer_premium` float(10,2) DEFAULT NULL COMMENT 'Premium collected by the Under writer',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_premiums`
--

LOCK TABLES `history_premiums` WRITE;
/*!40000 ALTER TABLE `history_premiums` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_premiums` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_quote_users`
--

DROP TABLE IF EXISTS `history_quote_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_quote_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'user ID',
  `quote_users_id` int(11) NOT NULL COMMENT 'Primary key parent quote_users table',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT '0' COMMENT '0 - not mentioned, 1 - male, 2- female',
  `area_code` int(11) NOT NULL DEFAULT '0',
  `smoker` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - non smoker, 1 - smoker',
  `health` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - excellent, 2 - good, 3 - average, 4 - poor',
  `protection` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT '0' COMMENT 'years of protection',
  `origin` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=551 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_quote_users`
--

LOCK TABLES `history_quote_users` WRITE;
/*!40000 ALTER TABLE `history_quote_users` DISABLE KEYS */;
INSERT INTO `history_quote_users` VALUES (1,16,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:45:52','2015-11-03 09:04:35'),(2,17,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:45:57','2015-11-03 09:04:35'),(3,18,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:46:04','2015-11-03 09:04:35'),(4,19,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:46:13','2015-11-03 09:04:35'),(5,20,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:46:47','2015-11-03 09:04:35'),(6,21,'eshwar','eshwarcc@gmail.com',30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:48:01','2015-11-03 09:04:35'),(7,22,NULL,NULL,23,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-06-30 21:48:33','2015-11-03 09:04:35'),(8,23,NULL,NULL,23,2,94301,0,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:49:09','2015-11-03 09:04:35'),(9,24,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:50:16','2015-11-03 09:04:35'),(10,25,NULL,NULL,27,1,95125,0,2,'$500,000',20,'v1-get-estimate',1,'2015-07-01 06:50:53','2015-11-03 09:04:35'),(11,26,'jacob','jacob@vendus.com',18,1,95125,1,1,'$500,000',7,'v1-get-estimate',1,'2015-07-01 17:28:43','2015-11-03 09:04:35'),(12,27,'asdfasdf','sdfds@sdfd.com',30,1,12345,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-01 17:21:54','2015-11-03 09:04:35'),(13,28,'jacob','jacob@sureify.com',30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-01 17:38:20','2015-11-03 09:04:35'),(14,29,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-01 17:41:24','2015-11-03 09:04:35'),(15,30,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-01 17:46:44','2015-11-03 09:04:35'),(16,31,NULL,NULL,55,1,28075,0,2,'$250,000',10,'v1-get-estimate',1,'2015-07-01 18:14:59','2015-11-03 09:04:35'),(17,32,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-01 18:23:48','2015-11-03 09:04:35'),(18,33,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-01 21:56:38','2015-11-03 09:04:35'),(19,34,NULL,NULL,30,1,95125,0,1,'$250,000',25,'v1-get-estimate',1,'2015-07-02 07:54:46','2015-11-03 09:04:35'),(20,35,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-02 08:36:43','2015-11-03 09:04:35'),(21,36,NULL,NULL,30,2,95125,0,3,'$500,000',30,'v1-get-estimate',1,'2015-07-02 21:27:28','2015-11-03 09:04:35'),(22,37,NULL,NULL,30,2,95125,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-02 21:37:51','2015-11-03 09:04:35'),(23,38,NULL,NULL,30,2,95125,0,1,'$500,000',10,'v1-get-estimate',1,'2015-07-03 01:29:01','2015-11-03 09:04:35'),(24,39,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 06:13:49','2015-11-03 09:04:35'),(25,40,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 06:23:11','2015-11-03 09:04:35'),(26,41,NULL,NULL,36,1,95125,0,3,'$250,000',30,'v1-get-estimate',1,'2015-07-03 11:45:43','2015-11-03 09:04:35'),(27,42,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 13:33:08','2015-11-03 09:04:35'),(28,43,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 17:17:50','2015-11-03 09:04:35'),(29,44,NULL,NULL,27,1,20176,0,1,'$500,000',10,'v1-get-estimate',1,'2015-07-04 05:23:55','2015-11-03 09:04:35'),(30,45,NULL,NULL,22,1,60622,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-04 16:46:55','2015-11-03 09:04:35'),(31,46,NULL,NULL,30,1,95125,0,3,'$250,000',30,'v1-get-estimate',1,'2015-07-04 17:19:00','2015-11-03 09:04:35'),(32,47,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-05 19:45:52','2015-11-03 09:04:35'),(33,48,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-06 02:15:20','2015-11-03 09:04:35'),(34,49,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-06 19:34:38','2015-11-03 09:04:35'),(35,50,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-06 21:58:17','2015-11-03 09:04:35'),(36,51,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v1-get-estimate',1,'2015-07-07 02:11:42','2015-11-03 09:04:35'),(37,52,NULL,NULL,35,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-07 14:19:09','2015-11-03 09:04:35'),(38,53,NULL,NULL,38,2,94103,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-07 14:02:26','2015-11-03 09:04:35'),(39,54,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 15:56:04','2015-11-03 09:04:35'),(40,55,NULL,NULL,25,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 15:56:30','2015-11-03 09:04:35'),(41,56,NULL,NULL,30,1,95125,0,1,'$500,000',15,'v1-get-estimate',1,'2015-07-07 16:50:27','2015-11-03 09:04:35'),(42,57,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 17:14:46','2015-11-03 09:04:35'),(43,58,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 23:04:15','2015-11-03 09:04:35'),(44,59,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-08 00:28:44','2015-11-03 09:04:35'),(45,60,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 10:39:44','2015-11-03 09:04:35'),(46,61,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 11:22:17','2015-11-03 09:04:35'),(47,62,NULL,NULL,48,1,22603,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 15:42:59','2015-11-03 09:04:35'),(48,63,NULL,NULL,30,2,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-08 17:48:38','2015-11-03 09:04:35'),(49,64,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 17:48:42','2015-11-03 09:04:35'),(50,65,NULL,NULL,30,2,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-08 21:54:06','2015-11-03 09:04:35'),(51,66,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 22:26:49','2015-11-03 09:04:35'),(52,67,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-09 05:23:50','2015-11-03 09:04:35'),(53,68,NULL,NULL,65,1,95125,1,4,'$500,000',30,'v1-get-estimate',1,'2015-07-09 17:04:00','2015-11-03 09:04:35'),(54,69,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-09 19:22:26','2015-11-03 09:04:35'),(55,70,NULL,NULL,24,1,95125,0,2,'$500,000',30,'v2-get-estimate',1,'2015-07-09 20:54:55','2015-11-03 09:04:35'),(56,71,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-09 21:04:51','2015-11-03 09:04:35'),(57,72,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-10 01:26:21','2015-11-03 09:04:35'),(58,73,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-10 13:47:29','2015-11-03 09:04:35'),(59,74,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-10 22:27:14','2015-11-03 09:04:35'),(60,75,NULL,NULL,30,2,39047,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-11 18:37:34','2015-11-03 09:04:35'),(61,76,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-12 17:44:59','2015-11-03 09:04:35'),(62,77,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-12 19:06:15','2015-11-03 09:04:35'),(63,78,NULL,NULL,30,2,95125,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-13 05:56:38','2015-11-03 09:04:35'),(64,79,NULL,NULL,40,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-13 10:58:23','2015-11-03 09:04:35'),(65,80,NULL,NULL,39,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-13 13:52:37','2015-11-03 09:04:35'),(66,81,NULL,NULL,30,2,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-13 18:03:28','2015-11-03 09:04:35'),(67,82,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-13 18:13:49','2015-11-03 09:04:35'),(68,83,NULL,NULL,44,1,90210,0,1,'$500,000',25,'v1-get-estimate',1,'2015-07-14 15:07:51','2015-11-03 09:04:35'),(69,84,'jacob','jacobspencerruiz@gmail.com',30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-14 21:25:33','2015-11-03 09:04:35'),(70,85,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-14 20:58:24','2015-11-03 09:04:35'),(71,86,'Jacob Ruiz','jacobspencerruiz@gmail.com',30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-14 21:31:50','2015-11-03 09:04:35'),(72,87,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-14 23:19:33','2015-11-03 09:04:35'),(73,88,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-15 09:08:05','2015-11-03 09:04:35'),(74,89,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-15 09:27:29','2015-11-03 09:04:35'),(75,90,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-15 14:18:38','2015-11-03 09:04:35'),(76,91,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-15 14:18:55','2015-11-03 09:04:35'),(77,92,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-15 17:25:30','2015-11-03 09:04:35'),(78,93,NULL,NULL,30,1,95125,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-15 21:48:50','2015-11-03 09:04:35'),(79,94,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-16 00:25:42','2015-11-03 09:04:35'),(80,95,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-16 11:39:18','2015-11-03 09:04:35'),(81,96,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-16 17:41:27','2015-11-03 09:04:35'),(82,97,'Dustin Yoder','Dustin@Sureifylabs.com ',30,1,95125,0,2,'$250,000',30,'v2-get-estimate',1,'2015-07-16 19:29:43','2015-11-03 09:04:35'),(83,98,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-16 19:30:25','2015-11-03 09:04:35'),(84,99,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v1-get-estimate',1,'2015-07-16 20:00:02','2015-11-03 09:04:35'),(85,100,NULL,NULL,45,2,94568,0,3,'$500,000',30,'v1-get-estimate',1,'2015-07-17 16:40:06','2015-11-03 09:04:35'),(86,101,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-17 21:09:54','2015-11-03 09:04:35'),(87,102,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-17 21:10:50','2015-11-03 09:04:35'),(88,103,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-18 01:42:12','2015-11-03 09:04:35'),(89,104,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-19 20:46:04','2015-11-03 09:04:35'),(90,105,'hooker','hooker@bitch.com',30,1,95125,1,1,'$500,000',30,'v2-get-estimate',1,'2015-07-20 05:02:01','2015-11-03 09:04:35'),(91,106,'swathi','swathi@vendus.com',NULL,0,0,0,0,NULL,0,'v1-get-in-touch',1,'2015-07-20 06:03:18','2015-11-03 09:04:35'),(92,107,NULL,NULL,25,2,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-20 17:00:06','2015-11-03 09:04:35'),(93,108,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-20 22:01:02','2015-11-03 09:04:35'),(94,109,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-20 22:11:16','2015-11-03 09:04:35'),(95,110,'Eshwar','contact@eshwar.me',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-21 17:21:23','2015-11-03 09:04:35'),(96,111,'Eshwar','mail@eshwar.me',30,1,95125,0,3,'$500,000',30,'v2a-get-estimate',1,'2015-07-21 17:40:34','2015-11-03 09:04:35'),(97,112,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-21 17:48:01','2015-11-03 09:04:35'),(98,113,NULL,NULL,30,1,45245,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-21 20:50:47','2015-11-03 09:04:35'),(99,114,NULL,NULL,44,1,208,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-21 20:53:14','2015-11-03 09:04:35'),(100,115,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-21 22:37:36','2015-11-03 09:04:35'),(101,116,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-22 15:11:27','2015-11-03 09:04:35'),(102,117,NULL,NULL,30,1,95125,0,2,'$500,000',30,'v2a-get-estimate',1,'2015-07-22 17:49:55','2015-11-03 09:04:35'),(103,118,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-22 17:51:50','2015-11-03 09:04:35'),(104,119,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-22 19:58:08','2015-11-03 09:04:35'),(105,120,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-23 18:27:28','2015-11-03 09:04:35'),(106,121,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-23 18:22:42','2015-11-03 09:04:35'),(107,122,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-23 20:02:21','2015-11-03 09:04:35'),(108,123,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-24 18:05:27','2015-11-03 09:04:35'),(109,124,NULL,NULL,38,2,41042,0,1,'$250,000',15,'v1-get-estimate',1,'2015-07-24 20:44:50','2015-11-03 09:04:35'),(110,125,'jacob','jacob@vendus.com',30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-25 00:18:05','2015-11-03 09:04:35'),(111,126,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-25 19:03:19','2015-11-03 09:04:35'),(112,127,'jacob','jacob@sureify.com',NULL,0,0,0,0,NULL,0,'v2a-get-in-touch',1,'2015-07-25 20:40:27','2015-11-03 09:04:35'),(113,128,'','jacob@sureify.com',30,1,95125,0,1,'$500,000',16,'v2a-get-estimate',1,'2015-07-25 20:41:45','2015-11-03 09:04:35'),(114,129,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-25 22:12:59','2015-11-03 09:04:35'),(115,130,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-26 04:24:39','2015-11-03 09:04:35'),(116,131,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-26 17:37:12','2015-11-03 09:04:35'),(117,132,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-26 17:42:40','2015-11-03 09:04:35'),(118,133,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:16:36','2015-11-03 09:04:35'),(119,134,'jacob','jacob@vendus.com',NULL,0,0,0,0,NULL,0,'v2b-get-in-touch',1,'2015-07-26 18:17:00','2015-11-03 09:04:35'),(120,135,'Jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:26:04','2015-11-03 09:04:35'),(121,136,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:46:57','2015-11-03 09:04:35'),(122,137,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:48:00','2015-11-03 09:04:35'),(123,138,'jacob','jacob@sureify.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 19:02:47','2015-11-03 09:04:35'),(124,139,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 19:03:48','2015-11-03 09:04:35'),(125,140,'jacob','jacob@vendus.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-26 19:04:07','2015-11-03 09:04:35'),(126,141,'Jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 19:06:53','2015-11-03 09:04:35'),(127,142,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-26 22:57:28','2015-11-03 09:04:35'),(128,143,'jacob','dustingyoder@gmail.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-26 22:35:40','2015-11-03 09:04:35'),(129,144,'Karen','karen@gmail.com',45,2,95125,1,4,'$500,000',30,'v2a-get-estimate',1,'2015-07-26 22:39:22','2015-11-03 09:04:35'),(130,145,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 02:47:38','2015-11-03 09:04:35'),(131,146,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-27 03:30:59','2015-11-03 09:04:35'),(132,147,'kendall dork face','kendallyoder@gmail.com',28,2,95125,1,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-27 03:32:46','2015-11-03 09:04:35'),(133,148,NULL,NULL,28,1,91306,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-27 08:22:52','2015-11-03 09:04:35'),(134,149,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 16:14:31','2015-11-03 09:04:35'),(135,150,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 16:16:21','2015-11-03 09:04:35'),(136,151,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 18:03:29','2015-11-03 09:04:35'),(137,152,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 18:02:15','2015-11-03 09:04:35'),(138,153,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 19:11:22','2015-11-03 09:04:35'),(139,154,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 18:56:17','2015-11-03 09:04:35'),(140,155,'eshwar','eshwar@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-in-touch',1,'2015-07-27 19:38:14','2015-11-03 09:04:35'),(141,156,'Eshwar','eshwar@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-in-touch',1,'2015-07-27 19:41:59','2015-11-03 09:04:35'),(142,157,NULL,NULL,63,2,27888,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-27 19:45:41','2015-11-03 09:04:35'),(143,158,'Margaret Bliss','margaretbliss@gmail.com',23,2,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-27 20:00:20','2015-11-03 09:04:35'),(144,159,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-27 20:29:17','2015-11-03 09:04:35'),(145,160,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 00:58:46','2015-11-03 09:04:35'),(146,161,'greg oder','greg@lpib.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-28 03:27:17','2015-11-03 09:04:35'),(147,162,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 07:05:33','2015-11-03 09:04:35'),(148,163,NULL,NULL,22,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 11:00:43','2015-11-03 09:04:35'),(149,164,NULL,NULL,22,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 11:00:43','2015-11-03 09:04:35'),(150,165,NULL,NULL,50,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 14:43:57','2015-11-03 09:04:35'),(151,166,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 14:55:15','2015-11-03 09:04:35'),(152,167,'Dustin Yoder','dustin@gmail.com',28,1,95125,0,2,'$500,000',30,'v2a-get-estimate',1,'2015-07-28 17:47:21','2015-11-03 09:04:35'),(153,168,NULL,NULL,32,1,18015,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 18:18:30','2015-11-03 09:04:35'),(154,169,'jacob','jacobspencerruiz@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-28 21:06:58','2015-11-03 09:04:35'),(155,170,NULL,NULL,30,1,94019,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 22:24:58','2015-11-03 09:04:35'),(156,171,NULL,NULL,30,1,94954,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 22:57:52','2015-11-03 09:04:35'),(157,172,NULL,NULL,29,1,91354,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-07-29 04:14:06','2015-11-03 09:04:35'),(158,173,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-29 15:29:30','2015-11-03 09:04:35'),(159,174,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-29 16:52:50','2015-11-03 09:04:35'),(160,175,NULL,NULL,31,1,95008,1,4,'$500,000',30,'v2b-get-estimate',1,'2015-07-29 17:01:25','2015-11-03 09:04:35'),(161,176,NULL,NULL,40,1,95630,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-07-29 18:33:08','2015-11-03 09:04:35'),(162,177,NULL,NULL,23,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-29 21:55:04','2015-11-03 09:04:35'),(163,178,NULL,NULL,28,1,94043,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-30 01:48:48','2015-11-03 09:04:35'),(164,179,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:51','2015-11-03 09:04:35'),(165,180,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:51','2015-11-03 09:04:35'),(166,181,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:51','2015-11-03 09:04:35'),(167,182,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:52','2015-11-03 09:04:35'),(168,183,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:52','2015-11-03 09:04:35'),(169,184,NULL,NULL,37,1,15367,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-30 08:30:52','2015-11-03 09:04:35'),(170,185,NULL,NULL,38,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 16:50:32','2015-11-03 09:04:35'),(171,186,NULL,NULL,30,2,95125,0,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-30 18:10:27','2015-11-03 09:04:35'),(172,187,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 23:40:15','2015-11-03 09:04:35'),(173,188,'john','john.gough1@yahoo.com',30,1,43154,0,2,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 02:13:32','2015-11-03 09:04:35'),(174,189,NULL,NULL,55,1,95070,0,1,'$500,000',10,'v2b-get-estimate',1,'2015-07-31 02:31:35','2015-11-03 09:04:35'),(175,190,NULL,NULL,33,1,98043,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 05:45:15','2015-11-03 09:04:35'),(176,191,NULL,NULL,66,1,95125,0,1,'$250,000',15,'v2b-get-estimate',1,'2015-07-31 18:07:28','2015-11-03 09:04:35'),(177,192,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 18:46:32','2015-11-03 09:04:35'),(178,193,'eshwar','eshwar@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 18:54:20','2015-11-03 09:04:35'),(179,194,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 18:58:17','2015-11-03 09:04:35'),(180,195,'Jacob','jacob@vendus.com',30,1,95125,0,3,'$500,000',20,'v2a-get-estimate',1,'2015-07-31 19:10:45','2015-11-03 09:04:35'),(181,196,NULL,NULL,28,1,94107,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 19:33:26','2015-11-03 09:04:35'),(182,197,'Dawkah','dawkah.farnad@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 20:26:27','2015-11-03 09:04:35'),(183,198,'Don Quitoe','Dustingyoder@gmail.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-31 20:28:35','2015-11-03 09:04:35'),(184,199,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 22:36:48','2015-11-03 09:04:35'),(185,200,NULL,NULL,40,1,27502,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-07-31 23:03:37','2015-11-03 09:04:35'),(186,201,NULL,NULL,55,1,72104,0,3,'$500,000',30,'v2a-get-estimate',1,'2015-08-01 00:58:11','2015-11-03 09:04:35'),(187,202,'jay-kob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-01 02:12:29','2015-11-03 09:04:35'),(188,203,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-01 03:52:10','2015-11-03 09:04:35'),(189,204,NULL,NULL,34,1,33444,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-02 00:35:12','2015-11-03 09:04:35'),(190,205,'Jeremy Cerra','jeremycerra@gmail.com',37,1,66062,0,2,'$250,000',15,'v2a-get-estimate',1,'2015-08-02 04:49:12','2015-11-03 09:04:35'),(191,206,NULL,NULL,50,1,95125,0,2,'$500,000',30,'v2a-get-estimate',1,'2015-08-02 14:08:18','2015-11-03 09:04:35'),(192,207,NULL,NULL,30,2,95008,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-08-02 19:06:54','2015-11-03 09:04:35'),(193,208,NULL,NULL,23,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-02 22:14:14','2015-11-03 09:04:35'),(194,209,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-02 22:59:58','2015-11-03 09:04:35'),(195,210,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-02 23:09:25','2015-11-03 09:04:35'),(196,211,NULL,NULL,28,1,91306,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-03 02:24:08','2015-11-03 09:04:35'),(197,212,NULL,NULL,24,1,94306,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-03 07:47:42','2015-11-03 09:04:35'),(198,213,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-03 20:55:40','2015-11-03 09:04:35'),(199,214,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-04 15:27:01','2015-11-03 09:04:35'),(200,215,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-04 23:57:10','2015-11-03 09:04:35'),(201,216,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-05 05:51:06','2015-11-03 09:04:35'),(202,217,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-05 10:31:12','2015-11-03 09:04:35'),(203,218,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-05 16:04:39','2015-11-03 09:04:35'),(204,219,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-08-06 03:35:58','2015-11-03 09:04:35'),(205,220,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-08-06 03:38:38','2015-11-03 09:04:35'),(206,221,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-06 06:27:32','2015-11-03 09:04:35'),(207,222,NULL,NULL,30,1,95125,1,4,'$250,000',30,'v2b-get-estimate',1,'2015-08-06 07:15:52','2015-11-03 09:04:35'),(208,223,NULL,NULL,30,2,95125,1,1,'$500,000',30,'v2a-get-estimate',1,'2015-08-07 05:27:57','2015-11-03 09:04:35'),(209,224,NULL,NULL,33,2,27283,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 10:57:30','2015-11-03 09:04:35'),(210,225,NULL,NULL,26,1,95107,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-07 16:19:27','2015-11-03 09:04:35'),(211,226,NULL,NULL,26,1,95107,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-07 16:19:29','2015-11-03 09:04:35'),(212,227,NULL,NULL,52,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 17:09:20','2015-11-03 09:04:35'),(213,228,NULL,NULL,25,1,95118,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 19:15:49','2015-11-03 09:04:35'),(214,229,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 21:34:04','2015-11-03 09:04:35'),(215,230,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-08 22:35:22','2015-11-03 09:04:35'),(216,231,'Ryan','Ryan@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-09 05:18:11','2015-11-03 09:04:35'),(217,232,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-10 13:01:25','2015-11-03 09:04:35'),(218,233,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-10 18:19:12','2015-11-03 09:04:35'),(219,234,'Haley Yoder','haleylyoder@gmail.com',NULL,0,0,0,0,NULL,0,'v2b-get-in-touch',1,'2015-08-10 23:26:24','2015-11-03 09:04:35'),(220,235,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-10 23:26:45','2015-11-03 09:04:35'),(221,236,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-11 05:07:56','2015-11-03 09:04:35'),(222,237,'Matt Londre','mlondre@gmail.com',30,1,95129,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-08-11 21:25:54','2015-11-03 09:04:35'),(223,238,NULL,NULL,31,1,95050,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-12 21:57:35','2015-11-03 09:04:35'),(224,239,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-13 16:41:07','2015-11-03 09:04:35'),(225,240,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-14 07:40:35','2015-11-03 09:04:35'),(226,241,NULL,NULL,35,1,2127,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-14 17:05:21','2015-11-03 09:04:35'),(227,242,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-14 19:42:32','2015-11-03 09:04:35'),(228,243,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-14 20:13:49','2015-11-03 09:04:35'),(229,244,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-16 12:48:29','2015-11-03 09:04:35'),(230,245,'dustina joder','dustin@venduslabsinc.com',30,1,95125,0,3,'$250,000',30,'millenial-get-estimate',1,'2015-08-16 17:57:40','2015-11-03 09:04:35'),(231,246,'test','test@test.com',30,1,95125,0,1,'$750,000',30,'millenial-get-estimate',1,'2015-08-16 21:20:50','2015-11-03 09:04:35'),(232,247,NULL,NULL,27,1,20000,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-17 00:33:00','2015-11-03 09:04:35'),(233,248,NULL,NULL,34,1,2062,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-17 12:43:12','2015-11-03 09:04:35'),(234,249,'ryan swanson','ryan.swanson26@yahoo.com',30,1,95125,0,2,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 16:22:23','2015-11-03 09:04:35'),(235,250,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-17 16:24:39','2015-11-03 09:04:35'),(236,251,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 16:25:50','2015-11-03 09:04:35'),(237,252,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 16:41:37','2015-11-03 09:04:35'),(238,253,'eshwar','eshwar@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 18:15:11','2015-11-03 09:04:35'),(239,254,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 18:17:55','2015-11-03 09:04:35'),(240,255,NULL,NULL,42,1,46814,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-17 20:03:05','2015-11-03 09:04:35'),(241,256,'raluca','raluca.brailescu@yahoo.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-18 16:22:26','2015-11-03 09:04:35'),(242,257,NULL,NULL,30,2,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-18 16:25:28','2015-11-03 09:04:35'),(243,258,NULL,NULL,47,1,95125,1,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-19 01:02:04','2015-11-03 09:04:35'),(244,259,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-19 15:35:44','2015-11-03 09:04:35'),(245,260,'Caribou Honig','caribou.honig@gmail.com',45,1,23005,0,1,'$500,000',10,'v2a-get-estimate',1,'2015-08-19 20:39:53','2015-11-03 09:04:35'),(246,261,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-20 00:53:23','2015-11-03 09:04:35'),(247,262,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-20 01:02:42','2015-11-03 09:04:35'),(248,263,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-20 02:23:18','2015-11-03 09:04:35'),(249,264,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-21 04:59:56','2015-11-03 09:04:35'),(250,265,NULL,NULL,31,2,2170,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-23 00:22:56','2015-11-03 09:04:35'),(251,266,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 06:40:02','2015-11-03 09:04:35'),(252,267,NULL,NULL,39,1,10012,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 09:05:22','2015-11-03 09:04:35'),(253,268,NULL,NULL,22,1,60610,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 19:09:06','2015-11-03 09:04:35'),(254,269,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 22:31:36','2015-11-03 09:04:35'),(255,270,NULL,NULL,22,1,94103,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 00:38:20','2015-11-03 09:04:35'),(256,271,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 03:09:11','2015-11-03 09:04:35'),(257,272,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 03:20:00','2015-11-03 09:04:35'),(258,273,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 19:01:02','2015-11-03 09:04:35'),(259,274,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 22:52:12','2015-11-03 09:04:35'),(260,275,NULL,NULL,28,1,95134,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-08-26 04:31:53','2015-11-03 09:04:35'),(261,276,NULL,NULL,32,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 05:26:08','2015-11-03 09:04:35'),(262,277,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 06:04:57','2015-11-03 09:04:35'),(263,278,NULL,NULL,24,1,2151,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-08-26 16:49:00','2015-11-03 09:04:35'),(264,279,NULL,NULL,34,1,78704,0,3,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 20:38:14','2015-11-03 09:04:35'),(265,280,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 21:24:47','2015-11-03 09:04:35'),(266,281,NULL,NULL,22,1,94103,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 22:47:26','2015-11-03 09:04:35'),(267,282,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-27 00:22:05','2015-11-03 09:04:35'),(268,283,NULL,NULL,65,2,10456,1,4,'$250,000',10,'v2b-get-estimate',1,'2015-08-27 04:52:41','2015-11-03 09:04:35'),(269,284,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v1-get-estimate',1,'2015-08-27 17:19:53','2015-11-03 09:04:35'),(270,285,NULL,NULL,26,1,95125,0,3,'$500,000',20,'v2b-get-estimate',1,'2015-08-27 23:15:48','2015-11-03 09:04:35'),(271,286,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 04:01:07','2015-11-03 09:04:35'),(272,287,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 09:06:07','2015-11-03 09:04:35'),(273,288,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 19:36:36','2015-11-03 09:04:35'),(274,289,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 20:36:23','2015-11-03 09:04:35'),(275,290,NULL,NULL,90,2,95125,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-08-31 04:15:02','2015-11-03 09:04:35'),(276,291,NULL,NULL,50,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 04:52:39','2015-11-03 09:04:35'),(277,292,'vijay','vijay@vendus.com',60,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-31 05:53:09','2015-11-03 09:04:35'),(278,293,NULL,NULL,76,1,95125,0,3,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 10:12:12','2015-11-03 09:04:35'),(279,294,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 11:03:29','2015-11-03 09:04:35'),(280,295,'vijay','vijay@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-31 13:25:15','2015-11-03 09:04:35'),(281,296,'vijay','vijay@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-estimate',1,'2015-08-31 13:26:04','2015-11-03 09:04:35'),(282,297,'vijay','vijay@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-estimate',1,'2015-08-31 13:32:32','2015-11-03 09:04:35'),(283,298,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 23:56:36','2015-11-03 09:04:35'),(284,299,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-01 17:45:28','2015-11-03 09:04:35'),(285,300,'Jamie','jamiehale@gmail.com',30,1,94025,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-09-01 18:13:52','2015-11-03 09:04:35'),(286,301,'Jeff Merkel','jeff.merkel@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-09-01 18:59:50','2015-11-03 09:04:35'),(287,302,NULL,NULL,30,2,94010,1,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-01 20:55:24','2015-11-03 09:04:35'),(288,303,NULL,NULL,28,1,58102,0,2,'$500,000',20,'v2b-get-estimate',1,'2015-09-02 14:31:44','2015-11-03 09:04:35'),(289,304,NULL,NULL,36,1,53562,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-09-02 17:29:26','2015-11-03 09:04:35'),(290,305,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-02 22:54:39','2015-11-03 09:04:35'),(291,306,'','mahesh@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 15:08:52','2015-11-03 09:04:35'),(292,307,'','sivaprasad@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 14:51:07','2015-11-03 09:04:35'),(293,308,'','sivaprasad@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 14:51:07','2015-11-03 09:04:35'),(294,309,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-03 14:51:12','2015-11-03 09:04:35'),(295,310,'Preethi P','sivaprasad@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 14:57:12','2015-11-03 09:04:35'),(296,311,'jqcob','jiofj0f934r',30,1,95125,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-03 18:10:48','2015-11-03 09:04:35'),(297,312,'vijay','ivijay@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 15:06:00','2015-11-03 09:04:35'),(298,313,NULL,NULL,28,1,95125,1,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-03 16:43:03','2015-11-03 09:04:35'),(299,314,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 01:17:33','2015-11-03 09:04:35'),(300,315,'Shaun','shaun.taylor@suncorp.com.au',32,1,95125,0,1,'$250,000',20,'v2a-get-estimate',1,'2015-09-04 03:26:52','2015-11-03 09:04:35'),(301,316,'','sivaprasadggggg.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-04 08:30:53','2015-11-03 09:04:35'),(302,317,'Preethi P','preethirekha6@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-09-04 11:36:01','2015-11-03 09:04:35'),(303,318,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 11:38:59','2015-11-03 09:04:35'),(304,319,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 12:51:45','2015-11-03 09:04:35'),(305,320,NULL,NULL,45,2,6611,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 12:57:05','2015-11-03 09:04:35'),(306,321,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 14:02:18','2015-11-03 09:04:35'),(307,322,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 14:02:18','2015-11-03 09:04:35'),(308,323,'','bbnbn',30,1,95125,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-04 14:43:04','2015-11-03 09:04:35'),(309,324,'','sivaatchala@gmail.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-04 14:53:46','2015-11-03 09:04:35'),(310,325,NULL,NULL,30,1,95125,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-09-05 01:18:22','2015-11-03 09:04:35'),(311,326,'Tiffany Ball','tball448@gmail.com',32,2,95123,0,4,'$500,000',30,'v2b-get-estimate',1,'2015-09-05 08:50:53','2015-11-03 09:04:35'),(312,327,'Dusts be','dustjn@ail',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-05 17:37:45','2015-11-03 09:04:35'),(313,328,'Dusts be','dustjn@ail',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-05 17:37:45','2015-11-03 09:04:35'),(314,329,'','buket.ozatay@gmail.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-07 07:30:06','2015-11-03 09:04:35'),(315,330,'jose','joseiv@gmail.com',30,1,95125,0,2,'$250,000',10,'v2b-get-estimate',1,'2015-09-07 19:30:57','2015-11-03 09:04:35'),(316,331,'josh','atxjclark@gmail.com',30,1,11215,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-08 13:44:57','2015-11-03 09:04:35'),(317,332,'Ryan ','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-08 16:43:50','2015-11-03 09:04:35'),(318,333,'Guillermo Gaviria','ggaviria@sura.com.co',37,1,95125,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-09-08 20:28:48','2015-11-03 09:04:35'),(319,334,'Jon','Jon@gmail.com',30,1,90210,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-08 23:01:01','2015-11-03 09:04:35'),(320,335,'dane','dane.ross@cba.com.au',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-09 00:15:56','2015-11-03 09:04:35'),(321,336,'Esther Dyson','edyson@edventure.com',64,2,10012,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-09 14:30:25','2015-11-03 09:04:35'),(322,337,'Jeta Beta','beyjesse@gmail.com',35,1,10010,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-09 15:55:49','2015-11-03 09:04:35'),(323,338,'W S','wayne+sureify@reaction.org',32,1,92130,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-09-09 16:15:46','2015-11-03 09:04:35'),(324,339,'jacob','jacob@vendus.com',24,1,95125,1,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-09 16:57:15','2015-11-03 09:04:35'),(325,340,'dawkah farnad','dawkahfarnad@gmail.com',50,1,95125,0,2,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-09 18:52:34','2015-11-03 09:04:35'),(326,341,'Vero','veritour@gmail.com',31,2,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-09 18:56:50','2015-11-03 09:04:35'),(327,342,'Tom','tommy9090@gmail.com',33,1,10023,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-10 00:15:22','2015-11-03 09:04:35'),(328,343,'james Yoder','Jamesyoder@gmai.com',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-10 02:56:52','2015-11-03 09:04:35'),(329,344,'amukhopa@gmail.com','amukhopa@gmail.com',30,1,60305,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-09-10 04:11:07','2015-11-03 09:04:35'),(330,345,'Jim','Jim@gmail.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-10 04:30:21','2015-11-03 09:04:35'),(331,346,'Andy Gordon','Agordo@mindspring.com',42,1,11713,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-10 09:36:15','2015-11-03 09:04:35'),(332,347,'Mary','mary.helen.watson@gmail.com',30,2,90210,1,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-10 16:46:07','2015-11-03 09:04:35'),(333,348,'Sam ','sam.wadsworth@suncorp.com.au',32,1,95125,0,2,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-11 08:37:15','2015-11-03 09:04:35'),(334,349,'scott.ham@transamerica.com','scott.ham@transamerica.com',50,1,54333,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-09-11 15:19:02','2015-11-03 09:04:35'),(335,350,'','abdul@abdul.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-11 20:21:15','2015-11-03 09:04:35'),(336,351,'Derek Brigham','derekbrigham@tds.net',50,1,53711,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-11 20:45:55','2015-11-03 09:04:35'),(337,352,'ed.walker@transamerica.com','ed.walker@transamerica.com',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-11 23:27:31','2015-11-03 09:04:35'),(338,353,'Robert','Robdanmor@icloud.com',40,1,75013,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-12 18:37:56','2015-11-03 09:04:35'),(339,354,'mehmet','mcvanli@gmail.com',30,1,95125,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-09-13 18:35:49','2015-11-03 09:04:35'),(340,355,'scott.ham@transamerica.com','scott.ham@transamerica.com',52,1,52333,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-14 13:47:08','2015-11-03 09:04:35'),(341,356,'Robert','robdanmor@icloud.com',43,1,75013,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-14 15:19:03','2015-11-03 09:04:35'),(342,357,'preethi','preethi@vendus.com',56,1,50002,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-16 17:10:20','2015-11-03 09:04:35'),(343,358,'vijay','vijay@vendus.com',28,1,9999,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-16 17:34:49','2015-11-03 09:04:35'),(344,359,'31231321312','pradeep@vendus.com',22,1,12345,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-16 17:22:39','2015-11-03 09:04:35'),(345,360,'prad','p@vendus.com',30,1,12345,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-16 20:59:55','2015-11-03 09:04:35'),(346,361,'Beth','bethko1234@gmail.com',25,2,21401,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-16 21:09:26','2015-11-03 09:04:35'),(347,362,'d','yoder@aol.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-17 00:57:43','2015-11-03 09:04:35'),(348,363,'Alex Volpicello','alexander_volpicello@brown.edu',19,1,2912,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-17 13:12:07','2015-11-03 09:04:35'),(349,364,'Jay zorn','Joseph.zorn@transamerica.com',40,1,80526,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-18 01:42:49','2015-11-03 09:04:35'),(350,365,'P','Pgilman@mac.com',42,1,50314,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-18 04:06:28','2015-11-03 09:04:35'),(351,366,'fjdhj,fd','sdnffjw@aol.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-18 18:34:55','2015-11-03 09:04:35'),(352,367,'Rodrigo','g11018883@trbvm.com',24,1,2151,1,2,'$250,000',30,'v2b-get-estimate',1,'2015-09-21 16:04:03','2015-11-03 09:04:35'),(353,368,'bob','bob@nobody.com',40,1,90210,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-21 19:55:24','2015-11-03 09:04:35'),(354,369,'Test','Test@test.com',38,1,75248,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-21 21:11:48','2015-11-03 09:04:35'),(355,370,'Ed','ed.walker@gmail.com',49,1,21136,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-22 12:30:22','2015-11-03 09:04:35'),(356,371,'Andrew Grinalds','Grinalds@gmail.com',24,1,94114,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-09-23 00:51:02','2015-11-03 09:04:35'),(357,372,'Camila','camila.carvalho.s@hotmail.com',26,2,10001,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-09-23 14:49:30','2015-11-03 09:04:35'),(358,373,'John','johnsmith__2015@hotmail.com',25,1,2151,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-09-23 20:58:09','2015-11-03 09:04:35'),(359,374,'Aura','aura.rebelo@gmail.com',49,2,22260020,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-09-23 23:48:44','2015-11-03 09:04:35'),(360,375,'Jeff','hawkhousejeff@hotmail.com',36,1,78739,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-24 17:58:12','2015-11-03 09:04:35'),(361,376,'Troy Vincent ','naismith1891@yahoo.com',41,1,50266,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-24 21:04:32','2015-11-03 09:04:35'),(362,377,'Steve','steve.hoskins@phmic.com',59,1,50511,0,3,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-25 15:44:44','2015-11-03 09:04:35'),(363,378,'duder fodder','dussdfasdtyyoder@gmial.com',21,2,95125,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-25 17:28:43','2015-11-03 09:04:35'),(364,379,'Chris Thompson','theobadiahgroup@gmail.com',58,1,95126,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-09-27 21:20:55','2015-11-03 09:04:35'),(365,380,'Lisa Woods','lisa.m.woods@gmail.com',34,2,80206,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-28 15:51:26','2015-11-03 09:04:35'),(366,381,'jacob','jacob@vendus.com',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-28 23:36:12','2015-11-03 09:04:35'),(367,382,'tim','tim@hotmail.com',33,1,91,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-30 15:50:09','2015-11-03 09:04:35'),(368,383,'Bob','Bob@Marley.com',50,1,6905,0,2,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-01 04:48:16','2015-11-03 09:04:35'),(369,384,'Richard Haigh','rhaigh2002@gmail.com',40,1,2135,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-10-01 23:31:48','2015-11-03 09:04:35'),(370,385,'rick','rick2gt@hotmail.com',35,1,90210,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-02 00:33:39','2015-11-03 09:04:35'),(371,386,'Katarina Blom','katarina.blom@gmail.com',30,2,11205,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-10-02 13:54:27','2015-11-03 09:04:35'),(372,387,'priyanka','priyanka@vendus.com',90,1,8989,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-05 05:24:59','2015-11-03 09:04:35'),(373,388,'priyanka','chiluveri.priyanka@gmail.com',48,2,7878,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-10-05 06:16:53','2015-11-03 09:04:35'),(374,389,'Jack','jack.dugan@gmail.com',32,1,10001,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-05 10:58:42','2015-11-03 09:04:35'),(375,390,'David','david@knip.ch',24,1,10012,1,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-05 13:46:06','2015-11-03 09:04:35'),(376,391,'David','david@knip.ch',24,1,10012,1,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-05 13:46:06','2015-11-03 09:04:35'),(377,392,'Brandon Moyles','brandonmoyles@gmail.com',29,1,92011,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-10-06 03:44:25','2015-11-03 09:04:35'),(378,393,'Matteo','matteo.solesin@yahoo.it',28,1,20137,0,1,'$750,000',10,'v2b-get-estimate',1,'2015-10-06 13:51:20','2015-11-03 09:04:35'),(379,394,'William Lincoln','wdemier@amfam.com',45,1,53713,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-10-06 18:07:53','2015-11-03 09:04:35'),(380,395,'xcds','sdsf@dfdsf.com',25,1,12345,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-06 21:16:44','2015-11-03 09:04:35'),(381,396,'john','jk715.84@gmail.com',30,1,94536,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-10-06 22:25:22','2015-11-03 09:04:35'),(382,397,'Jacob Are you here','WeinerButt@aol.com',54,1,95269,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-10-07 02:11:50','2015-11-03 09:04:35'),(383,398,'Paul','pjaessing@gmail.com',40,1,53090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-07 04:34:26','2015-11-03 09:04:35'),(384,399,'Jw','Boxdoctors03@ymail.com',33,1,28075,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-07 05:04:48','2015-11-03 09:04:35'),(385,400,'Anna Chambers','j_a_chambers2011@yahoo.com',35,2,37040,0,3,'$500,000',30,'v2b-get-estimate',1,'2015-10-07 06:18:24','2015-11-03 09:04:35'),(386,401,'Mark Batsiyan','mark.batsiyan@gmail.com',30,1,11215,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-08 20:04:03','2015-11-03 09:04:35'),(387,402,'Andrzej baraniak','Baraniak.andrzej@gmail.com',32,1,10312,1,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-09 11:17:50','2015-11-03 09:04:35'),(388,403,'Max','hubb8281@gmail.com',23,1,55101,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-09 14:42:07','2015-11-03 09:04:35'),(389,404,'yakob','jacob@vendus.com',18,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-09 18:48:28','2015-11-03 09:04:35'),(390,406,'Trisha','trisha.chhaya@gmail.com',60,2,94109,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-21 18:13:22','2015-11-03 09:04:35'),(391,407,'Ryan','ryan@vendus.com',23,1,95120,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-22 13:30:34','2015-11-03 09:04:35'),(392,408,'Axel StradaVecchia','axel2303@gmx.at',23,1,90210,0,1,'$500,000',10,'v2b-get-estimate',1,'2015-10-23 02:07:19','2015-11-03 09:04:35'),(393,409,'Tom','tommy9090@gmail.com',33,1,10023,0,1,'$500,000',10,'v2b-get-estimate',1,'2015-10-23 12:19:57','2015-11-03 09:04:35'),(394,410,'Eric Taylor','estaylor777@gmail.com',24,1,94306,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-10-23 18:12:54','2015-11-03 09:04:35'),(395,411,'RamBheem','rambheema@yahoo.com',39,1,1801,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-24 21:03:33','2015-11-03 09:04:35'),(396,412,'Sandeep','manchie@yahoo.com',51,1,10533,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-25 21:00:03','2015-11-03 09:04:35'),(397,413,'Ryan','ryan@vendus.com',23,1,2342,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-25 22:46:57','2015-11-03 09:04:35'),(398,414,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-26 08:57:29','2015-11-03 09:04:35'),(399,415,'sai','priyanka@gmail.com',33,1,33,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 06:17:35','2015-11-03 09:04:35'),(400,416,'Andreas','aulvaer@gmail.com',34,1,73157,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-26 05:57:59','2015-11-03 09:04:35'),(401,417,'jacob@vendus.com','jacob@sureify.com',24,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-26 09:21:37','2015-11-03 09:04:35'),(402,418,'James Davidson','jdavidson@gmail.com',31,1,94062,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-10-26 11:43:57','2015-11-03 09:04:35'),(403,419,'Jim','thegillyman@yahoo.com',49,1,6825,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-10-26 15:07:00','2015-11-03 09:04:35'),(404,420,'Garrett','viggers@sbcglobal.net',37,1,96001,0,2,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-26 22:24:33','2015-11-03 09:04:35'),(405,421,'Chris Kaye','ccvkaye@gmaill.com',43,1,94203,0,2,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-27 05:11:37','2015-11-03 09:04:35'),(406,422,'JDP','jdpark325@gmail.com',37,1,48105,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 07:52:24','2015-11-03 09:04:35'),(407,423,'Ryan Foss','ryanjfoss@gmail.com',41,1,55331,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 09:19:49','2015-11-03 09:04:35'),(408,424,'Test','test@test.com',25,1,27101,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-27 12:14:42','2015-11-03 09:04:35'),(409,425,'Pk','pradeep@vendus.com',98,1,12345,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 12:30:33','2015-11-03 09:04:35'),(410,426,'Phil Spokas','philspokas@gmail.com',52,1,99203,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-27 12:48:30','2015-11-03 09:04:35'),(411,427,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:05','2015-11-03 09:04:35'),(412,428,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:13','2015-11-03 09:04:35'),(413,429,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:25','2015-11-03 09:04:35'),(414,430,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:38','2015-11-03 09:04:35'),(415,431,'Maura','maura.egan@yahoo.com',30,2,60614,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-10-27 13:53:21','2015-11-03 09:04:35'),(416,432,'Jason','jason.emery@homesite.com',37,1,2062,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-10-27 14:01:09','2015-11-03 09:04:35'),(417,433,'pwalker2@yahoo.com','pwalker2@yahoo.com',40,2,1890,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-10-27 14:52:42','2015-11-03 09:04:35'),(418,434,'Tomasz Jaroszczyk','Tmj105@hotmail.com',35,1,53593,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-27 15:25:19','2015-11-03 09:04:35'),(419,435,'Ryan','ryantoner@gmail.com',32,1,19355,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 19:46:13','2015-11-03 09:04:35'),(420,436,'','kob34@adelphia.net',50,1,12801,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 20:04:43','2015-11-03 09:04:35'),(421,437,'xccx','priyanka@vendus.com',78,1,909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 12:29:13','2015-11-03 09:04:35'),(422,438,'xscfsf','priyanka@vendus.com',34,1,4343,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 12:31:19','2015-11-03 09:04:35'),(423,439,'xc','priyanka@vendus.com',89,1,9090,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-10-28 12:31:56','2015-11-03 09:04:35'),(424,440,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 12:32:18','2015-11-03 09:04:35'),(425,441,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:26:25','2015-11-03 09:04:35'),(426,442,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:29:22','2015-11-03 09:04:35'),(427,443,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:30:08','2015-11-03 09:04:35'),(428,444,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:30:52','2015-11-03 09:04:35'),(429,445,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:31:53','2015-11-03 09:04:35'),(430,446,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 13:33:25','2015-11-03 09:04:35'),(431,447,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 13:34:04','2015-11-03 09:04:35'),(432,448,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:39:03','2015-11-03 09:04:35'),(433,449,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:40:29','2015-11-03 09:04:35'),(434,450,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:41:13','2015-11-03 09:04:35'),(435,451,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 13:43:43','2015-11-03 09:04:35'),(436,452,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-28 13:53:43','2015-11-03 09:04:35'),(437,453,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-10-28 14:00:05','2015-11-03 09:04:35'),(438,454,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 04:19:10','2015-11-03 09:04:35'),(439,455,'vijay','vijay.ch@vendus.com',28,1,95514,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 04:50:41','2015-11-03 09:04:35'),(440,456,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 04:35:16','2015-11-03 09:04:35'),(441,457,'xcxc','priyanka@vendus.com',34,1,3434,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:14:54','2015-11-03 09:04:35'),(442,458,'xc','priyanka@vendus.com',89,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:15:17','2015-11-03 09:04:35'),(443,459,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 05:15:39','2015-11-03 09:04:35'),(444,460,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 05:15:43','2015-11-03 09:04:35'),(445,461,'nmm','saikrishna@vendus.com',45,1,7878,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:16:45','2015-11-03 09:04:35'),(446,462,'xcxc','priyanka@vendus.com',90,1,8989,0,1,'$250,000',10,'v2b-get-estimate',1,'2015-10-29 05:20:45','2015-11-03 09:04:35'),(447,463,'xccx','priyanka@vendus.com',45,1,4545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:21:04','2015-11-03 09:04:35'),(448,464,'xc','priyanka@vendus.com',67,1,9867,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:21:44','2015-11-03 09:04:35'),(449,465,'xc','priyanka@vendus.com',66,1,8888,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:22:17','2015-11-03 09:04:35'),(450,466,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 05:22:42','2015-11-03 09:04:35'),(451,467,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'alternate landing page bottom signup',1,'2015-10-29 05:23:06','2015-11-03 09:04:35'),(452,468,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page bottom signup',1,'2015-10-29 05:24:22','2015-11-03 09:04:35'),(453,469,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page bottom signup',1,'2015-10-29 05:25:25','2015-11-03 09:04:35'),(454,470,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page top signup',1,'2015-10-29 05:25:41','2015-11-03 09:04:35'),(455,471,'nmnm','priyanka@vendus.com',89,1,98978,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:29:56','2015-11-03 09:04:35'),(456,472,'xcnmxcn','priyanka@vendus.com',34,1,909099090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:06:58','2015-11-03 09:04:35'),(457,473,'xcnmxcn','priyanka@vendus.com',34,1,909099090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:07:00','2015-11-03 09:04:35'),(458,474,'xcnmxcn','priyanka@vendus.com',34,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:07:10','2015-11-03 09:04:35'),(459,475,'cvcv','priyanka@vendus.com',78,1,909090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:08:52','2015-11-03 09:04:35'),(460,476,'xc','priyanka@vendus.com',45,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:09:29','2015-11-03 09:04:35'),(461,477,'xc','priyanka@vendus.com',45,1,909090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:12:30','2015-11-03 09:04:35'),(462,478,'cvcv','priyanka@vendus.com',90,1,565,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:16:51','2015-11-03 09:04:35'),(463,479,'xcc','priyanka@vendus.com',34,1,45454545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:29:19','2015-11-03 09:04:35'),(464,480,'xcc','priyanka@vendus.com',34,1,45454545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:29:20','2015-11-03 09:04:35'),(465,481,'xcc','priyanka@vendus.com',34,1,454544545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:29:35','2015-11-03 09:04:35'),(466,482,'xcxc','priyanka@vendus.com',34,1,900909090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:31:14','2015-11-03 09:04:35'),(467,483,'xcxc','priyanka@vendus.com',34,1,90099,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:31:47','2015-11-03 09:04:35'),(468,484,NULL,'xcx@fddfnm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 12:34:41','2015-11-03 09:04:35'),(469,485,'dbvnbdv','vbcnv@jbn.com',34,1,67676767,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:36:10','2015-11-03 09:04:35'),(470,486,'','chvkcse@gmail.com',20,1,333333,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:40:05','2015-11-03 09:04:35'),(471,487,'xcxc','priyanka@vendus.com',34,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:43:45','2015-11-03 09:04:35'),(472,488,'xcxc','priyanka@vendus.com',34,1,2147483647,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:43:53','2015-11-03 09:04:35'),(473,489,'xc','chiluveri.priyanka@gmail.com',98,1,2147483647,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:45:13','2015-11-03 09:04:35'),(474,490,'','chvkcse@gmail.com',23,1,4214,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:48:02','2015-11-03 09:04:35'),(475,491,'','chiluveri.priyanka@gmail.com',43,1,12345,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:51:48','2015-11-03 09:04:35'),(476,492,'xc','cnxcnm@nmxnm.com',34,1,90909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:19:33','2015-11-03 09:04:35'),(477,493,'xc','priyanka@vendus.com',34,1,90909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:19:48','2015-11-03 09:04:35'),(478,494,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 13:20:19','2015-11-03 09:04:35'),(479,495,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-10-29 13:20:37','2015-11-03 09:04:35'),(480,496,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signup',1,'2015-10-29 13:21:07','2015-11-03 09:04:35'),(481,497,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-10-29 13:21:29','2015-11-03 09:04:35'),(482,498,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page top signup',1,'2015-10-29 13:21:42','2015-11-03 09:04:35'),(483,499,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page bottom signup',1,'2015-10-29 13:21:58','2015-11-03 09:04:35'),(484,500,'xv','priyanka@vendus.com',45,1,45589,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:31:39','2015-11-03 09:04:35'),(485,501,'xc','priyanka@vendus.com',34,1,90909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:32:30','2015-11-03 09:04:35'),(486,502,NULL,'xcxc@nmnm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 13:55:37','2015-11-03 09:04:35'),(487,503,NULL,'xncmnx@nmnm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 13:55:52','2015-11-03 09:04:35'),(488,504,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:00:35','2015-11-03 09:04:35'),(489,505,NULL,'sdmsndmn@mbb.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:03:27','2015-11-03 09:04:35'),(490,506,NULL,'chiluveri.priyankxcxca@gmail.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:05:21','2015-11-03 09:04:35'),(491,507,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:06:27','2015-11-03 09:04:35'),(492,508,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:07:12','2015-11-03 09:04:35'),(493,509,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:08:34','2015-11-03 09:04:35'),(494,510,NULL,'nmnm@Nm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:09:55','2015-11-03 09:04:35'),(495,511,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:13:28','2015-11-03 09:04:35'),(496,512,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:14:35','2015-11-03 09:04:35'),(497,513,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:15:41','2015-11-03 09:04:35'),(498,514,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-10-29 14:16:46','2015-11-03 09:04:35'),(499,515,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:18:23','2015-11-03 09:04:35'),(500,516,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:19:05','2015-11-03 09:04:35'),(501,517,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:20:33','2015-11-03 09:04:35'),(502,518,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:21:04','2015-11-03 09:04:35'),(503,519,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:21:09','2015-11-03 09:04:35'),(504,520,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:22:12','2015-11-03 09:04:35'),(505,521,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:23:17','2015-11-03 09:04:35'),(506,522,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:24:09','2015-11-03 09:04:35'),(507,523,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:25:07','2015-11-03 09:04:35'),(508,524,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:26:30','2015-11-03 09:04:35'),(509,525,NULL,'nmnm@Nm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:27:03','2015-11-03 09:04:35'),(510,526,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:27:43','2015-11-03 09:04:35'),(511,527,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:28:21','2015-11-03 09:04:35'),(512,528,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:29:04','2015-11-03 09:04:35'),(513,529,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:29:41','2015-11-03 09:04:35'),(514,530,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:31:22','2015-11-03 09:04:35'),(515,531,NULL,'nmnm@Nm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:32:56','2015-11-03 09:04:35'),(516,532,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:35:05','2015-11-03 09:04:35'),(517,533,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:36:12','2015-11-03 09:04:35'),(518,534,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:40:51','2015-11-03 09:04:35'),(519,535,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:43:29','2015-11-03 09:04:35'),(520,536,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:45:03','2015-11-03 09:04:35'),(521,537,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:45:59','2015-11-03 09:04:35'),(522,538,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:52:27','2015-11-03 09:04:35'),(523,539,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:52:31','2015-11-03 09:04:35'),(524,540,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:41','2015-11-03 09:04:35'),(525,541,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:46','2015-11-03 09:04:35'),(526,542,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:51','2015-11-03 09:04:35'),(527,543,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:55','2015-11-03 09:04:35'),(528,544,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:59:52','2015-11-03 09:04:35'),(529,545,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:00:02','2015-11-03 09:04:35'),(530,546,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:00:14','2015-11-03 09:04:35'),(531,547,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:02:54','2015-11-03 09:04:35'),(532,548,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:05:22','2015-11-03 09:04:35'),(533,549,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:05:55','2015-11-03 09:04:35'),(534,550,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:07:24','2015-11-03 09:04:35'),(535,551,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:08:52','2015-11-03 09:04:35'),(536,552,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:10:29','2015-11-03 09:04:35'),(537,553,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:11:41','2015-11-03 09:04:35'),(538,554,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:12:21','2015-11-03 09:04:35'),(539,555,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:13:16','2015-11-03 09:04:35'),(540,556,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:14:03','2015-11-03 09:04:35'),(541,557,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-10-29 15:16:08','2015-11-03 09:04:35'),(542,558,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signup',1,'2015-10-29 15:16:29','2015-11-03 09:04:35'),(543,559,'sai','saikrishna@vendus.com',24,1,36655,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-11-03 03:13:45','2015-11-03 11:13:45'),(544,560,NULL,'saikrishna@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-11-03 03:15:21','2015-11-03 11:15:21'),(545,561,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Signup',1,'2015-11-03 03:15:47','2015-11-03 11:15:47'),(546,562,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-11-03 03:16:12','2015-11-03 11:16:12'),(547,563,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-11-03 03:16:49','2015-11-03 11:16:49'),(548,564,NULL,'saikrishna@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-11-04 05:51:50','2015-11-04 13:51:50'),(549,565,'sai','saikrishna@vendus.com',25,1,54212,1,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-11-04 21:39:24','2015-11-05 05:39:24'),(550,566,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-11-04 21:52:45','2015-11-05 05:52:45');
/*!40000 ALTER TABLE `history_quote_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_remainder_setups`
--

DROP TABLE IF EXISTS `history_remainder_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_remainder_setups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary remainder_setups table',
  `remainder_setups_id` int(11) NOT NULL COMMENT 'Primary key parent remainder_setups table',
  `remainder_name` varchar(255) DEFAULT NULL COMMENT 'Remainder name',
  `description` text COMMENT 'Remainder description',
  `template_id` int(11) DEFAULT NULL COMMENT 'Primary key of email_templates id',
  `is_hours` tinyint(1) DEFAULT '0' COMMENT 'Checking remainder for hours',
  `remainder_hours` int(4) DEFAULT NULL COMMENT 'Number of Hours',
  `is_days` tinyint(1) DEFAULT '0' COMMENT 'Checking remainder for days',
  `remainder_days` int(4) DEFAULT NULL COMMENT 'Number of days',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_remainder_setups`
--

LOCK TABLES `history_remainder_setups` WRITE;
/*!40000 ALTER TABLE `history_remainder_setups` DISABLE KEYS */;
INSERT INTO `history_remainder_setups` VALUES (1,1,'example','asdsa',6,0,0,0,0,1,59,'2015-11-11 21:12:41','2015-11-12 05:12:41'),(2,1,'example','asdsa',6,0,0,0,0,1,59,'2015-11-11 21:12:41','2015-11-12 05:12:41'),(3,1,'example','asdsa',6,1,2,0,0,1,59,'2015-11-11 21:16:05','2015-11-12 05:16:05'),(4,1,'example','asdsa',6,0,0,0,0,1,59,'2015-11-11 21:16:24','2015-11-12 05:16:24'),(5,1,'example','asdsa',6,1,1,0,0,1,59,'2015-11-11 21:17:49','2015-11-12 05:17:49'),(6,1,'example','asdsa',6,0,2,0,0,1,59,'2015-11-11 21:18:37','2015-11-12 05:18:37'),(7,1,'example','asdsa',6,0,0,0,0,1,59,'2015-11-11 21:18:51','2015-11-12 05:18:51'),(8,1,'example','asdsa',6,0,0,0,0,1,59,'2015-11-11 21:25:40','2015-11-12 05:25:40'),(9,1,'example','asdsa',6,1,2,0,0,1,59,'2015-11-11 21:27:51','2015-11-12 05:27:51'),(10,1,'example','asdsa',6,0,2,1,2,1,59,'2015-11-11 21:31:08','2015-11-12 05:31:08'),(11,1,'example','asdsa',6,0,2,0,0,1,59,'2015-11-11 21:31:19','2015-11-12 05:31:19'),(12,1,'example','asdsa',6,1,2,1,0,1,59,'2015-11-11 21:47:30','2015-11-12 05:47:30'),(13,1,'example','asdsa',6,1,2,0,0,1,59,'2015-11-11 21:47:45','2015-11-12 05:47:45'),(14,2,'example','asdsadf',6,0,0,0,0,1,59,'2015-11-11 21:59:53','2015-11-12 05:59:53'),(15,3,'example1','sdfasd',9,0,0,0,0,1,59,'2015-11-11 22:00:23','2015-11-12 06:00:23'),(16,3,'example1','sdfasd',9,0,0,0,0,1,59,'2015-11-11 22:00:23','2015-11-12 06:00:23'),(17,4,'example1','asdsadf',6,0,0,0,0,1,59,'2015-11-11 22:01:09','2015-11-12 06:01:09'),(18,5,'example1a','asdsadf',6,0,0,0,0,1,59,'2015-11-11 22:01:37','2015-11-12 06:01:37'),(19,6,'example1aa','asdsadf',6,0,0,0,0,1,61,'2015-11-11 23:09:46','2015-11-12 07:09:46'),(20,6,'example1aa','asdsadf',6,0,0,0,0,1,61,'2015-11-11 23:09:46','2015-11-12 07:09:46'),(21,5,'example1a','asdsadf',6,0,0,0,0,1,59,'2015-11-11 22:01:37','2015-11-12 06:01:37'),(22,6,'example11','asdsadf',6,0,0,0,0,1,61,'2015-11-11 23:11:34','2015-11-12 07:11:34'),(23,4,'example1','asdsadf',6,0,0,0,0,1,59,'2015-11-11 22:01:09','2015-11-12 06:01:09'),(24,4,'example1','asdsadf',6,0,0,0,0,1,61,'2015-11-11 23:12:03','2015-11-12 07:12:03');
/*!40000 ALTER TABLE `history_remainder_setups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_calories`
--

DROP TABLE IF EXISTS `history_user_calories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_calories` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key calories table',
  `user_calories_id` int(11) NOT NULL COMMENT 'Primary key parent user_calories table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `calories` int(11) DEFAULT NULL COMMENT 'calories of the user on aparticular date',
  `calories_date` datetime DEFAULT NULL COMMENT 'date of the calories recorded',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_calories`
--

LOCK TABLES `history_user_calories` WRITE;
/*!40000 ALTER TABLE `history_user_calories` DISABLE KEYS */;
INSERT INTO `history_user_calories` VALUES (1,1,2,1354,'2015-10-25 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(2,2,2,1532,'2015-10-26 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(3,3,2,1944,'2015-10-27 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(4,4,2,1682,'2015-10-28 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(5,5,2,1658,'2015-10-29 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(6,6,2,1570,'2015-10-30 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(7,7,2,1354,'2015-10-31 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(8,8,2,1354,'2015-11-01 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(9,9,2,1540,'2015-11-02 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(10,10,2,1672,'2015-11-03 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(11,11,2,1647,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(12,11,2,1647,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(13,12,2,1647,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(14,11,2,1647,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(15,12,2,1647,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(16,13,2,1647,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(17,11,2,1647,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(18,12,2,1647,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(19,13,2,1647,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(20,14,2,1647,'2015-11-04 00:00:00',1,50,'2015-11-04 23:48:08','2015-11-05 07:48:08'),(21,15,3,1806,'2015-11-02 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22'),(22,16,3,1639,'2015-11-03 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22'),(23,17,3,1639,'2015-11-04 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22'),(24,18,3,937,'2015-11-05 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22');
/*!40000 ALTER TABLE `history_user_calories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_challenges`
--

DROP TABLE IF EXISTS `history_user_challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_challenges table',
  `user_challenges_id` int(11) NOT NULL COMMENT 'Primary key parent user_challenges table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `challenge_id` int(11) NOT NULL COMMENT 'Primary key of the challenges_master table',
  `status` int(4) DEFAULT NULL COMMENT 'challenges status value links to group values',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_challenges`
--

LOCK TABLES `history_user_challenges` WRITE;
/*!40000 ALTER TABLE `history_user_challenges` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_user_challenges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_devices`
--

DROP TABLE IF EXISTS `history_user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_devices table',
  `user_devices_id` int(11) DEFAULT NULL COMMENT 'primary key of user_devices table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key user_devices table',
  `device_id` int(11) DEFAULT NULL COMMENT 'Primary key devices_master table',
  `battery` varchar(255) DEFAULT NULL COMMENT 'Battery info',
  `device_version` varchar(255) DEFAULT NULL COMMENT 'Device version',
  `features` text COMMENT 'device futures',
  `fitbit_device_id` varchar(255) DEFAULT NULL COMMENT 'fitbit_device_id',
  `last_sync_time` varchar(255) DEFAULT NULL COMMENT 'Last time when user synchronizes the device',
  `mac` varchar(255) DEFAULT NULL COMMENT 'mac number',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type of the device',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_devices`
--

LOCK TABLES `history_user_devices` WRITE;
/*!40000 ALTER TABLE `history_user_devices` DISABLE KEYS */;
INSERT INTO `history_user_devices` VALUES (1,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,4,'0000-00-00 00:00:00','2015-11-05 07:24:17'),(4,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,4,'0000-00-00 00:00:00','2015-11-05 07:24:17'),(5,4,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(6,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,4,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(7,4,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(8,5,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(9,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,4,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(10,4,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(11,5,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(12,6,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(13,2,2,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,4,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(14,4,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(15,5,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',0,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(16,6,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(17,7,2,NULL,'Medium','Charge HR','a:0:{}','54889518','2015-11-04T23:31:17.000','3636864495DE','TRACKER',1,50,'2015-11-04 23:48:08','2015-11-05 07:48:08');
/*!40000 ALTER TABLE `history_user_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_info`
--

DROP TABLE IF EXISTS `history_user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_info table',
  `user_info_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'First name of user',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Last name of user',
  `height` varchar(255) DEFAULT NULL COMMENT 'Height of user',
  `weight` float(5,2) DEFAULT NULL COMMENT 'Weight of user',
  `location` varchar(255) DEFAULT NULL COMMENT 'Location of user',
  `address` text COMMENT 'Address of an user',
  `profile_pic` varchar(255) DEFAULT NULL COMMENT 'Profile pic of user',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Mobile number of user',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of user',
  `age` int(3) DEFAULT NULL,
  `gender` int(4) DEFAULT NULL COMMENT 'Gender-Group values-',
  `salary` float(10,2) DEFAULT NULL COMMENT 'Salary or income of user',
  `ssn` varchar(50) DEFAULT NULL COMMENT 'SSN number of an user',
  `driving_license` varchar(50) DEFAULT NULL COMMENT 'Driving license number of an user',
  `death_date` datetime DEFAULT NULL COMMENT 'Death date of user',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `date_of_birth` datetime DEFAULT NULL COMMENT 'Date of birth of an user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_info`
--

LOCK TABLES `history_user_info` WRITE;
/*!40000 ALTER TABLE `history_user_info` DISABLE KEYS */;
INSERT INTO `history_user_info` VALUES (1,6,2,'srujana',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'2015-11-03 18:38:38','2015-11-03 13:08:38',NULL),(2,6,2,'srujana',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'2015-11-03 18:38:38','2015-11-03 13:08:38',NULL),(3,6,2,'srujana',NULL,NULL,NULL,NULL,NULL,'sulu1.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'2015-11-03 18:38:38','2015-11-02 23:41:44',NULL),(4,6,2,'srujana',NULL,NULL,NULL,'india',NULL,'sulu1.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'2015-11-03 18:38:38','2015-11-03 13:26:20',NULL),(5,6,2,'srujana',NULL,NULL,NULL,'andhra',NULL,'sulu1.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'2015-11-03 18:38:38','2015-11-03 13:26:54',NULL),(6,6,2,'srujana',NULL,NULL,NULL,'andhra',NULL,'sulu1.jpg','(850) 025-7089',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,1,'2015-11-03 18:38:38','2015-11-03 13:29:18',NULL),(7,1,1,'Vijay','Chirivolu','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay.ch@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(8,2,2,'Srujana','Dakoju','5\"7',80.50,'India',NULL,NULL,'9848022338','srujana@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(9,3,3,'tammini','Venkat','5\"7',70.50,'India',NULL,NULL,'9848022338','tammini@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(10,4,4,'Pradeep','Reddy','5\"7',70.50,'India',NULL,NULL,'9848022338','pradeep@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(11,5,5,'Sulu','Velugu','5\"7',70.50,'India',NULL,NULL,'9848022338','sulu@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(12,6,6,'Vijay','Thodupunoori','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(13,7,7,'Dustin','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','dustin@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(14,8,8,'Ryan','Swanson','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','ryan@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(15,9,9,'Jacob','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','jacob@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(16,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-04 10:26:12',NULL),(17,1,1,'Vijay','Chirivolu','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay.ch@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(18,2,2,'Srujana','Dakoju','5\"7',80.50,'India',NULL,NULL,'9848022338','srujana@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(19,3,3,'tammini','Venkat','5\"7',70.50,'India',NULL,NULL,'9848022338','tammini@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(20,4,4,'Pradeep','Reddy','5\"7',70.50,'India',NULL,NULL,'9848022338','pradeep@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(21,5,5,'Sulu','Velugu','5\"7',70.50,'India',NULL,NULL,'9848022338','sulu@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(22,6,6,'Vijay','Thodupunoori','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(23,7,7,'Dustin','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','dustin@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(24,8,8,'Ryan','Swanson','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','ryan@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(25,9,9,'Jacob','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','jacob@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 09:54:28',NULL),(26,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-04 10:26:12',NULL),(27,2,2,'Srujana','Dakoju','5\"7',80.50,'India',NULL,NULL,'9848022338','srujana@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(28,3,3,'tammini','Venkat','5\"7',70.50,'India',NULL,NULL,'9848022338','tammini@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(29,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-04 11:04:18',NULL),(30,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-12 10:18:58',NULL),(31,1,1,'Vijay','Chirivolu','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay.ch@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(32,2,2,'Srujana','Dakoju','5\"7',80.50,'India',NULL,'index1.jpeg','9848022338','srujana@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 16:40:42',NULL),(33,3,3,'tammini','Venkat','5\"7',70.50,'Sri lanka',NULL,NULL,'9848022338','tammini@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,51,'2015-11-04 15:24:28','2015-11-05 08:21:14',NULL),(34,4,4,'Pradeep','Reddy','5\"7',70.50,'India',NULL,NULL,'9848022338','pradeep@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(35,5,5,'Sulu','Velugu','5\"7',70.50,'India',NULL,NULL,'9848022338','sulu@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(36,6,6,'Vijay','Thodupunoori','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(37,7,7,'Dustin','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','dustin@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(38,8,8,'Ryan','Swanson','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','ryan@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(39,9,9,'Jacob','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','jacob@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-04 11:04:18',NULL),(40,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-12 10:18:58',NULL),(41,1,1,'Vijay','Chirivolu','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay.ch@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(42,2,2,'Srujana','Dakoju','5\"7',80.50,'India',NULL,'index1.jpeg','9848022338','srujana@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(43,3,3,'tammini','Venkat','5\"7',70.50,'Sri lanka',NULL,NULL,'9848022338','tammini@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,51,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(44,4,4,'Pradeep','Reddy','5\"7',70.50,'India',NULL,NULL,'9848022338','pradeep@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(45,5,5,'Sulu','Velugu','5\"7',70.50,'India',NULL,NULL,'9848022338','sulu@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(46,6,6,'Vijay','Thodupunoori','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(47,7,7,'Dustin','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','dustin@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(48,8,8,'Ryan','Swanson','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','ryan@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(49,9,9,'Jacob','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','jacob@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:30',NULL),(50,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-16 05:43:30',NULL),(51,1,1,'Vijay','Chirivolu','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay.ch@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(52,2,2,'Srujana','Dakoju','5\"7',80.50,'India',NULL,'index1.jpeg','9848022338','srujana@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(53,3,3,'tammini','Venkat','5\"7',70.50,'Sri lanka',NULL,NULL,'9848022338','tammini@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,51,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(54,4,4,'Pradeep','Reddy','5\"7',70.50,'India',NULL,NULL,'9848022338','pradeep@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(55,5,5,'Sulu','Velugu','5\"7',70.50,'India',NULL,NULL,'9848022338','sulu@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(56,6,6,'Vijay','Thodupunoori','5\"7',70.50,'India',NULL,NULL,'9848022338','vijay@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(57,7,7,'Dustin','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','dustin@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(58,8,8,'Ryan','Swanson','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','ryan@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(59,9,9,'Jacob','Yoder','5\"7',70.50,'San Jose',NULL,NULL,'9848022338','jacob@vendus.com',NULL,1,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:43:33',NULL),(60,10,10,'Lalitha','Gurajada','5\"7',70.50,'India',NULL,NULL,'9848022338','lalitha@vendus.com',NULL,2,NULL,NULL,NULL,NULL,1,0,'2015-11-04 15:56:12','2015-11-16 05:43:33',NULL),(61,11,11,'New York Life','Insurance','5\"7',70.50,'New York',NULL,NULL,'9848022338','newyorklife@gmail.com',NULL,1,NULL,NULL,NULL,NULL,1,2,'2015-11-04 15:24:28','2015-11-04 04:24:28',NULL);
/*!40000 ALTER TABLE `history_user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_sessions`
--

DROP TABLE IF EXISTS `history_user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_sessions table',
  `user_sessions_id` int(11) NOT NULL COMMENT 'Primary key parent user_sessions table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `login_time` datetime DEFAULT NULL COMMENT 'Users login time',
  `logout_time` datetime DEFAULT NULL COMMENT 'Users logout time',
  `login_ip` varchar(255) DEFAULT NULL COMMENT 'Loggedin user ip address',
  `browser` varchar(255) DEFAULT NULL COMMENT 'Loggedin user browser or device id info',
  `OS` varchar(255) DEFAULT NULL COMMENT 'Loggedin user operating system',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `access_token` varchar(255) NOT NULL COMMENT 'access token of the user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_sessions`
--

LOCK TABLES `history_user_sessions` WRITE;
/*!40000 ALTER TABLE `history_user_sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_steps`
--

DROP TABLE IF EXISTS `history_user_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_steps` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key steps table',
  `user_steps_id` int(11) NOT NULL COMMENT 'Primary key parent user_steps table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `steps` int(11) DEFAULT NULL COMMENT 'Steps of the user on aparticular date',
  `steps_date` datetime DEFAULT NULL COMMENT 'date of the steps recorded',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_steps`
--

LOCK TABLES `history_user_steps` WRITE;
/*!40000 ALTER TABLE `history_user_steps` DISABLE KEYS */;
INSERT INTO `history_user_steps` VALUES (1,12,2,0,'2015-10-25 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(2,13,2,1526,'2015-10-26 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(3,14,2,7699,'2015-10-27 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(4,15,2,4387,'2015-10-28 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(5,16,2,4038,'2015-10-29 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(6,17,2,2693,'2015-10-30 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(7,18,2,0,'2015-10-31 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(8,19,2,0,'2015-11-01 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(9,20,2,2554,'2015-11-02 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(10,21,2,3647,'2015-11-03 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(11,22,2,3748,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(12,22,2,3748,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(13,23,2,3748,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(14,22,2,3748,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(15,23,2,3748,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(16,24,2,3748,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(17,22,2,3748,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(18,23,2,3748,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(19,24,2,3748,'2015-11-04 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(20,25,2,3748,'2015-11-04 00:00:00',1,50,'2015-11-04 23:48:05','2015-11-05 07:48:08'),(21,26,3,1628,'2015-11-02 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22'),(22,27,3,0,'2015-11-03 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22'),(23,28,3,0,'2015-11-04 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22'),(24,29,3,0,'2015-11-05 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22');
/*!40000 ALTER TABLE `history_user_steps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_user_weights`
--

DROP TABLE IF EXISTS `history_user_weights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_user_weights` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key weights table',
  `user_weights_id` int(11) NOT NULL COMMENT 'Primary key parent user_weights table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `weight` int(11) DEFAULT NULL COMMENT 'weight of the user on aparticular date',
  `weight_date` datetime DEFAULT NULL COMMENT 'date of the weight recorded',
  `bmi` varchar(255) DEFAULT NULL COMMENT 'Bmi of the user',
  `weight_time` time DEFAULT NULL COMMENT 'Time of the weight recorded',
  `log_id` varchar(255) DEFAULT NULL COMMENT 'Log id',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_user_weights`
--

LOCK TABLES `history_user_weights` WRITE;
/*!40000 ALTER TABLE `history_user_weights` DISABLE KEYS */;
/*!40000 ALTER TABLE `history_user_weights` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `history_users`
--

DROP TABLE IF EXISTS `history_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `history_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key users table',
  `users_id` int(11) NOT NULL COMMENT 'Primary key parent users table',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of user',
  `password` varchar(255) DEFAULT NULL COMMENT 'Password of user',
  `agent_id` int(11) DEFAULT NULL COMMENT 'Primary key of agents table',
  `user_type` int(11) DEFAULT NULL COMMENT 'User type - Group values-',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Mobile number of user',
  `status` int(11) DEFAULT NULL COMMENT 'User status - Group values-',
  `login_attempts` int(11) DEFAULT NULL COMMENT 'Number of failed login attempts',
  `last_login` datetime DEFAULT NULL COMMENT 'User last login time',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `fitbit_access_token` text COMMENT 'Fitbit_access_token of an user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=69 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `history_users`
--

LOCK TABLES `history_users` WRITE;
/*!40000 ALTER TABLE `history_users` DISABLE KEYS */;
INSERT INTO `history_users` VALUES (1,2,'srujana@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 03:49:00',NULL),(2,2,'srujana@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 03:49:00',NULL),(3,2,'srujana@vendus.com','b2b7f21cfb999af44b3f10c905c3ad9c',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 12:04:07',NULL),(4,2,'srujana@vendus.com','8c1d4ded88676c1276736be126037b27',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 12:07:17',NULL),(5,2,'srujana@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 12:32:23',NULL),(6,2,'srujana@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 12:33:14',NULL),(7,2,'srujana@vendus.com','1ee9cb572c30a8f27ebec15c193d4617',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-02 23:12:20',NULL),(9,2,'srujana@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 12:50:57',NULL),(10,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'8008374974',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-02 23:22:27',NULL),(11,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,NULL,1,1,'2015-11-03 14:49:00','2015-11-03 13:29:18',NULL),(12,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 21:55:03',1,1,'2015-11-03 14:49:00','2015-11-04 05:55:03',NULL),(13,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:00:51',1,1,'2015-11-03 14:49:00','2015-11-04 06:00:51',NULL),(14,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:03:08',1,1,'2015-11-03 14:49:00','2015-11-04 06:03:08',NULL),(15,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:15:50',1,1,'2015-11-03 14:49:00','2015-11-04 06:15:50',NULL),(16,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:21:12',1,1,'2015-11-03 14:49:00','2015-11-04 06:21:12',NULL),(17,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:22:55',1,1,'2015-11-03 14:49:00','2015-11-04 06:22:55',NULL),(18,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:37:15',1,1,'2015-11-03 14:49:00','2015-11-04 06:37:15',NULL),(19,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:41:02',1,1,'2015-11-03 14:49:00','2015-11-04 06:41:02',NULL),(20,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:41:54',1,1,'2015-11-03 14:49:00','2015-11-04 06:41:54',NULL),(21,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:52:05',1,1,'2015-11-03 14:49:00','2015-11-04 06:52:05',NULL),(22,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 22:57:06',1,1,'2015-11-03 14:49:00','2015-11-04 06:57:06',NULL),(23,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 23:03:01',1,1,'2015-11-03 14:49:00','2015-11-04 07:03:01',NULL),(24,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2001,'(850) 025-7089',1001,0,'2015-11-03 23:46:22',1,1,'2015-11-03 14:49:00','2015-11-04 07:46:22',NULL),(25,2,'srujana@vendus.com','81dc9bdb52d04dc20036dbd8313ed055',0,2004,'(850) 025-7089',1001,0,'2015-11-03 23:46:22',1,1,'2015-11-03 14:49:00','2015-11-04 07:55:48',NULL),(26,3,'tammini@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 14:45:00','2015-11-04 09:15:00',NULL),(27,1,'vijay.ch@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(28,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(29,3,'tammini@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(30,4,'pradeep@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(31,5,'sulu@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(32,6,'vijay@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(33,7,'dustin@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(34,8,'ryan@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(35,9,'jacob@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:03:07','2015-11-04 09:33:07',NULL),(36,1,'vijay.ch@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2004,NULL,1001,0,NULL,1,0,'2015-11-04 15:02:27','2015-11-04 09:32:27',NULL),(37,1,'vijay.ch@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(38,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(39,3,'tammini@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(40,4,'pradeep@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(41,5,'sulu@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(42,6,'vijay@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(43,7,'dustin@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(44,8,'ryan@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(45,9,'jacob@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:08:06','2015-11-04 09:38:06',NULL),(46,10,'lalitha@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:55:06','2015-11-04 10:25:06',NULL),(47,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(48,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 02:56:09',1,0,'2015-11-04 15:07:51','2015-11-04 10:56:09',NULL),(49,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 02:56:09',1,0,'2015-11-04 15:07:51','2015-11-04 10:56:30',NULL),(50,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 04:54:06',1,0,'2015-11-04 15:07:51','2015-11-04 12:54:06',NULL),(51,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 21:15:46',1,0,'2015-11-04 15:07:51','2015-11-05 05:15:46',NULL),(52,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 21:41:52',1,0,'2015-11-04 15:07:51','2015-11-05 05:41:52',NULL),(53,5,'sulu@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(54,5,'sulu@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:27:04',1,0,'2015-11-04 15:07:52','2015-11-05 06:27:04',NULL),(55,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:03:50',1,0,'2015-11-04 15:07:51','2015-11-05 06:03:50',NULL),(56,5,'sulu@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:30:08',1,0,'2015-11-04 15:07:52','2015-11-05 06:30:08',NULL),(57,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:30:54',1,0,'2015-11-04 15:07:51','2015-11-05 06:30:54',NULL),(58,6,'vijay@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(59,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:31:47',1,0,'2015-11-04 15:07:51','2015-11-05 06:31:47',NULL),(60,3,'tammini@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(61,3,'tammini@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-05 00:03:44',1,0,'2015-11-04 15:07:51','2015-11-05 08:03:44',NULL),(62,6,'vijay@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:36:05',1,0,'2015-11-04 15:07:52','2015-11-05 06:36:05',NULL),(63,6,'vijay@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-11 22:20:12',1,0,'2015-11-04 15:07:52','2015-11-12 06:20:12',NULL),(64,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:36:46',1,0,'2015-11-04 15:07:51','2015-11-05 06:36:46',NULL),(65,2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-13 01:55:25',1,0,'2015-11-04 15:07:51','2015-11-13 09:55:25',NULL),(66,11,'af06a1193d5a25b59c5e2f11b05446eb','0',2005,2147483647,'1001',0,NULL,'0000-00-00 00:00:00',0,2015,'2015-11-04 09:37:51','2015-11-16 06:23:57',NULL),(67,11,'af06a1193d5a25b59c5e2f11b05446eb','0',2005,2147483647,'1001',0,NULL,'0000-00-00 00:00:00',0,2015,'2015-11-04 09:37:51','2015-11-16 06:23:57',NULL),(68,11,'newyorklife@gmail.com','af06a1193d5a25b59c5e2f11b05446eb',0,2005,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 04:07:51',NULL);
/*!40000 ALTER TABLE `history_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_info`
--

DROP TABLE IF EXISTS `medical_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medical_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key medical_info table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `disease_id` int(11) DEFAULT NULL COMMENT 'Primary key of diseases master',
  `status` int(4) DEFAULT NULL COMMENT 'Medical status value links to group values',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `medical_session_fk` (`user_session_id`),
  KEY `medical_fk` (`user_id`),
  KEY `medical_info_disease_master_fk` (`disease_id`),
  CONSTRAINT `medical_info_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `medical_info_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `medical_info_ibfk_3` FOREIGN KEY (`disease_id`) REFERENCES `disease_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_info`
--

LOCK TABLES `medical_info` WRITE;
/*!40000 ALTER TABLE `medical_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_medical_info_after_insert
    AFTER INSERT ON medical_info
    FOR EACH ROW BEGIN
 
    INSERT INTO history_medical_info
    SET medical_info_id = new.id,
	user_id = new.user_id,
	disease_id = new.disease_id,
	status = new.status,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_medical_info_before_update
    BEFORE UPDATE ON medical_info
    FOR EACH ROW BEGIN
 
    INSERT INTO history_medical_info
    SET medical_info_id = old.id,
	user_id = old.user_id,
	disease_id = old.disease_id,
	status = old.status,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_medical_info_before_delete
    BEFORE Delete ON medical_info
    FOR EACH ROW BEGIN
 
    INSERT INTO history_medical_info
    SET medical_info_id = old.id,
	user_id = old.user_id,
	disease_id = old.disease_id,
	status = old.status,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key migrations table',
  `migration_name` varchar(255) DEFAULT NULL COMMENT 'Name of the migration with timestamp',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES (1,'201511031720_alter_user_info.sql',1,'2015-11-03 17:22:51','2015-11-03 11:52:51'),(2,'201511041434_create_users_customers.sql',1,'2015-11-04 16:00:15','2015-11-04 10:30:15'),(3,'201511091207_alter_polices.sql',1,'2015-11-09 12:09:34','2015-11-09 06:39:34'),(4,'201511091559_alter_polices.sql',1,'2015-11-09 16:03:52','2015-11-09 10:33:52'),(5,'201511121235_alter_user_sessions.sql',1,'2015-11-16 10:57:12','2015-11-16 05:27:12');
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_migrations_after_insert
    AFTER INSERT ON migrations
    FOR EACH ROW BEGIN
 
    INSERT INTO history_migrations
    SET migrations_id = new.id,
	migration_name = new.migration_name,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_migrations_before_update
    BEFORE UPDATE ON migrations
    FOR EACH ROW BEGIN
 
    INSERT INTO history_migrations
    SET migrations_id = old.id,
	migration_name = old.migration_name,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_migrations_before_delete
    BEFORE Delete ON migrations
    FOR EACH ROW BEGIN
 
    INSERT INTO history_migrations
    SET migrations_id = old.id,
	migration_name = old.migration_name,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plan_age_band_rates`
--

DROP TABLE IF EXISTS `plan_age_band_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_age_band_rates` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plan_age_band_rates table',
  `plan_id` int(11) NOT NULL COMMENT 'Primary key plans table',
  `age_band_start` datetime DEFAULT NULL COMMENT 'Date at which age starts',
  `age_band_end` datetime DEFAULT NULL COMMENT 'Date at which age ends',
  `rate` float(4,2) DEFAULT NULL COMMENT 'Rate at which the premium is charged',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `plans_age_session_fk` (`user_session_id`),
  KEY `plan_age_fk` (`plan_id`),
  CONSTRAINT `plan_age_band_rates_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `plan_age_band_rates_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_age_band_rates`
--

LOCK TABLES `plan_age_band_rates` WRITE;
/*!40000 ALTER TABLE `plan_age_band_rates` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_age_band_rates` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_age_band_rates_after_insert
    AFTER INSERT ON plan_age_band_rates
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_age_band_rates
    SET plan_age_band_rates_id = new.id,
	plan_id = new.plan_id,
	age_band_start = new.age_band_start,
	age_band_end = new.age_band_end,
	rate = new.rate,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_age_band_rates_before_update
    BEFORE UPDATE ON plan_age_band_rates
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_age_band_rates
    SET plan_age_band_rates_id = old.id,
	plan_id = old.plan_id,
	age_band_start = old.age_band_start,
	age_band_end = old.age_band_end,
	rate = old.rate,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_age_band_rates_before_delete
    BEFORE Delete ON plan_age_band_rates
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_age_band_rates
    SET plan_age_band_rates_id = old.id,
	plan_id = old.plan_id,
	age_band_start = old.age_band_start,
	age_band_end = old.age_band_end,
	rate = old.rate,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plan_devices`
--

DROP TABLE IF EXISTS `plan_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plan_devices table',
  `plan_id` int(11) NOT NULL COMMENT 'Primary key of the plans table',
  `device_id` int(11) NOT NULL COMMENT 'Primary key of the devices_master table',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `plans_devices_session_fk` (`user_session_id`),
  KEY `plans_devices_plans_fk` (`plan_id`),
  KEY `plan_devices_devices_master_session_fk` (`device_id`),
  CONSTRAINT `plan_devices_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `plan_devices_ibfk_2` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`),
  CONSTRAINT `plan_devices_ibfk_3` FOREIGN KEY (`device_id`) REFERENCES `devices_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_devices`
--

LOCK TABLES `plan_devices` WRITE;
/*!40000 ALTER TABLE `plan_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_devices` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_devices_after_insert
    AFTER INSERT ON plan_devices
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_devices
    SET plan_devices_id = new.id,
	plan_id = new.plan_id,
	device_id = new.device_id,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_devices_before_update
    BEFORE UPDATE ON plan_devices
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_devices
    SET plan_devices_id = old.id,
	plan_id = old.plan_id,
	device_id = old.device_id,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_devices_before_delete
    BEFORE Delete ON plan_devices
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_devices
    SET plan_devices_id = old.id,
	plan_id = old.plan_id,
	device_id = old.device_id,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plan_health_rate`
--

DROP TABLE IF EXISTS `plan_health_rate`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plan_health_rate` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plan_health_rate table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `disease_id` int(11) DEFAULT NULL COMMENT 'Primary key of diseases master',
  `rate` float(4,2) DEFAULT NULL COMMENT 'Rate at which the premium is charged',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `plans_health_session_fk` (`user_session_id`),
  KEY `plan_health_fk` (`user_id`),
  KEY `plan_disease_master_fk` (`disease_id`),
  CONSTRAINT `plan_health_rate_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `plan_health_rate_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `plan_health_rate_ibfk_3` FOREIGN KEY (`disease_id`) REFERENCES `disease_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plan_health_rate`
--

LOCK TABLES `plan_health_rate` WRITE;
/*!40000 ALTER TABLE `plan_health_rate` DISABLE KEYS */;
/*!40000 ALTER TABLE `plan_health_rate` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_health_rate_after_insert
    AFTER INSERT ON plan_health_rate
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_health_rate
    SET plan_health_rate_id = new.id,
	user_id = new.user_id,
	disease_id = new.disease_id,
	rate = new.rate,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_health_rate_before_update
    BEFORE UPDATE ON plan_health_rate
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_health_rate
    SET plan_health_rate_id = old.id,
	user_id = old.user_id,
	disease_id = old.disease_id,
	rate = old.rate,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plan_health_rate_before_delete
    BEFORE Delete ON plan_health_rate
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plan_health_rate
    SET plan_health_rate_id = old.id,
	user_id = old.user_id,
	disease_id = old.disease_id,
	rate = old.rate,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `plans`
--

DROP TABLE IF EXISTS `plans`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `plans` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key plans table',
  `plan_name` varchar(255) DEFAULT NULL COMMENT 'Plan name',
  `plan_start_date` datetime DEFAULT NULL COMMENT 'Plan start date',
  `plan_end_date` datetime DEFAULT NULL COMMENT 'Plan end date',
  `base_premium` float(6,2) DEFAULT NULL COMMENT 'Base premium value of the plan',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `plans_session_fk` (`user_session_id`),
  CONSTRAINT `plans_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plans`
--

LOCK TABLES `plans` WRITE;
/*!40000 ALTER TABLE `plans` DISABLE KEYS */;
INSERT INTO `plans` VALUES (1,'Me Seva','2015-11-11 00:00:00','2015-11-26 00:00:00',500.00,0,53,'2015-11-05 01:18:59','2015-11-05 09:22:43'),(2,'Me Seva','2015-11-14 00:00:00','2015-11-14 00:00:00',150.00,1,57,'2015-11-09 04:41:40','2015-11-09 12:41:40');
/*!40000 ALTER TABLE `plans` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plans_after_insert
    AFTER INSERT ON plans
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plans
    SET plans_id = new.id,
		plan_name = new.plan_name,
	plan_start_date = new.plan_start_date,
	plan_end_date = new.plan_end_date,
	base_premium = new.base_premium,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plans_before_update
    BEFORE UPDATE ON plans
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plans
    SET plans_id = old.id,
	plan_name = old.plan_name,
	plan_start_date = old.plan_start_date,
	plan_end_date = old.plan_end_date,
	base_premium = old.base_premium,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_plans_before_delete
    BEFORE Delete ON plans
    FOR EACH ROW BEGIN
 
    INSERT INTO history_plans
    SET plans_id = old.id,
		plan_name = old.plan_name,
	plan_start_date = old.plan_start_date,
	plan_end_date = old.plan_end_date,
	base_premium = old.base_premium,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `policies`
--

DROP TABLE IF EXISTS `policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policies` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key policies table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `plan_id` int(11) DEFAULT NULL COMMENT 'Primary key of the plans table',
  `policy_number` varchar(255) DEFAULT NULL COMMENT 'Policy number',
  `term` int(3) DEFAULT NULL COMMENT 'Policy term',
  `issue_date` datetime DEFAULT NULL COMMENT 'Policy issued date',
  `initial_premium` float(10,2) DEFAULT NULL COMMENT 'Initial premium of the policy',
  `policies_health` int(11) DEFAULT NULL COMMENT 'Linked to groups table',
  `policy_status` int(4) DEFAULT NULL COMMENT 'Policy status - Group values-',
  `under_writer` int(11) DEFAULT NULL COMMENT 'Under writer user id references to users table',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `policies_fk` (`user_id`),
  KEY `policies_session_fk` (`user_session_id`),
  CONSTRAINT `policies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `policies_ibfk_2` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policies`
--

LOCK TABLES `policies` WRITE;
/*!40000 ALTER TABLE `policies` DISABLE KEYS */;
INSERT INTO `policies` VALUES (1,7,1,'90522-0856-123',3,'2015-08-08 00:00:00',170.00,NULL,NULL,11,1,2,'2015-11-16 12:48:46','2015-11-16 07:18:46');
/*!40000 ALTER TABLE `policies` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_policies_after_insert
    AFTER INSERT ON policies
    FOR EACH ROW BEGIN
 
    INSERT INTO history_policies
    SET policies_id = new.id,
	user_id = new.user_id,
	policy_number = new.policy_number,
	term = new.term,
	issue_date = new.issue_date,
	initial_premium = new.initial_premium,
	policy_status = new.policy_status,
	under_writer = new.under_writer,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_policies_before_update
    BEFORE UPDATE ON policies
    FOR EACH ROW BEGIN
 
    INSERT INTO history_policies
    SET policies_id = old.id,
	user_id = old.user_id,
	policy_number = old.policy_number,
	term = old.term,
	issue_date = old.issue_date,
	initial_premium = old.initial_premium,
	policy_status = old.policy_status,
	under_writer = old.under_writer,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_policies_before_delete
    BEFORE Delete ON policies
    FOR EACH ROW BEGIN
 
    INSERT INTO history_policies
    SET policies_id = old.id,
	user_id = old.user_id,
	policy_number = old.policy_number,
	term = old.term,
	issue_date = old.issue_date,
	initial_premium = old.initial_premium,
	policy_status = old.policy_status,
	under_writer = old.under_writer,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `policy_benificiaries`
--

DROP TABLE IF EXISTS `policy_benificiaries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `policy_benificiaries` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key policy_benificiaries table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key policies table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `type` int(11) DEFAULT NULL COMMENT 'Type of benificiary - Group values',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'Benificiary first name',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Benificiary last name',
  `age` int(3) DEFAULT NULL COMMENT 'Benificiary age',
  `gender` int(4) DEFAULT NULL COMMENT 'Gender-Group values-',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `policy_benificiaries_fk` (`user_id`),
  KEY `policy_benificiaries_policy_fk` (`policy_id`),
  KEY `policy_benificiaries_session_fk` (`user_session_id`),
  CONSTRAINT `policy_benificiaries_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `policy_benificiaries_ibfk_2` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`id`),
  CONSTRAINT `policy_benificiaries_ibfk_3` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `policy_benificiaries`
--

LOCK TABLES `policy_benificiaries` WRITE;
/*!40000 ALTER TABLE `policy_benificiaries` DISABLE KEYS */;
INSERT INTO `policy_benificiaries` VALUES (3,1,7,NULL,'Kendall','Yoder',25,2,1,2,'2015-11-16 12:49:09','2015-11-16 07:19:09');
/*!40000 ALTER TABLE `policy_benificiaries` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_policy_benificiaries_after_insert
    AFTER INSERT ON policy_benificiaries
    FOR EACH ROW BEGIN
 
    INSERT INTO history_policy_benificiaries
    SET policy_benificiaries_id = new.id,
	policy_id = new.policy_id,
	user_id = new.user_id,
	type = new.type,
	first_name = new.first_name,
	last_name = new.last_name,
	age = new.age,
	gender = new.gender,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_policy_benificiaries_before_update
    BEFORE UPDATE ON policy_benificiaries
    FOR EACH ROW BEGIN
 
    INSERT INTO history_policy_benificiaries
    SET policy_benificiaries_id = old.id,
	policy_id = old.policy_id,
	user_id = old.user_id,
	type = old.type,
	first_name = old.first_name,
	last_name = old.last_name,
	age = old.age,
	gender = old.gender,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_policy_benificiaries_before_delete
    BEFORE Delete ON policy_benificiaries
    FOR EACH ROW BEGIN
 
    INSERT INTO history_policy_benificiaries
    SET policy_benificiaries_id = old.id,
	policy_id = old.policy_id,
	user_id = old.user_id,
	type = old.type,
	first_name = old.first_name,
	last_name = old.last_name,
	age = old.age,
	gender = old.gender,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `premium_discounts`
--

DROP TABLE IF EXISTS `premium_discounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premium_discounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key premium_discounts table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key policies table',
  `discount_id` int(11) DEFAULT NULL COMMENT 'Primary key discounts_master table',
  `discount_type` varchar(255) DEFAULT NULL COMMENT 'Discount type available in discounts_master table',
  `discount_percentage` float(3,2) DEFAULT NULL COMMENT 'Discount percentage value',
  `month` int(2) NOT NULL COMMENT 'Month number',
  `year` int(4) NOT NULL COMMENT 'Year number',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `premium_discounts_fk` (`user_id`),
  KEY `premium_discounts_policy_fk` (`policy_id`),
  KEY `premium_discounts_session_fk` (`user_session_id`),
  KEY `premium_discounts_discount_master_fk` (`discount_id`),
  CONSTRAINT `premium_discounts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `premium_discounts_ibfk_2` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`id`),
  CONSTRAINT `premium_discounts_ibfk_3` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `premium_discounts_ibfk_4` FOREIGN KEY (`discount_id`) REFERENCES `discounts_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premium_discounts`
--

LOCK TABLES `premium_discounts` WRITE;
/*!40000 ALTER TABLE `premium_discounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `premium_discounts` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_premium_discounts_after_insert
    AFTER INSERT ON premium_discounts
    FOR EACH ROW BEGIN
 
    INSERT INTO history_premium_discounts
    SET premium_discounts_id = new.id,
	user_id = new.user_id,
	policy_id = new.policy_id,
	discount_id = new.discount_id,
	discount_type = new.discount_type,
	discount_percentage = new.discount_percentage,
	month = new.month,
	year =new.year,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_premium_discounts_before_update
    BEFORE UPDATE ON premium_discounts
    FOR EACH ROW BEGIN
 
    INSERT INTO history_premium_discounts
    SET premium_discounts_id = old.id,
	user_id = old.user_id,
	policy_id = old.policy_id,
	discount_id = old.discount_id,
	discount_type = old.discount_type,
	discount_percentage = old.discount_percentage,
	month = old.month,
	year =old.year,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_premium_discounts_before_delete
    BEFORE Delete ON premium_discounts
    FOR EACH ROW BEGIN
 
    INSERT INTO history_premium_discounts
    SET premium_discounts_id = old.id,
	user_id = old.user_id,
	policy_id = old.policy_id,
	discount_id = old.discount_id,
	discount_type = old.discount_type,
	discount_percentage = old.discount_percentage,
	month = old.month,
	year =old.year,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `premiums`
--

DROP TABLE IF EXISTS `premiums`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `premiums` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key premiums table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `policy_id` int(11) NOT NULL COMMENT 'Primary key policies table',
  `month` int(2) NOT NULL COMMENT 'Specifies month',
  `year` int(4) NOT NULL COMMENT 'Specifies year',
  `premium` float(6,2) DEFAULT NULL COMMENT 'Policy premium value',
  `lifetime_savings` float(10,2) DEFAULT NULL COMMENT 'Policy life time value',
  `status` int(11) DEFAULT NULL COMMENT 'Premium Payment status - Linked to Group values',
  `transaction_id` varchar(255) DEFAULT NULL COMMENT 'Transaction id which comes from stripe',
  `under_writer_premium` float(10,2) DEFAULT NULL COMMENT 'Premium collected by the Under writer',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `premiums_fk` (`user_id`),
  KEY `premiums_policy_fk` (`policy_id`),
  KEY `premiums_session_fk` (`user_session_id`),
  CONSTRAINT `premiums_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `premiums_ibfk_2` FOREIGN KEY (`policy_id`) REFERENCES `policies` (`id`),
  CONSTRAINT `premiums_ibfk_3` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `premiums`
--

LOCK TABLES `premiums` WRITE;
/*!40000 ALTER TABLE `premiums` DISABLE KEYS */;
/*!40000 ALTER TABLE `premiums` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_premiums_after_insert
    AFTER INSERT ON premiums
    FOR EACH ROW BEGIN
 
    INSERT INTO history_premiums
    SET premiums_id = new.id,
	user_id = new.user_id,
	policy_id = new.policy_id,
	month = new.month,
	year = new.year,
	premium = new.premium,
	lifetime_savings = new.lifetime_savings,
	transaction_id = new.transaction_id,
	status = new.status,
	under_writer_premium = new.under_writer_premium,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_premiums_before_update
    BEFORE UPDATE ON premiums
    FOR EACH ROW BEGIN
 
    INSERT INTO history_premiums
    SET premiums_id = old.id,
	user_id = old.user_id,
	policy_id = old.policy_id,
	month = old.month,
	year = old.year,
	premium = old.premium,
	lifetime_savings = old.lifetime_savings,
	transaction_id = old.transaction_id,
	status = old.status,
	under_writer_premium = old.under_writer_premium,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_premiums_before_delete
    BEFORE Delete ON premiums
    FOR EACH ROW BEGIN
 
    INSERT INTO history_premiums
    SET premiums_id = old.id,
	user_id = old.user_id,
	policy_id = old.policy_id,
	month = old.month,
	year = old.year,
	premium = old.premium,
	lifetime_savings = old.lifetime_savings,
	transaction_id = old.transaction_id,
	status = old.status,
	under_writer_premium = old.under_writer_premium,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `quote_users`
--

DROP TABLE IF EXISTS `quote_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quote_users` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'user ID',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT '0' COMMENT '0 - not mentioned, 1 - male, 2- female',
  `area_code` int(11) NOT NULL DEFAULT '0',
  `smoker` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0 - non smoker, 1 - smoker',
  `health` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 - excellent, 2 - good, 3 - average, 4 - poor',
  `protection` varchar(30) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `duration` int(11) NOT NULL DEFAULT '0' COMMENT 'years of protection',
  `origin` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=567 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quote_users`
--

LOCK TABLES `quote_users` WRITE;
/*!40000 ALTER TABLE `quote_users` DISABLE KEYS */;
INSERT INTO `quote_users` VALUES (16,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:45:52','2015-11-03 09:04:35'),(17,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:45:57','2015-11-03 09:04:35'),(18,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:46:04','2015-11-03 09:04:35'),(19,'Eshwar','eshwarcc@gmail.com',NULL,0,0,0,0,NULL,0,'v1-get-estimate',1,'2015-06-30 21:46:13','2015-11-03 09:04:35'),(20,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:46:47','2015-11-03 09:04:35'),(21,'eshwar','eshwarcc@gmail.com',30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:48:01','2015-11-03 09:04:35'),(22,NULL,NULL,23,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-06-30 21:48:33','2015-11-03 09:04:35'),(23,NULL,NULL,23,2,94301,0,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:49:09','2015-11-03 09:04:35'),(24,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-06-30 21:50:16','2015-11-03 09:04:35'),(25,NULL,NULL,27,1,95125,0,2,'$500,000',20,'v1-get-estimate',1,'2015-07-01 06:50:53','2015-11-03 09:04:35'),(26,'jacob','jacob@vendus.com',18,1,95125,1,1,'$500,000',7,'v1-get-estimate',1,'2015-07-01 17:28:43','2015-11-03 09:04:35'),(27,'asdfasdf','sdfds@sdfd.com',30,1,12345,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-01 17:21:54','2015-11-03 09:04:35'),(28,'jacob','jacob@sureify.com',30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-01 17:38:20','2015-11-03 09:04:35'),(29,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-01 17:41:24','2015-11-03 09:04:35'),(30,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-01 17:46:44','2015-11-03 09:04:35'),(31,NULL,NULL,55,1,28075,0,2,'$250,000',10,'v1-get-estimate',1,'2015-07-01 18:14:59','2015-11-03 09:04:35'),(32,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-01 18:23:48','2015-11-03 09:04:35'),(33,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-01 21:56:38','2015-11-03 09:04:35'),(34,NULL,NULL,30,1,95125,0,1,'$250,000',25,'v1-get-estimate',1,'2015-07-02 07:54:46','2015-11-03 09:04:35'),(35,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-02 08:36:43','2015-11-03 09:04:35'),(36,NULL,NULL,30,2,95125,0,3,'$500,000',30,'v1-get-estimate',1,'2015-07-02 21:27:28','2015-11-03 09:04:35'),(37,NULL,NULL,30,2,95125,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-02 21:37:51','2015-11-03 09:04:35'),(38,NULL,NULL,30,2,95125,0,1,'$500,000',10,'v1-get-estimate',1,'2015-07-03 01:29:01','2015-11-03 09:04:35'),(39,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 06:13:49','2015-11-03 09:04:35'),(40,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 06:23:11','2015-11-03 09:04:35'),(41,NULL,NULL,36,1,95125,0,3,'$250,000',30,'v1-get-estimate',1,'2015-07-03 11:45:43','2015-11-03 09:04:35'),(42,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 13:33:08','2015-11-03 09:04:35'),(43,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-03 17:17:50','2015-11-03 09:04:35'),(44,NULL,NULL,27,1,20176,0,1,'$500,000',10,'v1-get-estimate',1,'2015-07-04 05:23:55','2015-11-03 09:04:35'),(45,NULL,NULL,22,1,60622,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-04 16:46:55','2015-11-03 09:04:35'),(46,NULL,NULL,30,1,95125,0,3,'$250,000',30,'v1-get-estimate',1,'2015-07-04 17:19:00','2015-11-03 09:04:35'),(47,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-05 19:45:52','2015-11-03 09:04:35'),(48,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-06 02:15:20','2015-11-03 09:04:35'),(49,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v1-get-estimate',1,'2015-07-06 19:34:38','2015-11-03 09:04:35'),(50,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-06 21:58:17','2015-11-03 09:04:35'),(51,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v1-get-estimate',1,'2015-07-07 02:11:42','2015-11-03 09:04:35'),(52,NULL,NULL,35,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-07 14:19:09','2015-11-03 09:04:35'),(53,NULL,NULL,38,2,94103,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-07 14:02:26','2015-11-03 09:04:35'),(54,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 15:56:04','2015-11-03 09:04:35'),(55,NULL,NULL,25,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 15:56:30','2015-11-03 09:04:35'),(56,NULL,NULL,30,1,95125,0,1,'$500,000',15,'v1-get-estimate',1,'2015-07-07 16:50:27','2015-11-03 09:04:35'),(57,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 17:14:46','2015-11-03 09:04:35'),(58,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-07 23:04:15','2015-11-03 09:04:35'),(59,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-08 00:28:44','2015-11-03 09:04:35'),(60,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 10:39:44','2015-11-03 09:04:35'),(61,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 11:22:17','2015-11-03 09:04:35'),(62,NULL,NULL,48,1,22603,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 15:42:59','2015-11-03 09:04:35'),(63,NULL,NULL,30,2,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-08 17:48:38','2015-11-03 09:04:35'),(64,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 17:48:42','2015-11-03 09:04:35'),(65,NULL,NULL,30,2,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-08 21:54:06','2015-11-03 09:04:35'),(66,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-08 22:26:49','2015-11-03 09:04:35'),(67,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-09 05:23:50','2015-11-03 09:04:35'),(68,NULL,NULL,65,1,95125,1,4,'$500,000',30,'v1-get-estimate',1,'2015-07-09 17:04:00','2015-11-03 09:04:35'),(69,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-09 19:22:26','2015-11-03 09:04:35'),(70,NULL,NULL,24,1,95125,0,2,'$500,000',30,'v2-get-estimate',1,'2015-07-09 20:54:55','2015-11-03 09:04:35'),(71,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-09 21:04:51','2015-11-03 09:04:35'),(72,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-10 01:26:21','2015-11-03 09:04:35'),(73,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-10 13:47:29','2015-11-03 09:04:35'),(74,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-10 22:27:14','2015-11-03 09:04:35'),(75,NULL,NULL,30,2,39047,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-11 18:37:34','2015-11-03 09:04:35'),(76,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-12 17:44:59','2015-11-03 09:04:35'),(77,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-12 19:06:15','2015-11-03 09:04:35'),(78,NULL,NULL,30,2,95125,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-13 05:56:38','2015-11-03 09:04:35'),(79,NULL,NULL,40,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-13 10:58:23','2015-11-03 09:04:35'),(80,NULL,NULL,39,1,95125,1,1,'$500,000',30,'v1-get-estimate',1,'2015-07-13 13:52:37','2015-11-03 09:04:35'),(81,NULL,NULL,30,2,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-13 18:03:28','2015-11-03 09:04:35'),(82,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-13 18:13:49','2015-11-03 09:04:35'),(83,NULL,NULL,44,1,90210,0,1,'$500,000',25,'v1-get-estimate',1,'2015-07-14 15:07:51','2015-11-03 09:04:35'),(84,'jacob','jacobspencerruiz@gmail.com',30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-14 21:25:33','2015-11-03 09:04:35'),(85,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-14 20:58:24','2015-11-03 09:04:35'),(86,'Jacob Ruiz','jacobspencerruiz@gmail.com',30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-14 21:31:50','2015-11-03 09:04:35'),(87,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-14 23:19:33','2015-11-03 09:04:35'),(88,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-15 09:08:05','2015-11-03 09:04:35'),(89,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-15 09:27:29','2015-11-03 09:04:35'),(90,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-15 14:18:38','2015-11-03 09:04:35'),(91,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-15 14:18:55','2015-11-03 09:04:35'),(92,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-15 17:25:30','2015-11-03 09:04:35'),(93,NULL,NULL,30,1,95125,0,2,'$500,000',30,'v1-get-estimate',1,'2015-07-15 21:48:50','2015-11-03 09:04:35'),(94,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-16 00:25:42','2015-11-03 09:04:35'),(95,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-16 11:39:18','2015-11-03 09:04:35'),(96,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-16 17:41:27','2015-11-03 09:04:35'),(97,'Dustin Yoder','Dustin@Sureifylabs.com ',30,1,95125,0,2,'$250,000',30,'v2-get-estimate',1,'2015-07-16 19:29:43','2015-11-03 09:04:35'),(98,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-16 19:30:25','2015-11-03 09:04:35'),(99,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v1-get-estimate',1,'2015-07-16 20:00:02','2015-11-03 09:04:35'),(100,NULL,NULL,45,2,94568,0,3,'$500,000',30,'v1-get-estimate',1,'2015-07-17 16:40:06','2015-11-03 09:04:35'),(101,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-17 21:09:54','2015-11-03 09:04:35'),(102,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-17 21:10:50','2015-11-03 09:04:35'),(103,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-18 01:42:12','2015-11-03 09:04:35'),(104,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-19 20:46:04','2015-11-03 09:04:35'),(105,'hooker','hooker@bitch.com',30,1,95125,1,1,'$500,000',30,'v2-get-estimate',1,'2015-07-20 05:02:01','2015-11-03 09:04:35'),(106,'swathi','swathi@vendus.com',NULL,0,0,0,0,NULL,0,'v1-get-in-touch',1,'2015-07-20 06:03:18','2015-11-03 09:04:35'),(107,NULL,NULL,25,2,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-20 17:00:06','2015-11-03 09:04:35'),(108,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-20 22:01:02','2015-11-03 09:04:35'),(109,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-20 22:11:16','2015-11-03 09:04:35'),(110,'Eshwar','contact@eshwar.me',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-21 17:21:23','2015-11-03 09:04:35'),(111,'Eshwar','mail@eshwar.me',30,1,95125,0,3,'$500,000',30,'v2a-get-estimate',1,'2015-07-21 17:40:34','2015-11-03 09:04:35'),(112,NULL,NULL,30,1,95125,1,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-21 17:48:01','2015-11-03 09:04:35'),(113,NULL,NULL,30,1,45245,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-21 20:50:47','2015-11-03 09:04:35'),(114,NULL,NULL,44,1,208,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-21 20:53:14','2015-11-03 09:04:35'),(115,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-21 22:37:36','2015-11-03 09:04:35'),(116,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-22 15:11:27','2015-11-03 09:04:35'),(117,NULL,NULL,30,1,95125,0,2,'$500,000',30,'v2a-get-estimate',1,'2015-07-22 17:49:55','2015-11-03 09:04:35'),(118,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-22 17:51:50','2015-11-03 09:04:35'),(119,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-22 19:58:08','2015-11-03 09:04:35'),(120,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2-get-estimate',1,'2015-07-23 18:27:28','2015-11-03 09:04:35'),(121,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-23 18:22:42','2015-11-03 09:04:35'),(122,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2-get-estimate',1,'2015-07-23 20:02:21','2015-11-03 09:04:35'),(123,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-24 18:05:27','2015-11-03 09:04:35'),(124,NULL,NULL,38,2,41042,0,1,'$250,000',15,'v1-get-estimate',1,'2015-07-24 20:44:50','2015-11-03 09:04:35'),(125,'jacob','jacob@vendus.com',30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-25 00:18:05','2015-11-03 09:04:35'),(126,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-25 19:03:19','2015-11-03 09:04:35'),(127,'jacob','jacob@sureify.com',NULL,0,0,0,0,NULL,0,'v2a-get-in-touch',1,'2015-07-25 20:40:27','2015-11-03 09:04:35'),(128,'','jacob@sureify.com',30,1,95125,0,1,'$500,000',16,'v2a-get-estimate',1,'2015-07-25 20:41:45','2015-11-03 09:04:35'),(129,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-25 22:12:59','2015-11-03 09:04:35'),(130,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v1-get-estimate',1,'2015-07-26 04:24:39','2015-11-03 09:04:35'),(131,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-26 17:37:12','2015-11-03 09:04:35'),(132,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-26 17:42:40','2015-11-03 09:04:35'),(133,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:16:36','2015-11-03 09:04:35'),(134,'jacob','jacob@vendus.com',NULL,0,0,0,0,NULL,0,'v2b-get-in-touch',1,'2015-07-26 18:17:00','2015-11-03 09:04:35'),(135,'Jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:26:04','2015-11-03 09:04:35'),(136,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:46:57','2015-11-03 09:04:35'),(137,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 18:48:00','2015-11-03 09:04:35'),(138,'jacob','jacob@sureify.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 19:02:47','2015-11-03 09:04:35'),(139,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 19:03:48','2015-11-03 09:04:35'),(140,'jacob','jacob@vendus.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-26 19:04:07','2015-11-03 09:04:35'),(141,'Jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-26 19:06:53','2015-11-03 09:04:35'),(142,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-26 22:57:28','2015-11-03 09:04:35'),(143,'jacob','dustingyoder@gmail.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-26 22:35:40','2015-11-03 09:04:35'),(144,'Karen','karen@gmail.com',45,2,95125,1,4,'$500,000',30,'v2a-get-estimate',1,'2015-07-26 22:39:22','2015-11-03 09:04:35'),(145,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 02:47:38','2015-11-03 09:04:35'),(146,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v1-get-estimate',1,'2015-07-27 03:30:59','2015-11-03 09:04:35'),(147,'kendall dork face','kendallyoder@gmail.com',28,2,95125,1,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-27 03:32:46','2015-11-03 09:04:35'),(148,NULL,NULL,28,1,91306,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-27 08:22:52','2015-11-03 09:04:35'),(149,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 16:14:31','2015-11-03 09:04:35'),(150,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 16:16:21','2015-11-03 09:04:35'),(151,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 18:03:29','2015-11-03 09:04:35'),(152,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 18:02:15','2015-11-03 09:04:35'),(153,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 19:11:22','2015-11-03 09:04:35'),(154,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-27 18:56:17','2015-11-03 09:04:35'),(155,'eshwar','eshwar@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-in-touch',1,'2015-07-27 19:38:14','2015-11-03 09:04:35'),(156,'Eshwar','eshwar@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-in-touch',1,'2015-07-27 19:41:59','2015-11-03 09:04:35'),(157,NULL,NULL,63,2,27888,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-27 19:45:41','2015-11-03 09:04:35'),(158,'Margaret Bliss','margaretbliss@gmail.com',23,2,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-27 20:00:20','2015-11-03 09:04:35'),(159,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-27 20:29:17','2015-11-03 09:04:35'),(160,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 00:58:46','2015-11-03 09:04:35'),(161,'greg oder','greg@lpib.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-28 03:27:17','2015-11-03 09:04:35'),(162,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 07:05:33','2015-11-03 09:04:35'),(163,NULL,NULL,22,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 11:00:43','2015-11-03 09:04:35'),(164,NULL,NULL,22,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 11:00:43','2015-11-03 09:04:35'),(165,NULL,NULL,50,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-28 14:43:57','2015-11-03 09:04:35'),(166,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 14:55:15','2015-11-03 09:04:35'),(167,'Dustin Yoder','dustin@gmail.com',28,1,95125,0,2,'$500,000',30,'v2a-get-estimate',1,'2015-07-28 17:47:21','2015-11-03 09:04:35'),(168,NULL,NULL,32,1,18015,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 18:18:30','2015-11-03 09:04:35'),(169,'jacob','jacobspencerruiz@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-28 21:06:58','2015-11-03 09:04:35'),(170,NULL,NULL,30,1,94019,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 22:24:58','2015-11-03 09:04:35'),(171,NULL,NULL,30,1,94954,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-28 22:57:52','2015-11-03 09:04:35'),(172,NULL,NULL,29,1,91354,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-07-29 04:14:06','2015-11-03 09:04:35'),(173,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-29 15:29:30','2015-11-03 09:04:35'),(174,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-29 16:52:50','2015-11-03 09:04:35'),(175,NULL,NULL,31,1,95008,1,4,'$500,000',30,'v2b-get-estimate',1,'2015-07-29 17:01:25','2015-11-03 09:04:35'),(176,NULL,NULL,40,1,95630,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-07-29 18:33:08','2015-11-03 09:04:35'),(177,NULL,NULL,23,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-29 21:55:04','2015-11-03 09:04:35'),(178,NULL,NULL,28,1,94043,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-30 01:48:48','2015-11-03 09:04:35'),(179,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:51','2015-11-03 09:04:35'),(180,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:51','2015-11-03 09:04:35'),(181,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:51','2015-11-03 09:04:35'),(182,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:52','2015-11-03 09:04:35'),(183,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 06:36:52','2015-11-03 09:04:35'),(184,NULL,NULL,37,1,15367,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-07-30 08:30:52','2015-11-03 09:04:35'),(185,NULL,NULL,38,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 16:50:32','2015-11-03 09:04:35'),(186,NULL,NULL,30,2,95125,0,3,'$500,000',30,'v2b-get-estimate',1,'2015-07-30 18:10:27','2015-11-03 09:04:35'),(187,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-30 23:40:15','2015-11-03 09:04:35'),(188,'john','john.gough1@yahoo.com',30,1,43154,0,2,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 02:13:32','2015-11-03 09:04:35'),(189,NULL,NULL,55,1,95070,0,1,'$500,000',10,'v2b-get-estimate',1,'2015-07-31 02:31:35','2015-11-03 09:04:35'),(190,NULL,NULL,33,1,98043,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 05:45:15','2015-11-03 09:04:35'),(191,NULL,NULL,66,1,95125,0,1,'$250,000',15,'v2b-get-estimate',1,'2015-07-31 18:07:28','2015-11-03 09:04:35'),(192,'jacob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 18:46:32','2015-11-03 09:04:35'),(193,'eshwar','eshwar@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 18:54:20','2015-11-03 09:04:35'),(194,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 18:58:17','2015-11-03 09:04:35'),(195,'Jacob','jacob@vendus.com',30,1,95125,0,3,'$500,000',20,'v2a-get-estimate',1,'2015-07-31 19:10:45','2015-11-03 09:04:35'),(196,NULL,NULL,28,1,94107,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 19:33:26','2015-11-03 09:04:35'),(197,'Dawkah','dawkah.farnad@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-07-31 20:26:27','2015-11-03 09:04:35'),(198,'Don Quitoe','Dustingyoder@gmail.com',30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-07-31 20:28:35','2015-11-03 09:04:35'),(199,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-07-31 22:36:48','2015-11-03 09:04:35'),(200,NULL,NULL,40,1,27502,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-07-31 23:03:37','2015-11-03 09:04:35'),(201,NULL,NULL,55,1,72104,0,3,'$500,000',30,'v2a-get-estimate',1,'2015-08-01 00:58:11','2015-11-03 09:04:35'),(202,'jay-kob','jacob@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-01 02:12:29','2015-11-03 09:04:35'),(203,NULL,NULL,30,1,95125,1,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-01 03:52:10','2015-11-03 09:04:35'),(204,NULL,NULL,34,1,33444,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-02 00:35:12','2015-11-03 09:04:35'),(205,'Jeremy Cerra','jeremycerra@gmail.com',37,1,66062,0,2,'$250,000',15,'v2a-get-estimate',1,'2015-08-02 04:49:12','2015-11-03 09:04:35'),(206,NULL,NULL,50,1,95125,0,2,'$500,000',30,'v2a-get-estimate',1,'2015-08-02 14:08:18','2015-11-03 09:04:35'),(207,NULL,NULL,30,2,95008,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-08-02 19:06:54','2015-11-03 09:04:35'),(208,NULL,NULL,23,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-02 22:14:14','2015-11-03 09:04:35'),(209,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-02 22:59:58','2015-11-03 09:04:35'),(210,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-02 23:09:25','2015-11-03 09:04:35'),(211,NULL,NULL,28,1,91306,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-03 02:24:08','2015-11-03 09:04:35'),(212,NULL,NULL,24,1,94306,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-03 07:47:42','2015-11-03 09:04:35'),(213,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-03 20:55:40','2015-11-03 09:04:35'),(214,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-04 15:27:01','2015-11-03 09:04:35'),(215,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-04 23:57:10','2015-11-03 09:04:35'),(216,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-05 05:51:06','2015-11-03 09:04:35'),(217,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-05 10:31:12','2015-11-03 09:04:35'),(218,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-05 16:04:39','2015-11-03 09:04:35'),(219,NULL,NULL,30,1,95125,1,3,'$500,000',30,'v2b-get-estimate',1,'2015-08-06 03:35:58','2015-11-03 09:04:35'),(220,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-08-06 03:38:38','2015-11-03 09:04:35'),(221,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-06 06:27:32','2015-11-03 09:04:35'),(222,NULL,NULL,30,1,95125,1,4,'$250,000',30,'v2b-get-estimate',1,'2015-08-06 07:15:52','2015-11-03 09:04:35'),(223,NULL,NULL,30,2,95125,1,1,'$500,000',30,'v2a-get-estimate',1,'2015-08-07 05:27:57','2015-11-03 09:04:35'),(224,NULL,NULL,33,2,27283,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 10:57:30','2015-11-03 09:04:35'),(225,NULL,NULL,26,1,95107,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-07 16:19:27','2015-11-03 09:04:35'),(226,NULL,NULL,26,1,95107,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-07 16:19:29','2015-11-03 09:04:35'),(227,NULL,NULL,52,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 17:09:20','2015-11-03 09:04:35'),(228,NULL,NULL,25,1,95118,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 19:15:49','2015-11-03 09:04:35'),(229,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-07 21:34:04','2015-11-03 09:04:35'),(230,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-08 22:35:22','2015-11-03 09:04:35'),(231,'Ryan','Ryan@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-09 05:18:11','2015-11-03 09:04:35'),(232,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-10 13:01:25','2015-11-03 09:04:35'),(233,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-10 18:19:12','2015-11-03 09:04:35'),(234,'Haley Yoder','haleylyoder@gmail.com',NULL,0,0,0,0,NULL,0,'v2b-get-in-touch',1,'2015-08-10 23:26:24','2015-11-03 09:04:35'),(235,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-10 23:26:45','2015-11-03 09:04:35'),(236,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-11 05:07:56','2015-11-03 09:04:35'),(237,'Matt Londre','mlondre@gmail.com',30,1,95129,0,1,'$500,000',30,'v2a-get-estimate',1,'2015-08-11 21:25:54','2015-11-03 09:04:35'),(238,NULL,NULL,31,1,95050,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-12 21:57:35','2015-11-03 09:04:35'),(239,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-13 16:41:07','2015-11-03 09:04:35'),(240,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-14 07:40:35','2015-11-03 09:04:35'),(241,NULL,NULL,35,1,2127,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-14 17:05:21','2015-11-03 09:04:35'),(242,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-14 19:42:32','2015-11-03 09:04:35'),(243,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-14 20:13:49','2015-11-03 09:04:35'),(244,'Eshwar','eshwar@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-16 12:48:29','2015-11-03 09:04:35'),(245,'dustina joder','dustin@venduslabsinc.com',30,1,95125,0,3,'$250,000',30,'millenial-get-estimate',1,'2015-08-16 17:57:40','2015-11-03 09:04:35'),(246,'test','test@test.com',30,1,95125,0,1,'$750,000',30,'millenial-get-estimate',1,'2015-08-16 21:20:50','2015-11-03 09:04:35'),(247,NULL,NULL,27,1,20000,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-17 00:33:00','2015-11-03 09:04:35'),(248,NULL,NULL,34,1,2062,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-17 12:43:12','2015-11-03 09:04:35'),(249,'ryan swanson','ryan.swanson26@yahoo.com',30,1,95125,0,2,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 16:22:23','2015-11-03 09:04:35'),(250,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-17 16:24:39','2015-11-03 09:04:35'),(251,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 16:25:50','2015-11-03 09:04:35'),(252,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 16:41:37','2015-11-03 09:04:35'),(253,'eshwar','eshwar@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 18:15:11','2015-11-03 09:04:35'),(254,'Ryan','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'millenial-get-estimate',1,'2015-08-17 18:17:55','2015-11-03 09:04:35'),(255,NULL,NULL,42,1,46814,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-17 20:03:05','2015-11-03 09:04:35'),(256,'raluca','raluca.brailescu@yahoo.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-18 16:22:26','2015-11-03 09:04:35'),(257,NULL,NULL,30,2,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-18 16:25:28','2015-11-03 09:04:35'),(258,NULL,NULL,47,1,95125,1,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-19 01:02:04','2015-11-03 09:04:35'),(259,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-19 15:35:44','2015-11-03 09:04:35'),(260,'Caribou Honig','caribou.honig@gmail.com',45,1,23005,0,1,'$500,000',10,'v2a-get-estimate',1,'2015-08-19 20:39:53','2015-11-03 09:04:35'),(261,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-20 00:53:23','2015-11-03 09:04:35'),(262,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-20 01:02:42','2015-11-03 09:04:35'),(263,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-20 02:23:18','2015-11-03 09:04:35'),(264,NULL,NULL,30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-08-21 04:59:56','2015-11-03 09:04:35'),(265,NULL,NULL,31,2,2170,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-23 00:22:56','2015-11-03 09:04:35'),(266,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 06:40:02','2015-11-03 09:04:35'),(267,NULL,NULL,39,1,10012,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 09:05:22','2015-11-03 09:04:35'),(268,NULL,NULL,22,1,60610,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 19:09:06','2015-11-03 09:04:35'),(269,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-24 22:31:36','2015-11-03 09:04:35'),(270,NULL,NULL,22,1,94103,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 00:38:20','2015-11-03 09:04:35'),(271,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 03:09:11','2015-11-03 09:04:35'),(272,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 03:20:00','2015-11-03 09:04:35'),(273,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 19:01:02','2015-11-03 09:04:35'),(274,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-25 22:52:12','2015-11-03 09:04:35'),(275,NULL,NULL,28,1,95134,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-08-26 04:31:53','2015-11-03 09:04:35'),(276,NULL,NULL,32,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 05:26:08','2015-11-03 09:04:35'),(277,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 06:04:57','2015-11-03 09:04:35'),(278,NULL,NULL,24,1,2151,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-08-26 16:49:00','2015-11-03 09:04:35'),(279,NULL,NULL,34,1,78704,0,3,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 20:38:14','2015-11-03 09:04:35'),(280,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 21:24:47','2015-11-03 09:04:35'),(281,NULL,NULL,22,1,94103,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-08-26 22:47:26','2015-11-03 09:04:35'),(282,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-27 00:22:05','2015-11-03 09:04:35'),(283,NULL,NULL,65,2,10456,1,4,'$250,000',10,'v2b-get-estimate',1,'2015-08-27 04:52:41','2015-11-03 09:04:35'),(284,NULL,NULL,30,1,95125,0,2,'$250,000',30,'v1-get-estimate',1,'2015-08-27 17:19:53','2015-11-03 09:04:35'),(285,NULL,NULL,26,1,95125,0,3,'$500,000',20,'v2b-get-estimate',1,'2015-08-27 23:15:48','2015-11-03 09:04:35'),(286,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 04:01:07','2015-11-03 09:04:35'),(287,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 09:06:07','2015-11-03 09:04:35'),(288,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 19:36:36','2015-11-03 09:04:35'),(289,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-28 20:36:23','2015-11-03 09:04:35'),(290,NULL,NULL,90,2,95125,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-08-31 04:15:02','2015-11-03 09:04:35'),(291,NULL,NULL,50,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 04:52:39','2015-11-03 09:04:35'),(292,'vijay','vijay@vendus.com',60,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-31 05:53:09','2015-11-03 09:04:35'),(293,NULL,NULL,76,1,95125,0,3,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 10:12:12','2015-11-03 09:04:35'),(294,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 11:03:29','2015-11-03 09:04:35'),(295,'vijay','vijay@vendus.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-08-31 13:25:15','2015-11-03 09:04:35'),(296,'vijay','vijay@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-estimate',1,'2015-08-31 13:26:04','2015-11-03 09:04:35'),(297,'vijay','vijay@vendus.com',NULL,0,0,0,0,NULL,0,'v2a-get-estimate',1,'2015-08-31 13:32:32','2015-11-03 09:04:35'),(298,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-08-31 23:56:36','2015-11-03 09:04:35'),(299,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-01 17:45:28','2015-11-03 09:04:35'),(300,'Jamie','jamiehale@gmail.com',30,1,94025,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-09-01 18:13:52','2015-11-03 09:04:35'),(301,'Jeff Merkel','jeff.merkel@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-09-01 18:59:50','2015-11-03 09:04:35'),(302,NULL,NULL,30,2,94010,1,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-01 20:55:24','2015-11-03 09:04:35'),(303,NULL,NULL,28,1,58102,0,2,'$500,000',20,'v2b-get-estimate',1,'2015-09-02 14:31:44','2015-11-03 09:04:35'),(304,NULL,NULL,36,1,53562,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-09-02 17:29:26','2015-11-03 09:04:35'),(305,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-02 22:54:39','2015-11-03 09:04:35'),(306,'','mahesh@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 15:08:52','2015-11-03 09:04:35'),(307,'','sivaprasad@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 14:51:07','2015-11-03 09:04:35'),(308,'','sivaprasad@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 14:51:07','2015-11-03 09:04:35'),(309,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-03 14:51:12','2015-11-03 09:04:35'),(310,'Preethi P','sivaprasad@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 14:57:12','2015-11-03 09:04:35'),(311,'jqcob','jiofj0f934r',30,1,95125,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-03 18:10:48','2015-11-03 09:04:35'),(312,'vijay','ivijay@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-03 15:06:00','2015-11-03 09:04:35'),(313,NULL,NULL,28,1,95125,1,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-03 16:43:03','2015-11-03 09:04:35'),(314,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 01:17:33','2015-11-03 09:04:35'),(315,'Shaun','shaun.taylor@suncorp.com.au',32,1,95125,0,1,'$250,000',20,'v2a-get-estimate',1,'2015-09-04 03:26:52','2015-11-03 09:04:35'),(316,'','sivaprasadggggg.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-04 08:30:53','2015-11-03 09:04:35'),(317,'Preethi P','preethirekha6@gmail.com',30,1,95125,0,1,'$250,000',30,'v2a-get-estimate',1,'2015-09-04 11:36:01','2015-11-03 09:04:35'),(318,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 11:38:59','2015-11-03 09:04:35'),(319,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 12:51:45','2015-11-03 09:04:35'),(320,NULL,NULL,45,2,6611,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 12:57:05','2015-11-03 09:04:35'),(321,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 14:02:18','2015-11-03 09:04:35'),(322,NULL,NULL,30,1,95125,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-04 14:02:18','2015-11-03 09:04:35'),(323,'','bbnbn',30,1,95125,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-04 14:43:04','2015-11-03 09:04:35'),(324,'','sivaatchala@gmail.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-04 14:53:46','2015-11-03 09:04:35'),(325,NULL,NULL,30,1,95125,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-09-05 01:18:22','2015-11-03 09:04:35'),(326,'Tiffany Ball','tball448@gmail.com',32,2,95123,0,4,'$500,000',30,'v2b-get-estimate',1,'2015-09-05 08:50:53','2015-11-03 09:04:35'),(327,'Dusts be','dustjn@ail',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-05 17:37:45','2015-11-03 09:04:35'),(328,'Dusts be','dustjn@ail',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-05 17:37:45','2015-11-03 09:04:35'),(329,'','buket.ozatay@gmail.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-07 07:30:06','2015-11-03 09:04:35'),(330,'jose','joseiv@gmail.com',30,1,95125,0,2,'$250,000',10,'v2b-get-estimate',1,'2015-09-07 19:30:57','2015-11-03 09:04:35'),(331,'josh','atxjclark@gmail.com',30,1,11215,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-08 13:44:57','2015-11-03 09:04:35'),(332,'Ryan ','ryan@vendus.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-08 16:43:50','2015-11-03 09:04:35'),(333,'Guillermo Gaviria','ggaviria@sura.com.co',37,1,95125,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-09-08 20:28:48','2015-11-03 09:04:35'),(334,'Jon','Jon@gmail.com',30,1,90210,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-08 23:01:01','2015-11-03 09:04:35'),(335,'dane','dane.ross@cba.com.au',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-09 00:15:56','2015-11-03 09:04:35'),(336,'Esther Dyson','edyson@edventure.com',64,2,10012,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-09 14:30:25','2015-11-03 09:04:35'),(337,'Jeta Beta','beyjesse@gmail.com',35,1,10010,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-09 15:55:49','2015-11-03 09:04:35'),(338,'W S','wayne+sureify@reaction.org',32,1,92130,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-09-09 16:15:46','2015-11-03 09:04:35'),(339,'jacob','jacob@vendus.com',24,1,95125,1,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-09 16:57:15','2015-11-03 09:04:35'),(340,'dawkah farnad','dawkahfarnad@gmail.com',50,1,95125,0,2,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-09 18:52:34','2015-11-03 09:04:35'),(341,'Vero','veritour@gmail.com',31,2,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-09 18:56:50','2015-11-03 09:04:35'),(342,'Tom','tommy9090@gmail.com',33,1,10023,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-10 00:15:22','2015-11-03 09:04:35'),(343,'james Yoder','Jamesyoder@gmai.com',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-10 02:56:52','2015-11-03 09:04:35'),(344,'amukhopa@gmail.com','amukhopa@gmail.com',30,1,60305,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-09-10 04:11:07','2015-11-03 09:04:35'),(345,'Jim','Jim@gmail.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-10 04:30:21','2015-11-03 09:04:35'),(346,'Andy Gordon','Agordo@mindspring.com',42,1,11713,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-10 09:36:15','2015-11-03 09:04:35'),(347,'Mary','mary.helen.watson@gmail.com',30,2,90210,1,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-10 16:46:07','2015-11-03 09:04:35'),(348,'Sam ','sam.wadsworth@suncorp.com.au',32,1,95125,0,2,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-11 08:37:15','2015-11-03 09:04:35'),(349,'scott.ham@transamerica.com','scott.ham@transamerica.com',50,1,54333,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-09-11 15:19:02','2015-11-03 09:04:35'),(350,'','abdul@abdul.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-11 20:21:15','2015-11-03 09:04:35'),(351,'Derek Brigham','derekbrigham@tds.net',50,1,53711,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-11 20:45:55','2015-11-03 09:04:35'),(352,'ed.walker@transamerica.com','ed.walker@transamerica.com',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-11 23:27:31','2015-11-03 09:04:35'),(353,'Robert','Robdanmor@icloud.com',40,1,75013,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-12 18:37:56','2015-11-03 09:04:35'),(354,'mehmet','mcvanli@gmail.com',30,1,95125,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-09-13 18:35:49','2015-11-03 09:04:35'),(355,'scott.ham@transamerica.com','scott.ham@transamerica.com',52,1,52333,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-14 13:47:08','2015-11-03 09:04:35'),(356,'Robert','robdanmor@icloud.com',43,1,75013,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-14 15:19:03','2015-11-03 09:04:35'),(357,'preethi','preethi@vendus.com',56,1,50002,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-16 17:10:20','2015-11-03 09:04:35'),(358,'vijay','vijay@vendus.com',28,1,9999,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-16 17:34:49','2015-11-03 09:04:35'),(359,'31231321312','pradeep@vendus.com',22,1,12345,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-16 17:22:39','2015-11-03 09:04:35'),(360,'prad','p@vendus.com',30,1,12345,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-16 20:59:55','2015-11-03 09:04:35'),(361,'Beth','bethko1234@gmail.com',25,2,21401,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-16 21:09:26','2015-11-03 09:04:35'),(362,'d','yoder@aol.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-17 00:57:43','2015-11-03 09:04:35'),(363,'Alex Volpicello','alexander_volpicello@brown.edu',19,1,2912,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-17 13:12:07','2015-11-03 09:04:35'),(364,'Jay zorn','Joseph.zorn@transamerica.com',40,1,80526,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-18 01:42:49','2015-11-03 09:04:35'),(365,'P','Pgilman@mac.com',42,1,50314,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-18 04:06:28','2015-11-03 09:04:35'),(366,'fjdhj,fd','sdnffjw@aol.com',30,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-18 18:34:55','2015-11-03 09:04:35'),(367,'Rodrigo','g11018883@trbvm.com',24,1,2151,1,2,'$250,000',30,'v2b-get-estimate',1,'2015-09-21 16:04:03','2015-11-03 09:04:35'),(368,'bob','bob@nobody.com',40,1,90210,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-21 19:55:24','2015-11-03 09:04:35'),(369,'Test','Test@test.com',38,1,75248,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-21 21:11:48','2015-11-03 09:04:35'),(370,'Ed','ed.walker@gmail.com',49,1,21136,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-22 12:30:22','2015-11-03 09:04:35'),(371,'Andrew Grinalds','Grinalds@gmail.com',24,1,94114,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-09-23 00:51:02','2015-11-03 09:04:35'),(372,'Camila','camila.carvalho.s@hotmail.com',26,2,10001,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-09-23 14:49:30','2015-11-03 09:04:35'),(373,'John','johnsmith__2015@hotmail.com',25,1,2151,0,2,'$500,000',30,'v2b-get-estimate',1,'2015-09-23 20:58:09','2015-11-03 09:04:35'),(374,'Aura','aura.rebelo@gmail.com',49,2,22260020,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-09-23 23:48:44','2015-11-03 09:04:35'),(375,'Jeff','hawkhousejeff@hotmail.com',36,1,78739,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-24 17:58:12','2015-11-03 09:04:35'),(376,'Troy Vincent ','naismith1891@yahoo.com',41,1,50266,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-09-24 21:04:32','2015-11-03 09:04:35'),(377,'Steve','steve.hoskins@phmic.com',59,1,50511,0,3,'$1,000,000',30,'v2b-get-estimate',1,'2015-09-25 15:44:44','2015-11-03 09:04:35'),(378,'duder fodder','dussdfasdtyyoder@gmial.com',21,2,95125,0,1,'$750,000',20,'v2b-get-estimate',1,'2015-09-25 17:28:43','2015-11-03 09:04:35'),(379,'Chris Thompson','theobadiahgroup@gmail.com',58,1,95126,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-09-27 21:20:55','2015-11-03 09:04:35'),(380,'Lisa Woods','lisa.m.woods@gmail.com',34,2,80206,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-28 15:51:26','2015-11-03 09:04:35'),(381,'jacob','jacob@vendus.com',30,1,95125,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-09-28 23:36:12','2015-11-03 09:04:35'),(382,'tim','tim@hotmail.com',33,1,91,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-09-30 15:50:09','2015-11-03 09:04:35'),(383,'Bob','Bob@Marley.com',50,1,6905,0,2,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-01 04:48:16','2015-11-03 09:04:35'),(384,'Richard Haigh','rhaigh2002@gmail.com',40,1,2135,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-10-01 23:31:48','2015-11-03 09:04:35'),(385,'rick','rick2gt@hotmail.com',35,1,90210,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-02 00:33:39','2015-11-03 09:04:35'),(386,'Katarina Blom','katarina.blom@gmail.com',30,2,11205,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-10-02 13:54:27','2015-11-03 09:04:35'),(387,'priyanka','priyanka@vendus.com',90,1,8989,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-05 05:24:59','2015-11-03 09:04:35'),(388,'priyanka','chiluveri.priyanka@gmail.com',48,2,7878,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-10-05 06:16:53','2015-11-03 09:04:35'),(389,'Jack','jack.dugan@gmail.com',32,1,10001,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-05 10:58:42','2015-11-03 09:04:35'),(390,'David','david@knip.ch',24,1,10012,1,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-05 13:46:06','2015-11-03 09:04:35'),(391,'David','david@knip.ch',24,1,10012,1,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-05 13:46:06','2015-11-03 09:04:35'),(392,'Brandon Moyles','brandonmoyles@gmail.com',29,1,92011,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-10-06 03:44:25','2015-11-03 09:04:35'),(393,'Matteo','matteo.solesin@yahoo.it',28,1,20137,0,1,'$750,000',10,'v2b-get-estimate',1,'2015-10-06 13:51:20','2015-11-03 09:04:35'),(394,'William Lincoln','wdemier@amfam.com',45,1,53713,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-10-06 18:07:53','2015-11-03 09:04:35'),(395,'xcds','sdsf@dfdsf.com',25,1,12345,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-06 21:16:44','2015-11-03 09:04:35'),(396,'john','jk715.84@gmail.com',30,1,94536,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-10-06 22:25:22','2015-11-03 09:04:35'),(397,'Jacob Are you here','WeinerButt@aol.com',54,1,95269,0,1,'$750,000',30,'v2b-get-estimate',1,'2015-10-07 02:11:50','2015-11-03 09:04:35'),(398,'Paul','pjaessing@gmail.com',40,1,53090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-07 04:34:26','2015-11-03 09:04:35'),(399,'Jw','Boxdoctors03@ymail.com',33,1,28075,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-07 05:04:48','2015-11-03 09:04:35'),(400,'Anna Chambers','j_a_chambers2011@yahoo.com',35,2,37040,0,3,'$500,000',30,'v2b-get-estimate',1,'2015-10-07 06:18:24','2015-11-03 09:04:35'),(401,'Mark Batsiyan','mark.batsiyan@gmail.com',30,1,11215,0,1,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-08 20:04:03','2015-11-03 09:04:35'),(402,'Andrzej baraniak','Baraniak.andrzej@gmail.com',32,1,10312,1,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-09 11:17:50','2015-11-03 09:04:35'),(403,'Max','hubb8281@gmail.com',23,1,55101,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-09 14:42:07','2015-11-03 09:04:35'),(404,'yakob','jacob@vendus.com',18,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-09 18:48:28','2015-11-03 09:04:35'),(406,'Trisha','trisha.chhaya@gmail.com',60,2,94109,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-21 18:13:22','2015-11-03 09:04:35'),(407,'Ryan','ryan@vendus.com',23,1,95120,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-22 13:30:34','2015-11-03 09:04:35'),(408,'Axel StradaVecchia','axel2303@gmx.at',23,1,90210,0,1,'$500,000',10,'v2b-get-estimate',1,'2015-10-23 02:07:19','2015-11-03 09:04:35'),(409,'Tom','tommy9090@gmail.com',33,1,10023,0,1,'$500,000',10,'v2b-get-estimate',1,'2015-10-23 12:19:57','2015-11-03 09:04:35'),(410,'Eric Taylor','estaylor777@gmail.com',24,1,94306,0,2,'$250,000',30,'v2b-get-estimate',1,'2015-10-23 18:12:54','2015-11-03 09:04:35'),(411,'RamBheem','rambheema@yahoo.com',39,1,1801,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-24 21:03:33','2015-11-03 09:04:35'),(412,'Sandeep','manchie@yahoo.com',51,1,10533,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-25 21:00:03','2015-11-03 09:04:35'),(413,'Ryan','ryan@vendus.com',23,1,2342,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-25 22:46:57','2015-11-03 09:04:35'),(414,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-26 08:57:29','2015-11-03 09:04:35'),(415,'sai','priyanka@gmail.com',33,1,33,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 06:17:35','2015-11-03 09:04:35'),(416,'Andreas','aulvaer@gmail.com',34,1,73157,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-26 05:57:59','2015-11-03 09:04:35'),(417,'jacob@vendus.com','jacob@sureify.com',24,1,95125,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-26 09:21:37','2015-11-03 09:04:35'),(418,'James Davidson','jdavidson@gmail.com',31,1,94062,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-10-26 11:43:57','2015-11-03 09:04:35'),(419,'Jim','thegillyman@yahoo.com',49,1,6825,0,1,'$1,000,000',10,'v2b-get-estimate',1,'2015-10-26 15:07:00','2015-11-03 09:04:35'),(420,'Garrett','viggers@sbcglobal.net',37,1,96001,0,2,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-26 22:24:33','2015-11-03 09:04:35'),(421,'Chris Kaye','ccvkaye@gmaill.com',43,1,94203,0,2,'$1,000,000',20,'v2b-get-estimate',1,'2015-10-27 05:11:37','2015-11-03 09:04:35'),(422,'JDP','jdpark325@gmail.com',37,1,48105,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 07:52:24','2015-11-03 09:04:35'),(423,'Ryan Foss','ryanjfoss@gmail.com',41,1,55331,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 09:19:49','2015-11-03 09:04:35'),(424,'Test','test@test.com',25,1,27101,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-27 12:14:42','2015-11-03 09:04:35'),(425,'Pk','pradeep@vendus.com',98,1,12345,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 12:30:33','2015-11-03 09:04:35'),(426,'Phil Spokas','philspokas@gmail.com',52,1,99203,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-27 12:48:30','2015-11-03 09:04:35'),(427,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:05','2015-11-03 09:04:35'),(428,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:13','2015-11-03 09:04:35'),(429,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:25','2015-11-03 09:04:35'),(430,NULL,'ryan@vendus.com',NULL,0,0,0,0,NULL,0,NULL,1,'2015-10-27 13:28:38','2015-11-03 09:04:35'),(431,'Maura','maura.egan@yahoo.com',30,2,60614,0,1,'$500,000',20,'v2b-get-estimate',1,'2015-10-27 13:53:21','2015-11-03 09:04:35'),(432,'Jason','jason.emery@homesite.com',37,1,2062,0,1,'$500,000',30,'v2b-get-estimate',1,'2015-10-27 14:01:09','2015-11-03 09:04:35'),(433,'pwalker2@yahoo.com','pwalker2@yahoo.com',40,2,1890,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-10-27 14:52:42','2015-11-03 09:04:35'),(434,'Tomasz Jaroszczyk','Tmj105@hotmail.com',35,1,53593,0,1,'$250,000',30,'v2b-get-estimate',1,'2015-10-27 15:25:19','2015-11-03 09:04:35'),(435,'Ryan','ryantoner@gmail.com',32,1,19355,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 19:46:13','2015-11-03 09:04:35'),(436,'','kob34@adelphia.net',50,1,12801,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-27 20:04:43','2015-11-03 09:04:35'),(437,'xccx','priyanka@vendus.com',78,1,909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 12:29:13','2015-11-03 09:04:35'),(438,'xscfsf','priyanka@vendus.com',34,1,4343,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 12:31:19','2015-11-03 09:04:35'),(439,'xc','priyanka@vendus.com',89,1,9090,0,1,'$250,000',20,'v2b-get-estimate',1,'2015-10-28 12:31:56','2015-11-03 09:04:35'),(440,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 12:32:18','2015-11-03 09:04:35'),(441,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:26:25','2015-11-03 09:04:35'),(442,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:29:22','2015-11-03 09:04:35'),(443,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:30:08','2015-11-03 09:04:35'),(444,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:30:52','2015-11-03 09:04:35'),(445,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:31:53','2015-11-03 09:04:35'),(446,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 13:33:25','2015-11-03 09:04:35'),(447,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 13:34:04','2015-11-03 09:04:35'),(448,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:39:03','2015-11-03 09:04:35'),(449,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:40:29','2015-11-03 09:04:35'),(450,'xvv','priyanka@vendus.com',78,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-28 13:41:13','2015-11-03 09:04:35'),(451,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'savings',1,'2015-10-28 13:43:43','2015-11-03 09:04:35'),(452,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-28 13:53:43','2015-11-03 09:04:35'),(453,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-10-28 14:00:05','2015-11-03 09:04:35'),(454,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 04:19:10','2015-11-03 09:04:35'),(455,'vijay','vijay.ch@vendus.com',28,1,95514,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 04:50:41','2015-11-03 09:04:35'),(456,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 04:35:16','2015-11-03 09:04:35'),(457,'xcxc','priyanka@vendus.com',34,1,3434,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:14:54','2015-11-03 09:04:35'),(458,'xc','priyanka@vendus.com',89,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:15:17','2015-11-03 09:04:35'),(459,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 05:15:39','2015-11-03 09:04:35'),(460,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 05:15:43','2015-11-03 09:04:35'),(461,'nmm','saikrishna@vendus.com',45,1,7878,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:16:45','2015-11-03 09:04:35'),(462,'xcxc','priyanka@vendus.com',90,1,8989,0,1,'$250,000',10,'v2b-get-estimate',1,'2015-10-29 05:20:45','2015-11-03 09:04:35'),(463,'xccx','priyanka@vendus.com',45,1,4545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:21:04','2015-11-03 09:04:35'),(464,'xc','priyanka@vendus.com',67,1,9867,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:21:44','2015-11-03 09:04:35'),(465,'xc','priyanka@vendus.com',66,1,8888,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:22:17','2015-11-03 09:04:35'),(466,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 05:22:42','2015-11-03 09:04:35'),(467,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'alternate landing page bottom signup',1,'2015-10-29 05:23:06','2015-11-03 09:04:35'),(468,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page bottom signup',1,'2015-10-29 05:24:22','2015-11-03 09:04:35'),(469,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page bottom signup',1,'2015-10-29 05:25:25','2015-11-03 09:04:35'),(470,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page top signup',1,'2015-10-29 05:25:41','2015-11-03 09:04:35'),(471,'nmnm','priyanka@vendus.com',89,1,98978,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 05:29:56','2015-11-03 09:04:35'),(472,'xcnmxcn','priyanka@vendus.com',34,1,909099090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:06:58','2015-11-03 09:04:35'),(473,'xcnmxcn','priyanka@vendus.com',34,1,909099090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:07:00','2015-11-03 09:04:35'),(474,'xcnmxcn','priyanka@vendus.com',34,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:07:10','2015-11-03 09:04:35'),(475,'cvcv','priyanka@vendus.com',78,1,909090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:08:52','2015-11-03 09:04:35'),(476,'xc','priyanka@vendus.com',45,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:09:29','2015-11-03 09:04:35'),(477,'xc','priyanka@vendus.com',45,1,909090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:12:30','2015-11-03 09:04:35'),(478,'cvcv','priyanka@vendus.com',90,1,565,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:16:51','2015-11-03 09:04:35'),(479,'xcc','priyanka@vendus.com',34,1,45454545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:29:19','2015-11-03 09:04:35'),(480,'xcc','priyanka@vendus.com',34,1,45454545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:29:20','2015-11-03 09:04:35'),(481,'xcc','priyanka@vendus.com',34,1,454544545,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:29:35','2015-11-03 09:04:35'),(482,'xcxc','priyanka@vendus.com',34,1,900909090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:31:14','2015-11-03 09:04:35'),(483,'xcxc','priyanka@vendus.com',34,1,90099,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:31:47','2015-11-03 09:04:35'),(484,NULL,'xcx@fddfnm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 12:34:41','2015-11-03 09:04:35'),(485,'dbvnbdv','vbcnv@jbn.com',34,1,67676767,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:36:10','2015-11-03 09:04:35'),(486,'','chvkcse@gmail.com',20,1,333333,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:40:05','2015-11-03 09:04:35'),(487,'xcxc','priyanka@vendus.com',34,1,9090,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:43:45','2015-11-03 09:04:35'),(488,'xcxc','priyanka@vendus.com',34,1,2147483647,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:43:53','2015-11-03 09:04:35'),(489,'xc','chiluveri.priyanka@gmail.com',98,1,2147483647,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:45:13','2015-11-03 09:04:35'),(490,'','chvkcse@gmail.com',23,1,4214,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:48:02','2015-11-03 09:04:35'),(491,'','chiluveri.priyanka@gmail.com',43,1,12345,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 12:51:48','2015-11-03 09:04:35'),(492,'xc','cnxcnm@nmxnm.com',34,1,90909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:19:33','2015-11-03 09:04:35'),(493,'xc','priyanka@vendus.com',34,1,90909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:19:48','2015-11-03 09:04:35'),(494,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 13:20:19','2015-11-03 09:04:35'),(495,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-10-29 13:20:37','2015-11-03 09:04:35'),(496,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signup',1,'2015-10-29 13:21:07','2015-11-03 09:04:35'),(497,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-10-29 13:21:29','2015-11-03 09:04:35'),(498,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page top signup',1,'2015-10-29 13:21:42','2015-11-03 09:04:35'),(499,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Alternate landing page bottom signup',1,'2015-10-29 13:21:58','2015-11-03 09:04:35'),(500,'xv','priyanka@vendus.com',45,1,45589,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:31:39','2015-11-03 09:04:35'),(501,'xc','priyanka@vendus.com',34,1,90909,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-10-29 13:32:30','2015-11-03 09:04:35'),(502,NULL,'xcxc@nmnm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 13:55:37','2015-11-03 09:04:35'),(503,NULL,'xncmnx@nmnm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 13:55:52','2015-11-03 09:04:35'),(504,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:00:35','2015-11-03 09:04:35'),(505,NULL,'sdmsndmn@mbb.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:03:27','2015-11-03 09:04:35'),(506,NULL,'chiluveri.priyankxcxca@gmail.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:05:21','2015-11-03 09:04:35'),(507,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:06:27','2015-11-03 09:04:35'),(508,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:07:12','2015-11-03 09:04:35'),(509,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:08:34','2015-11-03 09:04:35'),(510,NULL,'nmnm@Nm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:09:55','2015-11-03 09:04:35'),(511,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:13:28','2015-11-03 09:04:35'),(512,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:14:35','2015-11-03 09:04:35'),(513,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:15:41','2015-11-03 09:04:35'),(514,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-10-29 14:16:46','2015-11-03 09:04:35'),(515,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:18:23','2015-11-03 09:04:35'),(516,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:19:05','2015-11-03 09:04:35'),(517,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:20:33','2015-11-03 09:04:35'),(518,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:21:04','2015-11-03 09:04:35'),(519,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:21:09','2015-11-03 09:04:35'),(520,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:22:12','2015-11-03 09:04:35'),(521,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:23:17','2015-11-03 09:04:35'),(522,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:24:09','2015-11-03 09:04:35'),(523,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:25:07','2015-11-03 09:04:35'),(524,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:26:30','2015-11-03 09:04:35'),(525,NULL,'nmnm@Nm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:27:03','2015-11-03 09:04:35'),(526,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:27:43','2015-11-03 09:04:35'),(527,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:28:21','2015-11-03 09:04:35'),(528,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:29:04','2015-11-03 09:04:35'),(529,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:29:41','2015-11-03 09:04:35'),(530,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:31:22','2015-11-03 09:04:35'),(531,NULL,'nmnm@Nm.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:32:56','2015-11-03 09:04:35'),(532,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:35:05','2015-11-03 09:04:35'),(533,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:36:12','2015-11-03 09:04:35'),(534,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:40:51','2015-11-03 09:04:35'),(535,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:43:29','2015-11-03 09:04:35'),(536,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:45:03','2015-11-03 09:04:35'),(537,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:45:59','2015-11-03 09:04:35'),(538,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:52:27','2015-11-03 09:04:35'),(539,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:52:31','2015-11-03 09:04:35'),(540,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:41','2015-11-03 09:04:35'),(541,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:46','2015-11-03 09:04:35'),(542,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:51','2015-11-03 09:04:35'),(543,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:54:55','2015-11-03 09:04:35'),(544,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 14:59:52','2015-11-03 09:04:35'),(545,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:00:02','2015-11-03 09:04:35'),(546,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:00:14','2015-11-03 09:04:35'),(547,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:02:54','2015-11-03 09:04:35'),(548,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:05:22','2015-11-03 09:04:35'),(549,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:05:55','2015-11-03 09:04:35'),(550,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:07:24','2015-11-03 09:04:35'),(551,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:08:52','2015-11-03 09:04:35'),(552,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:10:29','2015-11-03 09:04:35'),(553,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:11:41','2015-11-03 09:04:35'),(554,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:12:21','2015-11-03 09:04:35'),(555,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:13:16','2015-11-03 09:04:35'),(556,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-10-29 15:14:03','2015-11-03 09:04:35'),(557,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-10-29 15:16:08','2015-11-03 09:04:35'),(558,NULL,'priyanka@vendus.com',NULL,0,0,0,0,NULL,0,'Signup',1,'2015-10-29 15:16:29','2015-11-03 09:04:35'),(559,'sai','saikrishna@vendus.com',24,1,36655,0,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-11-03 03:13:45','2015-11-03 11:13:45'),(560,NULL,'saikrishna@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-11-03 03:15:21','2015-11-03 11:15:21'),(561,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Signup',1,'2015-11-03 03:15:47','2015-11-03 11:15:47'),(562,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-11-03 03:16:12','2015-11-03 11:16:12'),(563,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Health',1,'2015-11-03 03:16:49','2015-11-03 11:16:49'),(564,NULL,'saikrishna@vendus.com',NULL,0,0,0,0,NULL,0,'Savings',1,'2015-11-04 05:51:50','2015-11-04 13:51:50'),(565,'sai','saikrishna@vendus.com',25,1,54212,1,1,'$1,000,000',30,'v2b-get-estimate',1,'2015-11-04 21:39:24','2015-11-05 05:39:24'),(566,NULL,'srujana@vendus.com',NULL,0,0,0,0,NULL,0,'Signupv2',1,'2015-11-04 21:52:45','2015-11-05 05:52:45');
/*!40000 ALTER TABLE `quote_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_quote_users_after_insert
    AFTER INSERT ON quote_users
    FOR EACH ROW BEGIN
 
    INSERT INTO history_quote_users
    SET quote_users_id = new.id,
	name = new.name,
	email = new.email,
	age = new.age,
	gender = new.gender,
	area_code = new.area_code,
	smoker = new.smoker,
	health = new.health,
	protection = new.protection,
	duration = new.duration,
	origin = new.origin,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_quote_users_before_update
    BEFORE UPDATE ON quote_users
    FOR EACH ROW BEGIN
 
    INSERT INTO history_quote_users
    SET quote_users_id = old.id,
	name = old.name,
	email = old.email,
	age = old.age,
	gender = old.gender,
	area_code = old.area_code,
	smoker = old.smoker,
	health = old.health,
	protection = old.protection,
	duration = old.duration,
	origin = old.origin,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_quote_users_before_delete
    BEFORE Delete ON quote_users
    FOR EACH ROW BEGIN
 
    INSERT INTO history_quote_users
    SET quote_users_id = old.id,
	name = old.name,
	email = old.email,
	age = old.age,
	gender = old.gender,
	area_code = old.area_code,
	smoker = old.smoker,
	health = old.health,
	protection = old.protection,
	duration = old.duration,
	origin = old.origin,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `remainder_setups`
--

DROP TABLE IF EXISTS `remainder_setups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `remainder_setups` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary remainder_setups table',
  `remainder_name` varchar(255) DEFAULT NULL COMMENT 'Remainder name',
  `description` text COMMENT 'Remainder description',
  `template_id` int(11) DEFAULT NULL COMMENT 'Primary key of email_templates id',
  `is_hours` tinyint(1) DEFAULT '0' COMMENT 'Checking remainder for hours',
  `remainder_hours` int(4) DEFAULT NULL COMMENT 'Number of Hours',
  `is_days` tinyint(1) DEFAULT '0' COMMENT 'Checking remainder for days',
  `remainder_days` int(4) DEFAULT NULL COMMENT 'Number of days',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `remainder_setups_session_fk` (`user_session_id`),
  KEY `remainder_setups_fk` (`template_id`),
  CONSTRAINT `remainder_setups_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `remainder_setups_ibfk_2` FOREIGN KEY (`template_id`) REFERENCES `email_templates` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `remainder_setups`
--

LOCK TABLES `remainder_setups` WRITE;
/*!40000 ALTER TABLE `remainder_setups` DISABLE KEYS */;
INSERT INTO `remainder_setups` VALUES (1,'example','asdsa',6,1,2,0,0,0,59,'2015-11-11 21:47:45','2015-11-12 05:48:42'),(2,'example','asdsadf',6,0,0,0,0,1,59,'2015-11-11 21:59:53','2015-11-12 05:59:53'),(3,'example1','sdfasd',9,0,0,0,0,0,59,'2015-11-11 22:00:23','2015-11-12 06:00:32'),(4,'example1','asdsadf',6,0,0,0,0,0,61,'2015-11-11 23:12:03','2015-11-12 07:23:22'),(5,'example1a','asdsadf',6,0,0,0,0,0,59,'2015-11-11 22:01:37','2015-11-12 07:11:46'),(6,'example11','asdsadf',6,0,0,0,0,0,61,'2015-11-11 23:11:34','2015-11-12 07:11:46');
/*!40000 ALTER TABLE `remainder_setups` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_remainder_setups_after_insert
    AFTER INSERT ON remainder_setups
    FOR EACH ROW BEGIN
 
    INSERT INTO history_remainder_setups
    SET remainder_setups_id = new.id,
	remainder_name = new.remainder_name,
	description = new.description,
	template_id = new.template_id,
	is_hours = new.is_hours,
	remainder_hours = new.remainder_hours,
	is_days = new.is_days,
	remainder_days = new.remainder_days,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_remainder_setups_before_update
    BEFORE UPDATE ON remainder_setups
    FOR EACH ROW BEGIN
 
    INSERT INTO history_remainder_setups
    SET remainder_setups_id = old.id,
	remainder_name = old.remainder_name,
	description = old.description,
	template_id = old.template_id,
	is_hours = old.is_hours,
	remainder_hours = old.remainder_hours,
	is_days = old.is_days,
	remainder_days = old.remainder_days,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_remainder_setups_before_delete
    BEFORE Delete ON remainder_setups
    FOR EACH ROW BEGIN
 
    INSERT INTO history_remainder_setups
    SET remainder_setups_id = old.id,
	remainder_name = old.remainder_name,
	description = old.description,
	template_id = old.template_id,
	is_hours = old.is_hours,
	remainder_hours = old.remainder_hours,
	is_days = old.is_days,
	remainder_days = old.remainder_days,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_calories`
--

DROP TABLE IF EXISTS `user_calories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_calories` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key calories table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `calories` int(11) DEFAULT NULL COMMENT 'calories of the user on aparticular date',
  `calories_date` datetime DEFAULT NULL COMMENT 'date of the calories recorded',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `user_calories_session_fk` (`user_session_id`),
  KEY `user_calories_fk` (`user_id`),
  CONSTRAINT `user_calories_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `user_calories_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_calories`
--

LOCK TABLES `user_calories` WRITE;
/*!40000 ALTER TABLE `user_calories` DISABLE KEYS */;
INSERT INTO `user_calories` VALUES (1,2,1354,'2015-10-25 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(2,2,1532,'2015-10-26 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(3,2,1944,'2015-10-27 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(4,2,1682,'2015-10-28 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(5,2,1658,'2015-10-29 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(6,2,1570,'2015-10-30 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(7,2,1354,'2015-10-31 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(8,2,1354,'2015-11-01 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(9,2,1540,'2015-11-02 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(10,2,1672,'2015-11-03 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(11,2,1647,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(12,2,1647,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(13,2,1647,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:48:08'),(14,2,1647,'2015-11-04 00:00:00',1,50,'2015-11-04 23:48:08','2015-11-05 07:48:08'),(15,3,1806,'2015-11-02 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22'),(16,3,1639,'2015-11-03 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22'),(17,3,1639,'2015-11-04 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22'),(18,3,937,'2015-11-05 00:00:00',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22');
/*!40000 ALTER TABLE `user_calories` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_calories_after_insert
    AFTER INSERT ON user_calories
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_calories
    SET user_calories_id = new.id,
	user_id = new.user_id,
	calories = new.calories,
	calories_date = new.calories_date,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_calories_before_update
    BEFORE UPDATE ON user_calories
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_calories
    SET user_calories_id = old.id,
	user_id = old.user_id,
	calories = old.calories,
	calories_date = old.calories_date,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_calories_before_delete
    BEFORE Delete ON user_calories
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_calories
    SET user_calories_id = old.id,
	user_id = old.user_id,
	calories = old.calories,
	calories_date = old.calories_date,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_challenges`
--

DROP TABLE IF EXISTS `user_challenges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_challenges` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_challenges table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `challenge_id` int(11) NOT NULL COMMENT 'Primary key of the challenges_master table',
  `status` int(4) DEFAULT NULL COMMENT 'challenges status value links to group values',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `challenges_session_fk` (`user_session_id`),
  KEY `challenges_fk` (`user_id`),
  KEY `challenges_cha_master_fk` (`challenge_id`),
  CONSTRAINT `user_challenges_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `user_challenges_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_challenges_ibfk_3` FOREIGN KEY (`challenge_id`) REFERENCES `challenges_master` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_challenges`
--

LOCK TABLES `user_challenges` WRITE;
/*!40000 ALTER TABLE `user_challenges` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_challenges` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_challenges_after_insert
    AFTER INSERT ON user_challenges
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_challenges
    SET user_challenges_id = new.id,
	user_id = new.user_id,
	challenge_id = new.challenge_id,
	status = new.status,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_challenges_before_update
    BEFORE UPDATE ON user_challenges
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_challenges
    SET user_challenges_id = old.id,
	user_id = old.user_id,
	challenge_id = old.challenge_id,
	status = old.status,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_challenges_before_delete
    BEFORE Delete ON user_challenges
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_challenges
    SET user_challenges_id = old.id,
	user_id = old.user_id,
	challenge_id = old.challenge_id,
	status = old.status,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_devices`
--

DROP TABLE IF EXISTS `user_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_devices` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_devices table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key user_devices table',
  `device_id` int(11) DEFAULT NULL COMMENT 'Primary key devices_master table',
  `battery` varchar(255) DEFAULT NULL COMMENT 'Battery info',
  `device_version` varchar(255) DEFAULT NULL COMMENT 'Device version',
  `features` text COMMENT 'device futures',
  `fitbit_device_id` varchar(255) DEFAULT NULL COMMENT 'fitbit_device_id',
  `last_sync_time` varchar(255) DEFAULT NULL COMMENT 'Last time when user synchronizes the device',
  `mac` varchar(255) DEFAULT NULL COMMENT 'mac number',
  `type` varchar(255) DEFAULT NULL COMMENT 'Type of the device',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `user_devices_fk` (`user_id`),
  KEY `user_devices_session_fk` (`user_session_id`),
  CONSTRAINT `user_devices_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_devices_ibfk_2` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_devices`
--

LOCK TABLES `user_devices` WRITE;
/*!40000 ALTER TABLE `user_devices` DISABLE KEYS */;
INSERT INTO `user_devices` VALUES (1,3,NULL,'Low','Charge HR','a:0:{}','51162949','2015-11-02T15:24:38.000','77978C31CFF9','TRACKER',1,51,'2015-11-05 00:13:22','2015-11-05 08:13:22');
/*!40000 ALTER TABLE `user_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_info table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `first_name` varchar(255) DEFAULT NULL COMMENT 'First name of user',
  `last_name` varchar(255) DEFAULT NULL COMMENT 'Last name of user',
  `height` varchar(255) DEFAULT NULL COMMENT 'Height of user',
  `weight` float(5,2) DEFAULT NULL COMMENT 'Weight of user',
  `location` varchar(255) DEFAULT NULL COMMENT 'Location of user',
  `address` text COMMENT 'Address of an user',
  `profile_pic` varchar(255) DEFAULT NULL COMMENT 'Profile pic of user',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Mobile number of user',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of user',
  `age` int(3) DEFAULT NULL,
  `gender` int(4) DEFAULT NULL COMMENT 'Gender-Group values-',
  `salary` float(10,2) DEFAULT NULL COMMENT 'Salary or income of user',
  `ssn` varchar(50) DEFAULT NULL COMMENT 'SSN number of an user',
  `driving_license` varchar(50) DEFAULT NULL COMMENT 'Driving license number of an user',
  `death_date` datetime DEFAULT NULL COMMENT 'Death date of user',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `date_of_birth` datetime DEFAULT NULL COMMENT 'Date of birth of an user',
  PRIMARY KEY (`id`),
  KEY `user_info_fk` (`user_id`),
  KEY `user_info_session_fk` (`user_session_id`),
  CONSTRAINT `user_info_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_info_session_fk` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
INSERT INTO `user_info` VALUES (1,1,'Vijay','Chirivolu','5\"7',70.50,'India','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','vijay.ch@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(2,2,'Srujana','Dakoju','5\"7',80.50,'India','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064','index1.jpeg','9848022338','srujana@vendus.com',25,2,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(3,3,'tammini','Venkat','5\"7',70.50,'Sri lanka','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','tammini@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,51,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(4,4,'Pradeep','Reddy','5\"7',70.50,'India','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','pradeep@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(5,5,'Sulu','Velugu','5\"7',70.50,'India','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','sulu@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(6,6,'Vijay','Thodupunoori','5\"7',70.50,'India','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','vijay@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(7,7,'Dustin','Yoder','5\"7',70.50,'San Jose','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','dustin@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(8,8,'Ryan','Swanson','5\"7',70.50,'San Jose','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','ryan@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(9,9,'Jacob','Yoder','5\"7',70.50,'San Jose','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','jacob@vendus.com',25,1,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:24:28','2015-11-16 05:47:12','1988-05-05 00:00:00'),(10,10,'Lalitha','Gurajada','5\"7',70.50,'India','University of California, Santa Cruz 1156 High Street Santa Cruz, CA 95064',NULL,'9848022338','lalitha@vendus.com',25,2,NULL,'721-07-1234','GARDN 605109 C99LY',NULL,1,0,'2015-11-04 15:56:12','2015-11-16 05:47:12','1988-05-05 00:00:00'),(11,11,'New York Life','Insurance','5\"7',70.50,'New York','',NULL,'9848022338','newyorklife@gmail.com',25,1,NULL,'','',NULL,1,2,'2015-11-04 15:24:28','2015-11-04 04:24:28','1988-05-05 00:00:00');
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_info_after_insert
    AFTER INSERT ON user_info
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_info
    SET user_info_id = new.id,
	user_id = new.user_id,
	first_name = new.first_name,
	last_name = new.last_name,
	height = new.height,
	weight = new.weight,
	location = new.location,
	profile_pic = new.profile_pic,
	phone_number = new.phone_number,
	email = new.email,
	gender = new.gender,
	salary = new.salary,
	death_date = new.death_date,
	row_status = new.row_status,
	user_session_id = new.user_session_id,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_info_before_update
    BEFORE UPDATE ON user_info
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_info
    SET user_info_id = old.id,
	user_id = old.user_id,
	first_name = old.first_name,
	last_name = old.last_name,
	height = old.height,
	weight = old.weight,
	location = old.location,
	profile_pic = old.profile_pic,
	phone_number = old.phone_number,
	email = old.email,
	gender = old.gender,
	salary = old.salary,
	death_date = old.death_date,
	row_status = old.row_status,
	user_session_id = old.user_session_id,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_info_before_delete
    BEFORE Delete ON user_info
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_info
    SET user_info_id = old.id,
	user_id = old.user_id,
	first_name = old.first_name,
	last_name = old.last_name,
	height = old.height,
	weight = old.weight,
	location = old.location,
	profile_pic = old.profile_pic,
	phone_number = old.phone_number,
	email = old.email,
	gender = old.gender,
	salary = old.salary,
	death_date = old.death_date,
	row_status = old.row_status,
	user_session_id = old.user_session_id,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_sessions`
--

DROP TABLE IF EXISTS `user_sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key user_sessions table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key users table',
  `login_time` datetime DEFAULT NULL COMMENT 'Users login time',
  `logout_time` datetime DEFAULT NULL COMMENT 'Users logout time',
  `login_ip` varchar(255) DEFAULT NULL COMMENT 'Loggedin user ip address',
  `browser` varchar(255) DEFAULT NULL COMMENT 'Loggedin user browser or device id info',
  `OS` varchar(255) DEFAULT NULL COMMENT 'Loggedin user operating system',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `access_token` varchar(255) NOT NULL COMMENT 'access token of the user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token` (`access_token`),
  KEY `user_sessions_fk` (`user_id`),
  CONSTRAINT `user_sessions_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_sessions`
--

LOCK TABLES `user_sessions` WRITE;
/*!40000 ALTER TABLE `user_sessions` DISABLE KEYS */;
INSERT INTO `user_sessions` VALUES (1,2,NULL,NULL,NULL,NULL,NULL,1,'2015-11-03 18:32:06','2015-11-16 05:27:11','1'),(2,2,'2015-11-03 06:01:05',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 06:01:05','2015-11-16 05:27:11','2'),(3,2,'2015-11-03 06:04:18',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 06:04:18','2015-11-16 05:27:11','3'),(4,2,'2015-11-03 06:10:04',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 06:10:04','2015-11-16 05:27:11','4'),(5,2,'2015-11-03 06:10:47',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 06:10:47','2015-11-16 05:27:11','5'),(6,2,'2015-11-03 06:11:30',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 06:11:30','2015-11-16 05:27:11','6'),(7,2,'2015-11-03 21:21:08',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:21:08','2015-11-16 05:27:11','7'),(8,2,'2015-11-03 21:26:51',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:26:51','2015-11-16 05:27:11','8'),(9,2,'2015-11-03 21:27:36',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:27:36','2015-11-16 05:27:11','9'),(10,2,'2015-11-03 21:27:58',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:27:58','2015-11-16 05:27:11','10'),(11,2,'2015-11-03 21:30:45',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:30:45','2015-11-16 05:27:11','11'),(12,2,'2015-11-03 21:32:10',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:32:10','2015-11-16 05:27:11','12'),(13,2,'2015-11-03 21:32:42',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:32:42','2015-11-16 05:27:11','13'),(14,2,'2015-11-03 21:34:26',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:34:26','2015-11-16 05:27:11','14'),(15,2,'2015-11-03 21:48:08','2015-11-03 21:49:29','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:48:08','2015-11-16 05:27:11','15'),(16,2,'2015-11-03 21:49:44','2015-11-03 21:50:06','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:49:44','2015-11-16 05:27:11','16'),(17,2,'2015-11-03 21:55:03','2015-11-03 21:55:37','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 21:55:03','2015-11-16 05:27:11','17'),(18,2,'2015-11-03 22:00:51','2015-11-03 22:01:05','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:00:51','2015-11-16 05:27:11','18'),(19,2,'2015-11-03 22:03:08','2015-11-03 22:08:34','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:03:08','2015-11-16 05:27:11','19'),(20,2,'2015-11-03 22:15:50','2015-11-03 22:20:17','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:15:50','2015-11-16 05:27:11','20'),(21,2,'2015-11-03 22:21:12','2015-11-03 22:22:45','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:21:12','2015-11-16 05:27:11','21'),(22,2,'2015-11-03 22:22:55','2015-11-03 22:35:42','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:22:55','2015-11-16 05:27:11','22'),(23,2,'2015-11-03 22:37:15','2015-11-03 22:40:52','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:37:15','2015-11-16 05:27:11','23'),(24,2,'2015-11-03 22:41:02','2015-11-03 22:41:37','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:41:02','2015-11-16 05:27:11','24'),(25,2,'2015-11-03 22:41:54','2015-11-03 22:47:26','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:41:54','2015-11-16 05:27:11','25'),(26,2,'2015-11-03 22:52:05','2015-11-03 22:52:28','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:52:05','2015-11-16 05:27:11','26'),(27,2,'2015-11-03 22:57:06',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 22:57:06','2015-11-16 05:27:11','27'),(28,1,'2015-11-03 23:01:02',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 23:01:02','2015-11-16 05:27:11','28'),(29,2,'2015-11-03 23:03:01','2015-11-03 23:42:06','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 23:03:01','2015-11-16 05:27:11','29'),(30,2,'2015-11-03 23:46:22','2015-11-03 23:55:55','127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 23:46:22','2015-11-16 05:27:11','30'),(31,2,'2015-11-03 23:57:54',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-03 23:57:54','2015-11-16 05:27:11','31'),(32,2,'2015-11-04 02:56:09','2015-11-04 04:53:39','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 02:56:09','2015-11-16 05:27:11','32'),(33,2,'2015-11-04 04:54:06','2015-11-04 05:50:49','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 04:54:06','2015-11-16 05:27:11','33'),(34,1,'2015-11-04 06:06:05',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:06:05','2015-11-16 05:27:11','34'),(35,1,'2015-11-04 06:06:45',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:06:45','2015-11-16 05:27:11','35'),(36,1,'2015-11-04 06:15:50',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:15:50','2015-11-16 05:27:11','36'),(37,1,'2015-11-04 06:16:21',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:16:21','2015-11-16 05:27:11','37'),(38,2,'2015-11-04 06:17:03',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:17:03','2015-11-16 05:27:11','38'),(39,1,'2015-11-04 06:22:55',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:22:55','2015-11-16 05:27:11','39'),(40,1,'2015-11-04 06:27:14',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 06:27:14','2015-11-16 05:27:11','40'),(41,2,'2015-11-04 21:15:46','2015-11-04 21:15:53','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 21:15:46','2015-11-16 05:27:11','41'),(42,2,'2015-11-04 21:41:52','2015-11-04 21:43:23','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 21:41:52','2015-11-16 05:27:11','42'),(43,2,'2015-11-04 22:03:50','2015-11-04 22:26:57','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:03:50','2015-11-16 05:27:11','43'),(44,5,'2015-11-04 22:27:04','2015-11-04 22:30:47','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:27:04','2015-11-16 05:27:11','44'),(45,5,'2015-11-04 22:30:08',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:30:08','2015-11-16 05:27:11','45'),(46,2,'2015-11-04 22:30:54','2015-11-04 22:30:59','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:30:54','2015-11-16 05:27:11','46'),(47,5,'2015-11-04 22:31:07','2015-11-04 22:31:41','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:31:07','2015-11-16 05:27:11','47'),(48,2,'2015-11-04 22:31:47','2015-11-04 22:35:51','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:31:47','2015-11-16 05:27:11','48'),(49,6,'2015-11-04 22:36:05','2015-11-04 22:36:22','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:36:05','2015-11-16 05:27:11','49'),(50,2,'2015-11-04 22:36:46','2015-11-04 23:55:38','127.0.0.1','Firefox','Ubuntu',1,'2015-11-04 22:36:46','2015-11-16 05:27:11','50'),(51,3,'2015-11-05 00:03:44','2015-11-05 01:11:26','127.0.0.1','Firefox','Ubuntu',1,'2015-11-05 00:03:44','2015-11-16 05:27:11','51'),(52,2,'2015-11-05 01:11:41',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-05 01:11:41','2015-11-16 05:27:11','52'),(53,1,'2015-11-05 01:14:51',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-05 01:14:51','2015-11-16 05:27:11','53'),(54,1,'2015-11-05 04:16:43',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-05 04:16:43','2015-11-16 05:27:11','54'),(55,1,'2015-11-05 21:36:26',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-05 21:36:26','2015-11-16 05:27:11','55'),(56,1,'2015-11-06 02:56:07',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-06 02:56:07','2015-11-16 05:27:11','56'),(57,1,'2015-11-08 20:57:49',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-08 20:57:49','2015-11-16 05:27:11','57'),(58,1,'2015-11-09 21:28:05',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-09 21:28:05','2015-11-16 05:27:11','58'),(59,1,'2015-11-11 20:44:22',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-11 20:44:22','2015-11-16 05:27:11','59'),(60,6,'2015-11-11 22:20:12','2015-11-11 22:20:52','127.0.0.1','Firefox','Ubuntu',1,'2015-11-11 22:20:12','2015-11-16 05:27:11','60'),(61,1,'2015-11-11 22:21:38',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-11 22:21:38','2015-11-16 05:27:11','61'),(62,1,'2015-11-12 02:17:54',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-12 02:17:54','2015-11-16 05:27:11','62'),(63,1,'2015-11-12 05:10:56',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-12 05:10:56','2015-11-16 05:27:11','63'),(64,1,'2015-11-12 22:59:26',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-12 22:59:26','2015-11-16 05:27:11','64'),(65,2,'2015-11-13 01:55:25',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-13 01:55:25','2015-11-16 05:27:11','65'),(66,1,'2015-11-15 20:45:08',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-15 20:45:08','2015-11-16 05:27:11','66'),(67,1,'2015-11-16 04:12:03',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-16 04:12:03','2015-11-16 12:12:03',''),(69,1,'2015-11-16 21:20:38',NULL,'127.0.0.1','Firefox','Ubuntu',1,'2015-11-16 21:20:38','2015-11-17 05:20:38','1447737638');
/*!40000 ALTER TABLE `user_sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_steps`
--

DROP TABLE IF EXISTS `user_steps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_steps` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key steps table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `steps` int(11) DEFAULT NULL COMMENT 'Steps of the user on aparticular date',
  `steps_date` datetime DEFAULT NULL COMMENT 'date of the steps recorded',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `user_steps_session_fk` (`user_session_id`),
  KEY `user_steps_fk` (`user_id`),
  CONSTRAINT `user_steps_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `user_steps_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_steps`
--

LOCK TABLES `user_steps` WRITE;
/*!40000 ALTER TABLE `user_steps` DISABLE KEYS */;
INSERT INTO `user_steps` VALUES (12,2,0,'2015-10-25 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(13,2,1526,'2015-10-26 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(14,2,7699,'2015-10-27 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(15,2,4387,'2015-10-28 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(16,2,4038,'2015-10-29 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(17,2,2693,'2015-10-30 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(18,2,0,'2015-10-31 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(19,2,0,'2015-11-01 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(20,2,2554,'2015-11-02 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(21,2,3647,'2015-11-03 00:00:00',1,50,'0000-00-00 00:00:00','2015-11-05 07:31:08'),(22,2,3748,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:32:02'),(23,2,3748,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:42:26'),(24,2,3748,'2015-11-04 00:00:00',0,50,'0000-00-00 00:00:00','2015-11-05 07:48:08'),(25,2,3748,'2015-11-04 00:00:00',1,50,'2015-11-04 23:48:05','2015-11-05 07:48:08'),(26,3,1628,'2015-11-02 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22'),(27,3,0,'2015-11-03 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22'),(28,3,0,'2015-11-04 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22'),(29,3,0,'2015-11-05 00:00:00',1,51,'2015-11-05 00:13:20','2015-11-05 08:13:22');
/*!40000 ALTER TABLE `user_steps` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_steps_after_insert
    AFTER INSERT ON user_steps
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_steps
    SET user_steps_id = new.id,
	user_id = new.user_id,
	steps = new.steps,
	steps_date = new.steps_date,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_steps_before_update
    BEFORE UPDATE ON user_steps
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_steps
    SET user_steps_id = old.id,
	user_id = old.user_id,
	steps = old.steps,
	steps_date = old.steps_date,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_steps_before_delete
    BEFORE Delete ON user_steps
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_steps
    SET user_steps_id = old.id,
	user_id = old.user_id,
	steps = old.steps,
	steps_date = old.steps_date,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user_weights`
--

DROP TABLE IF EXISTS `user_weights`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_weights` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key weights table',
  `user_id` int(11) NOT NULL COMMENT 'Primary key of the users table',
  `weight` int(11) DEFAULT NULL COMMENT 'weight of the user on aparticular date',
  `weight_date` datetime DEFAULT NULL COMMENT 'date of the weight recorded',
  `bmi` varchar(255) DEFAULT NULL COMMENT 'Bmi of the user',
  `weight_time` time DEFAULT NULL COMMENT 'Time of the weight recorded',
  `log_id` varchar(255) DEFAULT NULL COMMENT 'Log id',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  PRIMARY KEY (`id`),
  KEY `user_weights_session_fk` (`user_session_id`),
  KEY `user_weights_fk` (`user_id`),
  CONSTRAINT `user_weights_ibfk_1` FOREIGN KEY (`user_session_id`) REFERENCES `user_sessions` (`id`),
  CONSTRAINT `user_weights_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_weights`
--

LOCK TABLES `user_weights` WRITE;
/*!40000 ALTER TABLE `user_weights` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_weights` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_weights_after_insert
    AFTER INSERT ON user_weights
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_weights
    SET user_weights_id = new.id,
	user_id = new.user_id,
	weight = new.weight,
	weight_date = new.weight_date,
	bmi = new.bmi,
	log_id = new.log_id,
	weight_time = new.weight_time,
	user_session_id = new.user_session_id,
	row_status = new.row_status,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_weights_before_update
    BEFORE UPDATE ON user_weights
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_weights
    SET user_weights_id = old.id,
	user_id = old.user_id,
	weight = old.weight,
	weight_date = old.weight_date,
	bmi = old.bmi,
	log_id = old.log_id,
	weight_time = old.weight_time,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_user_weights_before_delete
    BEFORE Delete ON user_weights
    FOR EACH ROW BEGIN
 
    INSERT INTO history_user_weights
    SET user_weights_id = old.id,
	user_id = old.user_id,
	weight = old.weight,
	weight_date = old.weight_date,
	bmi = old.bmi,
	log_id = old.log_id,
	weight_time = old.weight_time,
	user_session_id = old.user_session_id,
	row_status = old.row_status,
	created_time = old.created_time,
	modified_time = old.modified_time;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key users table',
  `email` varchar(255) DEFAULT NULL COMMENT 'Email of user',
  `password` varchar(255) DEFAULT NULL COMMENT 'Password of user',
  `agent_id` int(11) DEFAULT NULL COMMENT 'Primary key of agents table',
  `user_type` int(11) DEFAULT NULL COMMENT 'User type - Group values-',
  `phone_number` varchar(20) DEFAULT NULL COMMENT 'Mobile number of user',
  `status` int(11) DEFAULT NULL COMMENT 'User status - Group values-',
  `login_attempts` int(11) DEFAULT NULL COMMENT 'Number of failed login attempts',
  `last_login` datetime DEFAULT NULL COMMENT 'User last login time',
  `row_status` tinyint(1) DEFAULT '1' COMMENT 'Record status 1-Active 0-Deactive',
  `user_session_id` int(11) NOT NULL COMMENT 'Primary key of user_sessions table',
  `created_time` datetime NOT NULL COMMENT 'Record created time',
  `modified_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'Record updated time',
  `fitbit_access_token` text COMMENT 'Fitbit_access_token of an user',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'vijay.ch@vendus.com','25f9e794323b453885f5181f1b624d0b',0,2001,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(2,'srujana@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-13 01:55:25',1,0,'2015-11-04 15:07:51','2015-11-13 09:55:44','N;'),(3,'tammini@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-05 00:03:44',1,0,'2015-11-04 15:07:51','2015-11-05 08:04:45','a:1:{s:41:\"https://api.fitbit.com/oauth/access_token\";a:3:{s:5:\"value\";s:32:\"24c8142c6a4635086f72901bb52ddabe\";s:6:\"secret\";s:32:\"20acd6fd75ddc9d30798961687438700\";s:10:\"authorized\";b:1;}}'),(4,'pradeep@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 09:37:51',NULL),(5,'sulu@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-04 22:31:07',1,0,'2015-11-04 15:07:52','2015-11-05 06:31:07',NULL),(6,'vijay@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,'2015-11-11 22:20:12',1,0,'2015-11-04 15:07:52','2015-11-12 06:20:23','N;'),(7,'dustin@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(8,'ryan@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:52','2015-11-04 09:37:52',NULL),(9,'jacob@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:08:06','2015-11-04 09:38:06',NULL),(10,'lalitha@vendus.com','af06a1193d5a25b59c5e2f11b05446eb',0,2004,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:55:06','2015-11-04 10:25:06',NULL),(11,'newyorklife@gmail.com','af06a1193d5a25b59c5e2f11b05446eb',0,2005,'9848022338',1001,0,NULL,1,0,'2015-11-04 15:07:51','2015-11-04 04:07:51',NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_users_after_insert
    AFTER INSERT ON users
    FOR EACH ROW BEGIN
 
    INSERT INTO history_users
    SET users_id = new.id,
	email = new.email,
	password = new.password,
	agent_id = new.agent_id,
	user_type = new.user_type,
	phone_number = new.phone_number,
	status = new.status,
	login_attempts = new.login_attempts,
	last_login = new.last_login,
	row_status = new.row_status,
	user_session_id = new.user_session_id,
	created_time = new.created_time,
	modified_time = new.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_users_before_update
    BEFORE UPDATE ON users
    FOR EACH ROW BEGIN
 
    INSERT INTO history_users
    SET users_id = old.id,
	email = old.email,
	password = old.password,
	agent_id = old.agent_id,
	user_type = old.user_type,
	phone_number = old.phone_number,
	status = old.status,
	login_attempts = old.login_attempts,
	last_login = old.last_login,
	row_status = old.row_status,
	user_session_id = old.user_session_id,
	created_time = old.created_time,
	modified_time = old.modified_time;
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
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER trigger_users_before_delete
    BEFORE Delete ON users
    FOR EACH ROW BEGIN
 
    INSERT INTO history_users
    SET users_id = old.id,
	email = old.email,
	password = old.password,
	agent_id = old.agent_id,
	user_type = old.user_type,
	phone_number = old.phone_number,
	status = old.status,
	login_attempts = old.login_attempts,
	last_login = old.last_login,
	row_status = old.row_status,
	user_session_id = old.user_session_id,
	created_time = old.created_time,
	modified_time = old.modified_time;
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

-- Dump completed on 2015-11-17 12:18:00
