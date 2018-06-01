-- MySQL dump 10.13  Distrib 8.0.3-rc, for Linux (x86_64)
--
-- Host: localhost    Database: school
-- ------------------------------------------------------
-- Server version	8.0.3-rc-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8mb4 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `SC`
--

DROP TABLE IF EXISTS `SC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `SC` (
  `sID` varchar(20) NOT NULL,
  `cID` varchar(20) NOT NULL,
  `scScore` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`sID`,`cID`),
  KEY `cID` (`cID`),
  CONSTRAINT `SC_ibfk_1` FOREIGN KEY (`sID`) REFERENCES `student_info` (`sid`),
  CONSTRAINT `SC_ibfk_2` FOREIGN KEY (`cID`) REFERENCES `course_info` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SC`
--

LOCK TABLES `SC` WRITE;
/*!40000 ALTER TABLE `SC` DISABLE KEYS */;
INSERT INTO `SC` VALUES ('1001','201801',59);
/*!40000 ALTER TABLE `SC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TC`
--

DROP TABLE IF EXISTS `TC`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `TC` (
  `tID` varchar(10) NOT NULL,
  `cID` varchar(20) NOT NULL,
  PRIMARY KEY (`tID`,`cID`),
  KEY `cID` (`cID`),
  CONSTRAINT `TC_ibfk_1` FOREIGN KEY (`tID`) REFERENCES `teacher_info` (`tid`),
  CONSTRAINT `TC_ibfk_2` FOREIGN KEY (`cID`) REFERENCES `course_info` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TC`
--

LOCK TABLES `TC` WRITE;
/*!40000 ALTER TABLE `TC` DISABLE KEYS */;
INSERT INTO `TC` VALUES ('101','201801');
/*!40000 ALTER TABLE `TC` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_info`
--

DROP TABLE IF EXISTS `course_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `course_info` (
  `cID` varchar(20) NOT NULL,
  `cName` varchar(100) DEFAULT NULL,
  `cCredit` tinyint(4) DEFAULT NULL,
  `cTerm` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`cID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_info`
--

LOCK TABLES `course_info` WRITE;
/*!40000 ALTER TABLE `course_info` DISABLE KEYS */;
INSERT INTO `course_info` VALUES ('201801','经济学基础',3,'1'),('201802','计算机导论',4,'2');
/*!40000 ALTER TABLE `course_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `major_info`
--

DROP TABLE IF EXISTS `major_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `major_info` (
  `mID` smallint(6) NOT NULL,
  `mName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`mID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `major_info`
--

LOCK TABLES `major_info` WRITE;
/*!40000 ALTER TABLE `major_info` DISABLE KEYS */;
INSERT INTO `major_info` VALUES (17,'经济'),(21,'计算机'),(29,'哲学');
/*!40000 ALTER TABLE `major_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `sInfo`
--

DROP TABLE IF EXISTS `sInfo`;
/*!50001 DROP VIEW IF EXISTS `sInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `sInfo` AS SELECT 
 1 AS `sID`,
 1 AS `mID`,
 1 AS `sName`,
 1 AS `sSex`,
 1 AS `sBirthday`,
 1 AS `sBirthplace`,
 1 AS `sCollege`,
 1 AS `sClass`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `sSC`
--

DROP TABLE IF EXISTS `sSC`;
/*!50001 DROP VIEW IF EXISTS `sSC`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `sSC` AS SELECT 
 1 AS `sID`,
 1 AS `cID`,
 1 AS `scScore`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `student_info`
--

DROP TABLE IF EXISTS `student_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `student_info` (
  `sID` varchar(20) NOT NULL,
  `mID` smallint(6) DEFAULT NULL,
  `sName` varchar(30) DEFAULT NULL,
  `sSex` varchar(10) DEFAULT NULL,
  `sBirthday` date DEFAULT NULL,
  `sBirthplace` varchar(50) DEFAULT NULL,
  `sCollege` varchar(60) DEFAULT NULL,
  `sClass` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`sID`),
  KEY `mID` (`mID`),
  CONSTRAINT `student_info_ibfk_1` FOREIGN KEY (`mID`) REFERENCES `major_info` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_info`
--

LOCK TABLES `student_info` WRITE;
/*!40000 ALTER TABLE `student_info` DISABLE KEYS */;
INSERT INTO `student_info` VALUES ('1001',17,'王伟','男','1999-09-09','广东','经济学院',1),('2001',21,'王芳','女','2000-10-01','北京','信息学院',1),('2002',21,'张伟','男','1996-05-01','上海','信息学院',2),('2003',21,'李勇','男','1997-07-01','天津','信息学院',2),('3001',29,'张静','女','1998-07-01','重庆','文学院',2);
/*!40000 ALTER TABLE `student_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `tInfo`
--

DROP TABLE IF EXISTS `tInfo`;
/*!50001 DROP VIEW IF EXISTS `tInfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `tInfo` AS SELECT 
 1 AS `tID`,
 1 AS `mID`,
 1 AS `tName`,
 1 AS `tSex`,
 1 AS `tCollege`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `teacher_info`
--

DROP TABLE IF EXISTS `teacher_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `teacher_info` (
  `tID` varchar(10) NOT NULL,
  `mID` smallint(6) DEFAULT NULL,
  `tName` varchar(30) DEFAULT NULL,
  `tSex` tinyint(4) DEFAULT NULL,
  `tCollege` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`tID`),
  KEY `mID` (`mID`),
  CONSTRAINT `teacher_info_ibfk_1` FOREIGN KEY (`mID`) REFERENCES `major_info` (`mid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teacher_info`
--

LOCK TABLES `teacher_info` WRITE;
/*!40000 ALTER TABLE `teacher_info` DISABLE KEYS */;
INSERT INTO `teacher_info` VALUES ('101',21,'赵老师',1,'信息学院'),('102',29,'钱老师',0,'文学院'),('103',29,'孙老师',0,'文学院');
/*!40000 ALTER TABLE `teacher_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_info`
--

DROP TABLE IF EXISTS `user_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user_info` (
  `uID` int(11) NOT NULL AUTO_INCREMENT,
  `uPass` varchar(100) DEFAULT NULL,
  `uIdentity` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`uID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_info`
--

LOCK TABLES `user_info` WRITE;
/*!40000 ALTER TABLE `user_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `sInfo`
--

/*!50001 DROP VIEW IF EXISTS `sInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`schoolAdmin`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `sInfo` AS select `student_info`.`sID` AS `sID`,`student_info`.`mID` AS `mID`,`student_info`.`sName` AS `sName`,`student_info`.`sSex` AS `sSex`,`student_info`.`sBirthday` AS `sBirthday`,`student_info`.`sBirthplace` AS `sBirthplace`,`student_info`.`sCollege` AS `sCollege`,`student_info`.`sClass` AS `sClass` from `student_info` where `student_info`.`sID` in (select substr(current_user(),8,4)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `sSC`
--

/*!50001 DROP VIEW IF EXISTS `sSC`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`schoolAdmin`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `sSC` AS select `SC`.`sID` AS `sID`,`SC`.`cID` AS `cID`,`SC`.`scScore` AS `scScore` from `SC` where `SC`.`sID` in (select substr(current_user(),8,4)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tInfo`
--

/*!50001 DROP VIEW IF EXISTS `tInfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`schoolAdmin`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `tInfo` AS select `teacher_info`.`tID` AS `tID`,`teacher_info`.`mID` AS `mID`,`teacher_info`.`tName` AS `tName`,`teacher_info`.`tSex` AS `tSex`,`teacher_info`.`tCollege` AS `tCollege` from `teacher_info` where `teacher_info`.`tID` in (select substr(current_user(),8,3)) */;
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

-- Dump completed on 2018-06-01 16:21:36
