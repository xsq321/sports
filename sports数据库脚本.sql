-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: sports
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sportsname` varchar(45) NOT NULL,
  `itemname` varchar(45) NOT NULL,
  `place` varchar(45) NOT NULL,
  `startTime` datetime NOT NULL,
  `endTime` datetime NOT NULL,
  `type` varchar(45) DEFAULT '比赛项目',
  `max` int DEFAULT '100',
  `state` int DEFAULT '1',
  `scorer` varchar(45) DEFAULT 'scorer',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `itemname_UNIQUE` (`itemname`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='项目列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (26,'第一届运动会','男子100米','田径场跑道','2021-11-19 11:00:00','2021-11-19 12:00:00','比赛项目',100,1,'scorer'),(27,'第一届运动会','男子800米','田径跑道','2021-11-20 14:50:00','2021-11-20 15:50:00','比赛项目',100,1,'scorer'),(28,'第一届运动会','男子跳远','田径场跳远区','2021-11-19 13:30:00','2021-11-19 14:30:00','比赛项目',100,1,'scorer'),(29,'第一届运动会','男子跳高','田径场跳高区','2021-11-20 08:30:00','2021-11-20 09:30:00','比赛项目',100,1,'scorer'),(30,'第一届运动会','女子100米','田径场跑道','2021-11-19 10:00:00','2021-11-19 11:00:00','比赛项目',100,1,'scorer2'),(31,'第一届运动会','女子800米','田径场跑道','2021-11-20 13:50:00','2021-11-20 14:50:00','比赛项目',100,1,'scorer2'),(32,'第一届运动会','女子跳远','田径场跳远区','2021-11-20 09:30:00','2021-11-20 10:30:00','比赛项目',100,1,'scorer2'),(33,'第一届运动会','女子跳高','田径场跳高区','2021-11-19 14:30:00','2021-11-19 15:30:00','比赛项目',100,1,'scorer2');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `score`
--

DROP TABLE IF EXISTS `score`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `score` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `truename` varchar(45) NOT NULL,
  `sportsname` varchar(45) NOT NULL,
  `itemname` varchar(45) NOT NULL,
  `scorer` varchar(45) DEFAULT 'scorer',
  `score` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='成绩表，也可作为参赛信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `score`
--

LOCK TABLES `score` WRITE;
/*!40000 ALTER TABLE `score` DISABLE KEYS */;
INSERT INTO `score` VALUES (13,'0101','郑梓豪','第一届运动会','男子100米','scorer','13.2秒'),(14,'2203','陈江坤','第一届运动会','男子100米','scorer','14.8秒'),(15,'2502','曾英豪','第一届运动会','男子100米','scorer','14.9秒'),(16,'5804','裴宇成','第一届运动会','男子100米','scorer','12.8秒'),(17,'1703','陈铖','第一届运动会','男子100米','scorer','14.9秒'),(18,'1805','黄佳龙','第一届运动会','男子100米','scorer','15.3秒'),(19,'0202','陈祥鑫','第一届运动会','男子100米','scorer','14.4秒'),(20,'5510','张烨','第一届运动会','男子100米','scorer','12.7秒'),(21,'0903','曾耘韬','第一届运动会','男子800米','scorer','2分50.4秒'),(22,'2304','郑安宝','第一届运动会','男子800米','scorer','2分49秒'),(23,'5115','陈小思','第一届运动会','男子800米','scorer','3分01秒'),(24,'5607','郑智伟','第一届运动会','男子800米','scorer','3分03.5秒'),(25,'2104','陈丁豪','第一届运动会','男子800米','scorer','2分59.1秒'),(26,'5203','曹骏','第一届运动会','男子800米','scorer','2分22.5秒'),(27,'5306','张正','第一届运动会','男子800米','scorer','2分47.7秒'),(28,'5114','满国鑫','第一届运动会','男子800米','scorer','3分05.5秒'),(29,'9101','王志祥','第一届运动会','男子跳远','scorer','4.85米'),(30,'4401','杨捷','第一届运动会','男子跳远','scorer','4.93米'),(31,'5304','柯志勇','第一届运动会','男子跳远','scorer','5.35米'),(32,'0308','白宇楠','第一届运动会','男子跳远','scorer','5.12米'),(33,'5208','秋泽楠','第一届运动会','男子跳远','scorer','4.69米'),(34,'4301','林梓颜','第一届运动会','男子跳远','scorer','4.56米'),(35,'5503','陈宗煜','第一届运动会','男子跳远','scorer','4.79米'),(36,'5708','黄明勇','第一届运动会','男子跳远','scorer','5.59米'),(37,'5805','方铭瀚','第一届运动会','男子跳高','scorer','1.53米'),(38,'4303','唐扬铭','第一届运动会','男子跳高','scorer','1.47米'),(39,'5111','陈司哲','第一届运动会','男子跳高','scorer','1.42米'),(40,'2107','计泽强','第一届运动会','男子跳高','scorer','1.59米'),(41,'5611','游卫凤','第一届运动会','男子跳高','scorer','1.43米'),(42,'5203','曹骏','第一届运动会','男子跳高','scorer','1.65米'),(43,'1802','余国庆','第一届运动会','男子跳高','scorer','1.55米'),(44,'2507','林俊龙','第一届运动会','男子跳高','scorer','1.67米'),(45,'2110','吴荟霏','第一届运动会','女子100米','scorer2','22.5秒'),(46,'1709','王婉婷','第一届运动会','女子100米','scorer2','17.5秒'),(47,'4515','曾淑琪','第一届运动会','女子100米','scorer2','18.4,秒'),(48,'0608','方兴雨','第一届运动会','女子100米','scorer2','18.1秒'),(49,'3002','詹心莹','第一届运动会','女子100米','scorer2','15.3秒'),(50,'9502','吴艺环','第一届运动会','女子100米','scorer2','16.5秒'),(51,'2903','黄文洁','第一届运动会','女子100米','scorer2','16.6秒'),(52,'5313','周银茜','第一届运动会','女子100米','scorer2','17.2秒'),(53,'3110','彭开欣','第一届运动会','女子800米','scorer2','4分07.6秒'),(54,'0207','李秋霖','第一届运动会','女子800米','scorer2','2分57.6秒'),(55,'3704','邓钰雪','第一届运动会','女子800米','scorer2','4分04.2秒'),(56,'5810','谢琪婷','第一届运动会','女子800米','scorer2','3分05.5秒'),(57,'3814','马崔','第一届运动会','女子800米','scorer2','4分11.1秒'),(58,'2807','陈琳','第一届运动会','女子800米','scorer2','3分52.1秒'),(59,'3907','黄承欣','第一届运动会','女子800米','scorer2','4分04.6秒'),(60,'0209','郭雪芳','第一届运动会','女子800米','scorer2','3分53.5秒'),(61,'0913','康佳璇','第一届运动会','女子跳远','scorer2','3.10米'),(62,'1812','唐苑萍','第一届运动会','女子跳远','scorer2','3.02米'),(63,'2703','郑爱惠','第一届运动会','女子跳远','scorer2','3.04米'),(64,'2006','金紫怡','第一届运动会','女子跳远','scorer2','3.58米'),(65,'1010','吴彩霞','第一届运动会','女子跳远','scorer2','3.11米'),(66,'9111','陈思悦','第一届运动会','女子跳远','scorer2','2.80米'),(67,'1911','韦璇','第一届运动会','女子跳远','scorer2','2.95米'),(68,'1813','历祉熹','第一届运动会','女子跳远','scorer2','3.05米'),(69,'1205','叶列敏','第一届运动会','女子跳高','scorer2','1.05米'),(70,'1809','杨砾丹','第一届运动会','女子跳高','scorer2','1.05米'),(71,'3115','赖晓茹','第一届运动会','女子跳高','scorer2','1.28米'),(72,'1204',' 赖文倩','第一届运动会','女子跳高','scorer2','1.10米'),(73,'1811','王悦','第一届运动会','女子跳高','scorer2','1.05米'),(74,'9708','王梅芳','第一届运动会','女子跳高','scorer2','1.26米'),(75,'3611','郭淑婷','第一届运动会','女子跳高','scorer2','1.36米'),(76,'4309','张友霖','第一届运动会','女子跳高','scorer2','1.13米');
/*!40000 ALTER TABLE `score` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sports`
--

DROP TABLE IF EXISTS `sports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `sportsname` varchar(45) NOT NULL,
  `startTime` date NOT NULL,
  `endTime` date NOT NULL,
  `state` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `sportsname_UNIQUE` (`sportsname`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='运动会数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sports`
--

LOCK TABLES `sports` WRITE;
/*!40000 ALTER TABLE `sports` DISABLE KEYS */;
INSERT INTO `sports` VALUES (17,'第一届运动会','2021-11-19','2021-11-21',1);
/*!40000 ALTER TABLE `sports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `truename` varchar(45) DEFAULT '昵称',
  `user_pic` text,
  `rank` varchar(45) NOT NULL,
  `state` tinyint NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','123456','超级管理员',NULL,'超级管理员',1),(2,'scorer','jfy123456','记分员1',NULL,'记分员',1),(22,'scorer2','jfy123456','记分员2',NULL,'记分员',1),(25,'scorer3','jfy123456','记分员3',NULL,'记分员',1),(26,'player','ydy123456','运动员',NULL,'运动员',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-08  9:27:04
