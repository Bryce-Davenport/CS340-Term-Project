/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.27-MariaDB, for Linux (x86_64)
--
-- Host: classmysql.engr.oregonstate.edu    Database: cs340_armsjack
-- ------------------------------------------------------
-- Server version	10.11.11-MariaDB-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Customers`
--

DROP TABLE IF EXISTS `Customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Customers` (
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(355) NOT NULL,
  `streetAddress` varchar(255) NOT NULL,
  `phoneNumber` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customers`
--

LOCK TABLES `Customers` WRITE;
/*!40000 ALTER TABLE `Customers` DISABLE KEYS */;
INSERT INTO `Customers` VALUES (1,'jordan.miles42@example.com','St, Portland, OR 97232','5034217742'),(2,'emily.ross88@testmail.org','278 Oakway Rd, Eugene, OR 97401','5416859931'),(3,'carter.blake@fakemail.net','9015 SW Barbur Blvd, Portland, OR 97219','9713031185'),(4,'natalie.wren13@samplemail.com','415 River Rd, Medford, OR 97501','4582126790'),(5,'theo.jenkins21@mockinbox.io','1680 Commercial St SE, Salem, OR 97302','5037778402');
/*!40000 ALTER TABLE `Customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OrderItems`
--

DROP TABLE IF EXISTS `OrderItems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OrderItems` (
  `orderItemID` int(11) NOT NULL AUTO_INCREMENT,
  `quantity` int(11) NOT NULL,
  `Orders_orderID` int(11) NOT NULL,
  `Products_productID` int(11) NOT NULL,
  PRIMARY KEY (`orderItemID`),
  KEY `FK_OrderItems_orderID` (`Orders_orderID`),
  KEY `FK_OrderItems_productID` (`Products_productID`),
  CONSTRAINT `FK_OrderItems_orderID` FOREIGN KEY (`Orders_orderID`) REFERENCES `Orders` (`orderID`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `FK_OrderItems_productID` FOREIGN KEY (`Products_productID`) REFERENCES `Products` (`productID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OrderItems`
--

LOCK TABLES `OrderItems` WRITE;
/*!40000 ALTER TABLE `OrderItems` DISABLE KEYS */;
INSERT INTO `OrderItems` VALUES (1,1,1,101),(2,2,2,104),(3,1,2,102),(4,1,3,105);
/*!40000 ALTER TABLE `OrderItems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Orders`
--

DROP TABLE IF EXISTS `Orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Orders` (
  `orderID` int(11) NOT NULL AUTO_INCREMENT,
  `orderDate` date NOT NULL,
  `shippingAddress` varchar(255) NOT NULL,
  `orderTotal` decimal(10,2) NOT NULL,
  `Customers_customerID` int(11) NOT NULL,
  PRIMARY KEY (`orderID`),
  KEY `FK_Orders_customerID` (`Customers_customerID`),
  CONSTRAINT `FK_Orders_customerID` FOREIGN KEY (`Customers_customerID`) REFERENCES `Customers` (`customerID`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Orders`
--

LOCK TABLES `Orders` WRITE;
/*!40000 ALTER TABLE `Orders` DISABLE KEYS */;
INSERT INTO `Orders` VALUES (1,'2025-04-15','1342 NE Davis St, Portland, OR 97232',149.99,1),(2,'2025-04-17','1342 NE Davis St, Portland, OR 97232',89.50,1),(3,'2025-04-18','415 River Rd, Medford, OR 97501',249.75,4),(4,'2025-04-21','9015 SW Barbur Blvd, Portland, OR 97219',59.99,3);
/*!40000 ALTER TABLE `Orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Products`
--

DROP TABLE IF EXISTS `Products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Products` (
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `manufacturer` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  `productType` varchar(50) NOT NULL,
  `color` varchar(25) DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`productID`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Products`
--

LOCK TABLES `Products` WRITE;
/*!40000 ALTER TABLE `Products` DISABLE KEYS */;
INSERT INTO `Products` VALUES (101,'ASUS','ROG Strix G16','Laptop','Black',999.99),(102,'Dell','OptiPlex 7010','Desktop','Gray',749.00),(103,'Logitech','MX Master 3s','Mouse','Graphite',59.99),(104,'Keychron','K8 Pro','Keyboard','White Backlit',89.50),(105,'SanDisk','Extreme 8TB','SSD','Red/Black',139.00);
/*!40000 ALTER TABLE `Products` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-08 23:37:27
