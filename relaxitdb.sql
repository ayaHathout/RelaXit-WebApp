CREATE DATABASE  IF NOT EXISTS `relaxitdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `relaxitdb`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: relaxitdb
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `cartitem`
--

DROP TABLE IF EXISTS `cartitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cartitem` (
  `cart_id` bigint NOT NULL AUTO_INCREMENT,
  `added_at` datetime(6) DEFAULT NULL,
  `itemTotal` decimal(38,2) DEFAULT NULL,
  `quantity` int NOT NULL,
  `product_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`cart_id`),
  KEY `FK99fv34ri9tybnctu5dlpm42xr` (`product_id`),
  KEY `FKf0ry23n5y73otkq016xaerbxs` (`user_id`),
  CONSTRAINT `FK99fv34ri9tybnctu5dlpm42xr` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  CONSTRAINT `FKf0ry23n5y73otkq016xaerbxs` FOREIGN KEY (`user_id`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cartitem`
--

LOCK TABLES `cartitem` WRITE;
/*!40000 ALTER TABLE `cartitem` DISABLE KEYS */;
INSERT INTO `cartitem` VALUES (32,'2025-04-24 20:44:48.226781',NULL,1,7,12);
/*!40000 ALTER TABLE `cartitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` bigint NOT NULL AUTO_INCREMENT,
  `description` text,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Office chairs, Gaming chairs, Conference room chairs','Fixed Chairs'),(2,'Multi-position recliners, Active sitting chairs','Adjustable Chairs'),(3,'Attachable backrest cushions, Memory foam back pillows, Mesh ventilated back supports','Lumbar Support Products'),(4,'Wearable back braces, Posture training belts','Posture Correctors'),(5,'Gel-infused seat cushions, Memory foam seat toppers','Chair Pads'),(6,'Coccyx cushions for tailbone relief, Hemorrhoid relief cushions','Specialty Cushions'),(7,'Car seat neck supports, Airplane travel pillows','Neck Pillows'),(8,'Inflatable seat cushions, Foldable posture supports','Portable Solutions'),(9,'Adjustable footrests, Keyboard wrist rests, Laptop stands','Desk Ergonomics'),(10,'Under-desk hammocks, Seat-mounted storage organizers','Comfort Add-ons');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order_items` (
  `order_item_id` bigint NOT NULL AUTO_INCREMENT,
  `price` decimal(38,2) NOT NULL,
  `quantity` int NOT NULL,
  `order_id` bigint NOT NULL,
  `product_id` bigint NOT NULL,
  PRIMARY KEY (`order_item_id`),
  KEY `FKbioxgbv59vetrxe0ejfubep1w` (`order_id`),
  KEY `FKocimc7dtr037rh4ls4l95nlfi` (`product_id`),
  CONSTRAINT `FKbioxgbv59vetrxe0ejfubep1w` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  CONSTRAINT `FKocimc7dtr037rh4ls4l95nlfi` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_items`
--

LOCK TABLES `order_items` WRITE;
/*!40000 ALTER TABLE `order_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orders` (
  `order_id` bigint NOT NULL AUTO_INCREMENT,
  `order_date` datetime(6) DEFAULT NULL,
  `status` enum('PENDING','COMPLETED','CANCELLED') DEFAULT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `FK32ql8ubntj5uh44ph9659tiih` (`user_id`),
  CONSTRAINT `FK32ql8ubntj5uh44ph9659tiih` FOREIGN KEY (`user_id`) REFERENCES `users` (`userId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `products` (
  `product_id` bigint NOT NULL AUTO_INCREMENT,
  `description` text,
  `name` varchar(100) NOT NULL,
  `price` decimal(38,2) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `quantity` int NOT NULL,
  `category_id` bigint DEFAULT NULL,
  PRIMARY KEY (`product_id`),
  KEY `FKog2rp4qthbtt2lfyhfo32lsw9` (`category_id`),
  CONSTRAINT `FKog2rp4qthbtt2lfyhfo32lsw9` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
INSERT INTO `products` VALUES (1,'Comfortable office chair with lumbar support','Ergonomic Office Chair',7.00,'/Uploads/76c556ec-4175-43a9-8b09-abe07a1ec054.png',0,1),(2,'Adjustable gaming chair with headrest and footrest','High-Back Gaming Chair',2005.00,'/Uploads/27d0c939-d4bd-4729-aa7a-19142c6e0ee8.png',0,1),(3,'Luxury leather chair for conference rooms','Conference Chair',250.00,'/Uploads/34c92109-fe9d-404d-99bc-855da54636a9.png',0,1),(4,'Multi-position recliner with padded armrests','Reclining Lounge Chair',180.00,'/Uploads/51ac58cf-c84a-47e0-a8f8-c7e759d844c5.png',11,2),(5,'Active sitting chair with stability ball for posture support','Balance Ball Chair',120.00,'/Uploads/cfffba66-13d8-4704-a59e-38d3d652afeb.png',17,2),(6,'Adjustable chair with smooth rotation','Swivel Recliner Chair',220.00,'/Uploads/dbad82f0-70dd-43b3-80b0-b97aa682f0e4.png',0,2),(7,'Soft memory foam cushion for lumbar support','Memory Foam Back Pillow',35.00,'/Uploads/1b438050-2509-4009-9636-10ed4607171d.png',22,3),(8,'Breathable mesh back support for chairs','Ventilated Mesh Back Support',25.00,'/Uploads/81e5b7a5-557c-48dc-8ab1-76fcce38e455.png',24,3),(9,'Attachable cushion for ergonomic support','Backrest Cushion',40.00,'/Uploads/c0b67799-bda1-4c1f-a48d-678f80b916a4.png',20,3),(10,'Adjustable back brace for improved posture','Wearable Posture Brace',50.00,'/Uploads/6758cfc8-2594-457a-a4d4-4fa368712325.png',0,4),(11,'Wearable device that vibrates when posture is incorrect','Smart Posture Trainer',70.00,'/Uploads/f17289df-b127-4522-9230-37ac1ba18c4a.png',15,4),(12,'Lightweight belt for spinal alignment','Posture Support Belt',45.00,'/Uploads/4d207bf2-faa1-48a7-be55-4182f3acd69b.png',20,4),(13,'Cooling gel cushion for long sitting comfort','Gel-Infused Seat Cushion',30.00,'/Uploads/2f3b287f-65fe-45c0-b3f4-5868da49d4ad.png',38,5),(14,'Memory foam seat topper for pressure relief','Memory Foam Cushion',35.00,'/Uploads/35763c07-c189-4533-b960-88d0e9b90d6e.png',33,5),(15,'Non-slip pad with ergonomic design','Anti-Slip Foot Pad',28.00,'/Uploads/6dcc2f43-5d6c-4b81-ad2e-de060edc36cc.png',30,5),(16,'Angled seat cushion Designed for tailbone pain relief','Coccyx Support Cushion',38.00,'/Uploads/e4250917-d42f-4450-a092-ed4506487b53.png',25,6),(17,'Soft cushion for pressure-free sitting','Hemorrhoid Relief Pillow',32.00,'/Uploads/cf425afb-96b9-412e-ab60-70815182aed7.png',20,6),(18,'Angled seat cushion for spine alignment','Orthopedic Seat Cushion',40.00,'/Uploads/dadfd1d1-4132-4c9f-a282-6c19c9f4dbe3.png',14,6),(19,'Memory foam pillow for neck support during travel','Travel Neck Pillow',25.00,'/Uploads/d2d316b6-85cc-4673-9df5-6b51fbaa739f.png',49,7),(20,'Neck support cushion for car journeys','Car Seat Neck Cushion',22.00,'/Uploads/f3fef987-0cd5-4cde-ba40-5019e8dc52dc.png',45,7),(21,'Customizable neck support pillow for All Cars Driving Seat Office Chair','Adjustable Neck Rest',28.00,'/Uploads/e03101cd-08b3-498b-bc03-cb5ffbe65c43.png',34,7),(22,'Compact and portable cushion for travel','Inflatable Seat Cushion',20.00,'/Uploads/f63e2b51-759c-475b-8ceb-611d1342e3ed.png',60,8),(23,'Ergonomic Kneeling Chair with Back Support, Adjustable Stool for better posture','Foldable Posture Chair',55.00,'/Uploads/7767890c-faed-4b64-9e29-9b3bd696f0f8.png',20,8),(24,'Lightweight and foldable support for long journeys','Ergonomic Travel Support',40.00,'/Uploads/0a4b6e52-7eb5-4895-8717-784610ad06cc.png',25,8),(25,'Under-desk footrest for better circulation','Adjustable Footrest',45.00,'/Uploads/3aaefede-6dc6-4cea-a67e-18a456f3200d.png',29,9),(26,'Soft wrist pad for typing comfort','Ergonomic Keyboard Wrist Rest',20.00,'/Uploads/ed52f11f-e8f2-4b50-8262-74ffd7923f69.png',49,9),(27,'Height-adjustable laptop stand for better ergonomics','Adjustable Laptop Stand',60.00,'/Uploads/7bcc89f2-7936-4ef4-9084-7800f0715bba.png',24,9),(28,'Relaxing foot hammock for under-desk comfort','Under-Desk Hammock',30.00,'/Uploads/3126453a-24ee-43ea-ae05-c6fcb612e250.png',40,10),(29,'Waterproof Car Back Seat Organizer with Convenient Storage','Car Seat Organizer',25.00,'/Uploads/91a73767-f7ea-4ed7-bb5d-57afcc18cc7a.png',35,10),(30,'Portable massaging pad for stress relief','Foot Massager Pad',50.00,'/Uploads/38e312bc-4677-46e4-934f-c9488ec92eca.png',19,10),(31,'Comfortable office chair with lumbar support','Ergonomic Office Chair',150.00,'/Uploads/de533313-a04f-45a3-8d5d-c9c22d748b0c.png',20,1),(32,'Multi-position recliner with padded armrests','Reclining Lounge Chair',180.00,'/Uploads/0b31bc60-b8db-449a-bdb4-2d8feb7c8f59.png',12,2),(33,'Multi-position recliner with padded armrests','Reclining Lounge Chair',180.00,'/Uploads/6ed3eaf5-6e40-4bed-9745-957dce5cc77b.png',12,3),(34,'Multi-position recliner with padded armrests','Reclining Lounge Chair',180.00,'/Uploads/61140051-3721-4c3d-90ac-6974fb462fde.png',12,4),(35,'any','Chair1',250.00,'/Uploads/78fcc747-4bd1-408d-be99-3b8321557562.png',5,2),(36,'non','Chair2',200.00,'/Uploads/cd321a4b-e144-4842-9ae0-1c64937839bd.png',200,2),(37,'non','Chair3',250.00,'/Uploads/960221ce-945c-462c-9d01-aabed37eac35.png',10,2);
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `userId` bigint NOT NULL AUTO_INCREMENT,
  `address` varchar(255) NOT NULL,
  `birthdate` date NOT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  `credit_limit` double DEFAULT '1200',
  `email` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `interests` varchar(255) DEFAULT NULL,
  `job` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profile_image` varchar(255) DEFAULT NULL,
  `role` enum('ADMIN','USER') NOT NULL,
  `updated_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`userId`),
  UNIQUE KEY `UK_6dotkott2kjsp8vw4d0m25fb7` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Cairo, Egypt','1995-06-12','2025-04-12 20:48:24.000000',15,'ali@example.com','Ali Hassan','Reading, Coding','Software Engineer','pass1234','ali.jpg','USER','2025-04-12 20:48:24.000000'),(2,'Alexandria, Egypt','1990-03-22','2025-04-12 20:48:24.000000',115,'mona@example.com','Mona Adel','Traveling, Art','Designer','monaPass','mona.jpg','USER','2025-04-12 20:48:24.000000'),(3,'Giza, Egypt','1988-11-05','2025-04-12 20:48:24.000000',500,'admin1@gmail.com','Ahmed Samir','Gaming, Music','Support Specialist','$2a$10$3fExHAxFjK84V/uQq/FL/.esEsPn3VkcqcE2s6Ed00Z4utBi0ihi2','ahmed.png','ADMIN','2025-04-12 20:48:24.000000'),(4,'Tanta, Egypt','1993-09-18','2025-04-12 20:48:24.000000',1000,'sara@example.com','Sara Khaled','Cooking, Reading','Teacher','saraPass','sara.jpg','USER','2025-04-12 20:48:24.000000'),(5,'Mansoura, Egypt','1998-01-30','2025-04-12 20:48:24.000000',5200,'omar@example.com','Omar Youssef','Photography, Sports','Photographer','omarPwd','omar.png','USER','2025-04-12 20:48:24.000000'),(6,'Aswan, Egypt','1991-12-25','2025-04-12 20:48:24.000000',6100,'layla@example.com','Layla Fathy','Music, Movies','Accountant','layla123','layla.jpg','USER','2025-04-12 20:48:24.000000'),(7,'Zagazig, Egypt','1997-04-14','2025-04-12 20:48:24.000000',4900,'khaled@example.com','Khaled Nabil','Writing, Drawing','Journalist','khaledPwd','khaled.jpg','USER','2025-04-12 20:48:24.000000'),(8,'Suez, Egypt','1992-07-07','2025-04-12 20:48:24.000000',5500,'nour@example.com','Nour Hany','Blogging, Fashion','Content Creator','nourPass','nour.png','USER','2025-04-12 20:48:24.000000'),(9,'Fayoum, Egypt','1994-10-10','2025-04-12 20:48:24.000000',5300,'hassan@example.com','Hassan Ezz','Cycling, History','Historian','hassanPwd','hassan.jpg','ADMIN','2025-04-12 20:48:24.000000'),(10,'Ismailia, Egypt','1996-08-08','2025-04-12 20:48:24.000000',6000,'dina@example.com','Dina Saeed','Swimming, Nature','Biologist','dina1234','dina.png','USER','2025-04-12 20:48:24.000000'),(11,'jhjhj','2022-12-21','2025-04-14 21:27:13.687431',580,'aya@gmail.com','Aya Hathout','jhjhj','hghgh','$2a$10$AlGp19YEjAYF.vdYTMnVDehbX2iFvTeabp/IyJqBEerHKyEPsrcpK',NULL,'USER','2025-04-14 21:27:13.687431'),(12,'cairo','2025-04-06','2025-04-24 14:52:03.467775',39,'mainasser2014@gmail.com','mai','any','eng','$2a$10$CswlB3N/4nqjpAs1pHAzBe6WX/cbAwJExtUWX1V4s2PB9kIB0HOsy','uploads/c000db14-4370-4459-828f-3fb8659ee34e.png','USER','2025-04-24 14:52:03.467775'),(13,'cairo','2025-03-30','2025-04-24 18:10:49.183109',1200,'sara@gmail.com','sara','non','eng','$2a$10$3fExHAxFjK84V/uQq/FL/.esEsPn3VkcqcE2s6Ed00Z4utBi0ihi2',NULL,'USER','2025-04-24 18:10:49.183109'),(14,'cairo','2002-06-13','2025-04-24 20:50:25.523757',478,'mainasser@gmail.com','mai','non','eng','$2a$10$SPhWp5aZ6t4BcXMnc8vyu.db2onkPwFokzHVs7SWgXhh7AFfVj1i.','uploads/44c117b5-c9bf-470a-8b14-6521bf436376.jpg','USER','2025-04-24 21:03:02.871159');
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

-- Dump completed on 2025-04-25 15:42:36
