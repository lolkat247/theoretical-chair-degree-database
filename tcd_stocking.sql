/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19-11.4.10-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: 127.0.0.1    Database: tcd_stocking
-- ------------------------------------------------------
-- Server version	11.4.10-MariaDB-ubu2404

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*M!100616 SET @OLD_NOTE_VERBOSITY=@@NOTE_VERBOSITY, NOTE_VERBOSITY=0 */;

--
-- Table structure for table `Bakery`
--

DROP TABLE IF EXISTS `Bakery`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Bakery` (
  `product_id` int(10) unsigned NOT NULL,
  `is_gluten_free` tinyint(1) NOT NULL DEFAULT 0,
  `shelf_life_days` int(10) unsigned DEFAULT NULL,
  `contains_nuts` tinyint(1) NOT NULL DEFAULT 0,
  `serving_size` varchar(50) DEFAULT NULL,
  `bake_date` date DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_bakery_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Bakery`
--

LOCK TABLES `Bakery` WRITE;
/*!40000 ALTER TABLE `Bakery` DISABLE KEYS */;
INSERT INTO `Bakery` VALUES
(56,0,14,0,'2 biscuits','2025-04-20'),
(57,0,3,0,'1 loaf','2025-04-25'),
(58,0,21,1,'2 biscuits','2025-04-20'),
(59,0,3,0,'1 loaf','2025-04-25'),
(60,0,4,0,'1 loaf','2025-04-24'),
(61,0,2,0,'1 pastry','2025-04-26'),
(62,0,5,0,'1 bagel','2025-04-24'),
(63,0,4,0,'1 muffin','2025-04-25'),
(64,0,2,0,'1 donut','2025-04-26'),
(65,0,1,1,'1 roll','2025-04-26'),
(66,0,2,0,'1 loaf','2025-04-25'),
(67,0,3,0,'1 loaf','2025-04-24'),
(68,0,2,0,'1 loaf','2025-04-25'),
(69,0,14,1,'1 cookie','2025-04-20'),
(70,0,2,1,'1 pastry','2025-04-26');
/*!40000 ALTER TABLE `Bakery` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_bakery_disjoint_ins BEFORE INSERT ON Bakery
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Bakery' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Bakery';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_bakery_disjoint_upd BEFORE UPDATE ON Bakery
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Bakery' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Bakery';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Customer`
--

DROP TABLE IF EXISTS `Customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Customer` (
  `customer_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(60) NOT NULL,
  `last_name` varchar(60) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(60) DEFAULT NULL,
  `zip_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=532 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES
(1,'Alice','Johnson','alice.johnson@email.com','555-1001','123 Main St','Pittsburgh','PA','15213'),
(2,'Bob','Smith','bob.smith@email.com','555-1002','456 Oak Ave','Los Angeles','CA','90001'),
(3,'Carol','Williams','carol.williams@email.com','555-1003','789 Pine Rd','Chicago','IL','60601'),
(4,'David','Brown','david.brown@email.com','555-1004','321 Elm St','Houston','TX','77001'),
(5,'Emma','Davis','emma.davis@email.com','555-1005','654 Maple Dr','Phoenix','AZ','85001'),
(6,'Frank','Miller','frank.miller@email.com','555-1006','987 Cedar Ln','Philadelphia','PA','19101'),
(7,'Grace','Wilson','grace.wilson@email.com','555-1007','147 Birch Ct','San Antonio','TX','78201'),
(8,'Henry','Moore','henry.moore@email.com','555-1008','258 Ash Blvd','San Diego','CA','92101'),
(9,'Iris','Taylor','iris.taylor@email.com','555-1009','369 Willow Way','Dallas','TX','75201'),
(10,'Jack','Anderson','jack.anderson@email.com','555-1010','741 Spruce St','San Jose','CA','95101'),
(11,'Karen','Thomas','karen.thomas@email.com','555-1011','852 Hemlock Ave','Pittsburgh','PA','15213'),
(12,'Larry','Jackson','larry.jackson@email.com','555-1012','963 Laurel Rd','Los Angeles','CA','90001'),
(13,'Michelle','White','michelle.white@email.com','555-1013','159 Dogwood Dr','Chicago','IL','60601'),
(14,'Nathan','Harris','nathan.harris@email.com','555-1014','357 Sycamore Ln','Houston','TX','77001'),
(15,'Olivia','Martin','olivia.martin@email.com','555-1015','486 Walnut St','Phoenix','AZ','85001'),
(16,'Peter','Lee','peter.lee@email.com','555-1016','912 Hickory Ct','Philadelphia','PA','19101'),
(17,'Quinn','Perez','quinn.perez@email.com','555-1017','135 Chestnut Way','San Antonio','TX','78201'),
(18,'Rachel','Roberts','rachel.roberts@email.com','555-1018','246 Cottonwood Ave','San Diego','CA','92101'),
(19,'Steven','Phillips','steven.phillips@email.com','555-1019','357 Juniper Blvd','Dallas','TX','75201'),
(20,'Tina','Campbell','tina.campbell@email.com','555-1020','468 Magnolia Rd','San Jose','CA','95101'),
(21,'Generated21','Customer21','generated.customer21@example.com','555-0021','21 Project Data Ave','Chicago','IL','90021'),
(22,'Generated22','Customer22','generated.customer22@example.com','555-0022','22 Project Data Ave','Houston','TX','90022'),
(23,'Generated23','Customer23','generated.customer23@example.com','555-0023','23 Project Data Ave','Phoenix','AZ','90023'),
(24,'Generated24','Customer24','generated.customer24@example.com','555-0024','24 Project Data Ave','Miami','FL','90024'),
(25,'Generated25','Customer25','generated.customer25@example.com','555-0025','25 Project Data Ave','Los Angeles','CA','90025'),
(26,'Generated26','Customer26','generated.customer26@example.com','555-0026','26 Project Data Ave','Chicago','IL','90026'),
(27,'Generated27','Customer27','generated.customer27@example.com','555-0027','27 Project Data Ave','Houston','TX','90027'),
(28,'Generated28','Customer28','generated.customer28@example.com','555-0028','28 Project Data Ave','Phoenix','AZ','90028'),
(29,'Generated29','Customer29','generated.customer29@example.com','555-0029','29 Project Data Ave','Miami','FL','90029'),
(30,'Generated30','Customer30','generated.customer30@example.com','555-0030','30 Project Data Ave','Los Angeles','CA','90030'),
(31,'Generated31','Customer31','generated.customer31@example.com','555-0031','31 Project Data Ave','Chicago','IL','90031'),
(32,'Generated32','Customer32','generated.customer32@example.com','555-0032','32 Project Data Ave','Houston','TX','90032'),
(33,'Generated33','Customer33','generated.customer33@example.com','555-0033','33 Project Data Ave','Phoenix','AZ','90033'),
(34,'Generated34','Customer34','generated.customer34@example.com','555-0034','34 Project Data Ave','Miami','FL','90034'),
(35,'Generated35','Customer35','generated.customer35@example.com','555-0035','35 Project Data Ave','Los Angeles','CA','90035'),
(36,'Generated36','Customer36','generated.customer36@example.com','555-0036','36 Project Data Ave','Chicago','IL','90036'),
(37,'Generated37','Customer37','generated.customer37@example.com','555-0037','37 Project Data Ave','Houston','TX','90037'),
(38,'Generated38','Customer38','generated.customer38@example.com','555-0038','38 Project Data Ave','Phoenix','AZ','90038'),
(39,'Generated39','Customer39','generated.customer39@example.com','555-0039','39 Project Data Ave','Miami','FL','90039'),
(40,'Generated40','Customer40','generated.customer40@example.com','555-0040','40 Project Data Ave','Los Angeles','CA','90040'),
(41,'Generated41','Customer41','generated.customer41@example.com','555-0041','41 Project Data Ave','Chicago','IL','90041'),
(42,'Generated42','Customer42','generated.customer42@example.com','555-0042','42 Project Data Ave','Houston','TX','90042'),
(43,'Generated43','Customer43','generated.customer43@example.com','555-0043','43 Project Data Ave','Phoenix','AZ','90043'),
(44,'Generated44','Customer44','generated.customer44@example.com','555-0044','44 Project Data Ave','Miami','FL','90044'),
(45,'Generated45','Customer45','generated.customer45@example.com','555-0045','45 Project Data Ave','Los Angeles','CA','90045'),
(46,'Generated46','Customer46','generated.customer46@example.com','555-0046','46 Project Data Ave','Chicago','IL','90046'),
(47,'Generated47','Customer47','generated.customer47@example.com','555-0047','47 Project Data Ave','Houston','TX','90047'),
(48,'Generated48','Customer48','generated.customer48@example.com','555-0048','48 Project Data Ave','Phoenix','AZ','90048'),
(49,'Generated49','Customer49','generated.customer49@example.com','555-0049','49 Project Data Ave','Miami','FL','90049'),
(50,'Generated50','Customer50','generated.customer50@example.com','555-0050','50 Project Data Ave','Los Angeles','CA','90050'),
(51,'Generated51','Customer51','generated.customer51@example.com','555-0051','51 Project Data Ave','Chicago','IL','90051'),
(52,'Generated52','Customer52','generated.customer52@example.com','555-0052','52 Project Data Ave','Houston','TX','90052'),
(53,'Generated53','Customer53','generated.customer53@example.com','555-0053','53 Project Data Ave','Phoenix','AZ','90053'),
(54,'Generated54','Customer54','generated.customer54@example.com','555-0054','54 Project Data Ave','Miami','FL','90054'),
(55,'Generated55','Customer55','generated.customer55@example.com','555-0055','55 Project Data Ave','Los Angeles','CA','90055'),
(56,'Generated56','Customer56','generated.customer56@example.com','555-0056','56 Project Data Ave','Chicago','IL','90056'),
(57,'Generated57','Customer57','generated.customer57@example.com','555-0057','57 Project Data Ave','Houston','TX','90057'),
(58,'Generated58','Customer58','generated.customer58@example.com','555-0058','58 Project Data Ave','Phoenix','AZ','90058'),
(59,'Generated59','Customer59','generated.customer59@example.com','555-0059','59 Project Data Ave','Miami','FL','90059'),
(60,'Generated60','Customer60','generated.customer60@example.com','555-0060','60 Project Data Ave','Los Angeles','CA','90060'),
(61,'Generated61','Customer61','generated.customer61@example.com','555-0061','61 Project Data Ave','Chicago','IL','90061'),
(62,'Generated62','Customer62','generated.customer62@example.com','555-0062','62 Project Data Ave','Houston','TX','90062'),
(63,'Generated63','Customer63','generated.customer63@example.com','555-0063','63 Project Data Ave','Phoenix','AZ','90063'),
(64,'Generated64','Customer64','generated.customer64@example.com','555-0064','64 Project Data Ave','Miami','FL','90064'),
(65,'Generated65','Customer65','generated.customer65@example.com','555-0065','65 Project Data Ave','Los Angeles','CA','90065'),
(66,'Generated66','Customer66','generated.customer66@example.com','555-0066','66 Project Data Ave','Chicago','IL','90066'),
(67,'Generated67','Customer67','generated.customer67@example.com','555-0067','67 Project Data Ave','Houston','TX','90067'),
(68,'Generated68','Customer68','generated.customer68@example.com','555-0068','68 Project Data Ave','Phoenix','AZ','90068'),
(69,'Generated69','Customer69','generated.customer69@example.com','555-0069','69 Project Data Ave','Miami','FL','90069'),
(70,'Generated70','Customer70','generated.customer70@example.com','555-0070','70 Project Data Ave','Los Angeles','CA','90070'),
(71,'Generated71','Customer71','generated.customer71@example.com','555-0071','71 Project Data Ave','Chicago','IL','90071'),
(72,'Generated72','Customer72','generated.customer72@example.com','555-0072','72 Project Data Ave','Houston','TX','90072'),
(73,'Generated73','Customer73','generated.customer73@example.com','555-0073','73 Project Data Ave','Phoenix','AZ','90073'),
(74,'Generated74','Customer74','generated.customer74@example.com','555-0074','74 Project Data Ave','Miami','FL','90074'),
(75,'Generated75','Customer75','generated.customer75@example.com','555-0075','75 Project Data Ave','Los Angeles','CA','90075'),
(76,'Generated76','Customer76','generated.customer76@example.com','555-0076','76 Project Data Ave','Chicago','IL','90076'),
(77,'Generated77','Customer77','generated.customer77@example.com','555-0077','77 Project Data Ave','Houston','TX','90077'),
(78,'Generated78','Customer78','generated.customer78@example.com','555-0078','78 Project Data Ave','Phoenix','AZ','90078'),
(79,'Generated79','Customer79','generated.customer79@example.com','555-0079','79 Project Data Ave','Miami','FL','90079'),
(80,'Generated80','Customer80','generated.customer80@example.com','555-0080','80 Project Data Ave','Los Angeles','CA','90080'),
(81,'Generated81','Customer81','generated.customer81@example.com','555-0081','81 Project Data Ave','Chicago','IL','90081'),
(82,'Generated82','Customer82','generated.customer82@example.com','555-0082','82 Project Data Ave','Houston','TX','90082'),
(83,'Generated83','Customer83','generated.customer83@example.com','555-0083','83 Project Data Ave','Phoenix','AZ','90083'),
(84,'Generated84','Customer84','generated.customer84@example.com','555-0084','84 Project Data Ave','Miami','FL','90084'),
(85,'Generated85','Customer85','generated.customer85@example.com','555-0085','85 Project Data Ave','Los Angeles','CA','90085'),
(86,'Generated86','Customer86','generated.customer86@example.com','555-0086','86 Project Data Ave','Chicago','IL','90086'),
(87,'Generated87','Customer87','generated.customer87@example.com','555-0087','87 Project Data Ave','Houston','TX','90087'),
(88,'Generated88','Customer88','generated.customer88@example.com','555-0088','88 Project Data Ave','Phoenix','AZ','90088'),
(89,'Generated89','Customer89','generated.customer89@example.com','555-0089','89 Project Data Ave','Miami','FL','90089'),
(90,'Generated90','Customer90','generated.customer90@example.com','555-0090','90 Project Data Ave','Los Angeles','CA','90090'),
(91,'Generated91','Customer91','generated.customer91@example.com','555-0091','91 Project Data Ave','Chicago','IL','90091'),
(92,'Generated92','Customer92','generated.customer92@example.com','555-0092','92 Project Data Ave','Houston','TX','90092'),
(93,'Generated93','Customer93','generated.customer93@example.com','555-0093','93 Project Data Ave','Phoenix','AZ','90093'),
(94,'Generated94','Customer94','generated.customer94@example.com','555-0094','94 Project Data Ave','Miami','FL','90094'),
(95,'Generated95','Customer95','generated.customer95@example.com','555-0095','95 Project Data Ave','Los Angeles','CA','90095'),
(96,'Generated96','Customer96','generated.customer96@example.com','555-0096','96 Project Data Ave','Chicago','IL','90096'),
(97,'Generated97','Customer97','generated.customer97@example.com','555-0097','97 Project Data Ave','Houston','TX','90097'),
(98,'Generated98','Customer98','generated.customer98@example.com','555-0098','98 Project Data Ave','Phoenix','AZ','90098'),
(99,'Generated99','Customer99','generated.customer99@example.com','555-0099','99 Project Data Ave','Miami','FL','90099'),
(100,'Generated100','Customer100','generated.customer100@example.com','555-0100','100 Project Data Ave','Los Angeles','CA','90100'),
(101,'Generated101','Customer101','generated.customer101@example.com','555-0101','101 Project Data Ave','Chicago','IL','90101'),
(102,'Generated102','Customer102','generated.customer102@example.com','555-0102','102 Project Data Ave','Houston','TX','90102'),
(103,'Generated103','Customer103','generated.customer103@example.com','555-0103','103 Project Data Ave','Phoenix','AZ','90103'),
(104,'Generated104','Customer104','generated.customer104@example.com','555-0104','104 Project Data Ave','Miami','FL','90104'),
(105,'Generated105','Customer105','generated.customer105@example.com','555-0105','105 Project Data Ave','Los Angeles','CA','90105'),
(106,'Generated106','Customer106','generated.customer106@example.com','555-0106','106 Project Data Ave','Chicago','IL','90106'),
(107,'Generated107','Customer107','generated.customer107@example.com','555-0107','107 Project Data Ave','Houston','TX','90107'),
(108,'Generated108','Customer108','generated.customer108@example.com','555-0108','108 Project Data Ave','Phoenix','AZ','90108'),
(109,'Generated109','Customer109','generated.customer109@example.com','555-0109','109 Project Data Ave','Miami','FL','90109'),
(110,'Generated110','Customer110','generated.customer110@example.com','555-0110','110 Project Data Ave','Los Angeles','CA','90110'),
(111,'Generated111','Customer111','generated.customer111@example.com','555-0111','111 Project Data Ave','Chicago','IL','90111'),
(112,'Generated112','Customer112','generated.customer112@example.com','555-0112','112 Project Data Ave','Houston','TX','90112'),
(113,'Generated113','Customer113','generated.customer113@example.com','555-0113','113 Project Data Ave','Phoenix','AZ','90113'),
(114,'Generated114','Customer114','generated.customer114@example.com','555-0114','114 Project Data Ave','Miami','FL','90114'),
(115,'Generated115','Customer115','generated.customer115@example.com','555-0115','115 Project Data Ave','Los Angeles','CA','90115'),
(116,'Generated116','Customer116','generated.customer116@example.com','555-0116','116 Project Data Ave','Chicago','IL','90116'),
(117,'Generated117','Customer117','generated.customer117@example.com','555-0117','117 Project Data Ave','Houston','TX','90117'),
(118,'Generated118','Customer118','generated.customer118@example.com','555-0118','118 Project Data Ave','Phoenix','AZ','90118'),
(119,'Generated119','Customer119','generated.customer119@example.com','555-0119','119 Project Data Ave','Miami','FL','90119'),
(120,'Generated120','Customer120','generated.customer120@example.com','555-0120','120 Project Data Ave','Los Angeles','CA','90120'),
(121,'Generated121','Customer121','generated.customer121@example.com','555-0121','121 Project Data Ave','Chicago','IL','90121'),
(122,'Generated122','Customer122','generated.customer122@example.com','555-0122','122 Project Data Ave','Houston','TX','90122'),
(123,'Generated123','Customer123','generated.customer123@example.com','555-0123','123 Project Data Ave','Phoenix','AZ','90123'),
(124,'Generated124','Customer124','generated.customer124@example.com','555-0124','124 Project Data Ave','Miami','FL','90124'),
(125,'Generated125','Customer125','generated.customer125@example.com','555-0125','125 Project Data Ave','Los Angeles','CA','90125'),
(126,'Generated126','Customer126','generated.customer126@example.com','555-0126','126 Project Data Ave','Chicago','IL','90126'),
(127,'Generated127','Customer127','generated.customer127@example.com','555-0127','127 Project Data Ave','Houston','TX','90127'),
(128,'Generated128','Customer128','generated.customer128@example.com','555-0128','128 Project Data Ave','Phoenix','AZ','90128'),
(129,'Generated129','Customer129','generated.customer129@example.com','555-0129','129 Project Data Ave','Miami','FL','90129'),
(130,'Generated130','Customer130','generated.customer130@example.com','555-0130','130 Project Data Ave','Los Angeles','CA','90130'),
(131,'Generated131','Customer131','generated.customer131@example.com','555-0131','131 Project Data Ave','Chicago','IL','90131'),
(132,'Generated132','Customer132','generated.customer132@example.com','555-0132','132 Project Data Ave','Houston','TX','90132'),
(133,'Generated133','Customer133','generated.customer133@example.com','555-0133','133 Project Data Ave','Phoenix','AZ','90133'),
(134,'Generated134','Customer134','generated.customer134@example.com','555-0134','134 Project Data Ave','Miami','FL','90134'),
(135,'Generated135','Customer135','generated.customer135@example.com','555-0135','135 Project Data Ave','Los Angeles','CA','90135'),
(136,'Generated136','Customer136','generated.customer136@example.com','555-0136','136 Project Data Ave','Chicago','IL','90136'),
(137,'Generated137','Customer137','generated.customer137@example.com','555-0137','137 Project Data Ave','Houston','TX','90137'),
(138,'Generated138','Customer138','generated.customer138@example.com','555-0138','138 Project Data Ave','Phoenix','AZ','90138'),
(139,'Generated139','Customer139','generated.customer139@example.com','555-0139','139 Project Data Ave','Miami','FL','90139'),
(140,'Generated140','Customer140','generated.customer140@example.com','555-0140','140 Project Data Ave','Los Angeles','CA','90140'),
(141,'Generated141','Customer141','generated.customer141@example.com','555-0141','141 Project Data Ave','Chicago','IL','90141'),
(142,'Generated142','Customer142','generated.customer142@example.com','555-0142','142 Project Data Ave','Houston','TX','90142'),
(143,'Generated143','Customer143','generated.customer143@example.com','555-0143','143 Project Data Ave','Phoenix','AZ','90143'),
(144,'Generated144','Customer144','generated.customer144@example.com','555-0144','144 Project Data Ave','Miami','FL','90144'),
(145,'Generated145','Customer145','generated.customer145@example.com','555-0145','145 Project Data Ave','Los Angeles','CA','90145'),
(146,'Generated146','Customer146','generated.customer146@example.com','555-0146','146 Project Data Ave','Chicago','IL','90146'),
(147,'Generated147','Customer147','generated.customer147@example.com','555-0147','147 Project Data Ave','Houston','TX','90147'),
(148,'Generated148','Customer148','generated.customer148@example.com','555-0148','148 Project Data Ave','Phoenix','AZ','90148'),
(149,'Generated149','Customer149','generated.customer149@example.com','555-0149','149 Project Data Ave','Miami','FL','90149'),
(150,'Generated150','Customer150','generated.customer150@example.com','555-0150','150 Project Data Ave','Los Angeles','CA','90150'),
(151,'Generated151','Customer151','generated.customer151@example.com','555-0151','151 Project Data Ave','Chicago','IL','90151'),
(152,'Generated152','Customer152','generated.customer152@example.com','555-0152','152 Project Data Ave','Houston','TX','90152'),
(153,'Generated153','Customer153','generated.customer153@example.com','555-0153','153 Project Data Ave','Phoenix','AZ','90153'),
(154,'Generated154','Customer154','generated.customer154@example.com','555-0154','154 Project Data Ave','Miami','FL','90154'),
(155,'Generated155','Customer155','generated.customer155@example.com','555-0155','155 Project Data Ave','Los Angeles','CA','90155'),
(156,'Generated156','Customer156','generated.customer156@example.com','555-0156','156 Project Data Ave','Chicago','IL','90156'),
(157,'Generated157','Customer157','generated.customer157@example.com','555-0157','157 Project Data Ave','Houston','TX','90157'),
(158,'Generated158','Customer158','generated.customer158@example.com','555-0158','158 Project Data Ave','Phoenix','AZ','90158'),
(159,'Generated159','Customer159','generated.customer159@example.com','555-0159','159 Project Data Ave','Miami','FL','90159'),
(160,'Generated160','Customer160','generated.customer160@example.com','555-0160','160 Project Data Ave','Los Angeles','CA','90160'),
(161,'Generated161','Customer161','generated.customer161@example.com','555-0161','161 Project Data Ave','Chicago','IL','90161'),
(162,'Generated162','Customer162','generated.customer162@example.com','555-0162','162 Project Data Ave','Houston','TX','90162'),
(163,'Generated163','Customer163','generated.customer163@example.com','555-0163','163 Project Data Ave','Phoenix','AZ','90163'),
(164,'Generated164','Customer164','generated.customer164@example.com','555-0164','164 Project Data Ave','Miami','FL','90164'),
(165,'Generated165','Customer165','generated.customer165@example.com','555-0165','165 Project Data Ave','Los Angeles','CA','90165'),
(166,'Generated166','Customer166','generated.customer166@example.com','555-0166','166 Project Data Ave','Chicago','IL','90166'),
(167,'Generated167','Customer167','generated.customer167@example.com','555-0167','167 Project Data Ave','Houston','TX','90167'),
(168,'Generated168','Customer168','generated.customer168@example.com','555-0168','168 Project Data Ave','Phoenix','AZ','90168'),
(169,'Generated169','Customer169','generated.customer169@example.com','555-0169','169 Project Data Ave','Miami','FL','90169'),
(170,'Generated170','Customer170','generated.customer170@example.com','555-0170','170 Project Data Ave','Los Angeles','CA','90170'),
(171,'Generated171','Customer171','generated.customer171@example.com','555-0171','171 Project Data Ave','Chicago','IL','90171'),
(172,'Generated172','Customer172','generated.customer172@example.com','555-0172','172 Project Data Ave','Houston','TX','90172'),
(173,'Generated173','Customer173','generated.customer173@example.com','555-0173','173 Project Data Ave','Phoenix','AZ','90173'),
(174,'Generated174','Customer174','generated.customer174@example.com','555-0174','174 Project Data Ave','Miami','FL','90174'),
(175,'Generated175','Customer175','generated.customer175@example.com','555-0175','175 Project Data Ave','Los Angeles','CA','90175'),
(176,'Generated176','Customer176','generated.customer176@example.com','555-0176','176 Project Data Ave','Chicago','IL','90176'),
(177,'Generated177','Customer177','generated.customer177@example.com','555-0177','177 Project Data Ave','Houston','TX','90177'),
(178,'Generated178','Customer178','generated.customer178@example.com','555-0178','178 Project Data Ave','Phoenix','AZ','90178'),
(179,'Generated179','Customer179','generated.customer179@example.com','555-0179','179 Project Data Ave','Miami','FL','90179'),
(180,'Generated180','Customer180','generated.customer180@example.com','555-0180','180 Project Data Ave','Los Angeles','CA','90180'),
(181,'Generated181','Customer181','generated.customer181@example.com','555-0181','181 Project Data Ave','Chicago','IL','90181'),
(182,'Generated182','Customer182','generated.customer182@example.com','555-0182','182 Project Data Ave','Houston','TX','90182'),
(183,'Generated183','Customer183','generated.customer183@example.com','555-0183','183 Project Data Ave','Phoenix','AZ','90183'),
(184,'Generated184','Customer184','generated.customer184@example.com','555-0184','184 Project Data Ave','Miami','FL','90184'),
(185,'Generated185','Customer185','generated.customer185@example.com','555-0185','185 Project Data Ave','Los Angeles','CA','90185'),
(186,'Generated186','Customer186','generated.customer186@example.com','555-0186','186 Project Data Ave','Chicago','IL','90186'),
(187,'Generated187','Customer187','generated.customer187@example.com','555-0187','187 Project Data Ave','Houston','TX','90187'),
(188,'Generated188','Customer188','generated.customer188@example.com','555-0188','188 Project Data Ave','Phoenix','AZ','90188'),
(189,'Generated189','Customer189','generated.customer189@example.com','555-0189','189 Project Data Ave','Miami','FL','90189'),
(190,'Generated190','Customer190','generated.customer190@example.com','555-0190','190 Project Data Ave','Los Angeles','CA','90190'),
(191,'Generated191','Customer191','generated.customer191@example.com','555-0191','191 Project Data Ave','Chicago','IL','90191'),
(192,'Generated192','Customer192','generated.customer192@example.com','555-0192','192 Project Data Ave','Houston','TX','90192'),
(193,'Generated193','Customer193','generated.customer193@example.com','555-0193','193 Project Data Ave','Phoenix','AZ','90193'),
(194,'Generated194','Customer194','generated.customer194@example.com','555-0194','194 Project Data Ave','Miami','FL','90194'),
(195,'Generated195','Customer195','generated.customer195@example.com','555-0195','195 Project Data Ave','Los Angeles','CA','90195'),
(196,'Generated196','Customer196','generated.customer196@example.com','555-0196','196 Project Data Ave','Chicago','IL','90196'),
(197,'Generated197','Customer197','generated.customer197@example.com','555-0197','197 Project Data Ave','Houston','TX','90197'),
(198,'Generated198','Customer198','generated.customer198@example.com','555-0198','198 Project Data Ave','Phoenix','AZ','90198'),
(199,'Generated199','Customer199','generated.customer199@example.com','555-0199','199 Project Data Ave','Miami','FL','90199'),
(200,'Generated200','Customer200','generated.customer200@example.com','555-0200','200 Project Data Ave','Los Angeles','CA','90200'),
(201,'Generated201','Customer201','generated.customer201@example.com','555-0201','201 Project Data Ave','Chicago','IL','90201'),
(202,'Generated202','Customer202','generated.customer202@example.com','555-0202','202 Project Data Ave','Houston','TX','90202'),
(203,'Generated203','Customer203','generated.customer203@example.com','555-0203','203 Project Data Ave','Phoenix','AZ','90203'),
(204,'Generated204','Customer204','generated.customer204@example.com','555-0204','204 Project Data Ave','Miami','FL','90204'),
(205,'Generated205','Customer205','generated.customer205@example.com','555-0205','205 Project Data Ave','Los Angeles','CA','90205'),
(206,'Generated206','Customer206','generated.customer206@example.com','555-0206','206 Project Data Ave','Chicago','IL','90206'),
(207,'Generated207','Customer207','generated.customer207@example.com','555-0207','207 Project Data Ave','Houston','TX','90207'),
(208,'Generated208','Customer208','generated.customer208@example.com','555-0208','208 Project Data Ave','Phoenix','AZ','90208'),
(209,'Generated209','Customer209','generated.customer209@example.com','555-0209','209 Project Data Ave','Miami','FL','90209'),
(210,'Generated210','Customer210','generated.customer210@example.com','555-0210','210 Project Data Ave','Los Angeles','CA','90210'),
(211,'Generated211','Customer211','generated.customer211@example.com','555-0211','211 Project Data Ave','Chicago','IL','90211'),
(212,'Generated212','Customer212','generated.customer212@example.com','555-0212','212 Project Data Ave','Houston','TX','90212'),
(213,'Generated213','Customer213','generated.customer213@example.com','555-0213','213 Project Data Ave','Phoenix','AZ','90213'),
(214,'Generated214','Customer214','generated.customer214@example.com','555-0214','214 Project Data Ave','Miami','FL','90214'),
(215,'Generated215','Customer215','generated.customer215@example.com','555-0215','215 Project Data Ave','Los Angeles','CA','90215'),
(216,'Generated216','Customer216','generated.customer216@example.com','555-0216','216 Project Data Ave','Chicago','IL','90216'),
(217,'Generated217','Customer217','generated.customer217@example.com','555-0217','217 Project Data Ave','Houston','TX','90217'),
(218,'Generated218','Customer218','generated.customer218@example.com','555-0218','218 Project Data Ave','Phoenix','AZ','90218'),
(219,'Generated219','Customer219','generated.customer219@example.com','555-0219','219 Project Data Ave','Miami','FL','90219'),
(220,'Generated220','Customer220','generated.customer220@example.com','555-0220','220 Project Data Ave','Los Angeles','CA','90220'),
(221,'Generated221','Customer221','generated.customer221@example.com','555-0221','221 Project Data Ave','Chicago','IL','90221'),
(222,'Generated222','Customer222','generated.customer222@example.com','555-0222','222 Project Data Ave','Houston','TX','90222'),
(223,'Generated223','Customer223','generated.customer223@example.com','555-0223','223 Project Data Ave','Phoenix','AZ','90223'),
(224,'Generated224','Customer224','generated.customer224@example.com','555-0224','224 Project Data Ave','Miami','FL','90224'),
(225,'Generated225','Customer225','generated.customer225@example.com','555-0225','225 Project Data Ave','Los Angeles','CA','90225'),
(226,'Generated226','Customer226','generated.customer226@example.com','555-0226','226 Project Data Ave','Chicago','IL','90226'),
(227,'Generated227','Customer227','generated.customer227@example.com','555-0227','227 Project Data Ave','Houston','TX','90227'),
(228,'Generated228','Customer228','generated.customer228@example.com','555-0228','228 Project Data Ave','Phoenix','AZ','90228'),
(229,'Generated229','Customer229','generated.customer229@example.com','555-0229','229 Project Data Ave','Miami','FL','90229'),
(230,'Generated230','Customer230','generated.customer230@example.com','555-0230','230 Project Data Ave','Los Angeles','CA','90230'),
(231,'Generated231','Customer231','generated.customer231@example.com','555-0231','231 Project Data Ave','Chicago','IL','90231'),
(232,'Generated232','Customer232','generated.customer232@example.com','555-0232','232 Project Data Ave','Houston','TX','90232'),
(233,'Generated233','Customer233','generated.customer233@example.com','555-0233','233 Project Data Ave','Phoenix','AZ','90233'),
(234,'Generated234','Customer234','generated.customer234@example.com','555-0234','234 Project Data Ave','Miami','FL','90234'),
(235,'Generated235','Customer235','generated.customer235@example.com','555-0235','235 Project Data Ave','Los Angeles','CA','90235'),
(236,'Generated236','Customer236','generated.customer236@example.com','555-0236','236 Project Data Ave','Chicago','IL','90236'),
(237,'Generated237','Customer237','generated.customer237@example.com','555-0237','237 Project Data Ave','Houston','TX','90237'),
(238,'Generated238','Customer238','generated.customer238@example.com','555-0238','238 Project Data Ave','Phoenix','AZ','90238'),
(239,'Generated239','Customer239','generated.customer239@example.com','555-0239','239 Project Data Ave','Miami','FL','90239'),
(240,'Generated240','Customer240','generated.customer240@example.com','555-0240','240 Project Data Ave','Los Angeles','CA','90240'),
(241,'Generated241','Customer241','generated.customer241@example.com','555-0241','241 Project Data Ave','Chicago','IL','90241'),
(242,'Generated242','Customer242','generated.customer242@example.com','555-0242','242 Project Data Ave','Houston','TX','90242'),
(243,'Generated243','Customer243','generated.customer243@example.com','555-0243','243 Project Data Ave','Phoenix','AZ','90243'),
(244,'Generated244','Customer244','generated.customer244@example.com','555-0244','244 Project Data Ave','Miami','FL','90244'),
(245,'Generated245','Customer245','generated.customer245@example.com','555-0245','245 Project Data Ave','Los Angeles','CA','90245'),
(246,'Generated246','Customer246','generated.customer246@example.com','555-0246','246 Project Data Ave','Chicago','IL','90246'),
(247,'Generated247','Customer247','generated.customer247@example.com','555-0247','247 Project Data Ave','Houston','TX','90247'),
(248,'Generated248','Customer248','generated.customer248@example.com','555-0248','248 Project Data Ave','Phoenix','AZ','90248'),
(249,'Generated249','Customer249','generated.customer249@example.com','555-0249','249 Project Data Ave','Miami','FL','90249'),
(250,'Generated250','Customer250','generated.customer250@example.com','555-0250','250 Project Data Ave','Los Angeles','CA','90250'),
(251,'Generated251','Customer251','generated.customer251@example.com','555-0251','251 Project Data Ave','Chicago','IL','90251'),
(252,'Generated252','Customer252','generated.customer252@example.com','555-0252','252 Project Data Ave','Houston','TX','90252'),
(253,'Generated253','Customer253','generated.customer253@example.com','555-0253','253 Project Data Ave','Phoenix','AZ','90253'),
(254,'Generated254','Customer254','generated.customer254@example.com','555-0254','254 Project Data Ave','Miami','FL','90254'),
(255,'Generated255','Customer255','generated.customer255@example.com','555-0255','255 Project Data Ave','Los Angeles','CA','90255'),
(256,'Generated256','Customer256','generated.customer256@example.com','555-0256','256 Project Data Ave','Chicago','IL','90256'),
(257,'Generated257','Customer257','generated.customer257@example.com','555-0257','257 Project Data Ave','Houston','TX','90257'),
(258,'Generated258','Customer258','generated.customer258@example.com','555-0258','258 Project Data Ave','Phoenix','AZ','90258'),
(259,'Generated259','Customer259','generated.customer259@example.com','555-0259','259 Project Data Ave','Miami','FL','90259'),
(260,'Generated260','Customer260','generated.customer260@example.com','555-0260','260 Project Data Ave','Los Angeles','CA','90260'),
(261,'Generated261','Customer261','generated.customer261@example.com','555-0261','261 Project Data Ave','Chicago','IL','90261'),
(262,'Generated262','Customer262','generated.customer262@example.com','555-0262','262 Project Data Ave','Houston','TX','90262'),
(263,'Generated263','Customer263','generated.customer263@example.com','555-0263','263 Project Data Ave','Phoenix','AZ','90263'),
(264,'Generated264','Customer264','generated.customer264@example.com','555-0264','264 Project Data Ave','Miami','FL','90264'),
(265,'Generated265','Customer265','generated.customer265@example.com','555-0265','265 Project Data Ave','Los Angeles','CA','90265'),
(266,'Generated266','Customer266','generated.customer266@example.com','555-0266','266 Project Data Ave','Chicago','IL','90266'),
(267,'Generated267','Customer267','generated.customer267@example.com','555-0267','267 Project Data Ave','Houston','TX','90267'),
(268,'Generated268','Customer268','generated.customer268@example.com','555-0268','268 Project Data Ave','Phoenix','AZ','90268'),
(269,'Generated269','Customer269','generated.customer269@example.com','555-0269','269 Project Data Ave','Miami','FL','90269'),
(270,'Generated270','Customer270','generated.customer270@example.com','555-0270','270 Project Data Ave','Los Angeles','CA','90270'),
(271,'Generated271','Customer271','generated.customer271@example.com','555-0271','271 Project Data Ave','Chicago','IL','90271'),
(272,'Generated272','Customer272','generated.customer272@example.com','555-0272','272 Project Data Ave','Houston','TX','90272'),
(273,'Generated273','Customer273','generated.customer273@example.com','555-0273','273 Project Data Ave','Phoenix','AZ','90273'),
(274,'Generated274','Customer274','generated.customer274@example.com','555-0274','274 Project Data Ave','Miami','FL','90274'),
(275,'Generated275','Customer275','generated.customer275@example.com','555-0275','275 Project Data Ave','Los Angeles','CA','90275'),
(276,'Generated276','Customer276','generated.customer276@example.com','555-0276','276 Project Data Ave','Chicago','IL','90276'),
(277,'Generated277','Customer277','generated.customer277@example.com','555-0277','277 Project Data Ave','Houston','TX','90277'),
(278,'Generated278','Customer278','generated.customer278@example.com','555-0278','278 Project Data Ave','Phoenix','AZ','90278'),
(279,'Generated279','Customer279','generated.customer279@example.com','555-0279','279 Project Data Ave','Miami','FL','90279'),
(280,'Generated280','Customer280','generated.customer280@example.com','555-0280','280 Project Data Ave','Los Angeles','CA','90280'),
(281,'Generated281','Customer281','generated.customer281@example.com','555-0281','281 Project Data Ave','Chicago','IL','90281'),
(282,'Generated282','Customer282','generated.customer282@example.com','555-0282','282 Project Data Ave','Houston','TX','90282'),
(283,'Generated283','Customer283','generated.customer283@example.com','555-0283','283 Project Data Ave','Phoenix','AZ','90283'),
(284,'Generated284','Customer284','generated.customer284@example.com','555-0284','284 Project Data Ave','Miami','FL','90284'),
(285,'Generated285','Customer285','generated.customer285@example.com','555-0285','285 Project Data Ave','Los Angeles','CA','90285'),
(286,'Generated286','Customer286','generated.customer286@example.com','555-0286','286 Project Data Ave','Chicago','IL','90286'),
(287,'Generated287','Customer287','generated.customer287@example.com','555-0287','287 Project Data Ave','Houston','TX','90287'),
(288,'Generated288','Customer288','generated.customer288@example.com','555-0288','288 Project Data Ave','Phoenix','AZ','90288'),
(289,'Generated289','Customer289','generated.customer289@example.com','555-0289','289 Project Data Ave','Miami','FL','90289'),
(290,'Generated290','Customer290','generated.customer290@example.com','555-0290','290 Project Data Ave','Los Angeles','CA','90290'),
(291,'Generated291','Customer291','generated.customer291@example.com','555-0291','291 Project Data Ave','Chicago','IL','90291'),
(292,'Generated292','Customer292','generated.customer292@example.com','555-0292','292 Project Data Ave','Houston','TX','90292'),
(293,'Generated293','Customer293','generated.customer293@example.com','555-0293','293 Project Data Ave','Phoenix','AZ','90293'),
(294,'Generated294','Customer294','generated.customer294@example.com','555-0294','294 Project Data Ave','Miami','FL','90294'),
(295,'Generated295','Customer295','generated.customer295@example.com','555-0295','295 Project Data Ave','Los Angeles','CA','90295'),
(296,'Generated296','Customer296','generated.customer296@example.com','555-0296','296 Project Data Ave','Chicago','IL','90296'),
(297,'Generated297','Customer297','generated.customer297@example.com','555-0297','297 Project Data Ave','Houston','TX','90297'),
(298,'Generated298','Customer298','generated.customer298@example.com','555-0298','298 Project Data Ave','Phoenix','AZ','90298'),
(299,'Generated299','Customer299','generated.customer299@example.com','555-0299','299 Project Data Ave','Miami','FL','90299'),
(300,'Generated300','Customer300','generated.customer300@example.com','555-0300','300 Project Data Ave','Los Angeles','CA','90300'),
(301,'Generated301','Customer301','generated.customer301@example.com','555-0301','301 Project Data Ave','Chicago','IL','90301'),
(302,'Generated302','Customer302','generated.customer302@example.com','555-0302','302 Project Data Ave','Houston','TX','90302'),
(303,'Generated303','Customer303','generated.customer303@example.com','555-0303','303 Project Data Ave','Phoenix','AZ','90303'),
(304,'Generated304','Customer304','generated.customer304@example.com','555-0304','304 Project Data Ave','Miami','FL','90304'),
(305,'Generated305','Customer305','generated.customer305@example.com','555-0305','305 Project Data Ave','Los Angeles','CA','90305'),
(306,'Generated306','Customer306','generated.customer306@example.com','555-0306','306 Project Data Ave','Chicago','IL','90306'),
(307,'Generated307','Customer307','generated.customer307@example.com','555-0307','307 Project Data Ave','Houston','TX','90307'),
(308,'Generated308','Customer308','generated.customer308@example.com','555-0308','308 Project Data Ave','Phoenix','AZ','90308'),
(309,'Generated309','Customer309','generated.customer309@example.com','555-0309','309 Project Data Ave','Miami','FL','90309'),
(310,'Generated310','Customer310','generated.customer310@example.com','555-0310','310 Project Data Ave','Los Angeles','CA','90310'),
(311,'Generated311','Customer311','generated.customer311@example.com','555-0311','311 Project Data Ave','Chicago','IL','90311'),
(312,'Generated312','Customer312','generated.customer312@example.com','555-0312','312 Project Data Ave','Houston','TX','90312'),
(313,'Generated313','Customer313','generated.customer313@example.com','555-0313','313 Project Data Ave','Phoenix','AZ','90313'),
(314,'Generated314','Customer314','generated.customer314@example.com','555-0314','314 Project Data Ave','Miami','FL','90314'),
(315,'Generated315','Customer315','generated.customer315@example.com','555-0315','315 Project Data Ave','Los Angeles','CA','90315'),
(316,'Generated316','Customer316','generated.customer316@example.com','555-0316','316 Project Data Ave','Chicago','IL','90316'),
(317,'Generated317','Customer317','generated.customer317@example.com','555-0317','317 Project Data Ave','Houston','TX','90317'),
(318,'Generated318','Customer318','generated.customer318@example.com','555-0318','318 Project Data Ave','Phoenix','AZ','90318'),
(319,'Generated319','Customer319','generated.customer319@example.com','555-0319','319 Project Data Ave','Miami','FL','90319'),
(320,'Generated320','Customer320','generated.customer320@example.com','555-0320','320 Project Data Ave','Los Angeles','CA','90320'),
(321,'Generated321','Customer321','generated.customer321@example.com','555-0321','321 Project Data Ave','Chicago','IL','90321'),
(322,'Generated322','Customer322','generated.customer322@example.com','555-0322','322 Project Data Ave','Houston','TX','90322'),
(323,'Generated323','Customer323','generated.customer323@example.com','555-0323','323 Project Data Ave','Phoenix','AZ','90323'),
(324,'Generated324','Customer324','generated.customer324@example.com','555-0324','324 Project Data Ave','Miami','FL','90324'),
(325,'Generated325','Customer325','generated.customer325@example.com','555-0325','325 Project Data Ave','Los Angeles','CA','90325'),
(326,'Generated326','Customer326','generated.customer326@example.com','555-0326','326 Project Data Ave','Chicago','IL','90326'),
(327,'Generated327','Customer327','generated.customer327@example.com','555-0327','327 Project Data Ave','Houston','TX','90327'),
(328,'Generated328','Customer328','generated.customer328@example.com','555-0328','328 Project Data Ave','Phoenix','AZ','90328'),
(329,'Generated329','Customer329','generated.customer329@example.com','555-0329','329 Project Data Ave','Miami','FL','90329'),
(330,'Generated330','Customer330','generated.customer330@example.com','555-0330','330 Project Data Ave','Los Angeles','CA','90330'),
(331,'Generated331','Customer331','generated.customer331@example.com','555-0331','331 Project Data Ave','Chicago','IL','90331'),
(332,'Generated332','Customer332','generated.customer332@example.com','555-0332','332 Project Data Ave','Houston','TX','90332'),
(333,'Generated333','Customer333','generated.customer333@example.com','555-0333','333 Project Data Ave','Phoenix','AZ','90333'),
(334,'Generated334','Customer334','generated.customer334@example.com','555-0334','334 Project Data Ave','Miami','FL','90334'),
(335,'Generated335','Customer335','generated.customer335@example.com','555-0335','335 Project Data Ave','Los Angeles','CA','90335'),
(336,'Generated336','Customer336','generated.customer336@example.com','555-0336','336 Project Data Ave','Chicago','IL','90336'),
(337,'Generated337','Customer337','generated.customer337@example.com','555-0337','337 Project Data Ave','Houston','TX','90337'),
(338,'Generated338','Customer338','generated.customer338@example.com','555-0338','338 Project Data Ave','Phoenix','AZ','90338'),
(339,'Generated339','Customer339','generated.customer339@example.com','555-0339','339 Project Data Ave','Miami','FL','90339'),
(340,'Generated340','Customer340','generated.customer340@example.com','555-0340','340 Project Data Ave','Los Angeles','CA','90340'),
(341,'Generated341','Customer341','generated.customer341@example.com','555-0341','341 Project Data Ave','Chicago','IL','90341'),
(342,'Generated342','Customer342','generated.customer342@example.com','555-0342','342 Project Data Ave','Houston','TX','90342'),
(343,'Generated343','Customer343','generated.customer343@example.com','555-0343','343 Project Data Ave','Phoenix','AZ','90343'),
(344,'Generated344','Customer344','generated.customer344@example.com','555-0344','344 Project Data Ave','Miami','FL','90344'),
(345,'Generated345','Customer345','generated.customer345@example.com','555-0345','345 Project Data Ave','Los Angeles','CA','90345'),
(346,'Generated346','Customer346','generated.customer346@example.com','555-0346','346 Project Data Ave','Chicago','IL','90346'),
(347,'Generated347','Customer347','generated.customer347@example.com','555-0347','347 Project Data Ave','Houston','TX','90347'),
(348,'Generated348','Customer348','generated.customer348@example.com','555-0348','348 Project Data Ave','Phoenix','AZ','90348'),
(349,'Generated349','Customer349','generated.customer349@example.com','555-0349','349 Project Data Ave','Miami','FL','90349'),
(350,'Generated350','Customer350','generated.customer350@example.com','555-0350','350 Project Data Ave','Los Angeles','CA','90350'),
(351,'Generated351','Customer351','generated.customer351@example.com','555-0351','351 Project Data Ave','Chicago','IL','90351'),
(352,'Generated352','Customer352','generated.customer352@example.com','555-0352','352 Project Data Ave','Houston','TX','90352'),
(353,'Generated353','Customer353','generated.customer353@example.com','555-0353','353 Project Data Ave','Phoenix','AZ','90353'),
(354,'Generated354','Customer354','generated.customer354@example.com','555-0354','354 Project Data Ave','Miami','FL','90354'),
(355,'Generated355','Customer355','generated.customer355@example.com','555-0355','355 Project Data Ave','Los Angeles','CA','90355'),
(356,'Generated356','Customer356','generated.customer356@example.com','555-0356','356 Project Data Ave','Chicago','IL','90356'),
(357,'Generated357','Customer357','generated.customer357@example.com','555-0357','357 Project Data Ave','Houston','TX','90357'),
(358,'Generated358','Customer358','generated.customer358@example.com','555-0358','358 Project Data Ave','Phoenix','AZ','90358'),
(359,'Generated359','Customer359','generated.customer359@example.com','555-0359','359 Project Data Ave','Miami','FL','90359'),
(360,'Generated360','Customer360','generated.customer360@example.com','555-0360','360 Project Data Ave','Los Angeles','CA','90360'),
(361,'Generated361','Customer361','generated.customer361@example.com','555-0361','361 Project Data Ave','Chicago','IL','90361'),
(362,'Generated362','Customer362','generated.customer362@example.com','555-0362','362 Project Data Ave','Houston','TX','90362'),
(363,'Generated363','Customer363','generated.customer363@example.com','555-0363','363 Project Data Ave','Phoenix','AZ','90363'),
(364,'Generated364','Customer364','generated.customer364@example.com','555-0364','364 Project Data Ave','Miami','FL','90364'),
(365,'Generated365','Customer365','generated.customer365@example.com','555-0365','365 Project Data Ave','Los Angeles','CA','90365'),
(366,'Generated366','Customer366','generated.customer366@example.com','555-0366','366 Project Data Ave','Chicago','IL','90366'),
(367,'Generated367','Customer367','generated.customer367@example.com','555-0367','367 Project Data Ave','Houston','TX','90367'),
(368,'Generated368','Customer368','generated.customer368@example.com','555-0368','368 Project Data Ave','Phoenix','AZ','90368'),
(369,'Generated369','Customer369','generated.customer369@example.com','555-0369','369 Project Data Ave','Miami','FL','90369'),
(370,'Generated370','Customer370','generated.customer370@example.com','555-0370','370 Project Data Ave','Los Angeles','CA','90370'),
(371,'Generated371','Customer371','generated.customer371@example.com','555-0371','371 Project Data Ave','Chicago','IL','90371'),
(372,'Generated372','Customer372','generated.customer372@example.com','555-0372','372 Project Data Ave','Houston','TX','90372'),
(373,'Generated373','Customer373','generated.customer373@example.com','555-0373','373 Project Data Ave','Phoenix','AZ','90373'),
(374,'Generated374','Customer374','generated.customer374@example.com','555-0374','374 Project Data Ave','Miami','FL','90374'),
(375,'Generated375','Customer375','generated.customer375@example.com','555-0375','375 Project Data Ave','Los Angeles','CA','90375'),
(376,'Generated376','Customer376','generated.customer376@example.com','555-0376','376 Project Data Ave','Chicago','IL','90376'),
(377,'Generated377','Customer377','generated.customer377@example.com','555-0377','377 Project Data Ave','Houston','TX','90377'),
(378,'Generated378','Customer378','generated.customer378@example.com','555-0378','378 Project Data Ave','Phoenix','AZ','90378'),
(379,'Generated379','Customer379','generated.customer379@example.com','555-0379','379 Project Data Ave','Miami','FL','90379'),
(380,'Generated380','Customer380','generated.customer380@example.com','555-0380','380 Project Data Ave','Los Angeles','CA','90380'),
(381,'Generated381','Customer381','generated.customer381@example.com','555-0381','381 Project Data Ave','Chicago','IL','90381'),
(382,'Generated382','Customer382','generated.customer382@example.com','555-0382','382 Project Data Ave','Houston','TX','90382'),
(383,'Generated383','Customer383','generated.customer383@example.com','555-0383','383 Project Data Ave','Phoenix','AZ','90383'),
(384,'Generated384','Customer384','generated.customer384@example.com','555-0384','384 Project Data Ave','Miami','FL','90384'),
(385,'Generated385','Customer385','generated.customer385@example.com','555-0385','385 Project Data Ave','Los Angeles','CA','90385'),
(386,'Generated386','Customer386','generated.customer386@example.com','555-0386','386 Project Data Ave','Chicago','IL','90386'),
(387,'Generated387','Customer387','generated.customer387@example.com','555-0387','387 Project Data Ave','Houston','TX','90387'),
(388,'Generated388','Customer388','generated.customer388@example.com','555-0388','388 Project Data Ave','Phoenix','AZ','90388'),
(389,'Generated389','Customer389','generated.customer389@example.com','555-0389','389 Project Data Ave','Miami','FL','90389'),
(390,'Generated390','Customer390','generated.customer390@example.com','555-0390','390 Project Data Ave','Los Angeles','CA','90390'),
(391,'Generated391','Customer391','generated.customer391@example.com','555-0391','391 Project Data Ave','Chicago','IL','90391'),
(392,'Generated392','Customer392','generated.customer392@example.com','555-0392','392 Project Data Ave','Houston','TX','90392'),
(393,'Generated393','Customer393','generated.customer393@example.com','555-0393','393 Project Data Ave','Phoenix','AZ','90393'),
(394,'Generated394','Customer394','generated.customer394@example.com','555-0394','394 Project Data Ave','Miami','FL','90394'),
(395,'Generated395','Customer395','generated.customer395@example.com','555-0395','395 Project Data Ave','Los Angeles','CA','90395'),
(396,'Generated396','Customer396','generated.customer396@example.com','555-0396','396 Project Data Ave','Chicago','IL','90396'),
(397,'Generated397','Customer397','generated.customer397@example.com','555-0397','397 Project Data Ave','Houston','TX','90397'),
(398,'Generated398','Customer398','generated.customer398@example.com','555-0398','398 Project Data Ave','Phoenix','AZ','90398'),
(399,'Generated399','Customer399','generated.customer399@example.com','555-0399','399 Project Data Ave','Miami','FL','90399'),
(400,'Generated400','Customer400','generated.customer400@example.com','555-0400','400 Project Data Ave','Los Angeles','CA','90400'),
(401,'Generated401','Customer401','generated.customer401@example.com','555-0401','401 Project Data Ave','Chicago','IL','90401'),
(402,'Generated402','Customer402','generated.customer402@example.com','555-0402','402 Project Data Ave','Houston','TX','90402'),
(403,'Generated403','Customer403','generated.customer403@example.com','555-0403','403 Project Data Ave','Phoenix','AZ','90403'),
(404,'Generated404','Customer404','generated.customer404@example.com','555-0404','404 Project Data Ave','Miami','FL','90404'),
(405,'Generated405','Customer405','generated.customer405@example.com','555-0405','405 Project Data Ave','Los Angeles','CA','90405'),
(406,'Generated406','Customer406','generated.customer406@example.com','555-0406','406 Project Data Ave','Chicago','IL','90406'),
(407,'Generated407','Customer407','generated.customer407@example.com','555-0407','407 Project Data Ave','Houston','TX','90407'),
(408,'Generated408','Customer408','generated.customer408@example.com','555-0408','408 Project Data Ave','Phoenix','AZ','90408'),
(409,'Generated409','Customer409','generated.customer409@example.com','555-0409','409 Project Data Ave','Miami','FL','90409'),
(410,'Generated410','Customer410','generated.customer410@example.com','555-0410','410 Project Data Ave','Los Angeles','CA','90410'),
(411,'Generated411','Customer411','generated.customer411@example.com','555-0411','411 Project Data Ave','Chicago','IL','90411'),
(412,'Generated412','Customer412','generated.customer412@example.com','555-0412','412 Project Data Ave','Houston','TX','90412'),
(413,'Generated413','Customer413','generated.customer413@example.com','555-0413','413 Project Data Ave','Phoenix','AZ','90413'),
(414,'Generated414','Customer414','generated.customer414@example.com','555-0414','414 Project Data Ave','Miami','FL','90414'),
(415,'Generated415','Customer415','generated.customer415@example.com','555-0415','415 Project Data Ave','Los Angeles','CA','90415'),
(416,'Generated416','Customer416','generated.customer416@example.com','555-0416','416 Project Data Ave','Chicago','IL','90416'),
(417,'Generated417','Customer417','generated.customer417@example.com','555-0417','417 Project Data Ave','Houston','TX','90417'),
(418,'Generated418','Customer418','generated.customer418@example.com','555-0418','418 Project Data Ave','Phoenix','AZ','90418'),
(419,'Generated419','Customer419','generated.customer419@example.com','555-0419','419 Project Data Ave','Miami','FL','90419'),
(420,'Generated420','Customer420','generated.customer420@example.com','555-0420','420 Project Data Ave','Los Angeles','CA','90420'),
(421,'Generated421','Customer421','generated.customer421@example.com','555-0421','421 Project Data Ave','Chicago','IL','90421'),
(422,'Generated422','Customer422','generated.customer422@example.com','555-0422','422 Project Data Ave','Houston','TX','90422'),
(423,'Generated423','Customer423','generated.customer423@example.com','555-0423','423 Project Data Ave','Phoenix','AZ','90423'),
(424,'Generated424','Customer424','generated.customer424@example.com','555-0424','424 Project Data Ave','Miami','FL','90424'),
(425,'Generated425','Customer425','generated.customer425@example.com','555-0425','425 Project Data Ave','Los Angeles','CA','90425'),
(426,'Generated426','Customer426','generated.customer426@example.com','555-0426','426 Project Data Ave','Chicago','IL','90426'),
(427,'Generated427','Customer427','generated.customer427@example.com','555-0427','427 Project Data Ave','Houston','TX','90427'),
(428,'Generated428','Customer428','generated.customer428@example.com','555-0428','428 Project Data Ave','Phoenix','AZ','90428'),
(429,'Generated429','Customer429','generated.customer429@example.com','555-0429','429 Project Data Ave','Miami','FL','90429'),
(430,'Generated430','Customer430','generated.customer430@example.com','555-0430','430 Project Data Ave','Los Angeles','CA','90430'),
(431,'Generated431','Customer431','generated.customer431@example.com','555-0431','431 Project Data Ave','Chicago','IL','90431'),
(432,'Generated432','Customer432','generated.customer432@example.com','555-0432','432 Project Data Ave','Houston','TX','90432'),
(433,'Generated433','Customer433','generated.customer433@example.com','555-0433','433 Project Data Ave','Phoenix','AZ','90433'),
(434,'Generated434','Customer434','generated.customer434@example.com','555-0434','434 Project Data Ave','Miami','FL','90434'),
(435,'Generated435','Customer435','generated.customer435@example.com','555-0435','435 Project Data Ave','Los Angeles','CA','90435'),
(436,'Generated436','Customer436','generated.customer436@example.com','555-0436','436 Project Data Ave','Chicago','IL','90436'),
(437,'Generated437','Customer437','generated.customer437@example.com','555-0437','437 Project Data Ave','Houston','TX','90437'),
(438,'Generated438','Customer438','generated.customer438@example.com','555-0438','438 Project Data Ave','Phoenix','AZ','90438'),
(439,'Generated439','Customer439','generated.customer439@example.com','555-0439','439 Project Data Ave','Miami','FL','90439'),
(440,'Generated440','Customer440','generated.customer440@example.com','555-0440','440 Project Data Ave','Los Angeles','CA','90440'),
(441,'Generated441','Customer441','generated.customer441@example.com','555-0441','441 Project Data Ave','Chicago','IL','90441'),
(442,'Generated442','Customer442','generated.customer442@example.com','555-0442','442 Project Data Ave','Houston','TX','90442'),
(443,'Generated443','Customer443','generated.customer443@example.com','555-0443','443 Project Data Ave','Phoenix','AZ','90443'),
(444,'Generated444','Customer444','generated.customer444@example.com','555-0444','444 Project Data Ave','Miami','FL','90444'),
(445,'Generated445','Customer445','generated.customer445@example.com','555-0445','445 Project Data Ave','Los Angeles','CA','90445'),
(446,'Generated446','Customer446','generated.customer446@example.com','555-0446','446 Project Data Ave','Chicago','IL','90446'),
(447,'Generated447','Customer447','generated.customer447@example.com','555-0447','447 Project Data Ave','Houston','TX','90447'),
(448,'Generated448','Customer448','generated.customer448@example.com','555-0448','448 Project Data Ave','Phoenix','AZ','90448'),
(449,'Generated449','Customer449','generated.customer449@example.com','555-0449','449 Project Data Ave','Miami','FL','90449'),
(450,'Generated450','Customer450','generated.customer450@example.com','555-0450','450 Project Data Ave','Los Angeles','CA','90450'),
(451,'Generated451','Customer451','generated.customer451@example.com','555-0451','451 Project Data Ave','Chicago','IL','90451'),
(452,'Generated452','Customer452','generated.customer452@example.com','555-0452','452 Project Data Ave','Houston','TX','90452'),
(453,'Generated453','Customer453','generated.customer453@example.com','555-0453','453 Project Data Ave','Phoenix','AZ','90453'),
(454,'Generated454','Customer454','generated.customer454@example.com','555-0454','454 Project Data Ave','Miami','FL','90454'),
(455,'Generated455','Customer455','generated.customer455@example.com','555-0455','455 Project Data Ave','Los Angeles','CA','90455'),
(456,'Generated456','Customer456','generated.customer456@example.com','555-0456','456 Project Data Ave','Chicago','IL','90456'),
(457,'Generated457','Customer457','generated.customer457@example.com','555-0457','457 Project Data Ave','Houston','TX','90457'),
(458,'Generated458','Customer458','generated.customer458@example.com','555-0458','458 Project Data Ave','Phoenix','AZ','90458'),
(459,'Generated459','Customer459','generated.customer459@example.com','555-0459','459 Project Data Ave','Miami','FL','90459'),
(460,'Generated460','Customer460','generated.customer460@example.com','555-0460','460 Project Data Ave','Los Angeles','CA','90460'),
(461,'Generated461','Customer461','generated.customer461@example.com','555-0461','461 Project Data Ave','Chicago','IL','90461'),
(462,'Generated462','Customer462','generated.customer462@example.com','555-0462','462 Project Data Ave','Houston','TX','90462'),
(463,'Generated463','Customer463','generated.customer463@example.com','555-0463','463 Project Data Ave','Phoenix','AZ','90463'),
(464,'Generated464','Customer464','generated.customer464@example.com','555-0464','464 Project Data Ave','Miami','FL','90464'),
(465,'Generated465','Customer465','generated.customer465@example.com','555-0465','465 Project Data Ave','Los Angeles','CA','90465'),
(466,'Generated466','Customer466','generated.customer466@example.com','555-0466','466 Project Data Ave','Chicago','IL','90466'),
(467,'Generated467','Customer467','generated.customer467@example.com','555-0467','467 Project Data Ave','Houston','TX','90467'),
(468,'Generated468','Customer468','generated.customer468@example.com','555-0468','468 Project Data Ave','Phoenix','AZ','90468'),
(469,'Generated469','Customer469','generated.customer469@example.com','555-0469','469 Project Data Ave','Miami','FL','90469'),
(470,'Generated470','Customer470','generated.customer470@example.com','555-0470','470 Project Data Ave','Los Angeles','CA','90470'),
(471,'Generated471','Customer471','generated.customer471@example.com','555-0471','471 Project Data Ave','Chicago','IL','90471'),
(472,'Generated472','Customer472','generated.customer472@example.com','555-0472','472 Project Data Ave','Houston','TX','90472'),
(473,'Generated473','Customer473','generated.customer473@example.com','555-0473','473 Project Data Ave','Phoenix','AZ','90473'),
(474,'Generated474','Customer474','generated.customer474@example.com','555-0474','474 Project Data Ave','Miami','FL','90474'),
(475,'Generated475','Customer475','generated.customer475@example.com','555-0475','475 Project Data Ave','Los Angeles','CA','90475'),
(476,'Generated476','Customer476','generated.customer476@example.com','555-0476','476 Project Data Ave','Chicago','IL','90476'),
(477,'Generated477','Customer477','generated.customer477@example.com','555-0477','477 Project Data Ave','Houston','TX','90477'),
(478,'Generated478','Customer478','generated.customer478@example.com','555-0478','478 Project Data Ave','Phoenix','AZ','90478'),
(479,'Generated479','Customer479','generated.customer479@example.com','555-0479','479 Project Data Ave','Miami','FL','90479'),
(480,'Generated480','Customer480','generated.customer480@example.com','555-0480','480 Project Data Ave','Los Angeles','CA','90480'),
(481,'Generated481','Customer481','generated.customer481@example.com','555-0481','481 Project Data Ave','Chicago','IL','90481'),
(482,'Generated482','Customer482','generated.customer482@example.com','555-0482','482 Project Data Ave','Houston','TX','90482'),
(483,'Generated483','Customer483','generated.customer483@example.com','555-0483','483 Project Data Ave','Phoenix','AZ','90483'),
(484,'Generated484','Customer484','generated.customer484@example.com','555-0484','484 Project Data Ave','Miami','FL','90484'),
(485,'Generated485','Customer485','generated.customer485@example.com','555-0485','485 Project Data Ave','Los Angeles','CA','90485'),
(486,'Generated486','Customer486','generated.customer486@example.com','555-0486','486 Project Data Ave','Chicago','IL','90486'),
(487,'Generated487','Customer487','generated.customer487@example.com','555-0487','487 Project Data Ave','Houston','TX','90487'),
(488,'Generated488','Customer488','generated.customer488@example.com','555-0488','488 Project Data Ave','Phoenix','AZ','90488'),
(489,'Generated489','Customer489','generated.customer489@example.com','555-0489','489 Project Data Ave','Miami','FL','90489'),
(490,'Generated490','Customer490','generated.customer490@example.com','555-0490','490 Project Data Ave','Los Angeles','CA','90490'),
(491,'Generated491','Customer491','generated.customer491@example.com','555-0491','491 Project Data Ave','Chicago','IL','90491'),
(492,'Generated492','Customer492','generated.customer492@example.com','555-0492','492 Project Data Ave','Houston','TX','90492'),
(493,'Generated493','Customer493','generated.customer493@example.com','555-0493','493 Project Data Ave','Phoenix','AZ','90493'),
(494,'Generated494','Customer494','generated.customer494@example.com','555-0494','494 Project Data Ave','Miami','FL','90494'),
(495,'Generated495','Customer495','generated.customer495@example.com','555-0495','495 Project Data Ave','Los Angeles','CA','90495'),
(496,'Generated496','Customer496','generated.customer496@example.com','555-0496','496 Project Data Ave','Chicago','IL','90496'),
(497,'Generated497','Customer497','generated.customer497@example.com','555-0497','497 Project Data Ave','Houston','TX','90497'),
(498,'Generated498','Customer498','generated.customer498@example.com','555-0498','498 Project Data Ave','Phoenix','AZ','90498'),
(499,'Generated499','Customer499','generated.customer499@example.com','555-0499','499 Project Data Ave','Miami','FL','90499'),
(500,'Generated500','Customer500','generated.customer500@example.com','555-0500','500 Project Data Ave','Los Angeles','CA','90500'),
(501,'Generated501','Customer501','generated.customer501@example.com','555-0501','501 Project Data Ave','Chicago','IL','90501'),
(502,'Generated502','Customer502','generated.customer502@example.com','555-0502','502 Project Data Ave','Houston','TX','90502'),
(503,'Generated503','Customer503','generated.customer503@example.com','555-0503','503 Project Data Ave','Phoenix','AZ','90503'),
(504,'Generated504','Customer504','generated.customer504@example.com','555-0504','504 Project Data Ave','Miami','FL','90504'),
(505,'Generated505','Customer505','generated.customer505@example.com','555-0505','505 Project Data Ave','Los Angeles','CA','90505'),
(506,'Generated506','Customer506','generated.customer506@example.com','555-0506','506 Project Data Ave','Chicago','IL','90506'),
(507,'Generated507','Customer507','generated.customer507@example.com','555-0507','507 Project Data Ave','Houston','TX','90507'),
(508,'Generated508','Customer508','generated.customer508@example.com','555-0508','508 Project Data Ave','Phoenix','AZ','90508'),
(509,'Generated509','Customer509','generated.customer509@example.com','555-0509','509 Project Data Ave','Miami','FL','90509'),
(510,'Generated510','Customer510','generated.customer510@example.com','555-0510','510 Project Data Ave','Los Angeles','CA','90510'),
(511,'Generated511','Customer511','generated.customer511@example.com','555-0511','511 Project Data Ave','Chicago','IL','90511'),
(512,'Generated512','Customer512','generated.customer512@example.com','555-0512','512 Project Data Ave','Houston','TX','90512'),
(513,'Generated513','Customer513','generated.customer513@example.com','555-0513','513 Project Data Ave','Phoenix','AZ','90513'),
(514,'Generated514','Customer514','generated.customer514@example.com','555-0514','514 Project Data Ave','Miami','FL','90514'),
(515,'Generated515','Customer515','generated.customer515@example.com','555-0515','515 Project Data Ave','Los Angeles','CA','90515'),
(516,'Generated516','Customer516','generated.customer516@example.com','555-0516','516 Project Data Ave','Chicago','IL','90516'),
(517,'Generated517','Customer517','generated.customer517@example.com','555-0517','517 Project Data Ave','Houston','TX','90517'),
(518,'Generated518','Customer518','generated.customer518@example.com','555-0518','518 Project Data Ave','Phoenix','AZ','90518'),
(519,'Generated519','Customer519','generated.customer519@example.com','555-0519','519 Project Data Ave','Miami','FL','90519'),
(520,'Generated520','Customer520','generated.customer520@example.com','555-0520','520 Project Data Ave','Los Angeles','CA','90520');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Dairy`
--

DROP TABLE IF EXISTS `Dairy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Dairy` (
  `product_id` int(10) unsigned NOT NULL,
  `fat_percentage` decimal(5,2) DEFAULT NULL,
  `pasteurized` tinyint(1) NOT NULL DEFAULT 0,
  `shelf_life_days` int(10) unsigned DEFAULT NULL,
  `lactose_free` tinyint(1) NOT NULL DEFAULT 0,
  `storage_temp` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_dairy_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_dairy_fat_percentage` CHECK (`fat_percentage` is null or `fat_percentage` between 0 and 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Dairy`
--

LOCK TABLES `Dairy` WRITE;
/*!40000 ALTER TABLE `Dairy` DISABLE KEYS */;
INSERT INTO `Dairy` VALUES
(21,28.00,1,60,0,4.00),
(22,30.00,1,30,0,4.00),
(23,3.00,1,14,0,4.00),
(24,32.00,1,45,0,4.00),
(25,3.50,1,14,0,4.00),
(26,17.00,1,14,0,4.00),
(27,11.00,1,21,0,4.00),
(28,12.00,1,10,0,4.00),
(29,24.00,1,30,0,4.00),
(30,28.00,1,60,0,4.00),
(31,26.00,1,45,0,4.00),
(32,31.00,1,60,0,4.00),
(33,24.00,1,14,0,4.00),
(34,80.00,1,30,0,4.00),
(35,10.00,1,21,0,4.00),
(36,14.00,1,21,0,4.00),
(37,35.00,1,7,0,4.00),
(38,1.50,1,14,0,4.00),
(39,8.00,1,365,0,8.00),
(40,9.00,1,14,0,4.00);
/*!40000 ALTER TABLE `Dairy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_dairy_disjoint_ins BEFORE INSERT ON Dairy
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Dairy' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Dairy';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_dairy_disjoint_upd BEFORE UPDATE ON Dairy
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Dairy' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Dairy';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Deli`
--

DROP TABLE IF EXISTS `Deli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Deli` (
  `product_id` int(10) unsigned NOT NULL,
  `slice_thickness` decimal(5,2) DEFAULT NULL,
  `is_prepackaged` tinyint(1) NOT NULL DEFAULT 0,
  `serving_size` varchar(50) DEFAULT NULL,
  `cure_method` varchar(50) DEFAULT NULL,
  `sodium_content` decimal(8,2) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_deli_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_deli_slice_thickness` CHECK (`slice_thickness` is null or `slice_thickness` > 0),
  CONSTRAINT `chk_deli_sodium_content` CHECK (`sodium_content` is null or `sodium_content` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Deli`
--

LOCK TABLES `Deli` WRITE;
/*!40000 ALTER TABLE `Deli` DISABLE KEYS */;
INSERT INTO `Deli` VALUES
(116,1.50,1,'4 oz','Smoked',720.00),
(117,1.50,1,'4 oz','Smoked',840.00),
(118,1.25,1,'3 oz','Dry cured',980.00),
(119,1.50,1,'4 oz','Roasted',760.00),
(120,1.50,1,'4 oz','Brined',890.00),
(121,1.25,1,'3 oz','Cured',780.00),
(122,0.75,1,'2 oz','Dry cured',900.00),
(123,1.00,1,'3 oz','Cured',820.00),
(124,NULL,1,'4 oz','Prepared salad',410.00),
(125,NULL,1,'4 oz','Prepared salad',390.00),
(126,NULL,1,'4 oz','Prepared salad',360.00),
(127,NULL,1,'4 oz','Prepared salad',320.00),
(128,NULL,1,'4 oz','Prepared salad',330.00),
(129,NULL,1,'4 oz','Prepared salad',240.00),
(130,1.50,1,'4 oz','Cured',700.00),
(131,1.50,1,'4 oz','Brined',880.00),
(132,1.00,1,'3 oz','Cured',760.00),
(133,1.50,1,'4 oz','Aged',120.00),
(134,1.50,1,'4 oz','Aged',140.00),
(135,NULL,1,'2 oz','Prepared spread',300.00);
/*!40000 ALTER TABLE `Deli` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_deli_disjoint_ins BEFORE INSERT ON Deli
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Deli' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Deli';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_deli_disjoint_upd BEFORE UPDATE ON Deli
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Deli' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Deli';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Frozen`
--

DROP TABLE IF EXISTS `Frozen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Frozen` (
  `product_id` int(10) unsigned NOT NULL,
  `freeze_date` date DEFAULT NULL,
  `storage_temp` decimal(5,2) DEFAULT NULL,
  `thaw_time_hours` int(10) unsigned DEFAULT NULL,
  `is_raw` tinyint(1) NOT NULL DEFAULT 0,
  `packaging_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_frozen_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Frozen`
--

LOCK TABLES `Frozen` WRITE;
/*!40000 ALTER TABLE `Frozen` DISABLE KEYS */;
INSERT INTO `Frozen` VALUES
(71,'2025-04-01',-18.00,12,1,'Vacuum sealed'),
(72,'2025-03-25',-18.00,12,1,'Vacuum sealed'),
(73,'2025-04-05',-18.00,12,1,'Vacuum sealed'),
(74,'2025-04-08',-18.00,12,1,'Vacuum sealed'),
(75,'2025-04-10',-18.00,12,1,'Vacuum sealed'),
(76,'2025-04-03',-18.00,12,1,'Vacuum sealed'),
(77,'2025-04-06',-18.00,12,1,'Vacuum sealed'),
(78,'2025-04-09',-18.00,12,1,'Vacuum sealed'),
(79,'2025-04-02',-18.00,12,1,'Vacuum sealed'),
(80,'2025-04-07',-18.00,12,1,'Vacuum sealed'),
(81,'2025-04-04',-18.00,12,1,'Vacuum sealed'),
(82,'2025-04-11',-18.00,12,1,'Vacuum sealed'),
(83,'2025-04-12',-18.00,8,1,'Vacuum sealed'),
(84,'2025-04-08',-18.00,10,1,'Vacuum sealed'),
(85,'2025-04-09',-18.00,10,1,'Vacuum sealed');
/*!40000 ALTER TABLE `Frozen` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_frozen_disjoint_ins BEFORE INSERT ON Frozen
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Frozen' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Frozen';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_frozen_disjoint_upd BEFORE UPDATE ON Frozen
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Frozen' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Frozen';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Inventory`
--

DROP TABLE IF EXISTS `Inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Inventory` (
  `inventory_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `warehouse_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL DEFAULT 0,
  `restock_threshold` int(10) unsigned NOT NULL DEFAULT 0,
  `last_restocked` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`inventory_id`),
  UNIQUE KEY `uq_inventory_warehouse_product` (`warehouse_id`,`product_id`),
  KEY `fk_inventory_product` (`product_id`),
  CONSTRAINT `fk_inventory_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_inventory_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `Warehouse` (`warehouse_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Inventory`
--

LOCK TABLES `Inventory` WRITE;
/*!40000 ALTER TABLE `Inventory` DISABLE KEYS */;
INSERT INTO `Inventory` VALUES
(1,1,1,46,64,'2025-03-01 00:00:00'),
(2,2,2,51,87,'2025-04-01 00:00:00'),
(3,3,3,38,67,'2025-04-01 00:00:00'),
(4,4,4,51,60,'2025-05-01 00:00:00'),
(5,5,5,27,22,'2025-05-01 00:00:00'),
(6,6,6,91,6,'2025-05-01 00:00:00'),
(7,7,7,17,85,'2025-05-01 00:00:00'),
(8,8,8,81,22,'2025-06-01 00:00:00'),
(9,9,9,78,24,'2025-06-01 00:00:00'),
(10,10,10,55,50,'2025-06-01 00:00:00'),
(11,1,11,60,9,'2025-06-01 00:00:00'),
(12,2,12,53,89,'2025-07-01 00:00:00'),
(13,3,13,94,58,'2025-08-01 00:00:00'),
(14,4,14,34,92,'2025-09-01 00:00:00'),
(15,5,15,79,37,'2025-09-01 00:00:00'),
(16,6,16,76,54,'2025-10-01 00:00:00'),
(17,7,17,12,30,'2025-10-01 00:00:00'),
(18,8,18,50,46,'2025-10-01 00:00:00'),
(19,9,19,25,62,'2025-10-01 00:00:00'),
(20,10,20,67,14,'2025-10-01 00:00:00'),
(21,1,21,38,43,'2025-10-01 00:00:00'),
(22,2,22,13,39,'2025-06-02 00:00:00'),
(23,3,23,78,24,'2025-08-02 00:00:00'),
(24,4,24,31,65,'2025-12-03 00:00:00'),
(25,5,25,50,14,'2025-06-02 00:00:00'),
(26,6,26,68,82,'2025-04-08 00:00:00'),
(27,7,27,55,83,'2025-04-02 00:00:00'),
(28,8,28,25,72,'2025-05-03 00:00:00'),
(29,9,29,30,42,'2025-05-02 00:00:00'),
(30,10,30,34,32,'2025-05-02 00:00:00'),
(31,1,31,42,50,'2025-04-15 00:00:00'),
(32,2,32,38,45,'2025-04-18 00:00:00'),
(33,3,33,22,30,'2025-04-20 00:00:00'),
(34,4,34,35,40,'2025-04-16 00:00:00'),
(35,5,35,28,35,'2025-04-19 00:00:00'),
(36,6,36,65,79,'2025-04-02 00:00:00'),
(37,7,37,40,30,'2025-07-02 00:00:00'),
(38,8,38,100,1,'2025-08-02 00:00:00'),
(39,9,39,17,63,'2025-08-02 00:00:00'),
(40,10,40,12,59,'2025-06-03 00:00:00'),
(41,1,41,30,42,'2025-05-02 00:00:00'),
(42,2,42,25,44,'2025-07-04 00:00:00'),
(43,3,43,29,72,'2025-05-03 00:00:00'),
(44,4,44,72,29,'2025-08-03 00:00:00'),
(45,5,45,75,80,'2025-07-06 00:00:00'),
(46,6,46,48,40,'2025-05-10 00:00:00'),
(47,7,47,32,25,'2025-05-11 00:00:00'),
(48,8,48,56,35,'2025-05-12 00:00:00'),
(49,9,49,44,38,'2025-05-13 00:00:00'),
(50,10,50,62,50,'2025-05-14 00:00:00'),
(51,1,51,35,45,'2025-05-15 00:00:00'),
(52,2,52,52,40,'2025-05-16 00:00:00'),
(53,3,53,68,45,'2025-05-17 00:00:00'),
(54,4,54,82,50,'2025-05-18 00:00:00'),
(55,5,55,45,35,'2025-05-19 00:00:00'),
(56,6,56,65,79,'2025-04-22 00:00:00'),
(57,7,57,40,30,'2025-07-22 00:00:00'),
(58,8,58,100,1,'2025-08-22 00:00:00'),
(59,9,59,17,63,'2025-08-23 00:00:00'),
(60,10,60,12,59,'2025-06-23 00:00:00'),
(61,1,61,28,20,'2025-04-25 00:00:00'),
(62,2,62,35,25,'2025-04-24 00:00:00'),
(63,3,63,42,30,'2025-04-26 00:00:00'),
(64,4,64,55,40,'2025-04-26 00:00:00'),
(65,5,65,18,15,'2025-04-25 00:00:00'),
(66,6,66,38,35,'2025-04-25 00:00:00'),
(67,7,67,45,40,'2025-04-24 00:00:00'),
(68,8,68,32,28,'2025-04-25 00:00:00'),
(69,9,69,85,10,'2025-04-20 00:00:00'),
(70,10,70,22,18,'2025-04-26 00:00:00'),
(71,1,71,30,42,'2025-05-02 00:00:00'),
(72,2,72,25,44,'2025-07-04 00:00:00'),
(73,3,73,29,72,'2025-05-03 00:00:00'),
(74,4,74,72,29,'2025-08-03 00:00:00'),
(75,5,75,75,80,'2025-07-06 00:00:00'),
(76,6,76,52,45,'2025-05-12 00:00:00'),
(77,7,77,48,38,'2025-05-13 00:00:00'),
(78,8,78,61,50,'2025-05-14 00:00:00'),
(79,9,79,36,30,'2025-05-15 00:00:00'),
(80,10,80,55,42,'2025-05-16 00:00:00'),
(81,1,81,42,38,'2025-05-17 00:00:00'),
(82,2,82,68,50,'2025-05-18 00:00:00'),
(83,3,83,71,55,'2025-05-19 00:00:00'),
(84,4,84,45,35,'2025-05-20 00:00:00'),
(85,5,85,59,48,'2025-05-21 00:00:00'),
(86,6,86,24,35,'2025-05-04 00:00:00'),
(87,7,87,17,85,'2025-04-03 00:00:00'),
(88,8,88,24,89,'2025-05-04 00:00:00'),
(89,9,89,34,32,'2025-05-02 00:00:00'),
(90,10,90,11,58,'2025-06-06 00:00:00'),
(91,1,91,54,78,'2025-05-02 00:00:00'),
(92,2,92,45,77,'2025-08-02 00:00:00'),
(93,3,93,58,5,'2025-10-02 00:00:00'),
(94,4,94,24,35,'2025-05-04 00:00:00'),
(95,5,95,100,92,'2025-05-05 00:00:00'),
(96,6,96,91,78,'2025-05-05 00:00:00'),
(97,7,97,18,72,'2025-05-05 00:00:00'),
(98,8,98,80,86,'2025-05-05 00:00:00'),
(99,9,99,46,81,'2025-09-05 00:00:00'),
(100,10,100,37,45,'2025-12-08 00:00:00'),
(101,1,101,52,60,'2025-05-15 00:00:00'),
(102,2,102,48,55,'2025-05-16 00:00:00'),
(103,3,103,61,50,'2025-05-17 00:00:00'),
(104,4,104,35,40,'2025-05-18 00:00:00'),
(105,5,105,73,65,'2025-05-19 00:00:00'),
(106,6,106,88,75,'2025-05-20 00:00:00'),
(107,7,107,42,35,'2025-05-21 00:00:00'),
(108,8,108,25,30,'2025-05-22 00:00:00'),
(109,9,109,68,55,'2025-05-23 00:00:00'),
(110,10,110,31,28,'2025-05-24 00:00:00'),
(111,1,111,47,40,'2025-05-25 00:00:00'),
(112,2,112,56,48,'2025-05-26 00:00:00'),
(113,3,113,39,35,'2025-05-27 00:00:00'),
(114,4,114,82,70,'2025-05-28 00:00:00'),
(115,5,115,27,25,'2025-05-29 00:00:00'),
(116,6,116,44,30,'2025-05-30 00:00:00'),
(117,7,117,52,35,'2025-05-30 00:00:00'),
(118,8,118,37,25,'2025-05-30 00:00:00'),
(119,9,119,41,28,'2025-05-30 00:00:00'),
(120,10,120,36,24,'2025-05-30 00:00:00'),
(121,1,121,55,40,'2025-05-31 00:00:00'),
(122,2,122,28,20,'2025-05-31 00:00:00'),
(123,3,123,33,22,'2025-05-31 00:00:00'),
(124,4,124,47,32,'2025-05-31 00:00:00'),
(125,5,125,50,35,'2025-05-31 00:00:00'),
(126,6,126,39,25,'2025-06-01 00:00:00'),
(127,7,127,62,45,'2025-06-01 00:00:00'),
(128,8,128,43,30,'2025-06-01 00:00:00'),
(129,9,129,58,40,'2025-06-01 00:00:00'),
(130,10,130,31,22,'2025-06-01 00:00:00'),
(131,1,131,35,25,'2025-06-02 00:00:00'),
(132,2,132,46,32,'2025-06-02 00:00:00'),
(133,3,133,49,34,'2025-06-02 00:00:00'),
(134,4,134,53,38,'2025-06-02 00:00:00'),
(135,5,135,40,28,'2025-06-02 00:00:00');
/*!40000 ALTER TABLE `Inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Meat`
--

DROP TABLE IF EXISTS `Meat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Meat` (
  `product_id` int(10) unsigned NOT NULL,
  `cut_type` varchar(50) DEFAULT NULL,
  `is_frozen` tinyint(1) NOT NULL DEFAULT 0,
  `grade` varchar(30) DEFAULT NULL,
  `animal_source` varchar(50) DEFAULT NULL,
  `weight_per_unit` decimal(10,3) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_meat_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_meat_weight_per_unit` CHECK (`weight_per_unit` is null or `weight_per_unit` > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Meat`
--

LOCK TABLES `Meat` WRITE;
/*!40000 ALTER TABLE `Meat` DISABLE KEYS */;
INSERT INTO `Meat` VALUES
(41,'Ground',0,'Choice','Beef',0.454),
(42,'Breast',1,'Grade A','Chicken',0.500),
(43,'Fillet',0,'Grade A','Salmon',0.300),
(44,'Chop',1,'Grade B','Pork',0.400),
(45,'Breast',1,'Grade A','Turkey',0.500),
(46,'Chop',1,'Prime','Lamb',0.350),
(47,'Cutlet',0,'Grade A','Veal',0.300),
(48,'Breast',1,'Grade A','Duck',0.400),
(49,'Ribeye',0,'Prime','Beef',0.350),
(50,'Ground',1,'Grade A','Turkey',0.454),
(51,'Thighs',0,'Grade A','Chicken',0.500),
(52,'Fillet',0,'Grade A','Cod',0.300),
(53,'Steak',0,'Choice','Beef',0.300),
(54,'Ribs',1,'Grade B','Pork',0.600),
(55,'Whole',1,'Grade A','Shrimp',0.250);
/*!40000 ALTER TABLE `Meat` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_meat_disjoint_ins BEFORE INSERT ON Meat
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Meat' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Meat';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_meat_disjoint_upd BEFORE UPDATE ON Meat
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Meat' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Meat';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Order`
--

DROP TABLE IF EXISTS `Order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order` (
  `order_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL,
  `order_date` date NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_order_customer` (`customer_id`),
  CONSTRAINT `fk_order_customer` FOREIGN KEY (`customer_id`) REFERENCES `Customer` (`customer_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=532 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order`
--

LOCK TABLES `Order` WRITE;
/*!40000 ALTER TABLE `Order` DISABLE KEYS */;
INSERT INTO `Order` VALUES
(1,1,'2025-01-15'),
(2,2,'2025-01-18'),
(3,3,'2025-01-22'),
(4,4,'2025-02-05'),
(5,5,'2025-02-10'),
(6,6,'2025-02-14'),
(7,7,'2025-02-20'),
(8,8,'2025-03-01'),
(9,9,'2025-03-05'),
(10,10,'2025-03-12'),
(11,11,'2025-03-18'),
(12,12,'2025-04-02'),
(13,13,'2025-04-08'),
(14,14,'2025-04-15'),
(15,15,'2025-04-20'),
(16,16,'2025-05-01'),
(17,17,'2025-05-08'),
(18,18,'2025-05-15'),
(19,19,'2025-05-22'),
(20,20,'2025-06-01'),
(21,21,'2025-06-01'),
(22,22,'2025-06-02'),
(23,23,'2025-06-03'),
(24,24,'2025-06-04'),
(25,25,'2025-06-05'),
(26,26,'2025-06-06'),
(27,27,'2025-06-07'),
(28,28,'2025-06-08'),
(29,29,'2025-06-09'),
(30,30,'2025-06-10'),
(31,31,'2025-06-11'),
(32,32,'2025-06-12'),
(33,33,'2025-06-13'),
(34,34,'2025-06-14'),
(35,35,'2025-06-15'),
(36,36,'2025-06-16'),
(37,37,'2025-06-17'),
(38,38,'2025-06-18'),
(39,39,'2025-06-19'),
(40,40,'2025-06-20'),
(41,41,'2025-06-21'),
(42,42,'2025-06-22'),
(43,43,'2025-06-23'),
(44,44,'2025-06-24'),
(45,45,'2025-06-25'),
(46,46,'2025-06-26'),
(47,47,'2025-06-27'),
(48,48,'2025-06-28'),
(49,49,'2025-06-29'),
(50,50,'2025-06-30'),
(51,51,'2025-07-01'),
(52,52,'2025-07-02'),
(53,53,'2025-07-03'),
(54,54,'2025-07-04'),
(55,55,'2025-07-05'),
(56,56,'2025-07-06'),
(57,57,'2025-07-07'),
(58,58,'2025-07-08'),
(59,59,'2025-07-09'),
(60,60,'2025-07-10'),
(61,61,'2025-07-11'),
(62,62,'2025-07-12'),
(63,63,'2025-07-13'),
(64,64,'2025-07-14'),
(65,65,'2025-07-15'),
(66,66,'2025-07-16'),
(67,67,'2025-07-17'),
(68,68,'2025-07-18'),
(69,69,'2025-07-19'),
(70,70,'2025-07-20'),
(71,71,'2025-07-21'),
(72,72,'2025-07-22'),
(73,73,'2025-07-23'),
(74,74,'2025-07-24'),
(75,75,'2025-07-25'),
(76,76,'2025-07-26'),
(77,77,'2025-07-27'),
(78,78,'2025-07-28'),
(79,79,'2025-07-29'),
(80,80,'2025-07-30'),
(81,81,'2025-07-31'),
(82,82,'2025-08-01'),
(83,83,'2025-08-02'),
(84,84,'2025-08-03'),
(85,85,'2025-08-04'),
(86,86,'2025-08-05'),
(87,87,'2025-08-06'),
(88,88,'2025-08-07'),
(89,89,'2025-08-08'),
(90,90,'2025-08-09'),
(91,91,'2025-08-10'),
(92,92,'2025-08-11'),
(93,93,'2025-08-12'),
(94,94,'2025-08-13'),
(95,95,'2025-08-14'),
(96,96,'2025-08-15'),
(97,97,'2025-08-16'),
(98,98,'2025-08-17'),
(99,99,'2025-08-18'),
(100,100,'2025-08-19'),
(101,101,'2025-08-20'),
(102,102,'2025-08-21'),
(103,103,'2025-08-22'),
(104,104,'2025-08-23'),
(105,105,'2025-08-24'),
(106,106,'2025-08-25'),
(107,107,'2025-08-26'),
(108,108,'2025-08-27'),
(109,109,'2025-08-28'),
(110,110,'2025-08-29'),
(111,111,'2025-08-30'),
(112,112,'2025-08-31'),
(113,113,'2025-09-01'),
(114,114,'2025-09-02'),
(115,115,'2025-09-03'),
(116,116,'2025-09-04'),
(117,117,'2025-09-05'),
(118,118,'2025-09-06'),
(119,119,'2025-09-07'),
(120,120,'2025-09-08'),
(121,121,'2025-09-09'),
(122,122,'2025-09-10'),
(123,123,'2025-09-11'),
(124,124,'2025-09-12'),
(125,125,'2025-09-13'),
(126,126,'2025-09-14'),
(127,127,'2025-09-15'),
(128,128,'2025-09-16'),
(129,129,'2025-09-17'),
(130,130,'2025-09-18'),
(131,131,'2025-09-19'),
(132,132,'2025-09-20'),
(133,133,'2025-09-21'),
(134,134,'2025-09-22'),
(135,135,'2025-09-23'),
(136,136,'2025-09-24'),
(137,137,'2025-09-25'),
(138,138,'2025-09-26'),
(139,139,'2025-09-27'),
(140,140,'2025-09-28'),
(141,141,'2025-09-29'),
(142,142,'2025-09-30'),
(143,143,'2025-10-01'),
(144,144,'2025-10-02'),
(145,145,'2025-10-03'),
(146,146,'2025-10-04'),
(147,147,'2025-10-05'),
(148,148,'2025-10-06'),
(149,149,'2025-10-07'),
(150,150,'2025-10-08'),
(151,151,'2025-10-09'),
(152,152,'2025-10-10'),
(153,153,'2025-10-11'),
(154,154,'2025-10-12'),
(155,155,'2025-10-13'),
(156,156,'2025-10-14'),
(157,157,'2025-10-15'),
(158,158,'2025-10-16'),
(159,159,'2025-10-17'),
(160,160,'2025-10-18'),
(161,161,'2025-10-19'),
(162,162,'2025-10-20'),
(163,163,'2025-10-21'),
(164,164,'2025-10-22'),
(165,165,'2025-10-23'),
(166,166,'2025-10-24'),
(167,167,'2025-10-25'),
(168,168,'2025-10-26'),
(169,169,'2025-10-27'),
(170,170,'2025-10-28'),
(171,171,'2025-10-29'),
(172,172,'2025-10-30'),
(173,173,'2025-10-31'),
(174,174,'2025-11-01'),
(175,175,'2025-11-02'),
(176,176,'2025-11-03'),
(177,177,'2025-11-04'),
(178,178,'2025-11-05'),
(179,179,'2025-11-06'),
(180,180,'2025-11-07'),
(181,181,'2025-11-08'),
(182,182,'2025-11-09'),
(183,183,'2025-11-10'),
(184,184,'2025-11-11'),
(185,185,'2025-11-12'),
(186,186,'2025-11-13'),
(187,187,'2025-11-14'),
(188,188,'2025-11-15'),
(189,189,'2025-11-16'),
(190,190,'2025-11-17'),
(191,191,'2025-11-18'),
(192,192,'2025-11-19'),
(193,193,'2025-11-20'),
(194,194,'2025-11-21'),
(195,195,'2025-11-22'),
(196,196,'2025-11-23'),
(197,197,'2025-11-24'),
(198,198,'2025-11-25'),
(199,199,'2025-11-26'),
(200,200,'2025-11-27'),
(201,201,'2025-11-28'),
(202,202,'2025-11-29'),
(203,203,'2025-11-30'),
(204,204,'2025-12-01'),
(205,205,'2025-12-02'),
(206,206,'2025-12-03'),
(207,207,'2025-12-04'),
(208,208,'2025-12-05'),
(209,209,'2025-12-06'),
(210,210,'2025-12-07'),
(211,211,'2025-12-08'),
(212,212,'2025-12-09'),
(213,213,'2025-12-10'),
(214,214,'2025-12-11'),
(215,215,'2025-12-12'),
(216,216,'2025-12-13'),
(217,217,'2025-12-14'),
(218,218,'2025-12-15'),
(219,219,'2025-12-16'),
(220,220,'2025-12-17'),
(221,221,'2025-12-18'),
(222,222,'2025-12-19'),
(223,223,'2025-12-20'),
(224,224,'2025-12-21'),
(225,225,'2025-12-22'),
(226,226,'2025-12-23'),
(227,227,'2025-12-24'),
(228,228,'2025-12-25'),
(229,229,'2025-12-26'),
(230,230,'2025-12-27'),
(231,231,'2025-12-28'),
(232,232,'2025-12-29'),
(233,233,'2025-12-30'),
(234,234,'2025-12-31'),
(235,235,'2026-01-01'),
(236,236,'2026-01-02'),
(237,237,'2026-01-03'),
(238,238,'2026-01-04'),
(239,239,'2026-01-05'),
(240,240,'2026-01-06'),
(241,241,'2026-01-07'),
(242,242,'2026-01-08'),
(243,243,'2026-01-09'),
(244,244,'2026-01-10'),
(245,245,'2026-01-11'),
(246,246,'2026-01-12'),
(247,247,'2026-01-13'),
(248,248,'2026-01-14'),
(249,249,'2026-01-15'),
(250,250,'2026-01-16'),
(251,251,'2026-01-17'),
(252,252,'2026-01-18'),
(253,253,'2026-01-19'),
(254,254,'2026-01-20'),
(255,255,'2026-01-21'),
(256,256,'2026-01-22'),
(257,257,'2026-01-23'),
(258,258,'2026-01-24'),
(259,259,'2026-01-25'),
(260,260,'2026-01-26'),
(261,261,'2026-01-27'),
(262,262,'2026-01-28'),
(263,263,'2026-01-29'),
(264,264,'2026-01-30'),
(265,265,'2026-01-31'),
(266,266,'2026-02-01'),
(267,267,'2026-02-02'),
(268,268,'2026-02-03'),
(269,269,'2026-02-04'),
(270,270,'2026-02-05'),
(271,271,'2026-02-06'),
(272,272,'2026-02-07'),
(273,273,'2026-02-08'),
(274,274,'2026-02-09'),
(275,275,'2026-02-10'),
(276,276,'2026-02-11'),
(277,277,'2026-02-12'),
(278,278,'2026-02-13'),
(279,279,'2026-02-14'),
(280,280,'2026-02-15'),
(281,281,'2026-02-16'),
(282,282,'2026-02-17'),
(283,283,'2026-02-18'),
(284,284,'2026-02-19'),
(285,285,'2026-02-20'),
(286,286,'2026-02-21'),
(287,287,'2026-02-22'),
(288,288,'2026-02-23'),
(289,289,'2026-02-24'),
(290,290,'2026-02-25'),
(291,291,'2026-02-26'),
(292,292,'2026-02-27'),
(293,293,'2026-02-28'),
(294,294,'2026-03-01'),
(295,295,'2026-03-02'),
(296,296,'2026-03-03'),
(297,297,'2026-03-04'),
(298,298,'2026-03-05'),
(299,299,'2026-03-06'),
(300,300,'2026-03-07'),
(301,301,'2026-03-08'),
(302,302,'2026-03-09'),
(303,303,'2026-03-10'),
(304,304,'2026-03-11'),
(305,305,'2026-03-12'),
(306,306,'2026-03-13'),
(307,307,'2026-03-14'),
(308,308,'2026-03-15'),
(309,309,'2026-03-16'),
(310,310,'2026-03-17'),
(311,311,'2026-03-18'),
(312,312,'2026-03-19'),
(313,313,'2026-03-20'),
(314,314,'2026-03-21'),
(315,315,'2026-03-22'),
(316,316,'2026-03-23'),
(317,317,'2026-03-24'),
(318,318,'2026-03-25'),
(319,319,'2026-03-26'),
(320,320,'2026-03-27'),
(321,321,'2026-03-28'),
(322,322,'2026-03-29'),
(323,323,'2026-03-30'),
(324,324,'2026-03-31'),
(325,325,'2026-04-01'),
(326,326,'2026-04-02'),
(327,327,'2026-04-03'),
(328,328,'2026-04-04'),
(329,329,'2026-04-05'),
(330,330,'2026-04-06'),
(331,331,'2026-04-07'),
(332,332,'2026-04-08'),
(333,333,'2026-04-09'),
(334,334,'2026-04-10'),
(335,335,'2026-04-11'),
(336,336,'2026-04-12'),
(337,337,'2026-04-13'),
(338,338,'2026-04-14'),
(339,339,'2026-04-15'),
(340,340,'2026-04-16'),
(341,341,'2026-04-17'),
(342,342,'2026-04-18'),
(343,343,'2026-04-19'),
(344,344,'2026-04-20'),
(345,345,'2026-04-21'),
(346,346,'2026-04-22'),
(347,347,'2026-04-23'),
(348,348,'2026-04-24'),
(349,349,'2026-04-25'),
(350,350,'2026-04-26'),
(351,351,'2026-04-27'),
(352,352,'2026-04-28'),
(353,353,'2026-04-29'),
(354,354,'2026-04-30'),
(355,355,'2026-05-01'),
(356,356,'2026-05-02'),
(357,357,'2026-05-03'),
(358,358,'2026-05-04'),
(359,359,'2026-05-05'),
(360,360,'2026-05-06'),
(361,361,'2026-05-07'),
(362,362,'2026-05-08'),
(363,363,'2026-05-09'),
(364,364,'2026-05-10'),
(365,365,'2026-05-11'),
(366,366,'2026-05-12'),
(367,367,'2026-05-13'),
(368,368,'2026-05-14'),
(369,369,'2026-05-15'),
(370,370,'2026-05-16'),
(371,371,'2026-05-17'),
(372,372,'2026-05-18'),
(373,373,'2026-05-19'),
(374,374,'2026-05-20'),
(375,375,'2026-05-21'),
(376,376,'2026-05-22'),
(377,377,'2026-05-23'),
(378,378,'2026-05-24'),
(379,379,'2026-05-25'),
(380,380,'2026-05-26'),
(381,381,'2026-05-27'),
(382,382,'2026-05-28'),
(383,383,'2026-05-29'),
(384,384,'2026-05-30'),
(385,385,'2026-05-31'),
(386,386,'2026-06-01'),
(387,387,'2026-06-02'),
(388,388,'2026-06-03'),
(389,389,'2026-06-04'),
(390,390,'2026-06-05'),
(391,391,'2026-06-06'),
(392,392,'2026-06-07'),
(393,393,'2026-06-08'),
(394,394,'2026-06-09'),
(395,395,'2026-06-10'),
(396,396,'2026-06-11'),
(397,397,'2026-06-12'),
(398,398,'2026-06-13'),
(399,399,'2026-06-14'),
(400,400,'2026-06-15'),
(401,401,'2026-06-16'),
(402,402,'2026-06-17'),
(403,403,'2026-06-18'),
(404,404,'2026-06-19'),
(405,405,'2026-06-20'),
(406,406,'2026-06-21'),
(407,407,'2026-06-22'),
(408,408,'2026-06-23'),
(409,409,'2026-06-24'),
(410,410,'2026-06-25'),
(411,411,'2026-06-26'),
(412,412,'2026-06-27'),
(413,413,'2026-06-28'),
(414,414,'2026-06-29'),
(415,415,'2026-06-30'),
(416,416,'2026-07-01'),
(417,417,'2026-07-02'),
(418,418,'2026-07-03'),
(419,419,'2026-07-04'),
(420,420,'2026-07-05'),
(421,421,'2026-07-06'),
(422,422,'2026-07-07'),
(423,423,'2026-07-08'),
(424,424,'2026-07-09'),
(425,425,'2026-07-10'),
(426,426,'2026-07-11'),
(427,427,'2026-07-12'),
(428,428,'2026-07-13'),
(429,429,'2026-07-14'),
(430,430,'2026-07-15'),
(431,431,'2026-07-16'),
(432,432,'2026-07-17'),
(433,433,'2026-07-18'),
(434,434,'2026-07-19'),
(435,435,'2026-07-20'),
(436,436,'2026-07-21'),
(437,437,'2026-07-22'),
(438,438,'2026-07-23'),
(439,439,'2026-07-24'),
(440,440,'2026-07-25'),
(441,441,'2026-07-26'),
(442,442,'2026-07-27'),
(443,443,'2026-07-28'),
(444,444,'2026-07-29'),
(445,445,'2026-07-30'),
(446,446,'2026-07-31'),
(447,447,'2026-08-01'),
(448,448,'2026-08-02'),
(449,449,'2026-08-03'),
(450,450,'2026-08-04'),
(451,451,'2026-08-05'),
(452,452,'2026-08-06'),
(453,453,'2026-08-07'),
(454,454,'2026-08-08'),
(455,455,'2026-08-09'),
(456,456,'2026-08-10'),
(457,457,'2026-08-11'),
(458,458,'2026-08-12'),
(459,459,'2026-08-13'),
(460,460,'2026-08-14'),
(461,461,'2026-08-15'),
(462,462,'2026-08-16'),
(463,463,'2026-08-17'),
(464,464,'2026-08-18'),
(465,465,'2026-08-19'),
(466,466,'2026-08-20'),
(467,467,'2026-08-21'),
(468,468,'2026-08-22'),
(469,469,'2026-08-23'),
(470,470,'2026-08-24'),
(471,471,'2026-08-25'),
(472,472,'2026-08-26'),
(473,473,'2026-08-27'),
(474,474,'2026-08-28'),
(475,475,'2026-08-29'),
(476,476,'2026-08-30'),
(477,477,'2026-08-31'),
(478,478,'2026-09-01'),
(479,479,'2026-09-02'),
(480,480,'2026-09-03'),
(481,481,'2026-09-04'),
(482,482,'2026-09-05'),
(483,483,'2026-09-06'),
(484,484,'2026-09-07'),
(485,485,'2026-09-08'),
(486,486,'2026-09-09'),
(487,487,'2026-09-10'),
(488,488,'2026-09-11'),
(489,489,'2026-09-12'),
(490,490,'2026-09-13'),
(491,491,'2026-09-14'),
(492,492,'2026-09-15'),
(493,493,'2026-09-16'),
(494,494,'2026-09-17'),
(495,495,'2026-09-18'),
(496,496,'2026-09-19'),
(497,497,'2026-09-20'),
(498,498,'2026-09-21'),
(499,499,'2026-09-22'),
(500,500,'2026-09-23'),
(501,501,'2026-09-24'),
(502,502,'2026-09-25'),
(503,503,'2026-09-26'),
(504,504,'2026-09-27'),
(505,505,'2026-09-28'),
(506,506,'2026-09-29'),
(507,507,'2026-09-30'),
(508,508,'2026-10-01'),
(509,509,'2026-10-02'),
(510,510,'2026-10-03'),
(511,511,'2026-10-04'),
(512,512,'2026-10-05'),
(513,513,'2026-10-06'),
(514,514,'2026-10-07'),
(515,515,'2026-10-08'),
(516,516,'2026-10-09'),
(517,517,'2026-10-10'),
(518,518,'2026-10-11'),
(519,519,'2026-10-12'),
(520,520,'2026-10-13');
/*!40000 ALTER TABLE `Order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_Line`
--

DROP TABLE IF EXISTS `Order_Line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Line` (
  `order_line_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `shipment_id` int(10) unsigned NOT NULL,
  `product_id` int(10) unsigned NOT NULL,
  `quantity` int(10) unsigned NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_line_id`),
  KEY `fk_order_line_shipment` (`shipment_id`),
  KEY `fk_order_line_product` (`product_id`),
  CONSTRAINT `fk_order_line_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_line_shipment` FOREIGN KEY (`shipment_id`) REFERENCES `Shipment` (`shipment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_order_line_quantity` CHECK (`quantity` > 0),
  CONSTRAINT `chk_order_line_unit_price` CHECK (`unit_price` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=552 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Line`
--

LOCK TABLES `Order_Line` WRITE;
/*!40000 ALTER TABLE `Order_Line` DISABLE KEYS */;
INSERT INTO `Order_Line` VALUES
(1,1,1,2,4.60),
(2,1,21,1,12.00),
(3,2,2,3,2.00),
(4,2,46,1,2.00),
(5,3,3,1,7.00),
(6,3,22,2,9.00),
(7,4,4,5,1.50),
(8,4,31,2,8.99),
(9,5,5,3,2.90),
(10,5,36,1,4.00),
(11,6,6,2,2.50),
(12,6,23,1,1.70),
(13,7,7,1,4.50),
(14,7,49,1,4.75),
(15,8,8,3,3.00),
(16,8,32,2,7.49),
(17,9,9,2,7.00),
(18,9,37,1,4.00),
(19,10,10,1,1.70),
(20,10,52,2,20.00),
(21,11,11,2,9.00),
(22,11,41,1,7.00),
(23,12,12,3,1.80),
(24,12,24,1,9.00),
(25,13,13,2,2.00),
(26,13,50,1,4.75),
(27,14,14,4,6.00),
(28,14,31,1,8.99),
(29,15,15,1,2.50),
(30,15,38,2,5.00),
(31,16,16,3,5.00),
(32,16,42,1,18.00),
(33,17,17,2,3.50),
(34,17,26,1,6.20),
(35,18,18,4,6.00),
(36,18,53,1,6.50),
(37,19,19,5,2.00),
(38,19,33,1,14.99),
(39,20,20,2,2.50),
(40,20,43,2,12.00),
(41,21,21,2,12.00),
(42,22,22,3,9.00),
(43,23,23,4,1.70),
(44,24,24,5,9.00),
(45,25,25,1,0.90),
(46,26,26,2,6.20),
(47,27,27,3,2.50),
(48,28,28,4,4.00),
(49,29,29,5,7.00),
(50,30,30,1,7.00),
(51,31,31,2,8.50),
(52,32,32,3,10.50),
(53,33,33,4,5.00),
(54,34,34,5,6.50),
(55,35,35,1,3.00),
(56,36,36,2,4.80),
(57,37,37,3,4.10),
(58,38,38,4,2.45),
(59,39,39,5,2.00),
(60,40,40,1,0.80),
(61,41,41,2,8.99),
(62,42,42,3,7.49),
(63,43,43,4,14.99),
(64,44,44,5,9.99),
(65,45,45,1,8.49),
(66,46,46,2,12.99),
(67,47,47,3,13.49),
(68,48,48,4,11.99),
(69,49,49,5,16.99),
(70,50,50,1,7.99),
(71,51,51,2,6.99),
(72,52,52,3,10.99),
(73,53,53,4,14.99),
(74,54,54,5,10.99),
(75,55,55,1,15.99),
(76,56,56,2,4.00),
(77,57,57,3,4.00),
(78,58,58,4,5.00),
(79,59,59,5,3.50),
(80,60,60,1,3.00),
(81,61,61,2,3.50),
(82,62,62,3,2.00),
(83,63,63,4,2.50),
(84,64,64,5,1.50),
(85,65,65,1,4.50),
(86,66,66,2,3.50),
(87,67,67,3,3.20),
(88,68,68,4,4.00),
(89,69,69,5,2.00),
(90,70,70,1,4.50),
(91,71,71,2,7.00),
(92,72,72,3,18.00),
(93,73,73,4,12.00),
(94,74,74,5,8.00),
(95,75,75,1,9.00),
(96,76,76,2,16.00),
(97,77,77,3,13.00),
(98,78,78,4,11.00),
(99,79,79,5,8.50),
(100,80,80,1,14.00),
(101,81,81,2,7.50),
(102,82,82,3,15.00),
(103,83,83,4,18.00),
(104,84,84,5,12.00),
(105,85,85,1,10.00),
(106,86,86,2,2.00),
(107,87,87,3,5.00),
(108,88,88,4,10.00),
(109,89,89,5,4.75),
(110,90,90,1,1.50),
(111,91,91,2,2.00),
(112,92,92,3,20.00),
(113,93,93,4,12.00),
(114,94,94,5,10.00),
(115,95,95,1,4.70),
(116,96,96,2,30.00),
(117,97,97,3,6.00),
(118,98,98,4,6.50),
(119,99,99,5,2.50),
(120,100,100,1,1.80),
(121,101,101,2,4.50),
(122,102,102,3,4.35),
(123,103,103,4,4.50),
(124,104,104,5,6.20),
(125,105,105,1,10.00),
(126,106,106,2,2.00),
(127,107,107,3,2.10),
(128,108,108,4,2.50),
(129,109,109,5,8.00),
(130,110,110,1,12.00),
(131,111,111,2,4.50),
(132,112,112,3,8.00),
(133,113,113,4,5.00),
(134,114,114,5,2.30),
(135,115,115,1,4.00),
(136,116,116,2,8.75),
(137,117,117,3,7.80),
(138,118,118,4,9.50),
(139,119,119,5,10.25),
(140,120,120,1,10.75),
(141,121,121,2,8.25),
(142,122,122,3,14.00),
(143,123,123,4,12.50),
(144,124,124,5,6.75),
(145,125,125,1,6.50),
(146,126,126,2,5.25),
(147,127,127,3,4.75),
(148,128,128,4,4.50),
(149,129,129,5,3.80),
(150,130,130,1,5.50),
(151,131,131,2,11.25),
(152,132,132,3,7.25),
(153,133,133,4,8.95),
(154,134,134,5,7.95),
(155,135,135,1,6.25),
(156,136,1,2,4.60),
(157,137,2,3,1.50),
(158,138,3,4,7.00),
(159,139,4,5,2.40),
(160,140,5,1,2.90),
(161,141,6,2,2.50),
(162,142,7,3,4.50),
(163,143,8,4,3.00),
(164,144,9,5,2.00),
(165,145,10,1,4.80),
(166,146,11,2,4.00),
(167,147,12,3,1.80),
(168,148,13,4,2.00),
(169,149,14,5,6.00),
(170,150,15,1,2.50),
(171,151,16,2,5.00),
(172,152,17,3,3.50),
(173,153,18,4,5.50),
(174,154,19,5,2.00),
(175,155,20,1,2.50),
(176,156,21,2,12.00),
(177,157,22,3,9.00),
(178,158,23,4,1.70),
(179,159,24,5,9.00),
(180,160,25,1,0.90),
(181,161,26,2,6.20),
(182,162,27,3,2.50),
(183,163,28,4,4.00),
(184,164,29,5,7.00),
(185,165,30,1,7.00),
(186,166,31,2,8.50),
(187,167,32,3,10.50),
(188,168,33,4,5.00),
(189,169,34,5,6.50),
(190,170,35,1,3.00),
(191,171,36,2,4.80),
(192,172,37,3,4.10),
(193,173,38,4,2.45),
(194,174,39,5,2.00),
(195,175,40,1,0.80),
(196,176,41,2,8.99),
(197,177,42,3,7.49),
(198,178,43,4,14.99),
(199,179,44,5,9.99),
(200,180,45,1,8.49),
(201,181,46,2,12.99),
(202,182,47,3,13.49),
(203,183,48,4,11.99),
(204,184,49,5,16.99),
(205,185,50,1,7.99),
(206,186,51,2,6.99),
(207,187,52,3,10.99),
(208,188,53,4,14.99),
(209,189,54,5,10.99),
(210,190,55,1,15.99),
(211,191,56,2,4.00),
(212,192,57,3,4.00),
(213,193,58,4,5.00),
(214,194,59,5,3.50),
(215,195,60,1,3.00),
(216,196,61,2,3.50),
(217,197,62,3,2.00),
(218,198,63,4,2.50),
(219,199,64,5,1.50),
(220,200,65,1,4.50),
(221,201,66,2,3.50),
(222,202,67,3,3.20),
(223,203,68,4,4.00),
(224,204,69,5,2.00),
(225,205,70,1,4.50),
(226,206,71,2,7.00),
(227,207,72,3,18.00),
(228,208,73,4,12.00),
(229,209,74,5,8.00),
(230,210,75,1,9.00),
(231,211,76,2,16.00),
(232,212,77,3,13.00),
(233,213,78,4,11.00),
(234,214,79,5,8.50),
(235,215,80,1,14.00),
(236,216,81,2,7.50),
(237,217,82,3,15.00),
(238,218,83,4,18.00),
(239,219,84,5,12.00),
(240,220,85,1,10.00),
(241,221,86,2,2.00),
(242,222,87,3,5.00),
(243,223,88,4,10.00),
(244,224,89,5,4.75),
(245,225,90,1,1.50),
(246,226,91,2,2.00),
(247,227,92,3,20.00),
(248,228,93,4,12.00),
(249,229,94,5,10.00),
(250,230,95,1,4.70),
(251,231,96,2,30.00),
(252,232,97,3,6.00),
(253,233,98,4,6.50),
(254,234,99,5,2.50),
(255,235,100,1,1.80),
(256,236,101,2,4.50),
(257,237,102,3,4.35),
(258,238,103,4,4.50),
(259,239,104,5,6.20),
(260,240,105,1,10.00),
(261,241,106,2,2.00),
(262,242,107,3,2.10),
(263,243,108,4,2.50),
(264,244,109,5,8.00),
(265,245,110,1,12.00),
(266,246,111,2,4.50),
(267,247,112,3,8.00),
(268,248,113,4,5.00),
(269,249,114,5,2.30),
(270,250,115,1,4.00),
(271,251,116,2,8.75),
(272,252,117,3,7.80),
(273,253,118,4,9.50),
(274,254,119,5,10.25),
(275,255,120,1,10.75),
(276,256,121,2,8.25),
(277,257,122,3,14.00),
(278,258,123,4,12.50),
(279,259,124,5,6.75),
(280,260,125,1,6.50),
(281,261,126,2,5.25),
(282,262,127,3,4.75),
(283,263,128,4,4.50),
(284,264,129,5,3.80),
(285,265,130,1,5.50),
(286,266,131,2,11.25),
(287,267,132,3,7.25),
(288,268,133,4,8.95),
(289,269,134,5,7.95),
(290,270,135,1,6.25),
(291,271,1,2,4.60),
(292,272,2,3,1.50),
(293,273,3,4,7.00),
(294,274,4,5,2.40),
(295,275,5,1,2.90),
(296,276,6,2,2.50),
(297,277,7,3,4.50),
(298,278,8,4,3.00),
(299,279,9,5,2.00),
(300,280,10,1,4.80),
(301,281,11,2,4.00),
(302,282,12,3,1.80),
(303,283,13,4,2.00),
(304,284,14,5,6.00),
(305,285,15,1,2.50),
(306,286,16,2,5.00),
(307,287,17,3,3.50),
(308,288,18,4,5.50),
(309,289,19,5,2.00),
(310,290,20,1,2.50),
(311,291,21,2,12.00),
(312,292,22,3,9.00),
(313,293,23,4,1.70),
(314,294,24,5,9.00),
(315,295,25,1,0.90),
(316,296,26,2,6.20),
(317,297,27,3,2.50),
(318,298,28,4,4.00),
(319,299,29,5,7.00),
(320,300,30,1,7.00),
(321,301,31,2,8.50),
(322,302,32,3,10.50),
(323,303,33,4,5.00),
(324,304,34,5,6.50),
(325,305,35,1,3.00),
(326,306,36,2,4.80),
(327,307,37,3,4.10),
(328,308,38,4,2.45),
(329,309,39,5,2.00),
(330,310,40,1,0.80),
(331,311,41,2,8.99),
(332,312,42,3,7.49),
(333,313,43,4,14.99),
(334,314,44,5,9.99),
(335,315,45,1,8.49),
(336,316,46,2,12.99),
(337,317,47,3,13.49),
(338,318,48,4,11.99),
(339,319,49,5,16.99),
(340,320,50,1,7.99),
(341,321,51,2,6.99),
(342,322,52,3,10.99),
(343,323,53,4,14.99),
(344,324,54,5,10.99),
(345,325,55,1,15.99),
(346,326,56,2,4.00),
(347,327,57,3,4.00),
(348,328,58,4,5.00),
(349,329,59,5,3.50),
(350,330,60,1,3.00),
(351,331,61,2,3.50),
(352,332,62,3,2.00),
(353,333,63,4,2.50),
(354,334,64,5,1.50),
(355,335,65,1,4.50),
(356,336,66,2,3.50),
(357,337,67,3,3.20),
(358,338,68,4,4.00),
(359,339,69,5,2.00),
(360,340,70,1,4.50),
(361,341,71,2,7.00),
(362,342,72,3,18.00),
(363,343,73,4,12.00),
(364,344,74,5,8.00),
(365,345,75,1,9.00),
(366,346,76,2,16.00),
(367,347,77,3,13.00),
(368,348,78,4,11.00),
(369,349,79,5,8.50),
(370,350,80,1,14.00),
(371,351,81,2,7.50),
(372,352,82,3,15.00),
(373,353,83,4,18.00),
(374,354,84,5,12.00),
(375,355,85,1,10.00),
(376,356,86,2,2.00),
(377,357,87,3,5.00),
(378,358,88,4,10.00),
(379,359,89,5,4.75),
(380,360,90,1,1.50),
(381,361,91,2,2.00),
(382,362,92,3,20.00),
(383,363,93,4,12.00),
(384,364,94,5,10.00),
(385,365,95,1,4.70),
(386,366,96,2,30.00),
(387,367,97,3,6.00),
(388,368,98,4,6.50),
(389,369,99,5,2.50),
(390,370,100,1,1.80),
(391,371,101,2,4.50),
(392,372,102,3,4.35),
(393,373,103,4,4.50),
(394,374,104,5,6.20),
(395,375,105,1,10.00),
(396,376,106,2,2.00),
(397,377,107,3,2.10),
(398,378,108,4,2.50),
(399,379,109,5,8.00),
(400,380,110,1,12.00),
(401,381,111,2,4.50),
(402,382,112,3,8.00),
(403,383,113,4,5.00),
(404,384,114,5,2.30),
(405,385,115,1,4.00),
(406,386,116,2,8.75),
(407,387,117,3,7.80),
(408,388,118,4,9.50),
(409,389,119,5,10.25),
(410,390,120,1,10.75),
(411,391,121,2,8.25),
(412,392,122,3,14.00),
(413,393,123,4,12.50),
(414,394,124,5,6.75),
(415,395,125,1,6.50),
(416,396,126,2,5.25),
(417,397,127,3,4.75),
(418,398,128,4,4.50),
(419,399,129,5,3.80),
(420,400,130,1,5.50),
(421,401,131,2,11.25),
(422,402,132,3,7.25),
(423,403,133,4,8.95),
(424,404,134,5,7.95),
(425,405,135,1,6.25),
(426,406,1,2,4.60),
(427,407,2,3,1.50),
(428,408,3,4,7.00),
(429,409,4,5,2.40),
(430,410,5,1,2.90),
(431,411,6,2,2.50),
(432,412,7,3,4.50),
(433,413,8,4,3.00),
(434,414,9,5,2.00),
(435,415,10,1,4.80),
(436,416,11,2,4.00),
(437,417,12,3,1.80),
(438,418,13,4,2.00),
(439,419,14,5,6.00),
(440,420,15,1,2.50),
(441,421,16,2,5.00),
(442,422,17,3,3.50),
(443,423,18,4,5.50),
(444,424,19,5,2.00),
(445,425,20,1,2.50),
(446,426,21,2,12.00),
(447,427,22,3,9.00),
(448,428,23,4,1.70),
(449,429,24,5,9.00),
(450,430,25,1,0.90),
(451,431,26,2,6.20),
(452,432,27,3,2.50),
(453,433,28,4,4.00),
(454,434,29,5,7.00),
(455,435,30,1,7.00),
(456,436,31,2,8.50),
(457,437,32,3,10.50),
(458,438,33,4,5.00),
(459,439,34,5,6.50),
(460,440,35,1,3.00),
(461,441,36,2,4.80),
(462,442,37,3,4.10),
(463,443,38,4,2.45),
(464,444,39,5,2.00),
(465,445,40,1,0.80),
(466,446,41,2,8.99),
(467,447,42,3,7.49),
(468,448,43,4,14.99),
(469,449,44,5,9.99),
(470,450,45,1,8.49),
(471,451,46,2,12.99),
(472,452,47,3,13.49),
(473,453,48,4,11.99),
(474,454,49,5,16.99),
(475,455,50,1,7.99),
(476,456,51,2,6.99),
(477,457,52,3,10.99),
(478,458,53,4,14.99),
(479,459,54,5,10.99),
(480,460,55,1,15.99),
(481,461,56,2,4.00),
(482,462,57,3,4.00),
(483,463,58,4,5.00),
(484,464,59,5,3.50),
(485,465,60,1,3.00),
(486,466,61,2,3.50),
(487,467,62,3,2.00),
(488,468,63,4,2.50),
(489,469,64,5,1.50),
(490,470,65,1,4.50),
(491,471,66,2,3.50),
(492,472,67,3,3.20),
(493,473,68,4,4.00),
(494,474,69,5,2.00),
(495,475,70,1,4.50),
(496,476,71,2,7.00),
(497,477,72,3,18.00),
(498,478,73,4,12.00),
(499,479,74,5,8.00),
(500,480,75,1,9.00),
(501,481,76,2,16.00),
(502,482,77,3,13.00),
(503,483,78,4,11.00),
(504,484,79,5,8.50),
(505,485,80,1,14.00),
(506,486,81,2,7.50),
(507,487,82,3,15.00),
(508,488,83,4,18.00),
(509,489,84,5,12.00),
(510,490,85,1,10.00),
(511,491,86,2,2.00),
(512,492,87,3,5.00),
(513,493,88,4,10.00),
(514,494,89,5,4.75),
(515,495,90,1,1.50),
(516,496,91,2,2.00),
(517,497,92,3,20.00),
(518,498,93,4,12.00),
(519,499,94,5,10.00),
(520,500,95,1,4.70),
(521,501,96,2,30.00),
(522,502,97,3,6.00),
(523,503,98,4,6.50),
(524,504,99,5,2.50),
(525,505,100,1,1.80),
(526,506,101,2,4.50),
(527,507,102,3,4.35),
(528,508,103,4,4.50),
(529,509,104,5,6.20),
(530,510,105,1,10.00),
(531,511,106,2,2.00),
(532,512,107,3,2.10),
(533,513,108,4,2.50),
(534,514,109,5,8.00),
(535,515,110,1,12.00),
(536,516,111,2,4.50),
(537,517,112,3,8.00),
(538,518,113,4,5.00),
(539,519,114,5,2.30),
(540,520,115,1,4.00);
/*!40000 ALTER TABLE `Order_Line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Order_Status_History`
--

DROP TABLE IF EXISTS `Order_Status_History`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Order_Status_History` (
  `status_history_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `status` enum('pending','processing','shipped','delivered','cancelled','unable_to_fulfill') NOT NULL,
  `changed_at` datetime NOT NULL DEFAULT current_timestamp(),
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`status_history_id`),
  KEY `fk_status_history_order` (`order_id`),
  CONSTRAINT `fk_status_history_order` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=585 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Order_Status_History`
--

LOCK TABLES `Order_Status_History` WRITE;
/*!40000 ALTER TABLE `Order_Status_History` DISABLE KEYS */;
INSERT INTO `Order_Status_History` VALUES
(1,1,'pending','2025-01-15 10:00:00','Order placed'),
(2,1,'processing','2025-01-15 14:30:00','Processing order'),
(3,1,'shipped','2025-01-16 08:00:00','Order shipped'),
(4,1,'delivered','2025-01-18 16:45:00','Delivered to customer'),
(5,2,'pending','2025-01-18 11:00:00','Order placed'),
(6,2,'processing','2025-01-18 15:00:00','Processing order'),
(7,2,'shipped','2025-01-19 09:00:00','Order shipped'),
(8,2,'delivered','2025-01-21 14:00:00','Delivered to customer'),
(9,3,'pending','2025-01-22 09:30:00','Order placed'),
(10,3,'processing','2025-01-22 13:00:00','Processing order'),
(11,3,'shipped','2025-01-23 07:30:00','Order shipped'),
(12,3,'delivered','2025-01-25 15:30:00','Delivered to customer'),
(13,4,'pending','2025-02-05 12:00:00','Order placed'),
(14,4,'processing','2025-02-05 16:00:00','Processing order'),
(15,4,'shipped','2025-02-06 08:30:00','Order shipped'),
(16,4,'delivered','2025-02-08 17:00:00','Delivered to customer'),
(17,5,'pending','2025-02-10 10:15:00','Order placed'),
(18,5,'processing','2025-02-10 14:45:00','Processing order'),
(19,5,'shipped','2025-02-11 09:00:00','Order shipped'),
(20,5,'delivered','2025-02-13 16:30:00','Delivered to customer'),
(21,6,'pending','2025-02-14 11:00:00','Order placed'),
(22,6,'processing','2025-02-14 15:30:00','Processing order'),
(23,6,'shipped','2025-02-15 08:00:00','Order shipped'),
(24,6,'delivered','2025-02-17 14:45:00','Delivered to customer'),
(25,7,'pending','2025-02-20 13:30:00','Order placed'),
(26,7,'processing','2025-02-20 17:00:00','Processing order'),
(27,7,'shipped','2025-02-21 09:30:00','Order shipped'),
(28,7,'delivered','2025-02-23 15:15:00','Delivered to customer'),
(29,8,'pending','2025-03-01 09:45:00','Order placed'),
(30,8,'processing','2025-03-01 14:15:00','Processing order'),
(31,8,'shipped','2025-03-02 08:30:00','Order shipped'),
(32,8,'delivered','2025-03-04 16:00:00','Delivered to customer'),
(33,9,'pending','2025-03-05 10:30:00','Order placed'),
(34,9,'processing','2025-03-05 15:00:00','Processing order'),
(35,9,'shipped','2025-03-06 07:45:00','Order shipped'),
(36,9,'delivered','2025-03-08 17:30:00','Delivered to customer'),
(37,10,'pending','2025-03-12 11:15:00','Order placed'),
(38,10,'processing','2025-03-12 16:00:00','Processing order'),
(39,10,'shipped','2025-03-13 09:00:00','Order shipped'),
(40,10,'delivered','2025-03-15 14:45:00','Delivered to customer'),
(41,11,'pending','2025-03-18 12:00:00','Order placed'),
(42,11,'processing','2025-03-18 16:30:00','Processing order'),
(43,11,'shipped','2025-03-19 08:15:00','Order shipped'),
(44,11,'delivered','2025-03-21 15:00:00','Delivered to customer'),
(45,12,'pending','2025-04-02 10:00:00','Order placed'),
(46,12,'processing','2025-04-02 14:30:00','Processing order'),
(47,12,'shipped','2025-04-03 08:00:00','Order shipped'),
(48,12,'delivered','2025-04-05 16:15:00','Delivered to customer'),
(49,13,'pending','2025-04-08 11:30:00','Order placed'),
(50,13,'processing','2025-04-08 15:45:00','Processing order'),
(51,13,'shipped','2025-04-09 09:00:00','Order shipped'),
(52,13,'delivered','2025-04-11 14:30:00','Delivered to customer'),
(53,14,'pending','2025-04-15 09:15:00','Order placed'),
(54,14,'processing','2025-04-15 13:45:00','Processing order'),
(55,14,'shipped','2025-04-16 08:30:00','Order shipped'),
(56,14,'delivered','2025-04-18 15:45:00','Delivered to customer'),
(57,15,'pending','2025-04-20 12:30:00','Order placed'),
(58,15,'processing','2025-04-20 16:15:00','Processing order'),
(59,15,'cancelled','2025-04-21 08:00:00','Customer requested cancellation'),
(60,16,'pending','2025-05-01 10:45:00','Order placed'),
(61,16,'cancelled','2025-05-01 13:30:00','Customer cancelled order'),
(62,17,'pending','2025-05-08 11:00:00','Order placed'),
(63,17,'processing','2025-05-08 15:30:00','Processing order'),
(64,17,'cancelled','2025-05-09 07:00:00','Customer cancelled - delivery address issue'),
(65,18,'pending','2025-05-15 12:15:00','Order placed'),
(66,18,'processing','2025-05-15 16:00:00','Processing order'),
(67,18,'unable_to_fulfill','2025-05-16 10:30:00','Unable to fulfill - product out of stock'),
(68,19,'pending','2025-05-22 10:30:00','Order placed'),
(69,19,'processing','2025-05-22 14:45:00','Processing order'),
(70,19,'unable_to_fulfill','2025-05-23 11:00:00','Unable to fulfill - supplier shortage on requested items'),
(71,20,'pending','2025-06-01 11:45:00','Order placed'),
(72,20,'processing','2025-06-01 15:15:00','Processing order'),
(73,20,'unable_to_fulfill','2025-06-02 09:00:00','Unable to fulfill - warehouse inventory damaged in incident'),
(74,21,'cancelled','2025-06-02 12:00:00','Synthetic current status for project row-count requirement'),
(75,22,'processing','2025-06-03 12:00:00','Synthetic current status for project row-count requirement'),
(76,23,'delivered','2025-06-04 12:00:00','Synthetic current status for project row-count requirement'),
(77,24,'delivered','2025-06-05 12:00:00','Synthetic current status for project row-count requirement'),
(78,25,'delivered','2025-06-06 12:00:00','Synthetic current status for project row-count requirement'),
(79,26,'delivered','2025-06-07 12:00:00','Synthetic current status for project row-count requirement'),
(80,27,'delivered','2025-06-08 12:00:00','Synthetic current status for project row-count requirement'),
(81,28,'delivered','2025-06-09 12:00:00','Synthetic current status for project row-count requirement'),
(82,29,'delivered','2025-06-10 12:00:00','Synthetic current status for project row-count requirement'),
(83,30,'unable_to_fulfill','2025-06-11 12:00:00','Synthetic current status for project row-count requirement'),
(84,31,'cancelled','2025-06-12 12:00:00','Synthetic current status for project row-count requirement'),
(85,32,'processing','2025-06-13 12:00:00','Synthetic current status for project row-count requirement'),
(86,33,'delivered','2025-06-14 12:00:00','Synthetic current status for project row-count requirement'),
(87,34,'delivered','2025-06-15 12:00:00','Synthetic current status for project row-count requirement'),
(88,35,'delivered','2025-06-16 12:00:00','Synthetic current status for project row-count requirement'),
(89,36,'delivered','2025-06-17 12:00:00','Synthetic current status for project row-count requirement'),
(90,37,'delivered','2025-06-18 12:00:00','Synthetic current status for project row-count requirement'),
(91,38,'delivered','2025-06-19 12:00:00','Synthetic current status for project row-count requirement'),
(92,39,'delivered','2025-06-20 12:00:00','Synthetic current status for project row-count requirement'),
(93,40,'unable_to_fulfill','2025-06-21 12:00:00','Synthetic current status for project row-count requirement'),
(94,41,'cancelled','2025-06-22 12:00:00','Synthetic current status for project row-count requirement'),
(95,42,'processing','2025-06-23 12:00:00','Synthetic current status for project row-count requirement'),
(96,43,'delivered','2025-06-24 12:00:00','Synthetic current status for project row-count requirement'),
(97,44,'delivered','2025-06-25 12:00:00','Synthetic current status for project row-count requirement'),
(98,45,'delivered','2025-06-26 12:00:00','Synthetic current status for project row-count requirement'),
(99,46,'delivered','2025-06-27 12:00:00','Synthetic current status for project row-count requirement'),
(100,47,'delivered','2025-06-28 12:00:00','Synthetic current status for project row-count requirement'),
(101,48,'delivered','2025-06-29 12:00:00','Synthetic current status for project row-count requirement'),
(102,49,'delivered','2025-06-30 12:00:00','Synthetic current status for project row-count requirement'),
(103,50,'unable_to_fulfill','2025-07-01 12:00:00','Synthetic current status for project row-count requirement'),
(104,51,'cancelled','2025-07-02 12:00:00','Synthetic current status for project row-count requirement'),
(105,52,'processing','2025-07-03 12:00:00','Synthetic current status for project row-count requirement'),
(106,53,'delivered','2025-07-04 12:00:00','Synthetic current status for project row-count requirement'),
(107,54,'delivered','2025-07-05 12:00:00','Synthetic current status for project row-count requirement'),
(108,55,'delivered','2025-07-06 12:00:00','Synthetic current status for project row-count requirement'),
(109,56,'delivered','2025-07-07 12:00:00','Synthetic current status for project row-count requirement'),
(110,57,'delivered','2025-07-08 12:00:00','Synthetic current status for project row-count requirement'),
(111,58,'delivered','2025-07-09 12:00:00','Synthetic current status for project row-count requirement'),
(112,59,'delivered','2025-07-10 12:00:00','Synthetic current status for project row-count requirement'),
(113,60,'unable_to_fulfill','2025-07-11 12:00:00','Synthetic current status for project row-count requirement'),
(114,61,'cancelled','2025-07-12 12:00:00','Synthetic current status for project row-count requirement'),
(115,62,'processing','2025-07-13 12:00:00','Synthetic current status for project row-count requirement'),
(116,63,'delivered','2025-07-14 12:00:00','Synthetic current status for project row-count requirement'),
(117,64,'delivered','2025-07-15 12:00:00','Synthetic current status for project row-count requirement'),
(118,65,'delivered','2025-07-16 12:00:00','Synthetic current status for project row-count requirement'),
(119,66,'delivered','2025-07-17 12:00:00','Synthetic current status for project row-count requirement'),
(120,67,'delivered','2025-07-18 12:00:00','Synthetic current status for project row-count requirement'),
(121,68,'delivered','2025-07-19 12:00:00','Synthetic current status for project row-count requirement'),
(122,69,'delivered','2025-07-20 12:00:00','Synthetic current status for project row-count requirement'),
(123,70,'unable_to_fulfill','2025-07-21 12:00:00','Synthetic current status for project row-count requirement'),
(124,71,'cancelled','2025-07-22 12:00:00','Synthetic current status for project row-count requirement'),
(125,72,'processing','2025-07-23 12:00:00','Synthetic current status for project row-count requirement'),
(126,73,'delivered','2025-07-24 12:00:00','Synthetic current status for project row-count requirement'),
(127,74,'delivered','2025-07-25 12:00:00','Synthetic current status for project row-count requirement'),
(128,75,'delivered','2025-07-26 12:00:00','Synthetic current status for project row-count requirement'),
(129,76,'delivered','2025-07-27 12:00:00','Synthetic current status for project row-count requirement'),
(130,77,'delivered','2025-07-28 12:00:00','Synthetic current status for project row-count requirement'),
(131,78,'delivered','2025-07-29 12:00:00','Synthetic current status for project row-count requirement'),
(132,79,'delivered','2025-07-30 12:00:00','Synthetic current status for project row-count requirement'),
(133,80,'unable_to_fulfill','2025-07-31 12:00:00','Synthetic current status for project row-count requirement'),
(134,81,'cancelled','2025-08-01 12:00:00','Synthetic current status for project row-count requirement'),
(135,82,'processing','2025-08-02 12:00:00','Synthetic current status for project row-count requirement'),
(136,83,'delivered','2025-08-03 12:00:00','Synthetic current status for project row-count requirement'),
(137,84,'delivered','2025-08-04 12:00:00','Synthetic current status for project row-count requirement'),
(138,85,'delivered','2025-08-05 12:00:00','Synthetic current status for project row-count requirement'),
(139,86,'delivered','2025-08-06 12:00:00','Synthetic current status for project row-count requirement'),
(140,87,'delivered','2025-08-07 12:00:00','Synthetic current status for project row-count requirement'),
(141,88,'delivered','2025-08-08 12:00:00','Synthetic current status for project row-count requirement'),
(142,89,'delivered','2025-08-09 12:00:00','Synthetic current status for project row-count requirement'),
(143,90,'unable_to_fulfill','2025-08-10 12:00:00','Synthetic current status for project row-count requirement'),
(144,91,'cancelled','2025-08-11 12:00:00','Synthetic current status for project row-count requirement'),
(145,92,'processing','2025-08-12 12:00:00','Synthetic current status for project row-count requirement'),
(146,93,'delivered','2025-08-13 12:00:00','Synthetic current status for project row-count requirement'),
(147,94,'delivered','2025-08-14 12:00:00','Synthetic current status for project row-count requirement'),
(148,95,'delivered','2025-08-15 12:00:00','Synthetic current status for project row-count requirement'),
(149,96,'delivered','2025-08-16 12:00:00','Synthetic current status for project row-count requirement'),
(150,97,'delivered','2025-08-17 12:00:00','Synthetic current status for project row-count requirement'),
(151,98,'delivered','2025-08-18 12:00:00','Synthetic current status for project row-count requirement'),
(152,99,'delivered','2025-08-19 12:00:00','Synthetic current status for project row-count requirement'),
(153,100,'unable_to_fulfill','2025-08-20 12:00:00','Synthetic current status for project row-count requirement'),
(154,101,'cancelled','2025-08-21 12:00:00','Synthetic current status for project row-count requirement'),
(155,102,'processing','2025-08-22 12:00:00','Synthetic current status for project row-count requirement'),
(156,103,'delivered','2025-08-23 12:00:00','Synthetic current status for project row-count requirement'),
(157,104,'delivered','2025-08-24 12:00:00','Synthetic current status for project row-count requirement'),
(158,105,'delivered','2025-08-25 12:00:00','Synthetic current status for project row-count requirement'),
(159,106,'delivered','2025-08-26 12:00:00','Synthetic current status for project row-count requirement'),
(160,107,'delivered','2025-08-27 12:00:00','Synthetic current status for project row-count requirement'),
(161,108,'delivered','2025-08-28 12:00:00','Synthetic current status for project row-count requirement'),
(162,109,'delivered','2025-08-29 12:00:00','Synthetic current status for project row-count requirement'),
(163,110,'unable_to_fulfill','2025-08-30 12:00:00','Synthetic current status for project row-count requirement'),
(164,111,'cancelled','2025-08-31 12:00:00','Synthetic current status for project row-count requirement'),
(165,112,'processing','2025-09-01 12:00:00','Synthetic current status for project row-count requirement'),
(166,113,'delivered','2025-09-02 12:00:00','Synthetic current status for project row-count requirement'),
(167,114,'delivered','2025-09-03 12:00:00','Synthetic current status for project row-count requirement'),
(168,115,'delivered','2025-09-04 12:00:00','Synthetic current status for project row-count requirement'),
(169,116,'delivered','2025-09-05 12:00:00','Synthetic current status for project row-count requirement'),
(170,117,'delivered','2025-09-06 12:00:00','Synthetic current status for project row-count requirement'),
(171,118,'delivered','2025-09-07 12:00:00','Synthetic current status for project row-count requirement'),
(172,119,'delivered','2025-09-08 12:00:00','Synthetic current status for project row-count requirement'),
(173,120,'unable_to_fulfill','2025-09-09 12:00:00','Synthetic current status for project row-count requirement'),
(174,121,'cancelled','2025-09-10 12:00:00','Synthetic current status for project row-count requirement'),
(175,122,'processing','2025-09-11 12:00:00','Synthetic current status for project row-count requirement'),
(176,123,'delivered','2025-09-12 12:00:00','Synthetic current status for project row-count requirement'),
(177,124,'delivered','2025-09-13 12:00:00','Synthetic current status for project row-count requirement'),
(178,125,'delivered','2025-09-14 12:00:00','Synthetic current status for project row-count requirement'),
(179,126,'delivered','2025-09-15 12:00:00','Synthetic current status for project row-count requirement'),
(180,127,'delivered','2025-09-16 12:00:00','Synthetic current status for project row-count requirement'),
(181,128,'delivered','2025-09-17 12:00:00','Synthetic current status for project row-count requirement'),
(182,129,'delivered','2025-09-18 12:00:00','Synthetic current status for project row-count requirement'),
(183,130,'unable_to_fulfill','2025-09-19 12:00:00','Synthetic current status for project row-count requirement'),
(184,131,'cancelled','2025-09-20 12:00:00','Synthetic current status for project row-count requirement'),
(185,132,'processing','2025-09-21 12:00:00','Synthetic current status for project row-count requirement'),
(186,133,'delivered','2025-09-22 12:00:00','Synthetic current status for project row-count requirement'),
(187,134,'delivered','2025-09-23 12:00:00','Synthetic current status for project row-count requirement'),
(188,135,'delivered','2025-09-24 12:00:00','Synthetic current status for project row-count requirement'),
(189,136,'delivered','2025-09-25 12:00:00','Synthetic current status for project row-count requirement'),
(190,137,'delivered','2025-09-26 12:00:00','Synthetic current status for project row-count requirement'),
(191,138,'delivered','2025-09-27 12:00:00','Synthetic current status for project row-count requirement'),
(192,139,'delivered','2025-09-28 12:00:00','Synthetic current status for project row-count requirement'),
(193,140,'unable_to_fulfill','2025-09-29 12:00:00','Synthetic current status for project row-count requirement'),
(194,141,'cancelled','2025-09-30 12:00:00','Synthetic current status for project row-count requirement'),
(195,142,'processing','2025-10-01 12:00:00','Synthetic current status for project row-count requirement'),
(196,143,'delivered','2025-10-02 12:00:00','Synthetic current status for project row-count requirement'),
(197,144,'delivered','2025-10-03 12:00:00','Synthetic current status for project row-count requirement'),
(198,145,'delivered','2025-10-04 12:00:00','Synthetic current status for project row-count requirement'),
(199,146,'delivered','2025-10-05 12:00:00','Synthetic current status for project row-count requirement'),
(200,147,'delivered','2025-10-06 12:00:00','Synthetic current status for project row-count requirement'),
(201,148,'delivered','2025-10-07 12:00:00','Synthetic current status for project row-count requirement'),
(202,149,'delivered','2025-10-08 12:00:00','Synthetic current status for project row-count requirement'),
(203,150,'unable_to_fulfill','2025-10-09 12:00:00','Synthetic current status for project row-count requirement'),
(204,151,'cancelled','2025-10-10 12:00:00','Synthetic current status for project row-count requirement'),
(205,152,'processing','2025-10-11 12:00:00','Synthetic current status for project row-count requirement'),
(206,153,'delivered','2025-10-12 12:00:00','Synthetic current status for project row-count requirement'),
(207,154,'delivered','2025-10-13 12:00:00','Synthetic current status for project row-count requirement'),
(208,155,'delivered','2025-10-14 12:00:00','Synthetic current status for project row-count requirement'),
(209,156,'delivered','2025-10-15 12:00:00','Synthetic current status for project row-count requirement'),
(210,157,'delivered','2025-10-16 12:00:00','Synthetic current status for project row-count requirement'),
(211,158,'delivered','2025-10-17 12:00:00','Synthetic current status for project row-count requirement'),
(212,159,'delivered','2025-10-18 12:00:00','Synthetic current status for project row-count requirement'),
(213,160,'unable_to_fulfill','2025-10-19 12:00:00','Synthetic current status for project row-count requirement'),
(214,161,'cancelled','2025-10-20 12:00:00','Synthetic current status for project row-count requirement'),
(215,162,'processing','2025-10-21 12:00:00','Synthetic current status for project row-count requirement'),
(216,163,'delivered','2025-10-22 12:00:00','Synthetic current status for project row-count requirement'),
(217,164,'delivered','2025-10-23 12:00:00','Synthetic current status for project row-count requirement'),
(218,165,'delivered','2025-10-24 12:00:00','Synthetic current status for project row-count requirement'),
(219,166,'delivered','2025-10-25 12:00:00','Synthetic current status for project row-count requirement'),
(220,167,'delivered','2025-10-26 12:00:00','Synthetic current status for project row-count requirement'),
(221,168,'delivered','2025-10-27 12:00:00','Synthetic current status for project row-count requirement'),
(222,169,'delivered','2025-10-28 12:00:00','Synthetic current status for project row-count requirement'),
(223,170,'unable_to_fulfill','2025-10-29 12:00:00','Synthetic current status for project row-count requirement'),
(224,171,'cancelled','2025-10-30 12:00:00','Synthetic current status for project row-count requirement'),
(225,172,'processing','2025-10-31 12:00:00','Synthetic current status for project row-count requirement'),
(226,173,'delivered','2025-11-01 12:00:00','Synthetic current status for project row-count requirement'),
(227,174,'delivered','2025-11-02 12:00:00','Synthetic current status for project row-count requirement'),
(228,175,'delivered','2025-11-03 12:00:00','Synthetic current status for project row-count requirement'),
(229,176,'delivered','2025-11-04 12:00:00','Synthetic current status for project row-count requirement'),
(230,177,'delivered','2025-11-05 12:00:00','Synthetic current status for project row-count requirement'),
(231,178,'delivered','2025-11-06 12:00:00','Synthetic current status for project row-count requirement'),
(232,179,'delivered','2025-11-07 12:00:00','Synthetic current status for project row-count requirement'),
(233,180,'unable_to_fulfill','2025-11-08 12:00:00','Synthetic current status for project row-count requirement'),
(234,181,'cancelled','2025-11-09 12:00:00','Synthetic current status for project row-count requirement'),
(235,182,'processing','2025-11-10 12:00:00','Synthetic current status for project row-count requirement'),
(236,183,'delivered','2025-11-11 12:00:00','Synthetic current status for project row-count requirement'),
(237,184,'delivered','2025-11-12 12:00:00','Synthetic current status for project row-count requirement'),
(238,185,'delivered','2025-11-13 12:00:00','Synthetic current status for project row-count requirement'),
(239,186,'delivered','2025-11-14 12:00:00','Synthetic current status for project row-count requirement'),
(240,187,'delivered','2025-11-15 12:00:00','Synthetic current status for project row-count requirement'),
(241,188,'delivered','2025-11-16 12:00:00','Synthetic current status for project row-count requirement'),
(242,189,'delivered','2025-11-17 12:00:00','Synthetic current status for project row-count requirement'),
(243,190,'unable_to_fulfill','2025-11-18 12:00:00','Synthetic current status for project row-count requirement'),
(244,191,'cancelled','2025-11-19 12:00:00','Synthetic current status for project row-count requirement'),
(245,192,'processing','2025-11-20 12:00:00','Synthetic current status for project row-count requirement'),
(246,193,'delivered','2025-11-21 12:00:00','Synthetic current status for project row-count requirement'),
(247,194,'delivered','2025-11-22 12:00:00','Synthetic current status for project row-count requirement'),
(248,195,'delivered','2025-11-23 12:00:00','Synthetic current status for project row-count requirement'),
(249,196,'delivered','2025-11-24 12:00:00','Synthetic current status for project row-count requirement'),
(250,197,'delivered','2025-11-25 12:00:00','Synthetic current status for project row-count requirement'),
(251,198,'delivered','2025-11-26 12:00:00','Synthetic current status for project row-count requirement'),
(252,199,'delivered','2025-11-27 12:00:00','Synthetic current status for project row-count requirement'),
(253,200,'unable_to_fulfill','2025-11-28 12:00:00','Synthetic current status for project row-count requirement'),
(254,201,'cancelled','2025-11-29 12:00:00','Synthetic current status for project row-count requirement'),
(255,202,'processing','2025-11-30 12:00:00','Synthetic current status for project row-count requirement'),
(256,203,'delivered','2025-12-01 12:00:00','Synthetic current status for project row-count requirement'),
(257,204,'delivered','2025-12-02 12:00:00','Synthetic current status for project row-count requirement'),
(258,205,'delivered','2025-12-03 12:00:00','Synthetic current status for project row-count requirement'),
(259,206,'delivered','2025-12-04 12:00:00','Synthetic current status for project row-count requirement'),
(260,207,'delivered','2025-12-05 12:00:00','Synthetic current status for project row-count requirement'),
(261,208,'delivered','2025-12-06 12:00:00','Synthetic current status for project row-count requirement'),
(262,209,'delivered','2025-12-07 12:00:00','Synthetic current status for project row-count requirement'),
(263,210,'unable_to_fulfill','2025-12-08 12:00:00','Synthetic current status for project row-count requirement'),
(264,211,'cancelled','2025-12-09 12:00:00','Synthetic current status for project row-count requirement'),
(265,212,'processing','2025-12-10 12:00:00','Synthetic current status for project row-count requirement'),
(266,213,'delivered','2025-12-11 12:00:00','Synthetic current status for project row-count requirement'),
(267,214,'delivered','2025-12-12 12:00:00','Synthetic current status for project row-count requirement'),
(268,215,'delivered','2025-12-13 12:00:00','Synthetic current status for project row-count requirement'),
(269,216,'delivered','2025-12-14 12:00:00','Synthetic current status for project row-count requirement'),
(270,217,'delivered','2025-12-15 12:00:00','Synthetic current status for project row-count requirement'),
(271,218,'delivered','2025-12-16 12:00:00','Synthetic current status for project row-count requirement'),
(272,219,'delivered','2025-12-17 12:00:00','Synthetic current status for project row-count requirement'),
(273,220,'unable_to_fulfill','2025-12-18 12:00:00','Synthetic current status for project row-count requirement'),
(274,221,'cancelled','2025-12-19 12:00:00','Synthetic current status for project row-count requirement'),
(275,222,'processing','2025-12-20 12:00:00','Synthetic current status for project row-count requirement'),
(276,223,'delivered','2025-12-21 12:00:00','Synthetic current status for project row-count requirement'),
(277,224,'delivered','2025-12-22 12:00:00','Synthetic current status for project row-count requirement'),
(278,225,'delivered','2025-12-23 12:00:00','Synthetic current status for project row-count requirement'),
(279,226,'delivered','2025-12-24 12:00:00','Synthetic current status for project row-count requirement'),
(280,227,'delivered','2025-12-25 12:00:00','Synthetic current status for project row-count requirement'),
(281,228,'delivered','2025-12-26 12:00:00','Synthetic current status for project row-count requirement'),
(282,229,'delivered','2025-12-27 12:00:00','Synthetic current status for project row-count requirement'),
(283,230,'unable_to_fulfill','2025-12-28 12:00:00','Synthetic current status for project row-count requirement'),
(284,231,'cancelled','2025-12-29 12:00:00','Synthetic current status for project row-count requirement'),
(285,232,'processing','2025-12-30 12:00:00','Synthetic current status for project row-count requirement'),
(286,233,'delivered','2025-12-31 12:00:00','Synthetic current status for project row-count requirement'),
(287,234,'delivered','2026-01-01 12:00:00','Synthetic current status for project row-count requirement'),
(288,235,'delivered','2026-01-02 12:00:00','Synthetic current status for project row-count requirement'),
(289,236,'delivered','2026-01-03 12:00:00','Synthetic current status for project row-count requirement'),
(290,237,'delivered','2026-01-04 12:00:00','Synthetic current status for project row-count requirement'),
(291,238,'delivered','2026-01-05 12:00:00','Synthetic current status for project row-count requirement'),
(292,239,'delivered','2026-01-06 12:00:00','Synthetic current status for project row-count requirement'),
(293,240,'unable_to_fulfill','2026-01-07 12:00:00','Synthetic current status for project row-count requirement'),
(294,241,'cancelled','2026-01-08 12:00:00','Synthetic current status for project row-count requirement'),
(295,242,'processing','2026-01-09 12:00:00','Synthetic current status for project row-count requirement'),
(296,243,'delivered','2026-01-10 12:00:00','Synthetic current status for project row-count requirement'),
(297,244,'delivered','2026-01-11 12:00:00','Synthetic current status for project row-count requirement'),
(298,245,'delivered','2026-01-12 12:00:00','Synthetic current status for project row-count requirement'),
(299,246,'delivered','2026-01-13 12:00:00','Synthetic current status for project row-count requirement'),
(300,247,'delivered','2026-01-14 12:00:00','Synthetic current status for project row-count requirement'),
(301,248,'delivered','2026-01-15 12:00:00','Synthetic current status for project row-count requirement'),
(302,249,'delivered','2026-01-16 12:00:00','Synthetic current status for project row-count requirement'),
(303,250,'unable_to_fulfill','2026-01-17 12:00:00','Synthetic current status for project row-count requirement'),
(304,251,'cancelled','2026-01-18 12:00:00','Synthetic current status for project row-count requirement'),
(305,252,'processing','2026-01-19 12:00:00','Synthetic current status for project row-count requirement'),
(306,253,'delivered','2026-01-20 12:00:00','Synthetic current status for project row-count requirement'),
(307,254,'delivered','2026-01-21 12:00:00','Synthetic current status for project row-count requirement'),
(308,255,'delivered','2026-01-22 12:00:00','Synthetic current status for project row-count requirement'),
(309,256,'delivered','2026-01-23 12:00:00','Synthetic current status for project row-count requirement'),
(310,257,'delivered','2026-01-24 12:00:00','Synthetic current status for project row-count requirement'),
(311,258,'delivered','2026-01-25 12:00:00','Synthetic current status for project row-count requirement'),
(312,259,'delivered','2026-01-26 12:00:00','Synthetic current status for project row-count requirement'),
(313,260,'unable_to_fulfill','2026-01-27 12:00:00','Synthetic current status for project row-count requirement'),
(314,261,'cancelled','2026-01-28 12:00:00','Synthetic current status for project row-count requirement'),
(315,262,'processing','2026-01-29 12:00:00','Synthetic current status for project row-count requirement'),
(316,263,'delivered','2026-01-30 12:00:00','Synthetic current status for project row-count requirement'),
(317,264,'delivered','2026-01-31 12:00:00','Synthetic current status for project row-count requirement'),
(318,265,'delivered','2026-02-01 12:00:00','Synthetic current status for project row-count requirement'),
(319,266,'delivered','2026-02-02 12:00:00','Synthetic current status for project row-count requirement'),
(320,267,'delivered','2026-02-03 12:00:00','Synthetic current status for project row-count requirement'),
(321,268,'delivered','2026-02-04 12:00:00','Synthetic current status for project row-count requirement'),
(322,269,'delivered','2026-02-05 12:00:00','Synthetic current status for project row-count requirement'),
(323,270,'unable_to_fulfill','2026-02-06 12:00:00','Synthetic current status for project row-count requirement'),
(324,271,'cancelled','2026-02-07 12:00:00','Synthetic current status for project row-count requirement'),
(325,272,'processing','2026-02-08 12:00:00','Synthetic current status for project row-count requirement'),
(326,273,'delivered','2026-02-09 12:00:00','Synthetic current status for project row-count requirement'),
(327,274,'delivered','2026-02-10 12:00:00','Synthetic current status for project row-count requirement'),
(328,275,'delivered','2026-02-11 12:00:00','Synthetic current status for project row-count requirement'),
(329,276,'delivered','2026-02-12 12:00:00','Synthetic current status for project row-count requirement'),
(330,277,'delivered','2026-02-13 12:00:00','Synthetic current status for project row-count requirement'),
(331,278,'delivered','2026-02-14 12:00:00','Synthetic current status for project row-count requirement'),
(332,279,'delivered','2026-02-15 12:00:00','Synthetic current status for project row-count requirement'),
(333,280,'unable_to_fulfill','2026-02-16 12:00:00','Synthetic current status for project row-count requirement'),
(334,281,'cancelled','2026-02-17 12:00:00','Synthetic current status for project row-count requirement'),
(335,282,'processing','2026-02-18 12:00:00','Synthetic current status for project row-count requirement'),
(336,283,'delivered','2026-02-19 12:00:00','Synthetic current status for project row-count requirement'),
(337,284,'delivered','2026-02-20 12:00:00','Synthetic current status for project row-count requirement'),
(338,285,'delivered','2026-02-21 12:00:00','Synthetic current status for project row-count requirement'),
(339,286,'delivered','2026-02-22 12:00:00','Synthetic current status for project row-count requirement'),
(340,287,'delivered','2026-02-23 12:00:00','Synthetic current status for project row-count requirement'),
(341,288,'delivered','2026-02-24 12:00:00','Synthetic current status for project row-count requirement'),
(342,289,'delivered','2026-02-25 12:00:00','Synthetic current status for project row-count requirement'),
(343,290,'unable_to_fulfill','2026-02-26 12:00:00','Synthetic current status for project row-count requirement'),
(344,291,'cancelled','2026-02-27 12:00:00','Synthetic current status for project row-count requirement'),
(345,292,'processing','2026-02-28 12:00:00','Synthetic current status for project row-count requirement'),
(346,293,'delivered','2026-03-01 12:00:00','Synthetic current status for project row-count requirement'),
(347,294,'delivered','2026-03-02 12:00:00','Synthetic current status for project row-count requirement'),
(348,295,'delivered','2026-03-03 12:00:00','Synthetic current status for project row-count requirement'),
(349,296,'delivered','2026-03-04 12:00:00','Synthetic current status for project row-count requirement'),
(350,297,'delivered','2026-03-05 12:00:00','Synthetic current status for project row-count requirement'),
(351,298,'delivered','2026-03-06 12:00:00','Synthetic current status for project row-count requirement'),
(352,299,'delivered','2026-03-07 12:00:00','Synthetic current status for project row-count requirement'),
(353,300,'unable_to_fulfill','2026-03-08 12:00:00','Synthetic current status for project row-count requirement'),
(354,301,'cancelled','2026-03-09 12:00:00','Synthetic current status for project row-count requirement'),
(355,302,'processing','2026-03-10 12:00:00','Synthetic current status for project row-count requirement'),
(356,303,'delivered','2026-03-11 12:00:00','Synthetic current status for project row-count requirement'),
(357,304,'delivered','2026-03-12 12:00:00','Synthetic current status for project row-count requirement'),
(358,305,'delivered','2026-03-13 12:00:00','Synthetic current status for project row-count requirement'),
(359,306,'delivered','2026-03-14 12:00:00','Synthetic current status for project row-count requirement'),
(360,307,'delivered','2026-03-15 12:00:00','Synthetic current status for project row-count requirement'),
(361,308,'delivered','2026-03-16 12:00:00','Synthetic current status for project row-count requirement'),
(362,309,'delivered','2026-03-17 12:00:00','Synthetic current status for project row-count requirement'),
(363,310,'unable_to_fulfill','2026-03-18 12:00:00','Synthetic current status for project row-count requirement'),
(364,311,'cancelled','2026-03-19 12:00:00','Synthetic current status for project row-count requirement'),
(365,312,'processing','2026-03-20 12:00:00','Synthetic current status for project row-count requirement'),
(366,313,'delivered','2026-03-21 12:00:00','Synthetic current status for project row-count requirement'),
(367,314,'delivered','2026-03-22 12:00:00','Synthetic current status for project row-count requirement'),
(368,315,'delivered','2026-03-23 12:00:00','Synthetic current status for project row-count requirement'),
(369,316,'delivered','2026-03-24 12:00:00','Synthetic current status for project row-count requirement'),
(370,317,'delivered','2026-03-25 12:00:00','Synthetic current status for project row-count requirement'),
(371,318,'delivered','2026-03-26 12:00:00','Synthetic current status for project row-count requirement'),
(372,319,'delivered','2026-03-27 12:00:00','Synthetic current status for project row-count requirement'),
(373,320,'unable_to_fulfill','2026-03-28 12:00:00','Synthetic current status for project row-count requirement'),
(374,321,'cancelled','2026-03-29 12:00:00','Synthetic current status for project row-count requirement'),
(375,322,'processing','2026-03-30 12:00:00','Synthetic current status for project row-count requirement'),
(376,323,'delivered','2026-03-31 12:00:00','Synthetic current status for project row-count requirement'),
(377,324,'delivered','2026-04-01 12:00:00','Synthetic current status for project row-count requirement'),
(378,325,'delivered','2026-04-02 12:00:00','Synthetic current status for project row-count requirement'),
(379,326,'delivered','2026-04-03 12:00:00','Synthetic current status for project row-count requirement'),
(380,327,'delivered','2026-04-04 12:00:00','Synthetic current status for project row-count requirement'),
(381,328,'delivered','2026-04-05 12:00:00','Synthetic current status for project row-count requirement'),
(382,329,'delivered','2026-04-06 12:00:00','Synthetic current status for project row-count requirement'),
(383,330,'unable_to_fulfill','2026-04-07 12:00:00','Synthetic current status for project row-count requirement'),
(384,331,'cancelled','2026-04-08 12:00:00','Synthetic current status for project row-count requirement'),
(385,332,'processing','2026-04-09 12:00:00','Synthetic current status for project row-count requirement'),
(386,333,'delivered','2026-04-10 12:00:00','Synthetic current status for project row-count requirement'),
(387,334,'delivered','2026-04-11 12:00:00','Synthetic current status for project row-count requirement'),
(388,335,'delivered','2026-04-12 12:00:00','Synthetic current status for project row-count requirement'),
(389,336,'delivered','2026-04-13 12:00:00','Synthetic current status for project row-count requirement'),
(390,337,'delivered','2026-04-14 12:00:00','Synthetic current status for project row-count requirement'),
(391,338,'delivered','2026-04-15 12:00:00','Synthetic current status for project row-count requirement'),
(392,339,'delivered','2026-04-16 12:00:00','Synthetic current status for project row-count requirement'),
(393,340,'unable_to_fulfill','2026-04-17 12:00:00','Synthetic current status for project row-count requirement'),
(394,341,'cancelled','2026-04-18 12:00:00','Synthetic current status for project row-count requirement'),
(395,342,'processing','2026-04-19 12:00:00','Synthetic current status for project row-count requirement'),
(396,343,'delivered','2026-04-20 12:00:00','Synthetic current status for project row-count requirement'),
(397,344,'delivered','2026-04-21 12:00:00','Synthetic current status for project row-count requirement'),
(398,345,'delivered','2026-04-22 12:00:00','Synthetic current status for project row-count requirement'),
(399,346,'delivered','2026-04-23 12:00:00','Synthetic current status for project row-count requirement'),
(400,347,'delivered','2026-04-24 12:00:00','Synthetic current status for project row-count requirement'),
(401,348,'delivered','2026-04-25 12:00:00','Synthetic current status for project row-count requirement'),
(402,349,'delivered','2026-04-26 12:00:00','Synthetic current status for project row-count requirement'),
(403,350,'unable_to_fulfill','2026-04-27 12:00:00','Synthetic current status for project row-count requirement'),
(404,351,'cancelled','2026-04-28 12:00:00','Synthetic current status for project row-count requirement'),
(405,352,'processing','2026-04-29 12:00:00','Synthetic current status for project row-count requirement'),
(406,353,'delivered','2026-04-30 12:00:00','Synthetic current status for project row-count requirement'),
(407,354,'delivered','2026-05-01 12:00:00','Synthetic current status for project row-count requirement'),
(408,355,'delivered','2026-05-02 12:00:00','Synthetic current status for project row-count requirement'),
(409,356,'delivered','2026-05-03 12:00:00','Synthetic current status for project row-count requirement'),
(410,357,'delivered','2026-05-04 12:00:00','Synthetic current status for project row-count requirement'),
(411,358,'delivered','2026-05-05 12:00:00','Synthetic current status for project row-count requirement'),
(412,359,'delivered','2026-05-06 12:00:00','Synthetic current status for project row-count requirement'),
(413,360,'unable_to_fulfill','2026-05-07 12:00:00','Synthetic current status for project row-count requirement'),
(414,361,'cancelled','2026-05-08 12:00:00','Synthetic current status for project row-count requirement'),
(415,362,'processing','2026-05-09 12:00:00','Synthetic current status for project row-count requirement'),
(416,363,'delivered','2026-05-10 12:00:00','Synthetic current status for project row-count requirement'),
(417,364,'delivered','2026-05-11 12:00:00','Synthetic current status for project row-count requirement'),
(418,365,'delivered','2026-05-12 12:00:00','Synthetic current status for project row-count requirement'),
(419,366,'delivered','2026-05-13 12:00:00','Synthetic current status for project row-count requirement'),
(420,367,'delivered','2026-05-14 12:00:00','Synthetic current status for project row-count requirement'),
(421,368,'delivered','2026-05-15 12:00:00','Synthetic current status for project row-count requirement'),
(422,369,'delivered','2026-05-16 12:00:00','Synthetic current status for project row-count requirement'),
(423,370,'unable_to_fulfill','2026-05-17 12:00:00','Synthetic current status for project row-count requirement'),
(424,371,'cancelled','2026-05-18 12:00:00','Synthetic current status for project row-count requirement'),
(425,372,'processing','2026-05-19 12:00:00','Synthetic current status for project row-count requirement'),
(426,373,'delivered','2026-05-20 12:00:00','Synthetic current status for project row-count requirement'),
(427,374,'delivered','2026-05-21 12:00:00','Synthetic current status for project row-count requirement'),
(428,375,'delivered','2026-05-22 12:00:00','Synthetic current status for project row-count requirement'),
(429,376,'delivered','2026-05-23 12:00:00','Synthetic current status for project row-count requirement'),
(430,377,'delivered','2026-05-24 12:00:00','Synthetic current status for project row-count requirement'),
(431,378,'delivered','2026-05-25 12:00:00','Synthetic current status for project row-count requirement'),
(432,379,'delivered','2026-05-26 12:00:00','Synthetic current status for project row-count requirement'),
(433,380,'unable_to_fulfill','2026-05-27 12:00:00','Synthetic current status for project row-count requirement'),
(434,381,'cancelled','2026-05-28 12:00:00','Synthetic current status for project row-count requirement'),
(435,382,'processing','2026-05-29 12:00:00','Synthetic current status for project row-count requirement'),
(436,383,'delivered','2026-05-30 12:00:00','Synthetic current status for project row-count requirement'),
(437,384,'delivered','2026-05-31 12:00:00','Synthetic current status for project row-count requirement'),
(438,385,'delivered','2026-06-01 12:00:00','Synthetic current status for project row-count requirement'),
(439,386,'delivered','2026-06-02 12:00:00','Synthetic current status for project row-count requirement'),
(440,387,'delivered','2026-06-03 12:00:00','Synthetic current status for project row-count requirement'),
(441,388,'delivered','2026-06-04 12:00:00','Synthetic current status for project row-count requirement'),
(442,389,'delivered','2026-06-05 12:00:00','Synthetic current status for project row-count requirement'),
(443,390,'unable_to_fulfill','2026-06-06 12:00:00','Synthetic current status for project row-count requirement'),
(444,391,'cancelled','2026-06-07 12:00:00','Synthetic current status for project row-count requirement'),
(445,392,'processing','2026-06-08 12:00:00','Synthetic current status for project row-count requirement'),
(446,393,'delivered','2026-06-09 12:00:00','Synthetic current status for project row-count requirement'),
(447,394,'delivered','2026-06-10 12:00:00','Synthetic current status for project row-count requirement'),
(448,395,'delivered','2026-06-11 12:00:00','Synthetic current status for project row-count requirement'),
(449,396,'delivered','2026-06-12 12:00:00','Synthetic current status for project row-count requirement'),
(450,397,'delivered','2026-06-13 12:00:00','Synthetic current status for project row-count requirement'),
(451,398,'delivered','2026-06-14 12:00:00','Synthetic current status for project row-count requirement'),
(452,399,'delivered','2026-06-15 12:00:00','Synthetic current status for project row-count requirement'),
(453,400,'unable_to_fulfill','2026-06-16 12:00:00','Synthetic current status for project row-count requirement'),
(454,401,'cancelled','2026-06-17 12:00:00','Synthetic current status for project row-count requirement'),
(455,402,'processing','2026-06-18 12:00:00','Synthetic current status for project row-count requirement'),
(456,403,'delivered','2026-06-19 12:00:00','Synthetic current status for project row-count requirement'),
(457,404,'delivered','2026-06-20 12:00:00','Synthetic current status for project row-count requirement'),
(458,405,'delivered','2026-06-21 12:00:00','Synthetic current status for project row-count requirement'),
(459,406,'delivered','2026-06-22 12:00:00','Synthetic current status for project row-count requirement'),
(460,407,'delivered','2026-06-23 12:00:00','Synthetic current status for project row-count requirement'),
(461,408,'delivered','2026-06-24 12:00:00','Synthetic current status for project row-count requirement'),
(462,409,'delivered','2026-06-25 12:00:00','Synthetic current status for project row-count requirement'),
(463,410,'unable_to_fulfill','2026-06-26 12:00:00','Synthetic current status for project row-count requirement'),
(464,411,'cancelled','2026-06-27 12:00:00','Synthetic current status for project row-count requirement'),
(465,412,'processing','2026-06-28 12:00:00','Synthetic current status for project row-count requirement'),
(466,413,'delivered','2026-06-29 12:00:00','Synthetic current status for project row-count requirement'),
(467,414,'delivered','2026-06-30 12:00:00','Synthetic current status for project row-count requirement'),
(468,415,'delivered','2026-07-01 12:00:00','Synthetic current status for project row-count requirement'),
(469,416,'delivered','2026-07-02 12:00:00','Synthetic current status for project row-count requirement'),
(470,417,'delivered','2026-07-03 12:00:00','Synthetic current status for project row-count requirement'),
(471,418,'delivered','2026-07-04 12:00:00','Synthetic current status for project row-count requirement'),
(472,419,'delivered','2026-07-05 12:00:00','Synthetic current status for project row-count requirement'),
(473,420,'unable_to_fulfill','2026-07-06 12:00:00','Synthetic current status for project row-count requirement'),
(474,421,'cancelled','2026-07-07 12:00:00','Synthetic current status for project row-count requirement'),
(475,422,'processing','2026-07-08 12:00:00','Synthetic current status for project row-count requirement'),
(476,423,'delivered','2026-07-09 12:00:00','Synthetic current status for project row-count requirement'),
(477,424,'delivered','2026-07-10 12:00:00','Synthetic current status for project row-count requirement'),
(478,425,'delivered','2026-07-11 12:00:00','Synthetic current status for project row-count requirement'),
(479,426,'delivered','2026-07-12 12:00:00','Synthetic current status for project row-count requirement'),
(480,427,'delivered','2026-07-13 12:00:00','Synthetic current status for project row-count requirement'),
(481,428,'delivered','2026-07-14 12:00:00','Synthetic current status for project row-count requirement'),
(482,429,'delivered','2026-07-15 12:00:00','Synthetic current status for project row-count requirement'),
(483,430,'unable_to_fulfill','2026-07-16 12:00:00','Synthetic current status for project row-count requirement'),
(484,431,'cancelled','2026-07-17 12:00:00','Synthetic current status for project row-count requirement'),
(485,432,'processing','2026-07-18 12:00:00','Synthetic current status for project row-count requirement'),
(486,433,'delivered','2026-07-19 12:00:00','Synthetic current status for project row-count requirement'),
(487,434,'delivered','2026-07-20 12:00:00','Synthetic current status for project row-count requirement'),
(488,435,'delivered','2026-07-21 12:00:00','Synthetic current status for project row-count requirement'),
(489,436,'delivered','2026-07-22 12:00:00','Synthetic current status for project row-count requirement'),
(490,437,'delivered','2026-07-23 12:00:00','Synthetic current status for project row-count requirement'),
(491,438,'delivered','2026-07-24 12:00:00','Synthetic current status for project row-count requirement'),
(492,439,'delivered','2026-07-25 12:00:00','Synthetic current status for project row-count requirement'),
(493,440,'unable_to_fulfill','2026-07-26 12:00:00','Synthetic current status for project row-count requirement'),
(494,441,'cancelled','2026-07-27 12:00:00','Synthetic current status for project row-count requirement'),
(495,442,'processing','2026-07-28 12:00:00','Synthetic current status for project row-count requirement'),
(496,443,'delivered','2026-07-29 12:00:00','Synthetic current status for project row-count requirement'),
(497,444,'delivered','2026-07-30 12:00:00','Synthetic current status for project row-count requirement'),
(498,445,'delivered','2026-07-31 12:00:00','Synthetic current status for project row-count requirement'),
(499,446,'delivered','2026-08-01 12:00:00','Synthetic current status for project row-count requirement'),
(500,447,'delivered','2026-08-02 12:00:00','Synthetic current status for project row-count requirement'),
(501,448,'delivered','2026-08-03 12:00:00','Synthetic current status for project row-count requirement'),
(502,449,'delivered','2026-08-04 12:00:00','Synthetic current status for project row-count requirement'),
(503,450,'unable_to_fulfill','2026-08-05 12:00:00','Synthetic current status for project row-count requirement'),
(504,451,'cancelled','2026-08-06 12:00:00','Synthetic current status for project row-count requirement'),
(505,452,'processing','2026-08-07 12:00:00','Synthetic current status for project row-count requirement'),
(506,453,'delivered','2026-08-08 12:00:00','Synthetic current status for project row-count requirement'),
(507,454,'delivered','2026-08-09 12:00:00','Synthetic current status for project row-count requirement'),
(508,455,'delivered','2026-08-10 12:00:00','Synthetic current status for project row-count requirement'),
(509,456,'delivered','2026-08-11 12:00:00','Synthetic current status for project row-count requirement'),
(510,457,'delivered','2026-08-12 12:00:00','Synthetic current status for project row-count requirement'),
(511,458,'delivered','2026-08-13 12:00:00','Synthetic current status for project row-count requirement'),
(512,459,'delivered','2026-08-14 12:00:00','Synthetic current status for project row-count requirement'),
(513,460,'unable_to_fulfill','2026-08-15 12:00:00','Synthetic current status for project row-count requirement'),
(514,461,'cancelled','2026-08-16 12:00:00','Synthetic current status for project row-count requirement'),
(515,462,'processing','2026-08-17 12:00:00','Synthetic current status for project row-count requirement'),
(516,463,'delivered','2026-08-18 12:00:00','Synthetic current status for project row-count requirement'),
(517,464,'delivered','2026-08-19 12:00:00','Synthetic current status for project row-count requirement'),
(518,465,'delivered','2026-08-20 12:00:00','Synthetic current status for project row-count requirement'),
(519,466,'delivered','2026-08-21 12:00:00','Synthetic current status for project row-count requirement'),
(520,467,'delivered','2026-08-22 12:00:00','Synthetic current status for project row-count requirement'),
(521,468,'delivered','2026-08-23 12:00:00','Synthetic current status for project row-count requirement'),
(522,469,'delivered','2026-08-24 12:00:00','Synthetic current status for project row-count requirement'),
(523,470,'unable_to_fulfill','2026-08-25 12:00:00','Synthetic current status for project row-count requirement'),
(524,471,'cancelled','2026-08-26 12:00:00','Synthetic current status for project row-count requirement'),
(525,472,'processing','2026-08-27 12:00:00','Synthetic current status for project row-count requirement'),
(526,473,'delivered','2026-08-28 12:00:00','Synthetic current status for project row-count requirement'),
(527,474,'delivered','2026-08-29 12:00:00','Synthetic current status for project row-count requirement'),
(528,475,'delivered','2026-08-30 12:00:00','Synthetic current status for project row-count requirement'),
(529,476,'delivered','2026-08-31 12:00:00','Synthetic current status for project row-count requirement'),
(530,477,'delivered','2026-09-01 12:00:00','Synthetic current status for project row-count requirement'),
(531,478,'delivered','2026-09-02 12:00:00','Synthetic current status for project row-count requirement'),
(532,479,'delivered','2026-09-03 12:00:00','Synthetic current status for project row-count requirement'),
(533,480,'unable_to_fulfill','2026-09-04 12:00:00','Synthetic current status for project row-count requirement'),
(534,481,'cancelled','2026-09-05 12:00:00','Synthetic current status for project row-count requirement'),
(535,482,'processing','2026-09-06 12:00:00','Synthetic current status for project row-count requirement'),
(536,483,'delivered','2026-09-07 12:00:00','Synthetic current status for project row-count requirement'),
(537,484,'delivered','2026-09-08 12:00:00','Synthetic current status for project row-count requirement'),
(538,485,'delivered','2026-09-09 12:00:00','Synthetic current status for project row-count requirement'),
(539,486,'delivered','2026-09-10 12:00:00','Synthetic current status for project row-count requirement'),
(540,487,'delivered','2026-09-11 12:00:00','Synthetic current status for project row-count requirement'),
(541,488,'delivered','2026-09-12 12:00:00','Synthetic current status for project row-count requirement'),
(542,489,'delivered','2026-09-13 12:00:00','Synthetic current status for project row-count requirement'),
(543,490,'unable_to_fulfill','2026-09-14 12:00:00','Synthetic current status for project row-count requirement'),
(544,491,'cancelled','2026-09-15 12:00:00','Synthetic current status for project row-count requirement'),
(545,492,'processing','2026-09-16 12:00:00','Synthetic current status for project row-count requirement'),
(546,493,'delivered','2026-09-17 12:00:00','Synthetic current status for project row-count requirement'),
(547,494,'delivered','2026-09-18 12:00:00','Synthetic current status for project row-count requirement'),
(548,495,'delivered','2026-09-19 12:00:00','Synthetic current status for project row-count requirement'),
(549,496,'delivered','2026-09-20 12:00:00','Synthetic current status for project row-count requirement'),
(550,497,'delivered','2026-09-21 12:00:00','Synthetic current status for project row-count requirement'),
(551,498,'delivered','2026-09-22 12:00:00','Synthetic current status for project row-count requirement'),
(552,499,'delivered','2026-09-23 12:00:00','Synthetic current status for project row-count requirement'),
(553,500,'unable_to_fulfill','2026-09-24 12:00:00','Synthetic current status for project row-count requirement'),
(554,501,'cancelled','2026-09-25 12:00:00','Synthetic current status for project row-count requirement'),
(555,502,'processing','2026-09-26 12:00:00','Synthetic current status for project row-count requirement'),
(556,503,'delivered','2026-09-27 12:00:00','Synthetic current status for project row-count requirement'),
(557,504,'delivered','2026-09-28 12:00:00','Synthetic current status for project row-count requirement'),
(558,505,'delivered','2026-09-29 12:00:00','Synthetic current status for project row-count requirement'),
(559,506,'delivered','2026-09-30 12:00:00','Synthetic current status for project row-count requirement'),
(560,507,'delivered','2026-10-01 12:00:00','Synthetic current status for project row-count requirement'),
(561,508,'delivered','2026-10-02 12:00:00','Synthetic current status for project row-count requirement'),
(562,509,'delivered','2026-10-03 12:00:00','Synthetic current status for project row-count requirement'),
(563,510,'unable_to_fulfill','2026-10-04 12:00:00','Synthetic current status for project row-count requirement'),
(564,511,'cancelled','2026-10-05 12:00:00','Synthetic current status for project row-count requirement'),
(565,512,'processing','2026-10-06 12:00:00','Synthetic current status for project row-count requirement'),
(566,513,'delivered','2026-10-07 12:00:00','Synthetic current status for project row-count requirement'),
(567,514,'delivered','2026-10-08 12:00:00','Synthetic current status for project row-count requirement'),
(568,515,'delivered','2026-10-09 12:00:00','Synthetic current status for project row-count requirement'),
(569,516,'delivered','2026-10-10 12:00:00','Synthetic current status for project row-count requirement'),
(570,517,'delivered','2026-10-11 12:00:00','Synthetic current status for project row-count requirement'),
(571,518,'delivered','2026-10-12 12:00:00','Synthetic current status for project row-count requirement'),
(572,519,'delivered','2026-10-13 12:00:00','Synthetic current status for project row-count requirement'),
(573,520,'unable_to_fulfill','2026-10-14 12:00:00','Synthetic current status for project row-count requirement');
/*!40000 ALTER TABLE `Order_Status_History` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Produce`
--

DROP TABLE IF EXISTS `Produce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Produce` (
  `product_id` int(10) unsigned NOT NULL,
  `is_organic` tinyint(1) NOT NULL DEFAULT 0,
  `shelf_life_days` int(10) unsigned DEFAULT NULL,
  `storage_temp` decimal(5,2) DEFAULT NULL,
  `origin_region` varchar(80) DEFAULT NULL,
  `season` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_produce_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Produce`
--

LOCK TABLES `Produce` WRITE;
/*!40000 ALTER TABLE `Produce` DISABLE KEYS */;
INSERT INTO `Produce` VALUES
(1,0,14,8.00,'California','Spring/Fall'),
(2,1,21,5.00,'Texas','Winter'),
(3,0,30,5.00,'California','Year-round'),
(4,0,21,8.00,'Florida','Winter'),
(5,0,21,8.00,'Florida','Winter'),
(6,1,10,5.00,'New York','Fall'),
(7,0,14,8.00,'Washington','Fall'),
(8,0,7,10.00,'New Jersey','Summer'),
(9,0,30,8.00,'North Carolina','Fall'),
(10,0,10,12.00,'Mexico','Summer'),
(11,1,10,5.00,'California','Year-round'),
(12,0,7,8.00,'Florida','Year-round'),
(13,0,14,8.00,'Mexico','Year-round'),
(14,0,5,5.00,'Pennsylvania','Spring'),
(15,1,10,5.00,'California','Year-round'),
(16,0,7,8.00,'California','Summer'),
(17,0,10,10.00,'Costa Rica','Year-round'),
(18,0,10,8.00,'California','Fall/Winter'),
(19,0,30,5.00,'New York','Year-round'),
(20,0,7,8.00,'Florida','Year-round');
/*!40000 ALTER TABLE `Produce` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_produce_disjoint_ins BEFORE INSERT ON Produce
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Produce' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Produce';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_produce_disjoint_upd BEFORE UPDATE ON Produce
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Produce' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Produce';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Product`
--

DROP TABLE IF EXISTS `Product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Product` (
  `product_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(150) NOT NULL,
  `product_type` enum('Produce','Meat','Dairy','Bakery','Deli','Frozen','Shelf_Stable') NOT NULL,
  `unit_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `weight` decimal(10,3) DEFAULT NULL,
  `vendor_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `fk_product_vendor` (`vendor_id`),
  CONSTRAINT `fk_product_vendor` FOREIGN KEY (`vendor_id`) REFERENCES `Vendor` (`vendor_id`) ON UPDATE CASCADE,
  CONSTRAINT `chk_product_unit_price` CHECK (`unit_price` >= 0),
  CONSTRAINT `chk_product_weight` CHECK (`weight` is null or `weight` > 0)
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Product`
--

LOCK TABLES `Product` WRITE;
/*!40000 ALTER TABLE `Product` DISABLE KEYS */;
INSERT INTO `Product` VALUES
(1,'Bell Pepper','Produce',4.60,0.250,1),
(2,'Carrot','Produce',1.50,0.200,4),
(3,'Garlic','Produce',7.00,0.100,5),
(4,'Lemon','Produce',2.40,0.150,6),
(5,'Orange','Produce',2.90,0.200,13),
(6,'Cauliflower','Produce',2.50,0.600,15),
(7,'Pear','Produce',4.50,0.300,16),
(8,'Eggplant','Produce',3.00,0.400,19),
(9,'Sweet Potato','Produce',2.00,0.350,22),
(10,'Mango','Produce',4.80,0.400,23),
(11,'Kale','Produce',4.00,0.250,24),
(12,'Cucumber','Produce',1.80,0.400,2),
(13,'Lime','Produce',2.00,0.100,5),
(14,'Mushrooms','Produce',6.00,0.250,23),
(15,'Spinach','Produce',2.50,0.200,24),
(16,'Apricot','Produce',5.00,0.100,20),
(17,'Pineapple','Produce',3.50,1.500,24),
(18,'Grapes','Produce',5.50,0.400,13),
(19,'Onion','Produce',2.00,0.250,15),
(20,'Tomato','Produce',2.50,0.300,15),
(21,'Parmesan Cheese','Dairy',12.00,0.500,3),
(22,'Cheese','Dairy',9.00,0.500,9),
(23,'Yogurt','Dairy',1.70,0.170,10),
(24,'Cheddar Cheese','Dairy',9.00,0.500,11),
(25,'Milk','Dairy',0.90,1.000,3),
(26,'Ricotta Cheese','Dairy',6.20,0.500,18),
(27,'Egg (Turkey)','Dairy',2.50,0.070,17),
(28,'Sour Cream','Dairy',4.00,0.500,9),
(29,'Feta Cheese','Dairy',7.00,0.500,16),
(30,'Gouda Cheese','Dairy',7.00,0.500,11),
(31,'Mozzarella Cheese','Dairy',8.50,0.500,3),
(32,'Swiss Cheese','Dairy',10.50,0.500,11),
(33,'Cream Cheese','Dairy',5.00,0.226,9),
(34,'Butter','Dairy',6.50,0.454,10),
(35,'Greek Yogurt','Dairy',3.00,0.170,10),
(36,'Cottage Cheese','Dairy',4.80,0.500,3),
(37,'Whipped Cream','Dairy',4.10,0.500,9),
(38,'Buttermilk','Dairy',2.45,0.946,10),
(39,'Evaporated Milk','Dairy',2.00,0.354,3),
(40,'Egg (Quail)','Dairy',0.80,0.015,17),
(41,'Ground Beef','Meat',8.99,0.454,5),
(42,'Chicken Breast','Meat',7.49,0.500,5),
(43,'Salmon Fillet','Meat',14.99,0.300,28),
(44,'Pork Chops','Meat',9.99,0.400,5),
(45,'Turkey Breast','Meat',8.49,0.500,28),
(46,'Lamb Chops','Meat',12.99,0.350,5),
(47,'Veal Cutlet','Meat',13.49,0.300,5),
(48,'Duck Breast','Meat',11.99,0.400,28),
(49,'Beef Ribeye','Meat',16.99,0.350,5),
(50,'Ground Turkey','Meat',7.99,0.454,28),
(51,'Chicken Thighs','Meat',6.99,0.500,5),
(52,'Cod Fillet','Meat',10.99,0.300,28),
(53,'Sirloin Steak','Meat',14.99,0.300,5),
(54,'Pork Ribs','Meat',10.99,0.600,5),
(55,'Shrimp','Meat',15.99,0.250,28),
(56,'Digestive Biscuit','Bakery',4.00,0.300,14),
(57,'Sourdough Bread','Bakery',4.00,0.680,25),
(58,'Chocolate Biscuit','Bakery',5.00,0.250,12),
(59,'Whole Wheat Bread','Bakery',3.50,0.680,9),
(60,'Rye Bread','Bakery',3.00,0.680,16),
(61,'Croissant','Bakery',3.50,0.150,25),
(62,'Bagel','Bakery',2.00,0.150,14),
(63,'English Muffin','Bakery',2.50,0.120,25),
(64,'Donut','Bakery',1.50,0.080,14),
(65,'Cinnamon Roll','Bakery',4.50,0.200,25),
(66,'Baguette','Bakery',3.50,0.500,16),
(67,'Multigrain Bread','Bakery',3.20,0.680,9),
(68,'Focaccia Bread','Bakery',4.00,0.400,25),
(69,'Oatmeal Cookie','Bakery',2.00,0.050,14),
(70,'Almond Croissant','Bakery',4.50,0.180,25),
(71,'Tilapia','Frozen',7.00,0.400,28),
(72,'Tuna','Frozen',18.00,0.300,29),
(73,'Trout','Frozen',12.00,0.350,26),
(74,'Cod','Frozen',8.00,0.400,30),
(75,'Haddock','Frozen',9.00,0.350,30),
(76,'Halibut','Frozen',16.00,0.400,28),
(77,'Mahi Mahi','Frozen',13.00,0.350,29),
(78,'Flounder','Frozen',11.00,0.350,26),
(79,'Catfish','Frozen',8.50,0.400,30),
(80,'Bass','Frozen',14.00,0.350,28),
(81,'Pollock','Frozen',7.50,0.350,29),
(82,'Snapper','Frozen',15.00,0.300,26),
(83,'Scallops','Frozen',18.00,0.200,30),
(84,'Clams','Frozen',12.00,0.250,28),
(85,'Mussels','Frozen',10.00,0.300,29),
(86,'Vegetable Oil','Shelf_Stable',2.00,0.946,2),
(87,'Coconut Sugar','Shelf_Stable',5.00,0.500,7),
(88,'Avocado Oil','Shelf_Stable',10.00,0.500,12),
(89,'Jasmine Rice','Shelf_Stable',4.75,0.500,24),
(90,'Bread Flour','Shelf_Stable',1.50,1.000,20),
(91,'Rice Flour','Shelf_Stable',2.00,1.000,24),
(92,'Arabica Coffee','Shelf_Stable',20.00,0.250,21),
(93,'Green Coffee','Shelf_Stable',12.00,0.500,26),
(94,'Robusta Coffee','Shelf_Stable',10.00,0.250,21),
(95,'Black Tea','Shelf_Stable',4.70,0.100,27),
(96,'Herbal Tea','Shelf_Stable',30.00,0.200,27),
(97,'Olive Oil','Shelf_Stable',6.00,0.500,28),
(98,'Sesame Oil','Shelf_Stable',6.50,0.500,12),
(99,'Sunflower Oil','Shelf_Stable',2.50,0.946,24),
(100,'Palm Oil','Shelf_Stable',1.80,0.946,24),
(101,'Basmati Rice','Shelf_Stable',4.50,0.500,24),
(102,'Sushi Rice','Shelf_Stable',4.35,0.500,26),
(103,'Arborio Rice','Shelf_Stable',4.50,0.500,29),
(104,'Black Rice','Shelf_Stable',6.20,0.500,29),
(105,'Wild Rice','Shelf_Stable',10.00,0.454,26),
(106,'White Sugar','Shelf_Stable',2.00,1.000,30),
(107,'Brown Sugar','Shelf_Stable',2.10,1.000,7),
(108,'Powdered Sugar','Shelf_Stable',2.50,1.000,30),
(109,'Honey','Shelf_Stable',8.00,0.680,7),
(110,'Maple Syrup','Shelf_Stable',12.00,0.473,2),
(111,'Peanut Butter','Shelf_Stable',4.50,0.500,21),
(112,'Almond Butter','Shelf_Stable',8.00,0.500,21),
(113,'Coconut Oil','Shelf_Stable',5.00,0.500,12),
(114,'Canola Oil','Shelf_Stable',2.30,0.946,24),
(115,'Peanut Oil','Shelf_Stable',4.00,0.946,25),
(116,'Smoked Turkey','Deli',8.75,0.500,5),
(117,'Black Forest Ham','Deli',7.80,0.500,5),
(118,'Genoa Salami','Deli',9.50,0.400,11),
(119,'Roast Beef Slices','Deli',10.25,0.500,5),
(120,'Pastrami','Deli',10.75,0.500,11),
(121,'Mortadella','Deli',8.25,0.400,15),
(122,'Prosciutto','Deli',14.00,0.250,15),
(123,'Capicola','Deli',12.50,0.300,15),
(124,'Chicken Salad','Deli',6.75,0.500,9),
(125,'Tuna Salad','Deli',6.50,0.500,28),
(126,'Egg Salad','Deli',5.25,0.500,17),
(127,'Potato Salad','Deli',4.75,0.500,9),
(128,'Macaroni Salad','Deli',4.50,0.500,9),
(129,'Coleslaw','Deli',3.80,0.500,9),
(130,'Bologna','Deli',5.50,0.500,5),
(131,'Corned Beef','Deli',11.25,0.500,11),
(132,'Pepperoni','Deli',7.25,0.300,11),
(133,'Swiss Deli Cheese','Deli',8.95,0.500,11),
(134,'Provolone Slices','Deli',7.95,0.500,15),
(135,'Olive Tapenade','Deli',6.25,0.250,12);
/*!40000 ALTER TABLE `Product` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_product_type_lock BEFORE UPDATE ON Product
FOR EACH ROW
BEGIN
    IF NEW.product_type <> OLD.product_type THEN
        IF (OLD.product_type = 'Produce'      AND EXISTS (SELECT 1 FROM Produce      WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Meat'         AND EXISTS (SELECT 1 FROM Meat         WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Dairy'        AND EXISTS (SELECT 1 FROM Dairy        WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Bakery'      AND EXISTS (SELECT 1 FROM Bakery       WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Deli'         AND EXISTS (SELECT 1 FROM Deli         WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Frozen'       AND EXISTS (SELECT 1 FROM Frozen       WHERE product_id = OLD.product_id))
        OR (OLD.product_type = 'Shelf_Stable' AND EXISTS (SELECT 1 FROM Shelf_Stable WHERE product_id = OLD.product_id))
        THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot change Product.product_type while a matching subtype row exists';
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Shelf_Stable`
--

DROP TABLE IF EXISTS `Shelf_Stable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shelf_Stable` (
  `product_id` int(10) unsigned NOT NULL,
  `expiration_date` date DEFAULT NULL,
  `packaging_type` varchar(50) DEFAULT NULL,
  `shelf_life_months` int(10) unsigned DEFAULT NULL,
  `is_canned` tinyint(1) NOT NULL DEFAULT 0,
  `serving_count` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  CONSTRAINT `fk_shelf_stable_product` FOREIGN KEY (`product_id`) REFERENCES `Product` (`product_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shelf_Stable`
--

LOCK TABLES `Shelf_Stable` WRITE;
/*!40000 ALTER TABLE `Shelf_Stable` DISABLE KEYS */;
INSERT INTO `Shelf_Stable` VALUES
(86,'2026-04-26','Bottle',12,0,30),
(87,'2026-01-26','Bag',9,0,20),
(88,'2026-01-26','Bottle',9,0,25),
(89,'2026-04-26','Bag',12,0,40),
(90,'2026-01-26','Bag',12,0,35),
(91,'2026-01-26','Bag',12,0,30),
(92,'2025-10-26','Bag',6,0,40),
(93,'2025-10-26','Bag',6,0,20),
(94,'2025-10-26','Bag',6,0,30),
(95,'2025-09-26','Box',5,0,25),
(96,'2025-11-26','Box',7,0,15),
(97,'2026-01-26','Bottle',9,0,20),
(98,'2025-12-26','Bottle',8,0,25),
(99,'2025-09-26','Bottle',5,0,30),
(100,'2025-10-26','Bottle',6,0,28),
(101,'2026-04-26','Bag',12,0,45),
(102,'2026-04-26','Bag',12,0,40),
(103,'2026-04-26','Bag',12,0,38),
(104,'2026-04-26','Bag',12,0,42),
(105,'2026-04-26','Bag',12,0,35),
(106,'2026-06-26','Bag',24,0,60),
(107,'2026-06-26','Bag',24,0,50),
(108,'2026-12-26','Jar',12,0,15),
(109,'2026-12-26','Bottle',24,0,20),
(110,'2026-04-26','Bottle',9,0,16),
(111,'2026-12-26','Jar',12,0,12),
(112,'2026-12-26','Jar',12,0,14),
(113,'2026-01-26','Bottle',9,0,22),
(114,'2026-04-26','Bottle',12,0,32),
(115,'2026-04-26','Bottle',12,0,28);
/*!40000 ALTER TABLE `Shelf_Stable` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_shelf_stable_disjoint_ins BEFORE INSERT ON Shelf_Stable
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Shelf_Stable' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Shelf_Stable';
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
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER trg_shelf_stable_disjoint_upd BEFORE UPDATE ON Shelf_Stable
FOR EACH ROW
BEGIN
    DECLARE pt VARCHAR(20);
    SELECT product_type INTO pt FROM Product WHERE product_id = NEW.product_id;
    IF pt <> 'Shelf_Stable' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Subtype mismatch: Product.product_type must be Shelf_Stable';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Shipment`
--

DROP TABLE IF EXISTS `Shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Shipment` (
  `shipment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order_id` int(10) unsigned NOT NULL,
  `warehouse_id` int(10) unsigned NOT NULL,
  `ship_date` date DEFAULT NULL,
  `tracking_number` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipment_id`),
  UNIQUE KEY `tracking_number` (`tracking_number`),
  KEY `fk_shipment_order` (`order_id`),
  KEY `fk_shipment_warehouse` (`warehouse_id`),
  CONSTRAINT `fk_shipment_order` FOREIGN KEY (`order_id`) REFERENCES `Order` (`order_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_shipment_warehouse` FOREIGN KEY (`warehouse_id`) REFERENCES `Warehouse` (`warehouse_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=532 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Shipment`
--

LOCK TABLES `Shipment` WRITE;
/*!40000 ALTER TABLE `Shipment` DISABLE KEYS */;
INSERT INTO `Shipment` VALUES
(1,1,1,'2025-01-16','TRK001001'),
(2,2,2,'2025-01-19','TRK001002'),
(3,3,3,'2025-01-23','TRK001003'),
(4,4,4,'2025-02-06','TRK001004'),
(5,5,5,'2025-02-11','TRK001005'),
(6,6,6,'2025-02-15','TRK001006'),
(7,7,7,'2025-02-21','TRK001007'),
(8,8,8,'2025-03-02','TRK001008'),
(9,9,9,'2025-03-06','TRK001009'),
(10,10,10,'2025-03-13','TRK001010'),
(11,11,1,'2025-03-19','TRK001011'),
(12,12,2,'2025-04-03','TRK001012'),
(13,13,3,'2025-04-09','TRK001013'),
(14,14,4,'2025-04-16','TRK001014'),
(15,15,5,'2025-04-21','TRK001015'),
(16,16,6,'2025-05-02','TRK001016'),
(17,17,7,'2025-05-09','TRK001017'),
(18,18,8,'2025-05-16','TRK001018'),
(19,19,9,'2025-05-23','TRK001019'),
(20,20,10,'2025-06-02','TRK001020'),
(21,21,1,'2025-06-02','TRK000021'),
(22,22,2,'2025-06-03','TRK000022'),
(23,23,3,'2025-06-04','TRK000023'),
(24,24,4,'2025-06-05','TRK000024'),
(25,25,5,'2025-06-06','TRK000025'),
(26,26,6,'2025-06-07','TRK000026'),
(27,27,7,'2025-06-08','TRK000027'),
(28,28,8,'2025-06-09','TRK000028'),
(29,29,9,'2025-06-10','TRK000029'),
(30,30,10,'2025-06-11','TRK000030'),
(31,31,1,'2025-06-12','TRK000031'),
(32,32,2,'2025-06-13','TRK000032'),
(33,33,3,'2025-06-14','TRK000033'),
(34,34,4,'2025-06-15','TRK000034'),
(35,35,5,'2025-06-16','TRK000035'),
(36,36,6,'2025-06-17','TRK000036'),
(37,37,7,'2025-06-18','TRK000037'),
(38,38,8,'2025-06-19','TRK000038'),
(39,39,9,'2025-06-20','TRK000039'),
(40,40,10,'2025-06-21','TRK000040'),
(41,41,1,'2025-06-22','TRK000041'),
(42,42,2,'2025-06-23','TRK000042'),
(43,43,3,'2025-06-24','TRK000043'),
(44,44,4,'2025-06-25','TRK000044'),
(45,45,5,'2025-06-26','TRK000045'),
(46,46,6,'2025-06-27','TRK000046'),
(47,47,7,'2025-06-28','TRK000047'),
(48,48,8,'2025-06-29','TRK000048'),
(49,49,9,'2025-06-30','TRK000049'),
(50,50,10,'2025-07-01','TRK000050'),
(51,51,1,'2025-07-02','TRK000051'),
(52,52,2,'2025-07-03','TRK000052'),
(53,53,3,'2025-07-04','TRK000053'),
(54,54,4,'2025-07-05','TRK000054'),
(55,55,5,'2025-07-06','TRK000055'),
(56,56,6,'2025-07-07','TRK000056'),
(57,57,7,'2025-07-08','TRK000057'),
(58,58,8,'2025-07-09','TRK000058'),
(59,59,9,'2025-07-10','TRK000059'),
(60,60,10,'2025-07-11','TRK000060'),
(61,61,1,'2025-07-12','TRK000061'),
(62,62,2,'2025-07-13','TRK000062'),
(63,63,3,'2025-07-14','TRK000063'),
(64,64,4,'2025-07-15','TRK000064'),
(65,65,5,'2025-07-16','TRK000065'),
(66,66,6,'2025-07-17','TRK000066'),
(67,67,7,'2025-07-18','TRK000067'),
(68,68,8,'2025-07-19','TRK000068'),
(69,69,9,'2025-07-20','TRK000069'),
(70,70,10,'2025-07-21','TRK000070'),
(71,71,1,'2025-07-22','TRK000071'),
(72,72,2,'2025-07-23','TRK000072'),
(73,73,3,'2025-07-24','TRK000073'),
(74,74,4,'2025-07-25','TRK000074'),
(75,75,5,'2025-07-26','TRK000075'),
(76,76,6,'2025-07-27','TRK000076'),
(77,77,7,'2025-07-28','TRK000077'),
(78,78,8,'2025-07-29','TRK000078'),
(79,79,9,'2025-07-30','TRK000079'),
(80,80,10,'2025-07-31','TRK000080'),
(81,81,1,'2025-08-01','TRK000081'),
(82,82,2,'2025-08-02','TRK000082'),
(83,83,3,'2025-08-03','TRK000083'),
(84,84,4,'2025-08-04','TRK000084'),
(85,85,5,'2025-08-05','TRK000085'),
(86,86,6,'2025-08-06','TRK000086'),
(87,87,7,'2025-08-07','TRK000087'),
(88,88,8,'2025-08-08','TRK000088'),
(89,89,9,'2025-08-09','TRK000089'),
(90,90,10,'2025-08-10','TRK000090'),
(91,91,1,'2025-08-11','TRK000091'),
(92,92,2,'2025-08-12','TRK000092'),
(93,93,3,'2025-08-13','TRK000093'),
(94,94,4,'2025-08-14','TRK000094'),
(95,95,5,'2025-08-15','TRK000095'),
(96,96,6,'2025-08-16','TRK000096'),
(97,97,7,'2025-08-17','TRK000097'),
(98,98,8,'2025-08-18','TRK000098'),
(99,99,9,'2025-08-19','TRK000099'),
(100,100,10,'2025-08-20','TRK000100'),
(101,101,1,'2025-08-21','TRK000101'),
(102,102,2,'2025-08-22','TRK000102'),
(103,103,3,'2025-08-23','TRK000103'),
(104,104,4,'2025-08-24','TRK000104'),
(105,105,5,'2025-08-25','TRK000105'),
(106,106,6,'2025-08-26','TRK000106'),
(107,107,7,'2025-08-27','TRK000107'),
(108,108,8,'2025-08-28','TRK000108'),
(109,109,9,'2025-08-29','TRK000109'),
(110,110,10,'2025-08-30','TRK000110'),
(111,111,1,'2025-08-31','TRK000111'),
(112,112,2,'2025-09-01','TRK000112'),
(113,113,3,'2025-09-02','TRK000113'),
(114,114,4,'2025-09-03','TRK000114'),
(115,115,5,'2025-09-04','TRK000115'),
(116,116,6,'2025-09-05','TRK000116'),
(117,117,7,'2025-09-06','TRK000117'),
(118,118,8,'2025-09-07','TRK000118'),
(119,119,9,'2025-09-08','TRK000119'),
(120,120,10,'2025-09-09','TRK000120'),
(121,121,1,'2025-09-10','TRK000121'),
(122,122,2,'2025-09-11','TRK000122'),
(123,123,3,'2025-09-12','TRK000123'),
(124,124,4,'2025-09-13','TRK000124'),
(125,125,5,'2025-09-14','TRK000125'),
(126,126,6,'2025-09-15','TRK000126'),
(127,127,7,'2025-09-16','TRK000127'),
(128,128,8,'2025-09-17','TRK000128'),
(129,129,9,'2025-09-18','TRK000129'),
(130,130,10,'2025-09-19','TRK000130'),
(131,131,1,'2025-09-20','TRK000131'),
(132,132,2,'2025-09-21','TRK000132'),
(133,133,3,'2025-09-22','TRK000133'),
(134,134,4,'2025-09-23','TRK000134'),
(135,135,5,'2025-09-24','TRK000135'),
(136,136,6,'2025-09-25','TRK000136'),
(137,137,7,'2025-09-26','TRK000137'),
(138,138,8,'2025-09-27','TRK000138'),
(139,139,9,'2025-09-28','TRK000139'),
(140,140,10,'2025-09-29','TRK000140'),
(141,141,1,'2025-09-30','TRK000141'),
(142,142,2,'2025-10-01','TRK000142'),
(143,143,3,'2025-10-02','TRK000143'),
(144,144,4,'2025-10-03','TRK000144'),
(145,145,5,'2025-10-04','TRK000145'),
(146,146,6,'2025-10-05','TRK000146'),
(147,147,7,'2025-10-06','TRK000147'),
(148,148,8,'2025-10-07','TRK000148'),
(149,149,9,'2025-10-08','TRK000149'),
(150,150,10,'2025-10-09','TRK000150'),
(151,151,1,'2025-10-10','TRK000151'),
(152,152,2,'2025-10-11','TRK000152'),
(153,153,3,'2025-10-12','TRK000153'),
(154,154,4,'2025-10-13','TRK000154'),
(155,155,5,'2025-10-14','TRK000155'),
(156,156,6,'2025-10-15','TRK000156'),
(157,157,7,'2025-10-16','TRK000157'),
(158,158,8,'2025-10-17','TRK000158'),
(159,159,9,'2025-10-18','TRK000159'),
(160,160,10,'2025-10-19','TRK000160'),
(161,161,1,'2025-10-20','TRK000161'),
(162,162,2,'2025-10-21','TRK000162'),
(163,163,3,'2025-10-22','TRK000163'),
(164,164,4,'2025-10-23','TRK000164'),
(165,165,5,'2025-10-24','TRK000165'),
(166,166,6,'2025-10-25','TRK000166'),
(167,167,7,'2025-10-26','TRK000167'),
(168,168,8,'2025-10-27','TRK000168'),
(169,169,9,'2025-10-28','TRK000169'),
(170,170,10,'2025-10-29','TRK000170'),
(171,171,1,'2025-10-30','TRK000171'),
(172,172,2,'2025-10-31','TRK000172'),
(173,173,3,'2025-11-01','TRK000173'),
(174,174,4,'2025-11-02','TRK000174'),
(175,175,5,'2025-11-03','TRK000175'),
(176,176,6,'2025-11-04','TRK000176'),
(177,177,7,'2025-11-05','TRK000177'),
(178,178,8,'2025-11-06','TRK000178'),
(179,179,9,'2025-11-07','TRK000179'),
(180,180,10,'2025-11-08','TRK000180'),
(181,181,1,'2025-11-09','TRK000181'),
(182,182,2,'2025-11-10','TRK000182'),
(183,183,3,'2025-11-11','TRK000183'),
(184,184,4,'2025-11-12','TRK000184'),
(185,185,5,'2025-11-13','TRK000185'),
(186,186,6,'2025-11-14','TRK000186'),
(187,187,7,'2025-11-15','TRK000187'),
(188,188,8,'2025-11-16','TRK000188'),
(189,189,9,'2025-11-17','TRK000189'),
(190,190,10,'2025-11-18','TRK000190'),
(191,191,1,'2025-11-19','TRK000191'),
(192,192,2,'2025-11-20','TRK000192'),
(193,193,3,'2025-11-21','TRK000193'),
(194,194,4,'2025-11-22','TRK000194'),
(195,195,5,'2025-11-23','TRK000195'),
(196,196,6,'2025-11-24','TRK000196'),
(197,197,7,'2025-11-25','TRK000197'),
(198,198,8,'2025-11-26','TRK000198'),
(199,199,9,'2025-11-27','TRK000199'),
(200,200,10,'2025-11-28','TRK000200'),
(201,201,1,'2025-11-29','TRK000201'),
(202,202,2,'2025-11-30','TRK000202'),
(203,203,3,'2025-12-01','TRK000203'),
(204,204,4,'2025-12-02','TRK000204'),
(205,205,5,'2025-12-03','TRK000205'),
(206,206,6,'2025-12-04','TRK000206'),
(207,207,7,'2025-12-05','TRK000207'),
(208,208,8,'2025-12-06','TRK000208'),
(209,209,9,'2025-12-07','TRK000209'),
(210,210,10,'2025-12-08','TRK000210'),
(211,211,1,'2025-12-09','TRK000211'),
(212,212,2,'2025-12-10','TRK000212'),
(213,213,3,'2025-12-11','TRK000213'),
(214,214,4,'2025-12-12','TRK000214'),
(215,215,5,'2025-12-13','TRK000215'),
(216,216,6,'2025-12-14','TRK000216'),
(217,217,7,'2025-12-15','TRK000217'),
(218,218,8,'2025-12-16','TRK000218'),
(219,219,9,'2025-12-17','TRK000219'),
(220,220,10,'2025-12-18','TRK000220'),
(221,221,1,'2025-12-19','TRK000221'),
(222,222,2,'2025-12-20','TRK000222'),
(223,223,3,'2025-12-21','TRK000223'),
(224,224,4,'2025-12-22','TRK000224'),
(225,225,5,'2025-12-23','TRK000225'),
(226,226,6,'2025-12-24','TRK000226'),
(227,227,7,'2025-12-25','TRK000227'),
(228,228,8,'2025-12-26','TRK000228'),
(229,229,9,'2025-12-27','TRK000229'),
(230,230,10,'2025-12-28','TRK000230'),
(231,231,1,'2025-12-29','TRK000231'),
(232,232,2,'2025-12-30','TRK000232'),
(233,233,3,'2025-12-31','TRK000233'),
(234,234,4,'2026-01-01','TRK000234'),
(235,235,5,'2026-01-02','TRK000235'),
(236,236,6,'2026-01-03','TRK000236'),
(237,237,7,'2026-01-04','TRK000237'),
(238,238,8,'2026-01-05','TRK000238'),
(239,239,9,'2026-01-06','TRK000239'),
(240,240,10,'2026-01-07','TRK000240'),
(241,241,1,'2026-01-08','TRK000241'),
(242,242,2,'2026-01-09','TRK000242'),
(243,243,3,'2026-01-10','TRK000243'),
(244,244,4,'2026-01-11','TRK000244'),
(245,245,5,'2026-01-12','TRK000245'),
(246,246,6,'2026-01-13','TRK000246'),
(247,247,7,'2026-01-14','TRK000247'),
(248,248,8,'2026-01-15','TRK000248'),
(249,249,9,'2026-01-16','TRK000249'),
(250,250,10,'2026-01-17','TRK000250'),
(251,251,1,'2026-01-18','TRK000251'),
(252,252,2,'2026-01-19','TRK000252'),
(253,253,3,'2026-01-20','TRK000253'),
(254,254,4,'2026-01-21','TRK000254'),
(255,255,5,'2026-01-22','TRK000255'),
(256,256,6,'2026-01-23','TRK000256'),
(257,257,7,'2026-01-24','TRK000257'),
(258,258,8,'2026-01-25','TRK000258'),
(259,259,9,'2026-01-26','TRK000259'),
(260,260,10,'2026-01-27','TRK000260'),
(261,261,1,'2026-01-28','TRK000261'),
(262,262,2,'2026-01-29','TRK000262'),
(263,263,3,'2026-01-30','TRK000263'),
(264,264,4,'2026-01-31','TRK000264'),
(265,265,5,'2026-02-01','TRK000265'),
(266,266,6,'2026-02-02','TRK000266'),
(267,267,7,'2026-02-03','TRK000267'),
(268,268,8,'2026-02-04','TRK000268'),
(269,269,9,'2026-02-05','TRK000269'),
(270,270,10,'2026-02-06','TRK000270'),
(271,271,1,'2026-02-07','TRK000271'),
(272,272,2,'2026-02-08','TRK000272'),
(273,273,3,'2026-02-09','TRK000273'),
(274,274,4,'2026-02-10','TRK000274'),
(275,275,5,'2026-02-11','TRK000275'),
(276,276,6,'2026-02-12','TRK000276'),
(277,277,7,'2026-02-13','TRK000277'),
(278,278,8,'2026-02-14','TRK000278'),
(279,279,9,'2026-02-15','TRK000279'),
(280,280,10,'2026-02-16','TRK000280'),
(281,281,1,'2026-02-17','TRK000281'),
(282,282,2,'2026-02-18','TRK000282'),
(283,283,3,'2026-02-19','TRK000283'),
(284,284,4,'2026-02-20','TRK000284'),
(285,285,5,'2026-02-21','TRK000285'),
(286,286,6,'2026-02-22','TRK000286'),
(287,287,7,'2026-02-23','TRK000287'),
(288,288,8,'2026-02-24','TRK000288'),
(289,289,9,'2026-02-25','TRK000289'),
(290,290,10,'2026-02-26','TRK000290'),
(291,291,1,'2026-02-27','TRK000291'),
(292,292,2,'2026-02-28','TRK000292'),
(293,293,3,'2026-03-01','TRK000293'),
(294,294,4,'2026-03-02','TRK000294'),
(295,295,5,'2026-03-03','TRK000295'),
(296,296,6,'2026-03-04','TRK000296'),
(297,297,7,'2026-03-05','TRK000297'),
(298,298,8,'2026-03-06','TRK000298'),
(299,299,9,'2026-03-07','TRK000299'),
(300,300,10,'2026-03-08','TRK000300'),
(301,301,1,'2026-03-09','TRK000301'),
(302,302,2,'2026-03-10','TRK000302'),
(303,303,3,'2026-03-11','TRK000303'),
(304,304,4,'2026-03-12','TRK000304'),
(305,305,5,'2026-03-13','TRK000305'),
(306,306,6,'2026-03-14','TRK000306'),
(307,307,7,'2026-03-15','TRK000307'),
(308,308,8,'2026-03-16','TRK000308'),
(309,309,9,'2026-03-17','TRK000309'),
(310,310,10,'2026-03-18','TRK000310'),
(311,311,1,'2026-03-19','TRK000311'),
(312,312,2,'2026-03-20','TRK000312'),
(313,313,3,'2026-03-21','TRK000313'),
(314,314,4,'2026-03-22','TRK000314'),
(315,315,5,'2026-03-23','TRK000315'),
(316,316,6,'2026-03-24','TRK000316'),
(317,317,7,'2026-03-25','TRK000317'),
(318,318,8,'2026-03-26','TRK000318'),
(319,319,9,'2026-03-27','TRK000319'),
(320,320,10,'2026-03-28','TRK000320'),
(321,321,1,'2026-03-29','TRK000321'),
(322,322,2,'2026-03-30','TRK000322'),
(323,323,3,'2026-03-31','TRK000323'),
(324,324,4,'2026-04-01','TRK000324'),
(325,325,5,'2026-04-02','TRK000325'),
(326,326,6,'2026-04-03','TRK000326'),
(327,327,7,'2026-04-04','TRK000327'),
(328,328,8,'2026-04-05','TRK000328'),
(329,329,9,'2026-04-06','TRK000329'),
(330,330,10,'2026-04-07','TRK000330'),
(331,331,1,'2026-04-08','TRK000331'),
(332,332,2,'2026-04-09','TRK000332'),
(333,333,3,'2026-04-10','TRK000333'),
(334,334,4,'2026-04-11','TRK000334'),
(335,335,5,'2026-04-12','TRK000335'),
(336,336,6,'2026-04-13','TRK000336'),
(337,337,7,'2026-04-14','TRK000337'),
(338,338,8,'2026-04-15','TRK000338'),
(339,339,9,'2026-04-16','TRK000339'),
(340,340,10,'2026-04-17','TRK000340'),
(341,341,1,'2026-04-18','TRK000341'),
(342,342,2,'2026-04-19','TRK000342'),
(343,343,3,'2026-04-20','TRK000343'),
(344,344,4,'2026-04-21','TRK000344'),
(345,345,5,'2026-04-22','TRK000345'),
(346,346,6,'2026-04-23','TRK000346'),
(347,347,7,'2026-04-24','TRK000347'),
(348,348,8,'2026-04-25','TRK000348'),
(349,349,9,'2026-04-26','TRK000349'),
(350,350,10,'2026-04-27','TRK000350'),
(351,351,1,'2026-04-28','TRK000351'),
(352,352,2,'2026-04-29','TRK000352'),
(353,353,3,'2026-04-30','TRK000353'),
(354,354,4,'2026-05-01','TRK000354'),
(355,355,5,'2026-05-02','TRK000355'),
(356,356,6,'2026-05-03','TRK000356'),
(357,357,7,'2026-05-04','TRK000357'),
(358,358,8,'2026-05-05','TRK000358'),
(359,359,9,'2026-05-06','TRK000359'),
(360,360,10,'2026-05-07','TRK000360'),
(361,361,1,'2026-05-08','TRK000361'),
(362,362,2,'2026-05-09','TRK000362'),
(363,363,3,'2026-05-10','TRK000363'),
(364,364,4,'2026-05-11','TRK000364'),
(365,365,5,'2026-05-12','TRK000365'),
(366,366,6,'2026-05-13','TRK000366'),
(367,367,7,'2026-05-14','TRK000367'),
(368,368,8,'2026-05-15','TRK000368'),
(369,369,9,'2026-05-16','TRK000369'),
(370,370,10,'2026-05-17','TRK000370'),
(371,371,1,'2026-05-18','TRK000371'),
(372,372,2,'2026-05-19','TRK000372'),
(373,373,3,'2026-05-20','TRK000373'),
(374,374,4,'2026-05-21','TRK000374'),
(375,375,5,'2026-05-22','TRK000375'),
(376,376,6,'2026-05-23','TRK000376'),
(377,377,7,'2026-05-24','TRK000377'),
(378,378,8,'2026-05-25','TRK000378'),
(379,379,9,'2026-05-26','TRK000379'),
(380,380,10,'2026-05-27','TRK000380'),
(381,381,1,'2026-05-28','TRK000381'),
(382,382,2,'2026-05-29','TRK000382'),
(383,383,3,'2026-05-30','TRK000383'),
(384,384,4,'2026-05-31','TRK000384'),
(385,385,5,'2026-06-01','TRK000385'),
(386,386,6,'2026-06-02','TRK000386'),
(387,387,7,'2026-06-03','TRK000387'),
(388,388,8,'2026-06-04','TRK000388'),
(389,389,9,'2026-06-05','TRK000389'),
(390,390,10,'2026-06-06','TRK000390'),
(391,391,1,'2026-06-07','TRK000391'),
(392,392,2,'2026-06-08','TRK000392'),
(393,393,3,'2026-06-09','TRK000393'),
(394,394,4,'2026-06-10','TRK000394'),
(395,395,5,'2026-06-11','TRK000395'),
(396,396,6,'2026-06-12','TRK000396'),
(397,397,7,'2026-06-13','TRK000397'),
(398,398,8,'2026-06-14','TRK000398'),
(399,399,9,'2026-06-15','TRK000399'),
(400,400,10,'2026-06-16','TRK000400'),
(401,401,1,'2026-06-17','TRK000401'),
(402,402,2,'2026-06-18','TRK000402'),
(403,403,3,'2026-06-19','TRK000403'),
(404,404,4,'2026-06-20','TRK000404'),
(405,405,5,'2026-06-21','TRK000405'),
(406,406,6,'2026-06-22','TRK000406'),
(407,407,7,'2026-06-23','TRK000407'),
(408,408,8,'2026-06-24','TRK000408'),
(409,409,9,'2026-06-25','TRK000409'),
(410,410,10,'2026-06-26','TRK000410'),
(411,411,1,'2026-06-27','TRK000411'),
(412,412,2,'2026-06-28','TRK000412'),
(413,413,3,'2026-06-29','TRK000413'),
(414,414,4,'2026-06-30','TRK000414'),
(415,415,5,'2026-07-01','TRK000415'),
(416,416,6,'2026-07-02','TRK000416'),
(417,417,7,'2026-07-03','TRK000417'),
(418,418,8,'2026-07-04','TRK000418'),
(419,419,9,'2026-07-05','TRK000419'),
(420,420,10,'2026-07-06','TRK000420'),
(421,421,1,'2026-07-07','TRK000421'),
(422,422,2,'2026-07-08','TRK000422'),
(423,423,3,'2026-07-09','TRK000423'),
(424,424,4,'2026-07-10','TRK000424'),
(425,425,5,'2026-07-11','TRK000425'),
(426,426,6,'2026-07-12','TRK000426'),
(427,427,7,'2026-07-13','TRK000427'),
(428,428,8,'2026-07-14','TRK000428'),
(429,429,9,'2026-07-15','TRK000429'),
(430,430,10,'2026-07-16','TRK000430'),
(431,431,1,'2026-07-17','TRK000431'),
(432,432,2,'2026-07-18','TRK000432'),
(433,433,3,'2026-07-19','TRK000433'),
(434,434,4,'2026-07-20','TRK000434'),
(435,435,5,'2026-07-21','TRK000435'),
(436,436,6,'2026-07-22','TRK000436'),
(437,437,7,'2026-07-23','TRK000437'),
(438,438,8,'2026-07-24','TRK000438'),
(439,439,9,'2026-07-25','TRK000439'),
(440,440,10,'2026-07-26','TRK000440'),
(441,441,1,'2026-07-27','TRK000441'),
(442,442,2,'2026-07-28','TRK000442'),
(443,443,3,'2026-07-29','TRK000443'),
(444,444,4,'2026-07-30','TRK000444'),
(445,445,5,'2026-07-31','TRK000445'),
(446,446,6,'2026-08-01','TRK000446'),
(447,447,7,'2026-08-02','TRK000447'),
(448,448,8,'2026-08-03','TRK000448'),
(449,449,9,'2026-08-04','TRK000449'),
(450,450,10,'2026-08-05','TRK000450'),
(451,451,1,'2026-08-06','TRK000451'),
(452,452,2,'2026-08-07','TRK000452'),
(453,453,3,'2026-08-08','TRK000453'),
(454,454,4,'2026-08-09','TRK000454'),
(455,455,5,'2026-08-10','TRK000455'),
(456,456,6,'2026-08-11','TRK000456'),
(457,457,7,'2026-08-12','TRK000457'),
(458,458,8,'2026-08-13','TRK000458'),
(459,459,9,'2026-08-14','TRK000459'),
(460,460,10,'2026-08-15','TRK000460'),
(461,461,1,'2026-08-16','TRK000461'),
(462,462,2,'2026-08-17','TRK000462'),
(463,463,3,'2026-08-18','TRK000463'),
(464,464,4,'2026-08-19','TRK000464'),
(465,465,5,'2026-08-20','TRK000465'),
(466,466,6,'2026-08-21','TRK000466'),
(467,467,7,'2026-08-22','TRK000467'),
(468,468,8,'2026-08-23','TRK000468'),
(469,469,9,'2026-08-24','TRK000469'),
(470,470,10,'2026-08-25','TRK000470'),
(471,471,1,'2026-08-26','TRK000471'),
(472,472,2,'2026-08-27','TRK000472'),
(473,473,3,'2026-08-28','TRK000473'),
(474,474,4,'2026-08-29','TRK000474'),
(475,475,5,'2026-08-30','TRK000475'),
(476,476,6,'2026-08-31','TRK000476'),
(477,477,7,'2026-09-01','TRK000477'),
(478,478,8,'2026-09-02','TRK000478'),
(479,479,9,'2026-09-03','TRK000479'),
(480,480,10,'2026-09-04','TRK000480'),
(481,481,1,'2026-09-05','TRK000481'),
(482,482,2,'2026-09-06','TRK000482'),
(483,483,3,'2026-09-07','TRK000483'),
(484,484,4,'2026-09-08','TRK000484'),
(485,485,5,'2026-09-09','TRK000485'),
(486,486,6,'2026-09-10','TRK000486'),
(487,487,7,'2026-09-11','TRK000487'),
(488,488,8,'2026-09-12','TRK000488'),
(489,489,9,'2026-09-13','TRK000489'),
(490,490,10,'2026-09-14','TRK000490'),
(491,491,1,'2026-09-15','TRK000491'),
(492,492,2,'2026-09-16','TRK000492'),
(493,493,3,'2026-09-17','TRK000493'),
(494,494,4,'2026-09-18','TRK000494'),
(495,495,5,'2026-09-19','TRK000495'),
(496,496,6,'2026-09-20','TRK000496'),
(497,497,7,'2026-09-21','TRK000497'),
(498,498,8,'2026-09-22','TRK000498'),
(499,499,9,'2026-09-23','TRK000499'),
(500,500,10,'2026-09-24','TRK000500'),
(501,501,1,'2026-09-25','TRK000501'),
(502,502,2,'2026-09-26','TRK000502'),
(503,503,3,'2026-09-27','TRK000503'),
(504,504,4,'2026-09-28','TRK000504'),
(505,505,5,'2026-09-29','TRK000505'),
(506,506,6,'2026-09-30','TRK000506'),
(507,507,7,'2026-10-01','TRK000507'),
(508,508,8,'2026-10-02','TRK000508'),
(509,509,9,'2026-10-03','TRK000509'),
(510,510,10,'2026-10-04','TRK000510'),
(511,511,1,'2026-10-05','TRK000511'),
(512,512,2,'2026-10-06','TRK000512'),
(513,513,3,'2026-10-07','TRK000513'),
(514,514,4,'2026-10-08','TRK000514'),
(515,515,5,'2026-10-09','TRK000515'),
(516,516,6,'2026-10-10','TRK000516'),
(517,517,7,'2026-10-11','TRK000517'),
(518,518,8,'2026-10-12','TRK000518'),
(519,519,9,'2026-10-13','TRK000519'),
(520,520,10,'2026-10-14','TRK000520');
/*!40000 ALTER TABLE `Shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Vendor`
--

DROP TABLE IF EXISTS `Vendor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Vendor` (
  `vendor_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vendor_name` varchar(100) NOT NULL,
  `country` varchar(60) DEFAULT NULL,
  `contact_name` varchar(100) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`vendor_id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Vendor`
--

LOCK TABLES `Vendor` WRITE;
/*!40000 ALTER TABLE `Vendor` DISABLE KEYS */;
INSERT INTO `Vendor` VALUES
(1,'Eimbee','USA','John Smith','john@eimbee.com','555-0101'),
(2,'Digitube','Canada','Sarah Johnson','sarah@digitube.ca','555-0102'),
(3,'BlogXS','USA','Mike Chen','mike@blogxs.com','555-0103'),
(4,'Avaveo','Mexico','Rosa Garcia','rosa@avaveo.mx','555-0104'),
(5,'Katz','USA','David Brown','david@katz.com','555-0105'),
(6,'Yata','Japan','Yuki Tanaka','yuki@yata.jp','555-0106'),
(7,'Lazz','Brazil','Lucas Silva','lucas@lazz.br','555-0107'),
(8,'Zoonder','Norway','Ole Andersen','ole@zoonder.no','555-0108'),
(9,'Oozz','Greece','Dimitri Papadopoulos','dimitri@oozz.gr','555-0109'),
(10,'Jaxnation','USA','Emily White','emily@jaxnation.com','555-0110'),
(11,'Gabcube','UK','James Miller','james@gabcube.co.uk','555-0111'),
(12,'Dabtype','Spain','Carlos Rodriguez','carlos@dabtype.es','555-0112'),
(13,'Flashdog','France','Marie Dubois','marie@flashdog.fr','555-0113'),
(14,'Devshare','Germany','Klaus Mueller','klaus@devshare.de','555-0114'),
(15,'Cogilith','Italy','Marco Rossi','marco@cogilith.it','555-0115'),
(16,'Roodel','Chile','Diego Morales','diego@roodel.cl','555-0116'),
(17,'Bluezoom','Australia','Sophie Martin','sophie@bluezoom.com.au','555-0117'),
(18,'Skimia','New Zealand','Tom Anderson','tom@skimia.co.nz','555-0118'),
(19,'Blogpad','USA','Rachel Green','rachel@blogpad.com','555-0119'),
(20,'Dabjam','USA','Kevin Lee','kevin@dabjam.com','555-0120'),
(21,'Feedmix','Colombia','Juan Perez','juan@feedmix.com.co','555-0121'),
(22,'Trupe','USA','Lisa Anderson','lisa@trupe.com','555-0122'),
(23,'Meevee','Peru','Pablo Hernandez','pablo@meevee.pe','555-0123'),
(24,'Topicware','Thailand','Somchai Pho','somchai@topicware.th','555-0124'),
(25,'Plajo','USA','Amanda Taylor','amanda@plajo.com','555-0125'),
(26,'Skyndu','Vietnam','Nguyen Tran','nguyen@skyndu.vn','555-0126'),
(27,'Yotz','Ethiopia','Abebe Alemayehu','abebe@yotz.et','555-0127'),
(28,'Vinder','Indonesia','Budi Santoso','budi@vinder.id','555-0128'),
(29,'Geba','USA','Robert Chen','robert@geba.com','555-0129'),
(30,'Dazzlesphere','USA','Jennifer Harris','jennifer@dazzlesphere.com','555-0130');
/*!40000 ALTER TABLE `Vendor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Warehouse`
--

DROP TABLE IF EXISTS `Warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `Warehouse` (
  `warehouse_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `warehouse_name` varchar(100) NOT NULL,
  `address` varchar(200) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(60) DEFAULT NULL,
  `shipping_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  `import_cost` decimal(10,2) NOT NULL DEFAULT 0.00,
  PRIMARY KEY (`warehouse_id`),
  CONSTRAINT `chk_warehouse_shipping_cost` CHECK (`shipping_cost` >= 0),
  CONSTRAINT `chk_warehouse_import_cost` CHECK (`import_cost` >= 0)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Warehouse`
--

LOCK TABLES `Warehouse` WRITE;
/*!40000 ALTER TABLE `Warehouse` DISABLE KEYS */;
INSERT INTO `Warehouse` VALUES
(1,'Pennsylvania Central','20 Pennsylvania Parkway','Pittsburgh','PA',25.00,150.00),
(2,'Oakridge Distribution','03643 Oakridge Lane','Los Angeles','CA',30.00,175.00),
(3,'Graedel Street Hub','73 Graedel Street','Chicago','IL',22.00,145.00),
(4,'Myrtle Center Warehouse','44801 Myrtle Center','Houston','TX',28.00,160.00),
(5,'Monterey Distribution','6195 Monterey Center','Phoenix','AZ',26.00,155.00),
(6,'Anniversary Crossing','5141 Anniversary Crossing','Philadelphia','PA',23.00,148.00),
(7,'Second Pass Storage','38583 2nd Pass','San Antonio','TX',27.00,158.00),
(8,'Porter Junction','86 Porter Junction','San Diego','CA',31.00,170.00),
(9,'Saint Paul Hub','05518 Saint Paul Street','Dallas','TX',25.00,152.00),
(10,'Dottie Avenue Center','14042 Dottie Avenue','San Jose','CA',32.00,172.00),
(11,'Austin Regional','8200 Tech Ridge Blvd','Austin','TX',26.00,154.00),
(12,'Miami Southeast','5555 Biscayne Blvd','Miami','FL',29.00,168.00),
(13,'Denver Rocky','2020 South Colorado','Denver','CO',27.00,162.00),
(14,'Seattle Pacific','1111 Elliott Ave W','Seattle','WA',28.00,165.00),
(15,'Boston Northeast','100 Hanover Street','Boston','MA',24.00,150.00);
/*!40000 ALTER TABLE `Warehouse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `vw_current_inventory`
--

DROP TABLE IF EXISTS `vw_current_inventory`;
/*!50001 DROP VIEW IF EXISTS `vw_current_inventory`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_current_inventory` AS SELECT
 1 AS `inventory_id`,
  1 AS `warehouse_id`,
  1 AS `warehouse_name`,
  1 AS `warehouse_city`,
  1 AS `warehouse_state`,
  1 AS `product_id`,
  1 AS `product_name`,
  1 AS `product_type`,
  1 AS `unit_price`,
  1 AS `vendor_name`,
  1 AS `quantity`,
  1 AS `restock_threshold`,
  1 AS `last_restocked`,
  1 AS `inventory_status` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_current_order_status`
--

DROP TABLE IF EXISTS `vw_current_order_status`;
/*!50001 DROP VIEW IF EXISTS `vw_current_order_status`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_current_order_status` AS SELECT
 1 AS `order_id`,
  1 AS `status`,
  1 AS `changed_at`,
  1 AS `notes` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `vw_order_totals`
--

DROP TABLE IF EXISTS `vw_order_totals`;
/*!50001 DROP VIEW IF EXISTS `vw_order_totals`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `vw_order_totals` AS SELECT
 1 AS `order_id`,
  1 AS `invoice_number`,
  1 AS `invoice_date`,
  1 AS `order_date`,
  1 AS `customer_id`,
  1 AS `customer_name`,
  1 AS `subtotal`,
  1 AS `shipping_amount`,
  1 AS `tax_rate`,
  1 AS `tax_amount`,
  1 AS `invoice_total` */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `vw_current_inventory`
--

/*!50001 DROP VIEW IF EXISTS `vw_current_inventory`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_current_inventory` AS select `i`.`inventory_id` AS `inventory_id`,`w`.`warehouse_id` AS `warehouse_id`,`w`.`warehouse_name` AS `warehouse_name`,`w`.`city` AS `warehouse_city`,`w`.`state` AS `warehouse_state`,`p`.`product_id` AS `product_id`,`p`.`product_name` AS `product_name`,`p`.`product_type` AS `product_type`,`p`.`unit_price` AS `unit_price`,`v`.`vendor_name` AS `vendor_name`,`i`.`quantity` AS `quantity`,`i`.`restock_threshold` AS `restock_threshold`,`i`.`last_restocked` AS `last_restocked`,case when `i`.`quantity` <= `i`.`restock_threshold` then 'RESTOCK' else 'OK' end AS `inventory_status` from (((`Inventory` `i` join `Warehouse` `w` on(`w`.`warehouse_id` = `i`.`warehouse_id`)) join `Product` `p` on(`p`.`product_id` = `i`.`product_id`)) left join `Vendor` `v` on(`v`.`vendor_id` = `p`.`vendor_id`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_current_order_status`
--

/*!50001 DROP VIEW IF EXISTS `vw_current_order_status`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_current_order_status` AS select `osh`.`order_id` AS `order_id`,`osh`.`status` AS `status`,`osh`.`changed_at` AS `changed_at`,`osh`.`notes` AS `notes` from (`Order_Status_History` `osh` join (select `Order_Status_History`.`order_id` AS `order_id`,max(`Order_Status_History`.`changed_at`) AS `changed_at` from `Order_Status_History` group by `Order_Status_History`.`order_id`) `latest` on(`latest`.`order_id` = `osh`.`order_id` and `latest`.`changed_at` = `osh`.`changed_at`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `vw_order_totals`
--

/*!50001 DROP VIEW IF EXISTS `vw_order_totals`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb3 */;
/*!50001 SET character_set_results     = utf8mb3 */;
/*!50001 SET collation_connection      = utf8mb3_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `vw_order_totals` AS select `o`.`order_id` AS `order_id`,concat('ORD-',lpad(`o`.`order_id`,6,'0')) AS `invoice_number`,`o`.`order_date` AS `invoice_date`,`o`.`order_date` AS `order_date`,`c`.`customer_id` AS `customer_id`,concat(`c`.`first_name`,' ',`c`.`last_name`) AS `customer_name`,round(sum(`ol`.`quantity` * `ol`.`unit_price`),2) AS `subtotal`,round(sum(distinct `w`.`shipping_cost`),2) AS `shipping_amount`,0.0725 AS `tax_rate`,round(sum(`ol`.`quantity` * `ol`.`unit_price`) * 0.0725,2) AS `tax_amount`,round(sum(`ol`.`quantity` * `ol`.`unit_price`) + sum(distinct `w`.`shipping_cost`) + sum(`ol`.`quantity` * `ol`.`unit_price`) * 0.0725,2) AS `invoice_total` from ((((`Order` `o` join `Customer` `c` on(`c`.`customer_id` = `o`.`customer_id`)) join `Shipment` `s` on(`s`.`order_id` = `o`.`order_id`)) join `Warehouse` `w` on(`w`.`warehouse_id` = `s`.`warehouse_id`)) join `Order_Line` `ol` on(`ol`.`shipment_id` = `s`.`shipment_id`)) group by `o`.`order_id`,`o`.`order_date`,`c`.`customer_id`,`c`.`first_name`,`c`.`last_name` */;
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
/*M!100616 SET NOTE_VERBOSITY=@OLD_NOTE_VERBOSITY */;

-- Dump completed on 2026-04-27  2:15:02
