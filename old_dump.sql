-- MySQL dump 10.13  Distrib 8.0.23, for macos10.15 (x86_64)
--
-- Host: localhost    Database: cfb_belt
-- ------------------------------------------------------
-- Server version	8.0.23

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
-- Table structure for table `Belt_Games`
--

DROP TABLE IF EXISTS `Belt_Games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Belt_Games` (
  `belt_game_id` int NOT NULL AUTO_INCREMENT,
  `belt` int NOT NULL,
  `champion` int NOT NULL,
  `game` int NOT NULL,
  PRIMARY KEY (`belt_game_id`),
  KEY `FK_Champion` (`champion`),
  KEY `FK_Belt_Game` (`game`),
  KEY `FK_Belt` (`belt`),
  CONSTRAINT `FK_Belt` FOREIGN KEY (`belt`) REFERENCES `Belts` (`belt_id`),
  CONSTRAINT `FK_Belt_Game` FOREIGN KEY (`game`) REFERENCES `Games` (`game_id`),
  CONSTRAINT `FK_Champion` FOREIGN KEY (`champion`) REFERENCES `Teams` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Belt_Games`
--

LOCK TABLES `Belt_Games` WRITE;
/*!40000 ALTER TABLE `Belt_Games` DISABLE KEYS */;
/*!40000 ALTER TABLE `Belt_Games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Belts`
--

DROP TABLE IF EXISTS `Belts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Belts` (
  `belt_id` int NOT NULL AUTO_INCREMENT,
  `belt_name` varchar(255) NOT NULL,
  `split_game` int DEFAULT NULL,
  `merge_game` int DEFAULT NULL,
  `split_parent` int DEFAULT NULL,
  `merge_child` int DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`belt_id`),
  KEY `FK_Split_Game` (`split_game`),
  KEY `FK_Merge_Game` (`merge_game`),
  KEY `FK_Merge_Child` (`merge_child`),
  KEY `FK_Split_Parent` (`split_parent`),
  CONSTRAINT `FK_Merge_Child` FOREIGN KEY (`merge_child`) REFERENCES `Belts` (`belt_id`),
  CONSTRAINT `FK_Merge_Game` FOREIGN KEY (`merge_game`) REFERENCES `Belt_Games` (`belt_game_id`),
  CONSTRAINT `FK_Split_Game` FOREIGN KEY (`split_game`) REFERENCES `Belt_Games` (`belt_game_id`),
  CONSTRAINT `FK_Split_Parent` FOREIGN KEY (`split_parent`) REFERENCES `Belts` (`belt_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Belts`
--

LOCK TABLES `Belts` WRITE;
/*!40000 ALTER TABLE `Belts` DISABLE KEYS */;
/*!40000 ALTER TABLE `Belts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Bowls`
--

DROP TABLE IF EXISTS `Bowls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bowls` (
  `bowl_id` int NOT NULL AUTO_INCREMENT,
  `bowl_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`bowl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bowls`
--

LOCK TABLES `Bowls` WRITE;
/*!40000 ALTER TABLE `Bowls` DISABLE KEYS */;
/*!40000 ALTER TABLE `Bowls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `games`
--

DROP TABLE IF EXISTS `games`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `games` (
  `game_id` int NOT NULL AUTO_INCREMENT,
  `game_date` date NOT NULL,
  `played_at` int NOT NULL,
  `home_team` int NOT NULL,
  `home_score` int NOT NULL,
  `away_team` int NOT NULL,
  `neutral_site` int DEFAULT NULL,
  `away_score` int DEFAULT NULL,
  PRIMARY KEY (`game_id`),
  KEY `FK_Game_Site` (`played_at`),
  KEY `FK_Neutral_Site` (`neutral_site`),
  KEY `FK_Home_Team` (`home_team`),
  KEY `FK_Away_Team` (`away_team`),
  CONSTRAINT `FK_Away_Team` FOREIGN KEY (`away_team`) REFERENCES `Teams` (`team_id`),
  CONSTRAINT `FK_Game_Site` FOREIGN KEY (`played_at`) REFERENCES `Venues` (`venue_id`),
  CONSTRAINT `FK_Home_Team` FOREIGN KEY (`home_team`) REFERENCES `Teams` (`team_id`),
  CONSTRAINT `FK_Neutral_Site` FOREIGN KEY (`neutral_site`) REFERENCES `Bowls` (`bowl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `games`
--

LOCK TABLES `games` WRITE;
/*!40000 ALTER TABLE `games` DISABLE KEYS */;
/*!40000 ALTER TABLE `games` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Secondary_Colors`
--

DROP TABLE IF EXISTS `Secondary_Colors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Secondary_Colors` (
  `color_id` int NOT NULL AUTO_INCREMENT,
  `team` int NOT NULL,
  `color` binary(3) NOT NULL,
  PRIMARY KEY (`color_id`),
  KEY `FK_Team_Add_Color` (`team`),
  CONSTRAINT `FK_Team_Add_Color` FOREIGN KEY (`team`) REFERENCES `Teams` (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Secondary_Colors`
--

LOCK TABLES `Secondary_Colors` WRITE;
/*!40000 ALTER TABLE `Secondary_Colors` DISABLE KEYS */;
/*!40000 ALTER TABLE `Secondary_Colors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Teams`
--

DROP TABLE IF EXISTS `Teams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Teams` (
  `team_id` int NOT NULL AUTO_INCREMENT,
  `uni_name` varchar(255) NOT NULL,
  `team_name` varchar(255) DEFAULT NULL,
  `primary_color` binary(3) NOT NULL,
  `short_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`team_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Teams`
--

LOCK TABLES `Teams` WRITE;
/*!40000 ALTER TABLE `Teams` DISABLE KEYS */;
/*!40000 ALTER TABLE `Teams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Venues`
--

DROP TABLE IF EXISTS `Venues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Venues` (
  `venue_id` int NOT NULL AUTO_INCREMENT,
  `stadium_name` varchar(255) NOT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `replaced` int DEFAULT NULL,
  `opened_date` date NOT NULL,
  PRIMARY KEY (`venue_id`),
  KEY `FK_Replaced_Venue` (`replaced`),
  CONSTRAINT `FK_Replaced_Venue` FOREIGN KEY (`replaced`) REFERENCES `Venues` (`venue_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Venues`
--

LOCK TABLES `Venues` WRITE;
/*!40000 ALTER TABLE `Venues` DISABLE KEYS */;
/*!40000 ALTER TABLE `Venues` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-08-15  9:36:26
