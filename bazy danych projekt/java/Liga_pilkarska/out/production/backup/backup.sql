-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: liga_pilkarska
-- ------------------------------------------------------
-- Server version	5.7.19-log

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
-- Current Database: `liga_pilkarska`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `liga_pilkarska` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `liga_pilkarska`;

--
-- Table structure for table `gole`
--

DROP TABLE IF EXISTS `gole`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gole` (
  `Mecz` int(11) NOT NULL,
  `Zawodnik` int(11) NOT NULL,
  KEY `Mecz` (`Mecz`),
  KEY `Zawodnik` (`Zawodnik`),
  CONSTRAINT `gole_ibfk_1` FOREIGN KEY (`Mecz`) REFERENCES `mecze` (`Id`),
  CONSTRAINT `gole_ibfk_2` FOREIGN KEY (`Zawodnik`) REFERENCES `zawodnicy` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gole`
--

LOCK TABLES `gole` WRITE;
/*!40000 ALTER TABLE `gole` DISABLE KEYS */;
/*!40000 ALTER TABLE `gole` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger CzyMeczSieOdbylGole before insert on Gole
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `golesamobojcze`
--

DROP TABLE IF EXISTS `golesamobojcze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `golesamobojcze` (
  `Mecz` int(11) NOT NULL,
  `Zawodnik` int(11) NOT NULL,
  KEY `Mecz` (`Mecz`),
  KEY `Zawodnik` (`Zawodnik`),
  CONSTRAINT `golesamobojcze_ibfk_1` FOREIGN KEY (`Mecz`) REFERENCES `mecze` (`Id`),
  CONSTRAINT `golesamobojcze_ibfk_2` FOREIGN KEY (`Zawodnik`) REFERENCES `zawodnicy` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `golesamobojcze`
--

LOCK TABLES `golesamobojcze` WRITE;
/*!40000 ALTER TABLE `golesamobojcze` DISABLE KEYS */;
/*!40000 ALTER TABLE `golesamobojcze` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger CzyMeczSieOdbylGoleSamobojcze before insert on GoleSamobojcze
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `kartki`
--

DROP TABLE IF EXISTS `kartki`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kartki` (
  `Mecz` int(11) NOT NULL,
  `Zawodnik` int(11) NOT NULL,
  `Rodzaj` enum('zolta','czerwona') DEFAULT NULL,
  KEY `Mecz` (`Mecz`),
  KEY `Zawodnik` (`Zawodnik`),
  CONSTRAINT `kartki_ibfk_1` FOREIGN KEY (`Mecz`) REFERENCES `mecze` (`Id`),
  CONSTRAINT `kartki_ibfk_2` FOREIGN KEY (`Zawodnik`) REFERENCES `zawodnicy` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kartki`
--

LOCK TABLES `kartki` WRITE;
/*!40000 ALTER TABLE `kartki` DISABLE KEYS */;
/*!40000 ALTER TABLE `kartki` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger CzyMeczSieOdbylKartki before insert on Kartki
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    if ((Select count(*) from wystepyzawodnikow where mecz=new.mecz and zawodnik=new.Zawodnik and new.rodzaj='zolta')>1) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    if ((Select count(*) from wystepyzawodnikow where mecz=new.mecz and zawodnik=new.Zawodnik and new.rodzaj='zczerwona')>0) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end */;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger DodajZawieszenie1 after insert on Kartki
for each row
begin
	if (new.rodzaj = 'czerwona') then
		Insert into Zawieszenia values (new.Zawodnik, null , 'czerwona kartka');
    end if;
    if (new.rodzaj = 'zolta' and (select count(*) from Kartki where Mecz=new.Mecz and Zawodnik=new.Zawodnik and new.Rodzaj=Rodzaj)=2 ) then
		Insert into Zawieszenia values (new.Zawodnik, null , 'dwie zolte kartki');
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `mecze`
--

DROP TABLE IF EXISTS `mecze`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mecze` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Sezon` int(11) NOT NULL,
  `Kolejka` int(11) NOT NULL,
  `Data` date NOT NULL,
  `Gospodarz` int(11) NOT NULL,
  `Gosc` int(11) NOT NULL,
  `MeczSieOdbyl` enum('tak','nie') NOT NULL,
  `GoleGospodarza` int(11) DEFAULT NULL,
  `GoleGoscia` int(11) DEFAULT NULL,
  `PunktyGospodarza` int(11) DEFAULT NULL,
  `PunktyGoscia` int(11) DEFAULT NULL,
  `Walkower` enum('Gospodarz','Gosc','brak') DEFAULT NULL,
  `komentarz` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mecze`
--

LOCK TABLES `mecze` WRITE;
/*!40000 ALTER TABLE `mecze` DISABLE KEYS */;
/*!40000 ALTER TABLE `mecze` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger DodanieDoZespolMecz after insert on Mecze
for each row

begin
	insert into zespolmecz values (new.Gospodarz,new.Id,'Gospodarz');
    insert into zespolmecz values (new.Gosc,new.Id,'Gosc');
end */;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger OdbyteZawieszenieDlaMeczu after update on Mecze
for each row
begin
	if (new.MeczSieOdbyl='tak' and old.MeczSieOdbyl='nie') then
	update Zawieszenia set mecz=new.id where mecz is null and 
		zawodnik in (Select (Zawodnik) from zespolzawodnik where zespol in (Select zespol from zespolmecz where mecz=1 ) and  Datazakonczenia is null);
	
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `wystepyzawodnikow`
--

DROP TABLE IF EXISTS `wystepyzawodnikow`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wystepyzawodnikow` (
  `Mecz` int(11) NOT NULL,
  `Zawodnik` int(11) NOT NULL,
  KEY `Mecz` (`Mecz`),
  KEY `Zawodnik` (`Zawodnik`),
  CONSTRAINT `wystepyzawodnikow_ibfk_1` FOREIGN KEY (`Mecz`) REFERENCES `mecze` (`Id`),
  CONSTRAINT `wystepyzawodnikow_ibfk_2` FOREIGN KEY (`Zawodnik`) REFERENCES `zawodnicy` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wystepyzawodnikow`
--

LOCK TABLES `wystepyzawodnikow` WRITE;
/*!40000 ALTER TABLE `wystepyzawodnikow` DISABLE KEYS */;
/*!40000 ALTER TABLE `wystepyzawodnikow` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger CzyMeczSieOdbylWystepy before insert on wystepyzawodnikow
for each row
begin
	if not ((Select MeczSieOdbyl from mecze where new.mecz=id)='tak') then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    if ((Select count(*) from wystepyzawodnikow where mecz=new.mecz and zawodnik=new.Zawodnik)>0) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end */;;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger SprawdzZawieszenie1 after insert on wystepyzawodnikow
for each row
begin

	if (new.zawodnik in (select zawodnik from zawieszenia where mecz=new.mecz)) then
		if ((Select Zespol from zespolmecz where Mecz=new.Mecz and `gospodarz/gosc`='Gospodarz')
        =(Select Zespol from zespolzawodnik where zawodnik=new.zawodnik and  Datazakonczenia is null)) then
			update Mecze set Walkower='Gospodarz',
				komentarz='walkower',
                PunktyGospodarza=0,
                PunktyGoscia=3,
                GoleGospodarza=0,
                Golegoscia=3
                where Id=new.mecz;
		else
			update Mecze set Walkower='Gosc',
				komentarz='walkower',
                PunktyGospodarza=3,
                PunktyGoscia=0,
                GoleGospodarza=3,
                Golegoscia=0
                where Id=new.mecz;
		end if;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `zawieszenia`
--

DROP TABLE IF EXISTS `zawieszenia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zawieszenia` (
  `Zawodnik` int(11) NOT NULL,
  `Mecz` int(11) DEFAULT NULL,
  `Komentarz` varchar(50) DEFAULT NULL,
  KEY `Zawodnik` (`Zawodnik`),
  CONSTRAINT `zawieszenia_ibfk_1` FOREIGN KEY (`Zawodnik`) REFERENCES `zawodnicy` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zawieszenia`
--

LOCK TABLES `zawieszenia` WRITE;
/*!40000 ALTER TABLE `zawieszenia` DISABLE KEYS */;
/*!40000 ALTER TABLE `zawieszenia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zawodnicy`
--

DROP TABLE IF EXISTS `zawodnicy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zawodnicy` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Imie` varchar(30) NOT NULL,
  `Nazwisko` varchar(30) NOT NULL,
  `DataUrodzenia` date NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zawodnicy`
--

LOCK TABLES `zawodnicy` WRITE;
/*!40000 ALTER TABLE `zawodnicy` DISABLE KEYS */;
/*!40000 ALTER TABLE `zawodnicy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zespolmecz`
--

DROP TABLE IF EXISTS `zespolmecz`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zespolmecz` (
  `Zespol` int(11) NOT NULL,
  `Mecz` int(11) NOT NULL,
  `Gospodarz/Gosc` enum('Gospodarz','Gosc') DEFAULT NULL,
  KEY `Zespol` (`Zespol`),
  KEY `Mecz` (`Mecz`),
  CONSTRAINT `zespolmecz_ibfk_1` FOREIGN KEY (`Zespol`) REFERENCES `zespoly` (`Id`),
  CONSTRAINT `zespolmecz_ibfk_2` FOREIGN KEY (`Mecz`) REFERENCES `mecze` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zespolmecz`
--

LOCK TABLES `zespolmecz` WRITE;
/*!40000 ALTER TABLE `zespolmecz` DISABLE KEYS */;
/*!40000 ALTER TABLE `zespolmecz` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zespoly`
--

DROP TABLE IF EXISTS `zespoly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zespoly` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nazwa` varchar(30) NOT NULL,
  `Miejscowosc` varchar(30) NOT NULL,
  `ZapisanyDoSezonu` enum('tak','nie') NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zespoly`
--

LOCK TABLES `zespoly` WRITE;
/*!40000 ALTER TABLE `zespoly` DISABLE KEYS */;
/*!40000 ALTER TABLE `zespoly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `zespolzawodnik`
--

DROP TABLE IF EXISTS `zespolzawodnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `zespolzawodnik` (
  `Zespol` int(11) NOT NULL,
  `Zawodnik` int(11) NOT NULL,
  `DataRozpoczecia` date NOT NULL,
  `DataZakonczenia` date DEFAULT NULL,
  KEY `Zespol` (`Zespol`),
  KEY `Zawodnik` (`Zawodnik`),
  CONSTRAINT `zespolzawodnik_ibfk_1` FOREIGN KEY (`Zespol`) REFERENCES `zespoly` (`Id`),
  CONSTRAINT `zespolzawodnik_ibfk_2` FOREIGN KEY (`Zawodnik`) REFERENCES `zawodnicy` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `zespolzawodnik`
--

LOCK TABLES `zespolzawodnik` WRITE;
/*!40000 ALTER TABLE `zespolzawodnik` DISABLE KEYS */;
/*!40000 ALTER TABLE `zespolzawodnik` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger CzyMozePodpisacNowy before insert on zespolzawodnik
for each row

begin
	if ((Select count(*) from zespolzawodnik where zespolzawodnik.Zawodnik=new.zawodnik and Datazakonczenia is null) > 0) then 
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping routines for database 'liga_pilkarska'
--
/*!50003 DROP PROCEDURE IF EXISTS `StworzTerminarz` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `StworzTerminarz`(nowysezon int)
Begin
	declare done int default false;
    declare number,numberOfTeams,lastTeam,i,j,a,allRounds,helper,matchsInRound int;
    declare cursor1 cursor for (Select Id from zespoly where ZapisanyDoSezonu='tak'order by rand());
    
    declare continue handler
    for not found set done = 1;
    
    if ((Select count(*) from mecze where sezon=nowysezon) <> 0) then
		signal sqlstate '45000' set message_text = 'My Error Message';
    end if;
    
    create table tymczasowa (
    Id int not null auto_increment,
    zespol int not null,
    Primary key (Id)
    );
    open cursor1;
    read_loop:Loop
		fetch cursor1 into number;
        if done then
			leave read_loop;
        end if;
		insert into tymczasowa (zespol) values (number);
    end loop;
    set numberOfTeams = (Select count(Id) from zespoly where ZapisanyDoSezonu='tak');
    set lastTeam=0;
    if (numberOfTeams%2=0) then
		set lastTeam= (Select zespol from tymczasowa where Id=numberOfTeams); 
        set allRounds = 2* (numberOfTeams-1);
        set a=numberOfTeams-1;
        set matchsInRound=(numberOfTeams/2)-1;
	else
		set allRounds = 2* (numberOfTeams);
        set a=numberOfTeams;
        set matchsInRound=(numberOfTeams-1)/2;
    end if;
    set i=0;
    while (i<allRounds) do
		set j=1;
		while (j<(matchsInRound)+1) do
			if (i%2=0) then
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
					(Select zespol from tymczasowa where id=((i+j)%a+1)),
                    (Select zespol from tymczasowa where id=((a+i-j)%a+1)),'nie');
			else
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
                    (Select zespol from tymczasowa where id=((a+i-j)%a+1)),
					(Select zespol from tymczasowa where id=((i+j)%a+1)),'nie');
            end if;
			set j=j+1;
        end while;
        if not (lastTeam=0) then
			if (i%2=0) then
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
					(Select zespol from tymczasowa where id=((i)%a+1)),
                    lastTeam,'nie');
			else
				insert into mecze (Sezon,Kolejka,Data,Gospodarz,Gosc,MeczSieOdbyl) 
					values (nowysezon,i+1,date_Add(curdate(), interval 7*(i+1) day),
                    lastTeam,
					(Select zespol from tymczasowa where id=((i)%a+1)),'nie');
            end if;
        end if;
        
		set i = i +1;
    end while;
    
	Set @sez = convert(nowysezon,char(10));
    
    SET @s1 = concat('create view Strzelcy',@sez,' as 
    (Select im,naz,z, count(z) from 
	(Select mecze.id as me, mecze.sezon as s, gole.zawodnik as z, zawodnicy.imie as im, zawodnicy.nazwisko as naz
		from ((mecze join gole on mecze.id=gole.Mecz) join zawodnicy on gole.zawodnik=zawodnicy.id)) as t
    where s=',@sez,' group by z)') ; 
	
	PREPARE stmt1 FROM @s1; 
	EXECUTE stmt1 ; 
	DEALLOCATE PREPARE stmt1; 
    
    SET @s2 = concat('create view KartkiZolte',@sez,' as 
    (Select im,naz,z, count(z) from 
	(Select mecze.id as me, mecze.sezon as s, kartki.zawodnik as z, zawodnicy.imie as im, zawodnicy.nazwisko as naz
		from ((mecze join kartki on mecze.id=kartki.Mecz) join zawodnicy on kartki.zawodnik=zawodnicy.id)
        where kartki.rodzaj="zolta") as t
    where s=',@sez,' group by z)') ; 
	
	PREPARE stmt2 FROM @s2; 
	EXECUTE stmt2 ; 
	DEALLOCATE PREPARE stmt2; 
    
    SET @s3 = concat('create view KartkiCzerwone',@sez,' as 
    (Select im,naz,z, count(z) from 
	(Select mecze.id as me, mecze.sezon as s, kartki.zawodnik as z, zawodnicy.imie as im, zawodnicy.nazwisko as naz
		from ((mecze join kartki on mecze.id=kartki.Mecz) join zawodnicy on kartki.zawodnik=zawodnicy.id)
        where kartki.rodzaj="czerwona") as t
    where s=',@sez,' group by z)') ; 
	
	PREPARE stmt3 FROM @s3; 
	EXECUTE stmt3 ; 
	DEALLOCATE PREPARE stmt3;
    
    create view view1 as
    select zespolmecz.Meczas m, `zespolmecz.Gospodarz/Gosc` as gg, zespoly.Nazwa as nazwa
    from zespolmecz join zespoly on zespolmecz.zespol=zespol.id;
    
    
    
    Select * from tymczasowa;
    drop table tymczasowa;
    
end ;;
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

-- Dump completed on 2018-01-12 16:50:49
