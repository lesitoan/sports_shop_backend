-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 20, 2025 at 05:48 PM
-- Server version: 8.0.31
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
(10, 'toandz123', '0353349251', ' Đà Nẵng', ' Liên Chiểu', 'Hòa Minh', 'đường Hoàng Trung Thông', 31, '2025-01-17 16:19:58'),
(13, 'dsdsd', '1111111111', ' Quảng Nam', ' Thăng Bình', 'Bình Quế', 'đường Hoàng Trung Thông', 54, '2025-01-17 17:58:56'),
(14, 'TOANDZ123', '0353349251', ' Bà Rịa - Vũng Tàu', ' Bà Rịa', 'Hoà Long', 'đường Hoàng Trung Thông', 31, '2025-01-17 21:42:18');

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
(8, 'Loại vải', 'mè caro', '2025-01-01 14:42:04');

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
(107, 67, 27, '2025-01-17 17:57:25'),
(108, 67, 31, '2025-01-17 17:57:25'),
(133, 80, 17, '2025-01-20 13:11:29'),
(134, 80, 22, '2025-01-20 13:11:29'),
(135, 81, 19, '2025-01-20 13:13:43'),
(136, 81, 24, '2025-01-20 13:13:43'),
(137, 82, 18, '2025-01-20 14:02:15'),
(138, 82, 23, '2025-01-20 14:02:15');

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
(67, 3, 360000, 7, '2025-01-17 17:57:25', 44),
(80, 3, 300000, 4, '2025-01-20 13:11:29', 43),
(81, 1, 130000, 4, '2025-01-20 13:13:43', 43),
(82, 1, 115000, 4, '2025-01-20 14:02:15', 43);

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
(4, 3, 545000, 31, '2024-12-31 22:26:46'),
(5, 0, 0, 35, '2024-12-31 22:28:00'),
(6, 0, 0, 53, '2025-01-06 22:05:17'),
(7, 1, 360000, 54, '2025-01-06 23:14:56');

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
(21, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268246/products/ao_bong_da_clb/rvljme0eqm8af3j91cgo.jpg', 43, '2025-01-07 23:44:09'),
(22, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268291/products/ao_bong_da_clb/m8jgducnsozm0baynlmn.webp', 44, '2025-01-07 23:44:52'),
(23, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268399/products/ao_bong_da_clb/lshfyp2esfeoi3y7b6gl.webp', 45, '2025-01-07 23:46:40'),
(24, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268435/products/ao_bong_da_clb/ehdlqkxgy6ceztxyyqhs.webp', 46, '2025-01-07 23:47:16'),
(25, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268485/products/ao_bong_da_clb/akhnpcoopg9konuygw5q.webp', 47, '2025-01-07 23:48:07'),
(26, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268518/products/ao_bong_da_clb/c0t5o9jcy3rxsthx4t7j.webp', 48, '2025-01-07 23:48:39'),
(27, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268561/products/ao_bong_da_clb/xdu6oq6xffu62lam8g6x.jpg', 49, '2025-01-07 23:49:22'),
(28, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268768/products/ao_bong_da_clb/cpmfix8gjybj2cvx0maf.webp', 50, '2025-01-07 23:52:50'),
(29, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736268797/products/ao_bong_da_clb/igiwophwemwmb4sljddr.jpg', 51, '2025-01-07 23:53:18'),
(30, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736269038/products/ao_bong_da_clb/fkgu5db3xfrvkz01cdh5.png', 52, '2025-01-07 23:56:51'),
(31, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736269038/products/ao_bong_da_clb/fkgu5db3xfrvkz01cdh5.png', 53, '2025-01-07 23:57:19'),
(32, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736269061/products/ao_bong_da_clb/rfci2927jrwgisxtzrvf.png', 54, '2025-01-07 23:57:42'),
(33, 'http://res.cloudinary.com/dfwvndqqw/image/upload/v1736269081/products/ao_bong_da_clb/uenmhn7wurtnywaibooz.jpg', 55, '2025-01-07 23:58:02');

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
(26, 'le si toan', '1234567890', 'quang Nam', 'thang binh', 'binh que', 'to 15', 32, '2025-01-17 18:19:39'),
(27, 'TOANDZ123', '0353349251', ' Bà Rịa - Vũng Tàu', ' Bà Rịa', 'Hoà Long', 'đường Hoàng Trung Thông', 33, '2025-01-17 21:59:42'),
(28, 'TOANDZ123', '0353349251', ' Bà Rịa - Vũng Tàu', ' Bà Rịa', 'Hoà Long', 'đường Hoàng Trung Thông', 34, '2025-01-17 22:01:10');

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
(39, 260000, 2, 44, 32, '2025-01-17 18:19:39', '[{\"attrName\": \"Loại vải\", \"attrValue\": \"mè caro\"}, {\"attrName\": \"size\", \"attrValue\": \"L\"}]'),
(40, 330000, 3, 52, 32, '2025-01-17 18:19:39', '[{\"attrName\": \"Loại vải\", \"attrValue\": \"Thum co giãn\"}, {\"attrName\": \"size\", \"attrValue\": \"L\"}]'),
(41, 780000, 6, 45, 33, '2025-01-17 21:59:42', '[{\"attrName\": \"Loại vải\", \"attrValue\": \"mè caro\"}, {\"attrName\": \"size\", \"attrValue\": \"L\"}]'),
(42, 120000, 1, 46, 33, '2025-01-17 21:59:42', '[{\"attrName\": \"Loại vải\", \"attrValue\": \"Thun lạnh\"}, {\"attrName\": \"size\", \"attrValue\": \"L\"}]'),
(43, 100000, 1, 52, 34, '2025-01-17 22:01:10', '[{\"attrName\": \"Loại vải\", \"attrValue\": \"Thum co giãn\"}, {\"attrName\": \"size\", \"attrValue\": \"S\"}]');

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
(32, NULL, 590000, 'inTransit', 'unpaid', 'cash', 20000, 'đóng gói cẩn thận nha shop', NULL, 31, '2025-01-17 18:19:39'),
(33, NULL, 900000, 'inTransit', 'unpaid', 'cash', 30000, NULL, NULL, 31, '2025-01-17 21:59:42'),
(34, NULL, 100000, 'completed', 'unpaid', 'cash', 30000, NULL, NULL, 31, '2025-01-17 22:01:10');

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
(8, 'Argentina', 'argentina', 'country', NULL, 3, '2024-12-31 21:02:48'),
(10, 'Liverpool', 'liverpool', 'club', 2, NULL, '2025-01-07 23:36:29'),
(11, 'Mu', 'mu', 'club', 2, NULL, '2025-01-07 23:36:38');

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
(17, 43, '2025-01-11 00:59:26', 1, 0),
(18, 43, '2025-01-11 00:59:26', 2, 5000),
(19, 43, '2025-01-11 00:59:26', 3, 10000),
(20, 43, '2025-01-11 00:59:26', 4, 15000),
(21, 43, '2025-01-11 00:59:26', 5, 20000),
(22, 43, '2025-01-11 00:59:26', 6, 0),
(23, 43, '2025-01-11 00:59:26', 7, 10000),
(24, 43, '2025-01-11 00:59:26', 8, 20000),
(25, 44, '2025-01-11 01:01:33', 1, 0),
(26, 44, '2025-01-11 01:01:33', 2, 5000),
(27, 44, '2025-01-11 01:01:33', 3, 10000),
(28, 44, '2025-01-11 01:01:33', 4, 15000),
(29, 44, '2025-01-11 01:01:33', 5, 20000),
(30, 44, '2025-01-11 01:01:33', 6, 0),
(31, 44, '2025-01-11 01:01:33', 7, 10000),
(32, 44, '2025-01-11 01:01:33', 8, 20000),
(33, 45, '2025-01-11 01:01:33', 1, 0),
(34, 45, '2025-01-11 01:01:33', 2, 5000),
(35, 45, '2025-01-11 01:01:33', 3, 10000),
(36, 45, '2025-01-11 01:01:33', 4, 15000),
(37, 45, '2025-01-11 01:01:33', 5, 20000),
(38, 45, '2025-01-11 01:01:33', 6, 0),
(39, 45, '2025-01-11 01:01:33', 7, 10000),
(40, 45, '2025-01-11 01:01:33', 8, 20000),
(41, 46, '2025-01-11 01:01:33', 1, 0),
(42, 46, '2025-01-11 01:01:33', 2, 5000),
(43, 46, '2025-01-11 01:01:33', 3, 10000),
(44, 46, '2025-01-11 01:01:33', 4, 15000),
(45, 46, '2025-01-11 01:01:33', 5, 20000),
(46, 46, '2025-01-11 01:01:33', 6, 0),
(47, 46, '2025-01-11 01:01:33', 7, 10000),
(48, 46, '2025-01-11 01:01:33', 8, 20000),
(49, 47, '2025-01-11 01:01:33', 1, 0),
(50, 47, '2025-01-11 01:01:33', 2, 5000),
(51, 47, '2025-01-11 01:01:33', 3, 10000),
(52, 47, '2025-01-11 01:01:33', 4, 15000),
(53, 47, '2025-01-11 01:01:33', 5, 20000),
(54, 47, '2025-01-11 01:01:33', 6, 0),
(55, 47, '2025-01-11 01:01:33', 7, 10000),
(56, 47, '2025-01-11 01:01:33', 8, 20000),
(57, 48, '2025-01-11 01:01:33', 1, 0),
(58, 48, '2025-01-11 01:01:33', 2, 5000),
(59, 48, '2025-01-11 01:01:33', 3, 10000),
(60, 48, '2025-01-11 01:01:33', 4, 15000),
(61, 48, '2025-01-11 01:01:33', 5, 20000),
(62, 48, '2025-01-11 01:01:33', 6, 0),
(63, 48, '2025-01-11 01:01:33', 7, 10000),
(64, 48, '2025-01-11 01:01:33', 8, 20000),
(65, 49, '2025-01-11 01:01:33', 1, 0),
(66, 49, '2025-01-11 01:01:33', 2, 5000),
(67, 49, '2025-01-11 01:01:33', 3, 10000),
(68, 49, '2025-01-11 01:01:33', 4, 15000),
(69, 49, '2025-01-11 01:01:33', 5, 20000),
(70, 49, '2025-01-11 01:01:33', 6, 0),
(71, 49, '2025-01-11 01:01:33', 7, 10000),
(72, 49, '2025-01-11 01:01:33', 8, 20000),
(73, 50, '2025-01-11 01:01:33', 1, 0),
(74, 50, '2025-01-11 01:01:33', 2, 5000),
(75, 50, '2025-01-11 01:01:33', 3, 10000),
(76, 50, '2025-01-11 01:01:33', 4, 15000),
(77, 50, '2025-01-11 01:01:33', 5, 20000),
(78, 50, '2025-01-11 01:01:33', 6, 0),
(79, 50, '2025-01-11 01:01:33', 7, 10000),
(80, 50, '2025-01-11 01:01:33', 8, 20000),
(81, 51, '2025-01-11 01:01:33', 1, 0),
(82, 51, '2025-01-11 01:01:33', 2, 5000),
(83, 51, '2025-01-11 01:01:33', 3, 10000),
(84, 51, '2025-01-11 01:01:33', 4, 15000),
(85, 51, '2025-01-11 01:01:33', 5, 20000),
(86, 51, '2025-01-11 01:01:33', 6, 0),
(87, 51, '2025-01-11 01:01:33', 7, 10000),
(88, 51, '2025-01-11 01:01:33', 8, 20000),
(89, 52, '2025-01-11 01:01:33', 1, 0),
(90, 52, '2025-01-11 01:01:33', 2, 5000),
(91, 52, '2025-01-11 01:01:33', 3, 10000),
(92, 52, '2025-01-11 01:01:33', 4, 15000),
(93, 52, '2025-01-11 01:01:33', 5, 20000),
(94, 52, '2025-01-11 01:01:33', 6, 0),
(95, 52, '2025-01-11 01:01:33', 7, 10000),
(96, 52, '2025-01-11 01:01:33', 8, 20000),
(97, 53, '2025-01-11 01:01:33', 1, 0),
(98, 53, '2025-01-11 01:01:33', 2, 5000),
(99, 53, '2025-01-11 01:01:33', 3, 10000),
(100, 53, '2025-01-11 01:01:33', 4, 15000),
(101, 53, '2025-01-11 01:01:33', 5, 20000),
(102, 53, '2025-01-11 01:01:33', 6, 0),
(103, 53, '2025-01-11 01:01:33', 7, 10000),
(104, 53, '2025-01-11 01:01:33', 8, 20000),
(105, 54, '2025-01-11 01:01:33', 1, 0),
(106, 54, '2025-01-11 01:01:33', 2, 5000),
(107, 54, '2025-01-11 01:01:33', 3, 10000),
(108, 54, '2025-01-11 01:01:33', 4, 15000),
(109, 54, '2025-01-11 01:01:33', 5, 20000),
(110, 54, '2025-01-11 01:01:33', 6, 0),
(111, 54, '2025-01-11 01:01:33', 7, 10000),
(112, 54, '2025-01-11 01:01:33', 8, 20000),
(113, 55, '2025-01-11 01:01:33', 1, 0),
(114, 55, '2025-01-11 01:01:33', 2, 5000),
(115, 55, '2025-01-11 01:01:33', 3, 10000),
(116, 55, '2025-01-11 01:01:33', 4, 15000),
(117, 55, '2025-01-11 01:01:33', 5, 20000),
(118, 55, '2025-01-11 01:01:33', 6, 0),
(119, 55, '2025-01-11 01:01:33', 7, 10000),
(120, 55, '2025-01-11 01:01:33', 8, 20000);

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
(43, 'áo bóng đá MU 2024 2025 siêu đẹp', 'ao_bong_da_mu_2024_2025_sieu_dep', 100000, 30, NULL, 6, 2, '2025-01-07 23:44:09', 11),
(44, 'áo bóng đá Chelsea 2024 2025 siêu đẹp', 'ao_bong_da_chelsea_2024_2025_sieu_dep', 100000, 35, NULL, 6, 2, '2025-01-07 23:44:52', 3),
(45, 'áo bóng đá Chelsea sân khách 2024 2025 siêu đẹp', 'ao_bong_da_chelsea_san_khach_2024_2025_sieu_dep', 100000, 34, NULL, 6, 2, '2025-01-07 23:46:40', 3),
(46, 'áo bóng đá Liverpool sân nhà 2024 2025 siêu đẹp', 'ao_bong_da_liverpool_san_nha_2024_2025_sieu_dep', 100000, 70, NULL, 6, 2, '2025-01-07 23:47:16', 10),
(47, 'áo bóng đá clb Barcelona sân nhà 2024 2025 siêu đẹp', 'ao_bong_da_clb_barcelona_san_nha_2024_2025_sieu_dep', 100000, 100, NULL, 6, 2, '2025-01-07 23:48:07', 1),
(48, 'áo bóng đá clb Barcelona sân khách 2024 2025 siêu đẹp', 'ao_bong_da_clb_barcelona_san_khach_2024_2025_sieu_dep', 100000, 100, NULL, 6, 2, '2025-01-07 23:48:39', 1),
(49, 'áo bóng đá clb Real Madrid sân nhà 2024 2025 siêu đẹp', 'ao_bong_da_clb_real_madrid_san_nha_2024_2025_sieu_dep', 100000, 12, NULL, 6, 2, '2025-01-07 23:49:22', 2),
(50, 'áo bóng đá đội tuyển Tây Ban Nha sân nhà siêu đẹp', 'ao_bong_da_doi_tuyen_tay_ban_nha_san_nha_sieu_dep', 100000, 122, NULL, 7, 2, '2025-01-07 23:52:50', 4),
(51, 'áo bóng đá đội tuyển Argentina sân nhà siêu đẹp', 'ao_bong_da_doi_tuyen_argentina_san_nha_sieu_dep', 100000, 122, NULL, 7, 2, '2025-01-07 23:53:18', 8),
(52, 'áo bóng đá đội tuyển Argentina trắng kẻ sọc', 'ao_bong_da_doi_tuyen_argentina_trang_ke_soc', 100000, 122, NULL, 7, 2, '2025-01-07 23:56:51', 8),
(53, 'Áo Bóng Đá Argentina tím than sân khách mùa 2016 - 2017', 'ao_bong_da_argentina_tim_than_san_khach_mua_2016_-_2017', 100000, 122, NULL, 7, 2, '2025-01-07 23:57:19', 8),
(54, 'Áo Bóng Đá Argentina xanh World Cup 2018 - 2019', 'ao_bong_da_argentina_xanh_world_cup_2018_-_2019', 100000, 122, NULL, 7, 2, '2025-01-07 23:57:42', 8),
(55, 'Áo Bóng Đá Đội Tuyển Argentina xanh loang copa 2020 - 2021', 'ao_bong_da_doi_tuyen_argentina_xanh_loang_copa_2020_-_2021', 100000, 122, NULL, 7, 2, '2025-01-07 23:58:02', 8);

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
(31, 'lesitoan', 'lesitoan@gmail.com', NULL, '$2a$10$YhuMQMb1KDaIobePbLV7Ku5JpHFVrQZ631BAaY4Z7J4c4BEpNNSTG', '2024-12-05 21:38:05', 'user'),
(34, '1dsds', 'lesitoan2@gmail.com', NULL, '$2a$10$DuKsxV2n9ePlIJCdEM4QX..jw1x1fKxwvjdgLoHk7FfqtJFPW0eOy', '2024-12-05 21:46:53', 'user'),
(35, 'admin', 'admin@gmail.com', NULL, '$2a$10$EYCxWhp4TdTlDHmri2C2cOeSx10eMSKv/g2ERwPsSctYjL9ewTh2u', '2024-12-07 12:38:58', 'admin'),
(48, 'toandeptrai', 'toandeptrai@gmail.com', NULL, '$2a$10$QaIf2d0UtHDSDMVBDkdcO.yeZJDm4rCwdDrg6/sOgtv/qkUZ1CisC', '2024-12-31 22:20:15', 'user'),
(49, 'toandeptrai2', 'toandeptrai2@gmail.com', NULL, '$2a$10$v.1ISf7rmT6MyhdmZ2HcceuToWeQQCXVFvSEQHjNSpyD5azLCko1W', '2024-12-31 22:21:15', 'user'),
(50, 'toandeptrai3', 'toandeptrai3@gmail.com', NULL, '$2a$10$1uNVDELOphTpitsnln83oe0no8TBJsSp6bAIgxYp0SwgLC3CKz6B6', '2024-12-31 22:25:36', 'user'),
(52, 'toandeptrai4', 'toandeptrai4@gmail.com', NULL, '$2a$10$QUX368RJW3BXFAIMNWs0CuRTbNJ/QAtn6v73n1eFGJGcMZsj616tG', '2024-12-31 22:26:46', 'user'),
(53, 'tesst11', 'tesst11@gmail.com', NULL, '$2a$10$uCLqsCsfgojIozNpzXNTL.H5agNKQz2UgC3ZqH7wAjoiUoSkCunIC', '2025-01-06 22:05:17', 'user'),
(54, 'hokieu', 'hokieu@gmail.com', NULL, '$2a$10$KMmw468kGuJK9RGC8IQF4ego8ZoBjkDLSSKxia2bNSHlvwzLWxNvu', '2025-01-06 23:14:56', 'user');

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
(106, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsInVzZXJOYW1lIjoibGVzaXRvYW4iLCJyb2xlIjoidXNlciIsImlhdCI6MTczNzM1Njg5MCwiZXhwIjoxNzM3NDQzMjkwfQ.P91Vfdzj2-uTCmutN0UvLZzTVfTHjt1Cq4PjY32Ux8M', 31);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `cartitems`
--
ALTER TABLE `cartitems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `leagues`
--
ALTER TABLE `leagues`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `orderaddresses`
--
ALTER TABLE `orderaddresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `productassociations`
--
ALTER TABLE `productassociations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `productattributes`
--
ALTER TABLE `productattributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `uservalidations`
--
ALTER TABLE `uservalidations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

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
