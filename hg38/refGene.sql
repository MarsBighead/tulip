-- MySQL dump 10.13  Distrib 5.6.26, for Linux (x86_64)
--
-- Host: localhost    Database: hg38
-- ------------------------------------------------------
-- Server version	5.6.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `refGene`
--

DROP TABLE IF EXISTS `refGene`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `refGene` (
  `bin` smallint(5) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `chrom` varchar(255) NOT NULL,
  `strand` char(1) NOT NULL,
  `txStart` int(10) unsigned NOT NULL,
  `txEnd` int(10) unsigned NOT NULL,
  `cdsStart` int(10) unsigned NOT NULL,
  `cdsEnd` int(10) unsigned NOT NULL,
  `exonCount` int(10) unsigned NOT NULL,
  `exonStarts` longblob NOT NULL,
  `exonEnds` longblob NOT NULL,
  `score` int(11) DEFAULT NULL,
  `name2` varchar(255) NOT NULL,
  `cdsStartStat` enum('none','unk','incmpl','cmpl') NOT NULL,
  `cdsEndStat` enum('none','unk','incmpl','cmpl') NOT NULL,
  `exonFrames` longblob NOT NULL,
  KEY `chrom` (`chrom`,`bin`),
  KEY `name` (`name`),
  KEY `name2` (`name2`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-06-13 17:59:21
