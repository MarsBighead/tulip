-- MySQL dump 10.13  Distrib 5.6.26, for Linux (x86_64)
--
-- Host: localhost    Database: hg38
-- ------------------------------------------------------
-- Server version	5.6.26

--
-- Table structure for table `refGene`
--

DROP TABLE IF EXISTS `refGene`;

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


-- Dump completed on 2017-06-13 17:59:21
