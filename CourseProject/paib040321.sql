-- MySQL dump 10.13  Distrib 8.0.23, for Linux (x86_64)
--
-- Host: localhost    Database: piab
-- ------------------------------------------------------
-- Server version	8.0.23

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `Client's_Card`
--

DROP TABLE IF EXISTS `Client's_Card`;
/*!50001 DROP VIEW IF EXISTS `Client's_Card`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `Client's_Card` AS SELECT 
 1 AS `Client Code`,
 1 AS `Client Name`,
 1 AS `Account Number`,
 1 AS `Account currency`,
 1 AS `Card Product`,
 1 AS `Masked PAN`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `LastRates`
--

DROP TABLE IF EXISTS `LastRates`;
/*!50001 DROP VIEW IF EXISTS `LastRates`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `LastRates` AS SELECT 
 1 AS `Date & Time`,
 1 AS `Sell`,
 1 AS `Buy`,
 1 AS `Rate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `List_of_Clients`
--

DROP TABLE IF EXISTS `List_of_Clients`;
/*!50001 DROP VIEW IF EXISTS `List_of_Clients`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `List_of_Clients` AS SELECT 
 1 AS `Client Code`,
 1 AS `Residence`,
 1 AS `Citizenship`,
 1 AS `Client Name`,
 1 AS `Tariff Name`,
 1 AS `Total balance in rubbles`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `List_of_Services`
--

DROP TABLE IF EXISTS `List_of_Services`;
/*!50001 DROP VIEW IF EXISTS `List_of_Services`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `List_of_Services` AS SELECT 
 1 AS `Service Name`,
 1 AS `Service Description`,
 1 AS `Tariff - Basic`,
 1 AS `Tariff - Standard`,
 1 AS `Tariff - Advanced`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `accounts`
--

DROP TABLE IF EXISTS `accounts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `acc_type` char(2) NOT NULL DEFAULT 'cu' COMMENT 'тип счета: cu - текущий счет, dp - депозитный счет, ln - ссудный счет. Типов счетов конечно больше, и по хорошему нужна отдельная таблица - справочник типов счетов. ',
  `sub_acc` tinyint unsigned NOT NULL DEFAULT '1' COMMENT 'Номер субсчета - последовательный номер, начиная с 1 - 1,2, 3 и т.д. В случае, если у клиента возникает больше одного счета данного типа в одной валюте',
  `cur_id` int unsigned NOT NULL COMMENT ' идентификатор валюты счета. ',
  `acc_number` varchar(30) NOT NULL COMMENT 'номер счета',
  `balance` decimal(18,2) NOT NULL DEFAULT '0.00' COMMENT 'текущий баланс счета	',
  `client_id` bigint unsigned NOT NULL COMMENT 'Ссылка на идентификатор клиента, которому принадлежит счет',
  PRIMARY KEY (`id`,`client_id`,`cur_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `acc_number_UNIQUE` (`acc_number`),
  KEY `fk_accounts_cur_1_idx` (`cur_id`),
  KEY `fk_accounts_client1_idx` (`client_id`),
  CONSTRAINT `fk_accounts_client1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_accounts_cur_1` FOREIGN KEY (`cur_id`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица счетов. Содержит информацию о счетах клиентов: типе счета (текущий, депозитный, кредитный), валюте счета, \nномере субсчета (если клиент имеет больше одного счета данного типа в данной валюте), номере счета, текущем остатке';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts`
--

LOCK TABLES `accounts` WRITE;
/*!40000 ALTER TABLE `accounts` DISABLE KEYS */;
INSERT INTO `accounts` VALUES (1,'cu',1,1,'12345678901234567890',1101.00,1),(2,'cu',1,2,'12345678901234567891',1.00,1),(3,'cu',1,3,'12345678901234567892',1.00,1),(4,'cu',1,1,'22345678901234567890',2.00,2),(5,'cu',1,2,'22345678901234567891',2.00,2),(6,'cu',1,3,'22345678901234567892',2.00,2),(7,'cu',1,1,'32345678901234567890',3.00,3),(8,'cu',1,2,'32345678901234567891',3.00,3),(9,'cu',1,3,'32345678901234567892',3.00,3);
/*!40000 ALTER TABLE `accounts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cards`
--

DROP TABLE IF EXISTS `cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cards` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `mps` varchar(30) NOT NULL COMMENT 'Международная платежная система (MPS) - Visa, MasterCard, China Union Pay (CUP) и т.д. ',
  `is_credit` tinyint(1) NOT NULL COMMENT 'Тип карты. 0 - дебетовая, 1 - кредитная',
  `is_virtual` tinyint(1) NOT NULL COMMENT 'признак - виртуальная карта или пластиковая. 0 - пластиковая, 1 - виртуальная',
  `product` varchar(128) NOT NULL COMMENT 'Наименования банковского карточного продукта: MC Standart Next, Visa Classic, MC Black CashBack и т.д.',
  `token` varchar(20) NOT NULL COMMENT 'токенизированный номер карты. Используется для идентификации карты в ИС.',
  `masked_pan` varchar(20) NOT NULL COMMENT 'маскированный номер карты. Обычно 4 последнии цифры, остальные звездочки.',
  `valid_up` varchar(10) NOT NULL COMMENT 'срок действия карты - месяц и год\n',
  `issued_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время выпуска карты.',
  `client_id` bigint unsigned NOT NULL COMMENT 'Ссылка на идентификатор клиента, которому принадлежит карта',
  `accounts_id` bigint unsigned NOT NULL COMMENT 'Ссылка на идентификатор счета, по которому будут проводится операции по карте (с которым связана карта). Карта может быть связана только с одним счетом типа - текущий',
  PRIMARY KEY (`id`,`client_id`,`accounts_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_cards_client1_idx` (`client_id`),
  KEY `fk_cards_accounts1_idx` (`accounts_id`),
  CONSTRAINT `fk_cards_accounts1` FOREIGN KEY (`accounts_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `fk_cards_client1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица карт. У каждого клиента может быть несколько карт. Каждая карта может быть связана только с одним счетом, типа текущий.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cards`
--

LOCK TABLES `cards` WRITE;
/*!40000 ALTER TABLE `cards` DISABLE KEYS */;
INSERT INTO `cards` VALUES (1,'Master Card',0,0,'Master Card Black CashBack','1234567890123456','123456***1234','03/2025','2021-03-04 12:21:17',1,1),(2,'Master Card',0,1,'Master Card Alfa Virtual','1234567890123456','123456***1235','03/2025','2021-03-04 12:24:44',1,1),(3,'VISA',1,0,'VISA GOLD','1234567890123456','123456***1236','03/2025','2021-03-04 12:27:01',1,2),(4,'VISA',0,1,'VISA Standard','1234567890123456','123456***1237','03/2025','2021-03-04 12:30:25',1,3),(5,'Master Card',0,0,'Master Card Black CashBack','1234567890123456','123456***1234','03/2025','2021-03-04 12:33:27',2,1);
/*!40000 ALTER TABLE `cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clients`
--

DROP TABLE IF EXISTS `clients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clients` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `code` int unsigned NOT NULL COMMENT 'код клиента в банке - уникальный идентификатор клиента в банке. ',
  `residence` tinyint unsigned NOT NULL COMMENT 'признак резиденства. Будлево значение: 0 -  не резидент, 1 - резидент',
  `citizenship` varchar(128) DEFAULT NULL COMMENT 'гражданство',
  `registered_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата и время первичной регистрации клиента банке',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата и время обновления информации о клиенте',
  `users_id` bigint unsigned NOT NULL COMMENT 'Ссылка на идентификатор пользователя, с которым связан клиент',
  `tariffs_id` int unsigned NOT NULL,
  PRIMARY KEY (`id`,`users_id`,`tariffs_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_client_users1_idx` (`users_id`),
  KEY `fk_client_tariffs1_idx` (`tariffs_id`),
  CONSTRAINT `fk_client_tariffs1` FOREIGN KEY (`tariffs_id`) REFERENCES `tariffs` (`id`),
  CONSTRAINT `fk_client_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица клиентов. Для банка базовым понятием является клиент. Разделение понятий клиента и пользователя дает большую гибкость в создании будущих продуктов.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clients`
--

LOCK TABLES `clients` WRITE;
/*!40000 ALTER TABLE `clients` DISABLE KEYS */;
INSERT INTO `clients` VALUES (1,2001,1,'Российская Федерация','2021-03-03 19:03:59',NULL,1,1),(2,2002,1,'Российская Федерация','2021-03-03 19:03:59',NULL,2,2),(3,2003,1,'Российская Федерация','2021-03-03 19:03:59',NULL,3,3),(4,2004,1,'Российская Федерация','2021-03-03 19:03:59',NULL,4,1),(5,2005,0,'Российская Федерация','2021-03-03 19:03:59',NULL,5,2),(6,2006,1,'Российская Федерация','2021-03-03 19:03:59',NULL,6,3),(7,2007,1,'Российская Федерация','2021-03-03 19:36:37',NULL,7,1),(8,2008,1,'Российская Федерация','2021-03-03 19:36:37',NULL,8,2),(9,2009,1,'Российская Федерация','2021-03-03 19:36:37',NULL,9,3),(10,2010,1,'Российская Федерация','2021-03-03 19:36:37',NULL,10,1),(11,2011,0,'Российская Федерация','2021-03-03 19:36:37',NULL,11,2),(12,2012,1,'Российская Федерация','2021-03-03 19:36:37',NULL,12,3);
/*!40000 ALTER TABLE `clients` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `currencies`
--

DROP TABLE IF EXISTS `currencies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `currencies` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `code` char(3) NOT NULL,
  `iso_code` char(3) NOT NULL,
  `name` varchar(128) DEFAULT NULL,
  `iso_name` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица содержащая список валют, доступных клиентам';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `currencies`
--

LOCK TABLES `currencies` WRITE;
/*!40000 ALTER TABLE `currencies` DISABLE KEYS */;
INSERT INTO `currencies` VALUES (1,'RUB','643','Российский рубль','Russian Ruble'),(2,'EUR','978','Евро','Euro'),(3,'USD','840','доллар США','US Dollar');
/*!40000 ALTER TABLE `currencies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `from_client` bigint unsigned DEFAULT NULL COMMENT 'идентификатор клиента, который написал сообщение. to_client и from_client - не могут одновременно иметь значение NULL',
  `to_client` bigint unsigned DEFAULT NULL COMMENT 'идентификатор клиента, кому написали сообщение. to_client и from_client - не могут одновременно иметь значение NULL',
  `text` varchar(255) NOT NULL COMMENT 'текст сообщения',
  `attachment` blob COMMENT 'вложение, для иллюстрации сообщения',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_messages_from_client_1_idx` (`from_client`),
  KEY `fk_messages_to_client_1_idx` (`to_client`),
  CONSTRAINT `fk_messages_from_client_1` FOREIGN KEY (`from_client`) REFERENCES `clients` (`id`),
  CONSTRAINT `fk_messages_to_client_1` FOREIGN KEY (`to_client`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица обмена сообщениями с клиентами. Клиент может задавать вопросы, представитель банка (клиентская служба и\\или бот - отвечает).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,1,NULL,'Почему с меня списали 100 рублей?',NULL,'2021-03-04 12:54:54'),(2,NULL,1,'Здравствуйте Евгений, передаю вопрос оператору',NULL,'2021-03-04 12:56:22'),(3,NULL,1,'Здравствуйте Евгений, 100 рублей списано за обслуживание карты согласно тарифам банка.',NULL,'2021-03-04 12:57:36'),(4,1,NULL,'Неожиданно! А давно у Вас поменялись тарифы?',NULL,'2021-03-04 12:58:24'),(5,NULL,1,'Евгений, тарифы изменились с нового года. Чем я могу помочь еще?',NULL,'2021-03-04 12:59:33'),(6,1,NULL,'Спасибо. Больше вопросов нет',NULL,'2021-03-04 13:00:11'),(7,NULL,1,'Евгений, спасибо за обращение! Рада помочь, хорошего дня!',NULL,'2021-03-04 13:01:15'),(8,2,NULL,'Привет, бот!',NULL,'2021-03-04 13:02:11');
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `messages_BEFORE_INSERT` BEFORE INSERT ON `messages` FOR EACH ROW BEGIN
	IF (NEW.from_client IS NULL) AND (NEW.to_client IS NULL) THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Field `from_client` and `to_client` can not be NULL at the same time';
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
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `messages_BEFORE_UPDATE` BEFORE UPDATE ON `messages` FOR EACH ROW BEGIN
	IF (NEW.from_client IS NULL) AND (NEW.to_client IS NULL) THEN
		SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Field `from_client` and `to_client` can not be NULL at the same time';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(255) NOT NULL COMMENT 'текст уведомления',
  `client_id` bigint unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'Дата и время отправки сообщения клиенту',
  PRIMARY KEY (`id`,`client_id`),
  KEY `fk_notifications_client1_idx` (`client_id`),
  CONSTRAINT `fk_notifications_client1` FOREIGN KEY (`client_id`) REFERENCES `clients` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица содержащия уведомления, которые банк посылает клиенту. Это могут быть уведомления о совершенных операциях, готовности услуг и т.д.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (1,'**1234 Покупка совершена успешно. Сумма 106 RUB. Остаток 17 051,51 Пятерочка 28 февраля',1,'2021-03-04 12:44:58'),(2,'VISA1235 25.02.21 17:51 ОТКАЗ. Покупка  305 RUB Азбука вкуса 27 февраля',1,'2021-03-04 12:48:34'),(3,'Документ \"Выписка по счету дебетовой карты\" готов. Документ доступен по ссылке \"ссылка\"',1,'2021-03-04 12:50:20'),(4,'Пополнение счета внутренним переводом',1,'2021-03-04 13:42:56'),(5,'Уважаемый клиент, карта visa1239 активирована',2,'2021-03-04 15:37:14');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operations`
--

DROP TABLE IF EXISTS `operations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `operations` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `amount` decimal(18,2) NOT NULL COMMENT 'сумма операции. Может принимать положительное и отрицательное значение. \nСумма больше нуля - операция зачисления\nСумма меньше нуля - операция списания\nСумма равна нулю - для операций, не связанных с изменением баланса, например, операция открытия счета. \nВ зависимости от бизнес задач, такие операции можно не записывать в эту таблицу. \nТогда можно поставить условие, что сумма не может быть равна нулю',
  `description` varchar(255) NOT NULL COMMENT 'Описание операции, например: "**1508 покупка успешна. Пятерочка. 28 февраля"',
  `accounts_id` bigint unsigned NOT NULL COMMENT 'Ссылка на идентификатор счета, по которому совершается операция, и меняющая его баланс.',
  `cards_id` bigint unsigned DEFAULT NULL COMMENT 'Ссылка на идентификатор карты, если операция карточная. ',
  `services_id` int unsigned NOT NULL COMMENT 'Ссылка на идентификатор услуги, которой соответствует операция',
  PRIMARY KEY (`id`,`accounts_id`,`services_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_operations_accounts1_idx` (`accounts_id`),
  KEY `fk_operations_cards1_idx` (`cards_id`),
  KEY `fk_operations_services1_idx` (`services_id`),
  CONSTRAINT `fk_operations_accounts1` FOREIGN KEY (`accounts_id`) REFERENCES `accounts` (`id`),
  CONSTRAINT `fk_operations_cards1` FOREIGN KEY (`cards_id`) REFERENCES `cards` (`id`),
  CONSTRAINT `fk_operations_services1` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица содержащая список операций. Операции могут относиться к счетам и картам. Каждая операция относится к какому либо счету. \nНе каждая операция относится к какой-либо карте';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operations`
--

LOCK TABLES `operations` WRITE;
/*!40000 ALTER TABLE `operations` DISABLE KEYS */;
INSERT INTO `operations` VALUES (1,1000.00,'Пополнение счета',1,NULL,7),(2,100.00,'Пополнение счета внутренним переводом',1,NULL,7);
/*!40000 ALTER TABLE `operations` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `operations_BEFORE_INSERT` BEFORE INSERT ON `operations` FOR EACH ROW BEGIN
 DECLARE new_balance DECIMAL(18,2) default 0;
 DECLARE id_client BIGINT;
 SELECT balance, client_id INTO new_balance, id_client FROM accounts a WHERE a.id = NEW.accounts_id;
 UPDATE accounts a SET balance = (new_balance + NEW.amount) WHERE a.id = NEW.accounts_id;
 INSERT notifications (message, client_id) VALUES (NEW.description, id_client);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `profiles`
--

DROP TABLE IF EXISTS `profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `profiles` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL COMMENT 'имя',
  `last_name` varchar(255) NOT NULL COMMENT 'фамилия',
  `dob` date NOT NULL COMMENT 'дата рождения',
  `gender` enum('m','f','not defined') DEFAULT NULL COMMENT 'пол',
  `address` varchar(255) NOT NULL COMMENT 'адрес',
  `gov_id` blob COMMENT 'скан паспорта или другого идентификационного документа',
  `avatar` blob COMMENT 'аватар или селфи',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата и время создания профиля',
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'дата и время обновления профиля',
  `users_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`,`users_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_profiles_users_idx` (`users_id`),
  CONSTRAINT `fk_profiles_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица профилей клиентов.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `profiles`
--

LOCK TABLES `profiles` WRITE;
/*!40000 ALTER TABLE `profiles` DISABLE KEYS */;
INSERT INTO `profiles` VALUES (1,'Евгений','Пашкевич','1979-11-14','m','Москва, Россия',NULL,NULL,'2021-03-03 18:44:48',NULL,1),(2,'Татьяна','Волкова','1986-03-08','f','Санкт-Петербург, Россия',NULL,NULL,'2021-03-03 18:44:48',NULL,2),(3,'Александр','Дуров','1990-05-16','m','Краснодар, Россия',NULL,NULL,'2021-03-03 18:44:48',NULL,3),(4,'Наталья','Гундарева','1975-08-31','f','Казань, Россия',NULL,NULL,'2021-03-03 18:44:48',NULL,4),(5,'Леонид','Артюхин','1978-04-16','m','Калининград, Россия',NULL,NULL,'2021-03-03 18:44:48',NULL,5),(6,'Людмила','Алексеева','1988-12-31','f','Новосибирск, Россия',NULL,NULL,'2021-03-03 18:44:48',NULL,6),(7,'Константин','Берлов','1979-11-14','m','Пенза, Россия',NULL,NULL,'2021-03-03 19:35:21',NULL,7),(8,'Марина','Андреенко','1986-03-08','f','Сартов, Россия',NULL,NULL,'2021-03-03 19:35:21',NULL,8),(9,'Михаил','Строганов','1990-05-16','m','Владимир, Россия',NULL,NULL,'2021-03-03 19:35:21',NULL,9),(10,'Анастасия','Петренко','1975-08-31','f','Вологда, Россия',NULL,NULL,'2021-03-03 19:35:21',NULL,10),(11,'Федор','Малкин','1978-04-16','m','Челябинск, Россия',NULL,NULL,'2021-03-03 19:35:21',NULL,11),(12,'Ольга','Иванова','1988-12-31','f','Воркута, Россия',NULL,NULL,'2021-03-03 19:35:21',NULL,12);
/*!40000 ALTER TABLE `profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rates`
--

DROP TABLE IF EXISTS `rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rates` (
  `timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'UNIX TIMESTAMP используется как возрастающий идентификатор записей курсов валют. Значения курсов для каждой пары валют в таблицу могут вносится много раз в день.',
  `date_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата и время, соответствующие данному курсу. По умолчанию - дата и время вставки в базу данных, но может задаваться  и явно',
  `cur_2_sell` int unsigned NOT NULL COMMENT 'ссылка на запись в таблице - currencies, обнозначающая валюту для продажи.',
  `cur_2_buy` int unsigned NOT NULL COMMENT 'ссылка на запись в таблице - currencies, обнозначающая валюту для покупки.',
  `rate` decimal(18,6) NOT NULL COMMENT 'курс для данной пары валют. точность - 6 знаков после запятой',
  KEY `fk_rates_cur_sell_1_idx` (`cur_2_sell`),
  KEY `fk_rates_cur_buy_1_idx` (`cur_2_buy`),
  KEY `timestamp_INDEX` (`timestamp` DESC),
  CONSTRAINT `fk_rates_cur_buy_1` FOREIGN KEY (`cur_2_buy`) REFERENCES `currencies` (`id`),
  CONSTRAINT `fk_rates_cur_sell_1` FOREIGN KEY (`cur_2_sell`) REFERENCES `currencies` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица курсов валют. Может актуализироваться несколько раз в день. Для расчета доступного баланса, должен использоваться последний актуальный на дату  курс валют.\nИли если нужна историческая справка, то используется курс, ближайший снизу к интересующей дате и времени.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rates`
--

LOCK TABLES `rates` WRITE;
/*!40000 ALTER TABLE `rates` DISABLE KEYS */;
INSERT INTO `rates` VALUES ('2021-03-02 14:32:50','2021-03-02 17:32:50',3,1,73.010000),('2021-03-02 14:33:03','2021-03-02 17:33:03',1,3,74.510000),('2021-03-02 14:43:51','2021-03-02 17:43:51',3,1,73.010560),('2021-03-02 14:44:02','2021-03-02 17:44:02',1,3,74.520100),('2021-03-02 14:44:30','2021-03-02 17:44:30',3,1,73.110000),('2021-03-02 14:51:25','2021-03-02 17:51:25',3,1,73.110000),('2021-03-02 14:51:25','2021-03-02 17:51:25',1,3,74.490100),('2021-03-02 15:41:00','2021-03-02 18:41:00',2,1,88.280000),('2021-03-02 15:41:00','2021-03-02 18:41:00',1,2,89.780000),('2021-03-03 14:31:44','2021-03-03 17:31:44',2,1,88.380000),('2021-03-03 14:31:44','2021-03-03 17:31:44',1,2,90.780000);
/*!40000 ALTER TABLE `rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT 'Наименование услуги',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание услуги',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица с перечнем услуг банка. Доступность услуг организуется посредством тарифных планов, на которые подписался клиент. \nесли услуга входит в более дорогой тариф, значит она доступна и на более дешевых тарифах.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'Open account','Открытие счета'),(2,'Open currency account','Открытие валютного счета счета'),(3,'Issue card','Выпуск карты'),(4,'Issue additional card','Выпуск дополнительной карты'),(5,'Issue virtual card','Выпуск виртуальной карты'),(6,'Issue additional virtual card','Выпуск дополнительной виртуальной карты'),(7,'Internal Transfer','Перевод средств клиенту банка'),(8,'External Transfer','Перевод средств клиенту другого банка'),(9,'Tariff payment','Оплата тарифного плана'),(10,'Service Fee','Комиссия за услуги банка'),(11,'Utility payment','Оплата коммунальных услуг'),(12,'Mobile payment','Оплата мобильного телефона'),(13,'Card purchase','Покупка с использованием карты'),(14,'Cash withdrawal','Снятие наличных в банкоматах банка'),(15,'Cash withdrawal ext','Снятие наличных в банкоматах другого банка'),(16,'External Transfer curr','Перевод средств в валюте'),(17,'Card top up','Пополнение карт');
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `logged_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'дата и время начала сеанса',
  `ip_address` varchar(35) NOT NULL COMMENT 'IP адрес, с которого был осуществлен вход. Обязательное поле.',
  `device_id` varchar(36) DEFAULT NULL COMMENT 'идентификатор устройства, с которого был осуществлен вход',
  `device_name` varchar(128) DEFAULT NULL COMMENT 'имя устройства, с которого был осуществлен вход',
  `location` varchar(255) DEFAULT NULL COMMENT 'примерное расположение пользователя, на основе IP адреса',
  `users_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`id`,`users_id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `fk_sessions_users1_idx` (`users_id`),
  CONSTRAINT `fk_sessions_users1` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица содержащая историю сессий клиентов';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES (1,'2021-03-03 19:53:34','195.1.10.223','75d20e85-6bf2-4799-84a1-8c23a502fb96','Windows PC, Windows 10, Chrome',NULL,1),(2,'2021-03-03 20:17:10','210.120.1.12','75d20e85-6bf2-4799-84a1-8c23a502fb96','MAC OS, Canberra, Safari',NULL,1),(3,'2021-03-03 20:18:06','212.20.112.22','0035a5af-d69e-4746-8f96-3a0635a0acfd','iPHONE, iOS 14.1 Safari',NULL,1),(4,'2021-03-03 20:18:55','10.58.11.132','a91f28bb-461b-49ef-bc41-d055d55a1cef','Windows PC, Windows 10, Internet Explorer 10',NULL,1),(5,'2021-03-03 20:20:03','11.11.10.226','d7e29a20-0207-4e71-82dd-50a6e09a2d43','MAC OS, Canberra, Safari',NULL,1),(6,'2021-03-03 20:21:20','195.20.101.2','7648b2ea-e87d-4cc6-bb48-b0ef5ca7961a','iPHONE, iOS 14.1 Safari',NULL,1),(7,'2021-03-03 23:19:56','195.20.101.2','7648b2ea-e87d-4cc6-bb48-b0ef5ca7961a','iPHONE, iOS 14.1 Safari','Москва, Россия',1);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariffs`
--

DROP TABLE IF EXISTS `tariffs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tariffs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL COMMENT 'Наименование тарифного плана',
  `description` varchar(255) DEFAULT NULL COMMENT 'Описание тарифного плана',
  `price_m` decimal(18,2) NOT NULL COMMENT 'стоимость в базовой валюте (рублях) в месяц',
  `price_y` decimal(18,2) NOT NULL COMMENT 'стоимость в базовой валюте (рублях) в год.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица тарифных планов. Действующих тарифных планов обычно немного. Каждый тарифный план включает набор функциональных возможностей, доступных на нем (перечислены в таблице services).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariffs`
--

LOCK TABLES `tariffs` WRITE;
/*!40000 ALTER TABLE `tariffs` DISABLE KEYS */;
INSERT INTO `tariffs` VALUES (1,'Basic','Базовый бесплатный тариф',0.00,0.00),(2,'Standard','Стандартный тариф',300.00,3000.00),(3,'Advanced','Продвинутый тариф. Все включено',1000.00,11000.00);
/*!40000 ALTER TABLE `tariffs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tariffs_services`
--

DROP TABLE IF EXISTS `tariffs_services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tariffs_services` (
  `tariffs_id` int unsigned NOT NULL COMMENT 'Ссылка на идентификатор тарифного плана',
  `services_id` int unsigned NOT NULL COMMENT 'Ссылка на идентификатор услуги',
  PRIMARY KEY (`tariffs_id`,`services_id`),
  KEY `fk_tariffs_services_services1_idx` (`services_id`),
  CONSTRAINT `fk_tariffs_services_services1` FOREIGN KEY (`services_id`) REFERENCES `services` (`id`),
  CONSTRAINT `fk_tariffs_services_tariffs1` FOREIGN KEY (`tariffs_id`) REFERENCES `tariffs` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица соответствия тарифных планов и входящих в них услуг. Более старшие тарифные планы содержат услуги всех предыдущих тарифных планов.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tariffs_services`
--

LOCK TABLES `tariffs_services` WRITE;
/*!40000 ALTER TABLE `tariffs_services` DISABLE KEYS */;
INSERT INTO `tariffs_services` VALUES (1,1),(2,1),(3,1),(2,2),(3,2),(1,3),(2,3),(3,3),(3,4),(2,5),(3,5),(3,6),(1,7),(2,7),(3,7),(1,8),(2,8),(3,8),(1,9),(2,9),(3,9),(1,10),(2,10),(3,10),(1,11),(2,11),(3,11),(1,12),(2,12),(3,12),(1,13),(2,13),(3,13),(1,14),(2,14),(3,14),(2,15),(3,15),(2,16),(3,16);
/*!40000 ALTER TABLE `tariffs_services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `phone` bigint NOT NULL COMMENT 'номер телефона является обязательным',
  `email` varchar(255) DEFAULT NULL,
  `pass_hash` varchar(60) DEFAULT NULL COMMENT 'хэш пароля, SHA-1',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 - normal\n1 - view only\n2 - limited operations\nНаличие данного статуса в этом месте, позволяет использовать статус для тех или иных ограничений на фронтенде в момент авторизации. Особенно полев мзикросервисной архитектуре.',
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='Таблица содержащая список пользователей. Список пользователей и список клиентов в общем случае это два разных понятия.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,79100010101,'e1@mail.ru','31d4ec76e912e9c218a6d40482d4eb23b7c4980c',0),(2,79100010102,'e2@mail.ru','24edb21b15d95aca150a4941e7725708f9b90ce1',0),(3,79100010103,'e3@mail.ru','a9572530f377a1c945cf50e4db286a4a7ca3b1bf',0),(4,79100010104,'e4@mail.ru','c98afd8754d99fcc71e1541a208bf75c300d44af',0),(5,79100010105,'e5@mail.ru','67d14548d77c1f90999fa3b10786152f25ef5d33',1),(6,79000010106,'e6@mail.ru','d731435043fca7c3003c45289e6957c4193ff497',2),(7,79100010107,'e7@mail.ru','543d1c9e9b02201b87057728bd69263123d80efe',0),(8,79100010108,'e8@mail.ru','7ca610510bf852e3519c3db31d4eb1b75d99ae6e',0),(9,79100010109,'e9@mail.ru','a64da1ad7b2639b14de95419f102ad4e6cb7ae79',0),(10,79100010110,'e10@mail.ru','c0debe270a12c0678373d8c1e945a6e17a0ae6c4',0),(11,79100010111,'e11@mail.ru','8add8abcb95be9999a54d4dc602874132e05e7ea',1),(12,79000010112,'e12@mail.ru','b4730a472272baaaed4b99231bfb75233114edf4',2);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'piab'
--
/*!50003 DROP PROCEDURE IF EXISTS `Client's cards` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Client's cards`(IN ccode INT)
BEGIN
	SELECT 
		cl.`code` `Client Code`,
		CONCAT(p.first_name, ' ', p.last_name) `Client Name`,
		a.acc_number `Account Number`,
		cur.`code` `Account currency`,
		c.product `Card Product`,
		c.masked_pan `Masked PAN`
	FROM piab.cards c 
		JOIN clients cl 
		ON c.client_id = cl.id AND cl.code = ccode
		JOIN accounts a 
		ON c.accounts_id = a.id
		JOIN `profiles` p
		ON cl.users_id = p.users_id
		JOIN currencies cur
		ON a.cur_id = cur.id
	ORDER BY cl.code, c.accounts_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Client's_chat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Client's_chat`(IN ccode INT)
BEGIN
	SELECT 
		IF(ISNULL(m.from_client), '', 1) `From`,
		IF(ISNULL(m.to_client), '', 1) `To`,
		m.`text`
	FROM piab.messages m 
		JOIN clients c 
		ON (m.from_client = c.id OR m.to_client = c.id) AND c.code = ccode
	ORDER BY m.created_at;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `Client_notifications` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `Client_notifications`(IN ccode INT)
BEGIN
	SELECT n.message 
	FROM piab.notifications n 
		JOIN clients c 
		ON n.client_id = c.id AND c.code = ccode
	ORDER BY n.created_at DESC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `PairsRate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `PairsRate`(IN csell varchar(10), IN cbuy varchar(10), OUT rate decimal(18,6))
BEGIN
-- процедура возвращает последний актуальный курс для переданной в качестве входных параметров пары валют
	DECLARE r1, r2 DECIMAL(18,6);
	p:BEGIN
		IF (csell = cbuy) 
			THEN 
				Set rate = 1;
                leave p;
                
		END IF;
-- в случае, если переданная пара валют не содержит базовую, то курс вычисляется через кросс-курс
        IF (csell != 'RUB' AND cbuy != 'RUB') THEN
			SELECT r.rate INTO r1 FROM rates r 
				JOIN currencies cs ON cs.id = cur_2_sell AND cs.code = csell
				JOIN currencies cb ON cb.id = cur_2_buy AND cb.code = 'RUB'
			ORDER BY `timestamp` DESC 
			LIMIT 1;			
			SELECT r.rate INTO r2 FROM rates r 
				JOIN currencies cs ON cs.id = cur_2_sell AND cs.code = 'RUB'
				JOIN currencies cb ON cb.id = cur_2_buy AND cb.code = cbuy
			ORDER BY `timestamp` DESC 
			LIMIT 1;			
			SET rate = r1/r2;
            leave p;
        END IF;
		SELECT r.rate INTO rate FROM rates r 
			JOIN currencies cs ON cs.id = cur_2_sell AND cs.code = csell
			JOIN currencies cb ON cb.id = cur_2_buy AND cb.code = cbuy
		ORDER BY `timestamp` DESC 
		LIMIT 1;
	END;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `SessionHistory` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `SessionHistory`(IN user_id BIGINT, IN `last` TINYINT(1))
BEGIN
	IF (last = 1) THEN
		SELECT 
			DATE(logged_at) `Date`, 
			TIME(logged_at) `Time`, 
			ip_address `IP Address`, 
			IF(ISNULL(device_name), '', device_name) `From Device`,
			IF(ISNULL(location), '', location) `From Location`
		FROM sessions WHERE users_id = user_id
        ORDER BY logged_at DESC
        LIMIT 1;
	ELSE 
		SELECT 
			DATE(logged_at) `Date`, 
			TIME(logged_at) `Time`, 
			ip_address `IP Address`, 
			IF(ISNULL(device_name), '', device_name) `From Device`,
			IF(ISNULL(location), '', location) `From Location`
		FROM sessions WHERE users_id = user_id
        ORDER BY logged_at DESC
        LIMIT 10;
     END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `Client's_Card`
--

/*!50001 DROP VIEW IF EXISTS `Client's_Card`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `Client's_Card` AS select `cl`.`code` AS `Client Code`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `Client Name`,`a`.`acc_number` AS `Account Number`,`cur`.`code` AS `Account currency`,`c`.`product` AS `Card Product`,`c`.`masked_pan` AS `Masked PAN` from ((((`cards` `c` join `clients` `cl` on((`c`.`client_id` = `cl`.`id`))) join `accounts` `a` on((`c`.`accounts_id` = `a`.`id`))) join `profiles` `p` on((`cl`.`users_id` = `p`.`users_id`))) join `currencies` `cur` on((`a`.`cur_id` = `cur`.`id`))) order by `cl`.`code`,`c`.`accounts_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `LastRates`
--

/*!50001 DROP VIEW IF EXISTS `LastRates`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `LastRates` AS select distinct `r`.`timestamp` AS `Date & Time`,`cs`.`code` AS `Sell`,`cb`.`code` AS `Buy`,`r`.`rate` AS `Rate` from (((`rates` `r` join (select max(`r`.`timestamp`) AS `tid` from ((`rates` `r` join `currencies` `cs` on((`cs`.`id` = `r`.`cur_2_sell`))) join `currencies` `cb` on((`cb`.`id` = `r`.`cur_2_buy`))) group by `cs`.`code`,`cb`.`code`) `g` on((`r`.`timestamp` = `g`.`tid`))) join `currencies` `cs` on((`cs`.`id` = `r`.`cur_2_sell`))) join `currencies` `cb` on((`cb`.`id` = `r`.`cur_2_buy`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `List_of_Clients`
--

/*!50001 DROP VIEW IF EXISTS `List_of_Clients`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `List_of_Clients` AS select `c`.`code` AS `Client Code`,if((`c`.`residence` = 1),'Резидент','Нерезидент') AS `Residence`,`c`.`citizenship` AS `Citizenship`,concat(`p`.`first_name`,' ',`p`.`last_name`) AS `Client Name`,`tr`.`name` AS `Tariff Name`,format(if((`t2`.`Rub_Balance` is null),0,`t2`.`Rub_Balance`),2) AS `Total balance in rubbles` from (((`clients` `c` left join (select `a`.`client_id` AS `client_id`,sum(if((`t1`.`rate` is null),`a`.`balance`,(`a`.`balance` * `t1`.`rate`))) AS `Rub_Balance` from (`accounts` `a` left join (select `r`.`cur_2_sell` AS `cur_2_sell`,`r`.`rate` AS `rate` from (`rates` `r` join (select max(`r1`.`timestamp`) AS `tid` from `rates` `r1` group by `r1`.`cur_2_sell`,`r1`.`cur_2_buy` having (`r1`.`cur_2_buy` = 1)) `t` on(((`r`.`timestamp` = `t`.`tid`) and (`r`.`cur_2_buy` = 1))))) `t1` on(((`a`.`cur_id` = `t1`.`cur_2_sell`) and (`a`.`acc_type` = 'cu')))) group by `a`.`client_id`) `t2` on((`c`.`id` = `t2`.`client_id`))) join `profiles` `p` on((`c`.`users_id` = `p`.`users_id`))) join `tariffs` `tr` on((`c`.`tariffs_id` = `tr`.`id`))) order by `c`.`code` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `List_of_Services`
--

/*!50001 DROP VIEW IF EXISTS `List_of_Services`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `List_of_Services` AS select `s`.`name` AS `Service Name`,`s`.`description` AS `Service Description`,`s2`.`Basic` AS `Tariff - Basic`,`s3`.`Standard` AS `Tariff - Standard`,`s4`.`Advanced` AS `Tariff - Advanced` from (((`services` `s` join (select `s1`.`id` AS `id`,if((`ts`.`tariffs_id` is null),'-','+') AS `Basic` from (`services` `s1` left join (select `ts1`.`tariffs_id` AS `tariffs_id`,`ts1`.`services_id` AS `services_id` from (`tariffs_services` `ts1` join `tariffs` `t` on(((`ts1`.`tariffs_id` = `t`.`id`) and (`t`.`name` = 'Basic'))))) `ts` on((`s1`.`id` = `ts`.`services_id`)))) `s2`) join (select `s1`.`id` AS `id`,if((`ts`.`tariffs_id` is null),'-','+') AS `Standard` from (`services` `s1` left join (select `ts1`.`tariffs_id` AS `tariffs_id`,`ts1`.`services_id` AS `services_id` from (`tariffs_services` `ts1` join `tariffs` `t` on(((`ts1`.`tariffs_id` = `t`.`id`) and (`t`.`name` = 'Standard'))))) `ts` on((`s1`.`id` = `ts`.`services_id`)))) `s3`) join (select `s1`.`id` AS `id`,if((`ts`.`tariffs_id` is null),'-','+') AS `Advanced` from (`services` `s1` left join (select `ts1`.`tariffs_id` AS `tariffs_id`,`ts1`.`services_id` AS `services_id` from (`tariffs_services` `ts1` join `tariffs` `t` on(((`ts1`.`tariffs_id` = `t`.`id`) and (`t`.`name` = 'Advanced'))))) `ts` on((`s1`.`id` = `ts`.`services_id`)))) `s4`) where ((`s`.`id` = `s2`.`id`) and (`s`.`id` = `s3`.`id`) and (`s`.`id` = `s4`.`id`)) */;
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

-- Dump completed on 2021-03-04 18:08:04
