-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 03, 2025 at 07:49 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sports_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `ward` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `addressDetail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `userId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `fullName`, `phoneNumber`, `province`, `district`, `ward`, `addressDetail`, `userId`, `createAt`) VALUES
(1, 'le si toan', '1234567890', 'Quảng Nam', 'Thăng Bình', 'Bình Quế', 'tổ 14, BÌnh Phụng', 35, '2025-01-02 13:37:56'),
(3, 'le si toan', '1234567890', 'Quảng Nam', 'Thăng Bình', 'Bình Quế', 'tổ 14, BÌnh Phụng', 31, '2025-01-02 13:40:17');

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` int NOT NULL,
  `attrName` varchar(255) NOT NULL,
  `attrvalue` varchar(255) NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `attrName`, `attrvalue`, `createAt`) VALUES
(1, 'size', 'S', '2025-01-01 14:26:33'),
(2, 'size', 'M', '2025-01-01 14:26:33'),
(3, 'size', 'L', '2025-01-01 14:26:33'),
(4, 'size', 'XL', '2025-01-01 14:26:33'),
(5, 'size', 'XXL', '2025-01-01 14:26:33'),
(6, 'Loại vải', 'Thum co giãn', '2025-01-01 14:42:04'),
(7, 'Loại vải', 'Thun lạnh', '2025-01-01 14:42:04'),
(8, 'Loại vải', 'mè caro', '2025-01-01 14:42:04'),
(18, 'Loại vải', 'mè caro 2', '2025-01-03 14:34:20');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `createAt`) VALUES
(2, 'Wika', 'wika', '2024-12-08 13:40:06');

-- --------------------------------------------------------

--
-- Table structure for table `cartitemattributes`
--

CREATE TABLE `cartitemattributes` (
  `id` int NOT NULL,
  `cartItemId` int NOT NULL,
  `productAttributeId` int NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cartitemattributes`
--

INSERT INTO `cartitemattributes` (`id`, `cartItemId`, `productAttributeId`, `createAt`) VALUES
(19, 16, 9, '2025-01-01 23:15:25'),
(20, 16, 10, '2025-01-01 23:15:25'),
(21, 16, 11, '2025-01-01 23:15:25'),
(32, 23, 11, '2025-01-02 00:28:10');

-- --------------------------------------------------------

--
-- Table structure for table `cartitems`
--

CREATE TABLE `cartitems` (
  `id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `cartId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `productId` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `cartitems`
--

INSERT INTO `cartitems` (`id`, `quantity`, `price`, `cartId`, `createAt`, `productId`) VALUES
(16, 10, 100000, 5, '2025-01-01 23:15:25', 38),
(23, 100, 500000, 5, '2025-01-02 00:28:10', 37);

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `userId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`id`, `quantity`, `price`, `userId`, `createAt`) VALUES
(1, 0, 0, 48, '2024-12-31 22:20:15'),
(2, 0, 0, 49, '2024-12-31 22:21:15'),
(3, 0, 0, 50, '2024-12-31 22:25:36'),
(4, 0, 0, 31, '2024-12-31 22:26:46'),
(5, 2, 600000, 35, '2024-12-31 22:28:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `createAt`) VALUES
(6, 'Áo bóng đá CLB', 'ao_bong_da_clb', '2024-12-07 14:06:02'),
(7, 'Áo bóng đá đội tuyển', 'ao_bong_da_doi_tuyen', '2024-12-07 14:06:32'),
(8, 'Quần áo bóng chuyền', 'quan_ao_bong_chuyen', '2024-12-07 14:06:47'),
(9, 'Phụ kiện bóng chuyền', 'phu_kien_bong_chuyen', '2024-12-07 14:06:57'),
(10, 'Phụ kiện bóng đá', 'phu_kien_bong_da', '2024-12-07 14:07:12'),
(11, 'Quần áo cầu lông', 'quan_ao_cau_long', '2024-12-07 14:07:23'),
(14, 'Phụ kiện cầu lông', 'phu_kien_cau_long', '2024-12-07 20:22:20'),
(16, 'phụ kiện bóng rỗ', 'phu_kien_bong_ro', '2024-12-08 13:36:02');

-- --------------------------------------------------------

--
-- Table structure for table `continents`
--

CREATE TABLE `continents` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `continents`
--

INSERT INTO `continents` (`id`, `name`, `slug`, `createAt`) VALUES
(1, 'châu Á', 'chau_a', '2024-12-14 17:12:09'),
(2, 'châu Âu', 'chau_au', '2024-12-14 17:12:09'),
(3, 'Nam mỹ', 'nam_my', '2024-12-31 21:02:32');

-- --------------------------------------------------------

--
-- Table structure for table `images`
--

CREATE TABLE `images` (
  `id` int NOT NULL,
  `url` text NOT NULL,
  `productId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `images`
--

INSERT INTO `images` (`id`, `url`, `productId`, `createAt`) VALUES
(15, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1734624747/products/ao_bong_da_clb/rbcq3aqymgabu71vvysz.jpg', 37, '2024-12-19 23:12:30'),
(16, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1735570100/products/ao_bong_da_clb/cewvrfhqxsvqgekybgb6.jpg', 37, '2024-12-30 21:48:22'),
(17, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1735640419/products/ao_bong_da_clb/vo6aiyzuvklys8fstqlb.jpg', 37, '2024-12-31 17:20:20'),
(18, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1735653878/products/ao_bong_da_clb/wc5khjlwvpeiaxqvn649.png', 37, '2024-12-31 21:04:39'),
(19, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1735658567/products/ao_bong_da_clb/kclufau9oifar0zolzrz.png', 37, '2024-12-31 22:22:48');

-- --------------------------------------------------------

--
-- Table structure for table `leagues`
--

CREATE TABLE `leagues` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `leagues`
--

INSERT INTO `leagues` (`id`, `name`, `slug`, `createAt`) VALUES
(1, 'Laliga', 'laliga', '2024-12-14 17:10:18'),
(2, 'Premier League', 'premier_league', '2024-12-14 17:10:18');

-- --------------------------------------------------------

--
-- Table structure for table `orderaddresses`
--

CREATE TABLE `orderaddresses` (
  `id` int NOT NULL,
  `fullName` varchar(255) NOT NULL,
  `phoneNumber` varchar(255) NOT NULL,
  `province` varchar(255) NOT NULL,
  `district` varchar(255) NOT NULL,
  `ward` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `addressDetail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `orderId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderaddresses`
--

INSERT INTO `orderaddresses` (`id`, `fullName`, `phoneNumber`, `province`, `district`, `ward`, `addressDetail`, `orderId`, `createAt`) VALUES
(19, 'le si toan', '1234567890', 'quang Nam', 'thang binh', 'binh que', 'to 15', 25, '2025-01-03 14:29:50');

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `id` int NOT NULL,
  `price` int NOT NULL,
  `quantity` int NOT NULL,
  `productId` int DEFAULT NULL,
  `orderId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `attributes` json DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`id`, `price`, `quantity`, `productId`, `orderId`, `createAt`, `attributes`) VALUES
(30, 100000, 1, 37, 25, '2025-01-03 14:29:50', '[{\"attrName\": \"size\", \"attrValue\": \"XXL\"}]');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int NOT NULL,
  `deliveryDate` datetime DEFAULT NULL,
  `price` int NOT NULL,
  `orderStatus` enum('pending','confirmed','inTransit','completed','error') NOT NULL DEFAULT 'pending',
  `paymentStatus` enum('unpaid','paid','refunded') NOT NULL DEFAULT 'unpaid',
  `paymentMethod` enum('cash','transfer') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'cash',
  `shippingFee` int DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `errorMessge` varchar(255) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `deliveryDate`, `price`, `orderStatus`, `paymentStatus`, `paymentMethod`, `shippingFee`, `description`, `errorMessge`, `userId`, `createAt`) VALUES
(25, NULL, 100000, 'confirmed', 'unpaid', 'cash', 20000, 'đóng gói cẩn thận nha shop', NULL, 31, '2025-01-03 14:29:50');

-- --------------------------------------------------------

--
-- Table structure for table `productassociations`
--

CREATE TABLE `productassociations` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `type` enum('club','country') NOT NULL,
  `leagueId` int DEFAULT NULL,
  `continentId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productassociations`
--

INSERT INTO `productassociations` (`id`, `name`, `slug`, `type`, `leagueId`, `continentId`, `createAt`) VALUES
(1, 'Barcelona', 'barcelona', 'club', 1, NULL, '2024-12-14 17:12:50'),
(2, 'Real Madrid', 'real_madrid', 'club', 1, NULL, '2024-12-14 17:13:07'),
(3, 'Chelsea', 'chelsea', 'club', 2, NULL, '2024-12-14 17:13:17'),
(4, 'Tây Ban Nha', 'tay_ban_nha', 'country', NULL, 2, '2024-12-14 17:13:50'),
(8, 'Argentina', 'argentina', 'country', NULL, 3, '2024-12-31 21:02:48');

-- --------------------------------------------------------

--
-- Table structure for table `productattributes`
--

CREATE TABLE `productattributes` (
  `id` int NOT NULL,
  `productId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `attributeId` int NOT NULL,
  `addPrice` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `productattributes`
--

INSERT INTO `productattributes` (`id`, `productId`, `createAt`, `attributeId`, `addPrice`) VALUES
(9, 38, '2025-01-01 14:28:07', 1, 0),
(10, 38, '2025-01-01 14:28:07', 2, 5000),
(11, 38, '2025-01-01 14:28:07', 3, 10000),
(12, 38, '2025-01-01 14:28:07', 4, 15000),
(13, 38, '2025-01-01 14:28:07', 5, 20000),
(14, 37, '2025-01-01 14:28:26', 1, 0),
(15, 37, '2025-01-01 14:28:26', 2, 5000),
(16, 37, '2025-01-01 14:28:26', 3, 10000);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  `quantity` int NOT NULL DEFAULT '1',
  `description` varchar(255) DEFAULT NULL,
  `categoryId` int DEFAULT NULL,
  `brandId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `productAssociationId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `slug`, `price`, `quantity`, `description`, `categoryId`, `brandId`, `createAt`, `productAssociationId`) VALUES
(37, 'áo bóng đá clb Barcelona', 'ao_bong_da_clb_barcelona', 90000, 50, NULL, 6, 2, '2024-12-19 23:12:30', 1),
(38, 'áo bóng đá clb Barcelona', 'ao_bong_da_clb_barcelona', 90000, 50, NULL, 6, 2, '2024-12-30 21:48:22', 1),
(39, 'áo bóng đá clb Real Madird 1', 'ao_bong_da_clb_real_madird_1', 90000, 50, NULL, 6, 2, '2024-12-31 17:20:20', 2),
(40, 'áo bóng đá Argentina mẫu 1', 'ao_bong_da_argentina_mau_1', 110000, 30, NULL, 7, 2, '2024-12-31 21:04:39', 8),
(41, 'áo bóng đá Argentina mẫu 2', 'ao_bong_da_argentina_mau_2', 110000, 30, NULL, 7, 2, '2024-12-31 22:22:48', 8);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `userName` varchar(255) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phoneNumber` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `userPw` varchar(255) NOT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP,
  `role` enum('user','admin') NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `userName`, `email`, `phoneNumber`, `userPw`, `createAt`, `role`) VALUES
(4, 'user3', 'user3@gmail.com', '0987654323', 'password3', '2024-12-04 21:23:41', 'user'),
(5, 'user4', 'user4@gmail.com', '0987654324', 'password4', '2024-12-04 21:23:41', 'user'),
(7, 'user6', 'user6@gmail.com', '0987654326', 'password6', '2024-12-04 21:23:41', 'user'),
(8, 'user7', 'user7@gmail.com', '0987654327', 'password7', '2024-12-04 21:23:41', 'user'),
(9, 'user8', 'user8@gmail.com', '0987654328', 'password8', '2024-12-04 21:23:41', 'user'),
(11, 'user10', 'user10@gmail.com', '0987654330', 'password10', '2024-12-02 21:23:41', 'user'),
(12, 'user11', 'user11@gmail.com', '0987654331', 'password11', '2024-12-04 21:23:41', 'user'),
(13, 'user12', 'user12@gmail.com', '0987654332', 'password12', '2024-12-04 21:23:41', 'user'),
(14, 'user13', 'user13@gmail.com', '0987654333', 'password13', '2024-12-04 21:23:41', 'user'),
(15, 'user14', 'user14@gmail.com', '0987654334', 'password14', '2024-12-01 21:23:41', 'user'),
(16, 'user15', 'user15@gmail.com', '0987654335', 'password15', '2024-12-04 21:23:41', 'user'),
(17, 'user16', 'user16@gmail.com', '0987654336', 'password16', '2024-12-04 21:23:41', 'user'),
(18, 'user17', 'user17@gmail.com', '0987654337', 'password17', '2024-12-04 21:23:41', 'user'),
(19, 'user18', 'user18@gmail.com', '0987654338', 'password18', '2024-12-04 21:23:41', 'user'),
(20, 'user19', 'user19@gmail.com', '0987654339', 'password19', '2024-12-04 21:23:41', 'user'),
(21, 'user20', 'user20@gmail.com', '0987654340', 'password20', '2024-12-04 21:23:41', 'user'),
(22, 'user21', 'user21@gmail.com', '0987654341', 'password21', '2024-12-04 21:23:41', 'user'),
(23, 'user22', 'user22@gmail.com', '0987654342', 'password22', '2024-12-04 21:23:41', 'user'),
(24, 'user23', 'user23@gmail.com', '0987654343', 'password23', '2024-12-04 21:23:41', 'user'),
(25, 'user24', 'user24@gmail.com', '0987654344', 'password24', '2024-12-04 21:23:41', 'user'),
(26, 'user25', 'user25@gmail.com', '0987654345', 'password25', '2024-12-04 21:23:41', 'user'),
(31, 'lesitoan', 'lesitoan@gmail.com', NULL, '$2a$10$vF0frpScpJOVa1qpl/oAzedjP5Zlyc9WFZKMQIFAyPDv3SXcCqjPO', '2024-12-05 21:38:05', 'user'),
(34, '1dsds', 'lesitoan2@gmail.com', NULL, '$2a$10$DuKsxV2n9ePlIJCdEM4QX..jw1x1fKxwvjdgLoHk7FfqtJFPW0eOy', '2024-12-05 21:46:53', 'user'),
(35, 'admin', 'admin@gmail.com', NULL, '$2a$10$EYCxWhp4TdTlDHmri2C2cOeSx10eMSKv/g2ERwPsSctYjL9ewTh2u', '2024-12-07 12:38:58', 'admin'),
(48, 'toandeptrai', 'toandeptrai@gmail.com', NULL, '$2a$10$QaIf2d0UtHDSDMVBDkdcO.yeZJDm4rCwdDrg6/sOgtv/qkUZ1CisC', '2024-12-31 22:20:15', 'user'),
(49, 'toandeptrai2', 'toandeptrai2@gmail.com', NULL, '$2a$10$v.1ISf7rmT6MyhdmZ2HcceuToWeQQCXVFvSEQHjNSpyD5azLCko1W', '2024-12-31 22:21:15', 'user'),
(50, 'toandeptrai3', 'toandeptrai3@gmail.com', NULL, '$2a$10$1uNVDELOphTpitsnln83oe0no8TBJsSp6bAIgxYp0SwgLC3CKz6B6', '2024-12-31 22:25:36', 'user'),
(52, 'toandeptrai4', 'toandeptrai4@gmail.com', NULL, '$2a$10$QUX368RJW3BXFAIMNWs0CuRTbNJ/QAtn6v73n1eFGJGcMZsj616tG', '2024-12-31 22:26:46', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `uservalidations`
--

CREATE TABLE `uservalidations` (
  `id` int NOT NULL,
  `refreshToken` text NOT NULL,
  `userId` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `uservalidations`
--

INSERT INTO `uservalidations` (`id`, `refreshToken`, `userId`) VALUES
(15, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzUsInVzZXJOYW1lIjoiYWRtaW4iLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MzU4ODk2NTgsImV4cCI6MTczNjA2MjQ1OH0.oJn0OaBtD-qKn_pkusXuvxSXwBrb-_zMuB-vN5-AglE', 35),
(16, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsInVzZXJOYW1lIjoibGVzaXRvYW4iLCJyb2xlIjoidXNlciIsImlhdCI6MTczNTgxMTAwNSwiZXhwIjoxNzM1OTgzODA1fQ.ArD5XFK9ZD294tnvnrZlI5ss9CUrSMUpwLBZ7_SzJNs', 31);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `only` (`attrName`,`attrvalue`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `cartitemattributes`
--
ALTER TABLE `cartitemattributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cartItemId` (`cartItemId`),
  ADD KEY `attributeId` (`productAttributeId`);

--
-- Indexes for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cartId` (`cartId`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `continents`
--
ALTER TABLE `continents`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`);

--
-- Indexes for table `leagues`
--
ALTER TABLE `leagues`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `orderaddresses`
--
ALTER TABLE `orderaddresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`),
  ADD KEY `orderId` (`orderId`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `userId` (`userId`);

--
-- Indexes for table `productassociations`
--
ALTER TABLE `productassociations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `leagueId` (`leagueId`),
  ADD KEY `continentId` (`continentId`);

--
-- Indexes for table `productattributes`
--
ALTER TABLE `productattributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `productId` (`productId`),
  ADD KEY `attributeId` (`attributeId`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `categoryId` (`categoryId`),
  ADD KEY `brandId` (`brandId`),
  ADD KEY `productAssociationId` (`productAssociationId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userName` (`userName`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`);

--
-- Indexes for table `uservalidations`
--
ALTER TABLE `uservalidations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userId` (`userId`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cartitemattributes`
--
ALTER TABLE `cartitemattributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `cartitems`
--
ALTER TABLE `cartitems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `continents`
--
ALTER TABLE `continents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `leagues`
--
ALTER TABLE `leagues`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orderaddresses`
--
ALTER TABLE `orderaddresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `productassociations`
--
ALTER TABLE `productassociations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `productattributes`
--
ALTER TABLE `productattributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `uservalidations`
--
ALTER TABLE `uservalidations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `cartitemattributes`
--
ALTER TABLE `cartitemattributes`
  ADD CONSTRAINT `cartitemattributes_ibfk_1` FOREIGN KEY (`cartItemId`) REFERENCES `cartitems` (`id`),
  ADD CONSTRAINT `cartitemattributes_ibfk_2` FOREIGN KEY (`productAttributeId`) REFERENCES `productattributes` (`id`);

--
-- Constraints for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD CONSTRAINT `cartitems_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `carts` (`id`),
  ADD CONSTRAINT `cartitems_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`id`);

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `carts_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`);

--
-- Constraints for table `orderaddresses`
--
ALTER TABLE `orderaddresses`
  ADD CONSTRAINT `orderaddresses_ibfk_1` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`);

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`orderId`) REFERENCES `orders` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `productassociations`
--
ALTER TABLE `productassociations`
  ADD CONSTRAINT `productassociations_ibfk_1` FOREIGN KEY (`leagueId`) REFERENCES `leagues` (`id`),
  ADD CONSTRAINT `productassociations_ibfk_2` FOREIGN KEY (`continentId`) REFERENCES `continents` (`id`);

--
-- Constraints for table `productattributes`
--
ALTER TABLE `productattributes`
  ADD CONSTRAINT `productattributes_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `productattributes_ibfk_3` FOREIGN KEY (`attributeId`) REFERENCES `attributes` (`id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categoryId`) REFERENCES `categories` (`id`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`brandId`) REFERENCES `brands` (`id`),
  ADD CONSTRAINT `products_ibfk_3` FOREIGN KEY (`productAssociationId`) REFERENCES `productassociations` (`id`);

--
-- Constraints for table `uservalidations`
--
ALTER TABLE `uservalidations`
  ADD CONSTRAINT `uservalidations_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
