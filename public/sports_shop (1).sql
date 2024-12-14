-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 14, 2024 at 09:40 AM
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
  `wards` varchar(255) NOT NULL,
  `arrdessDetail` varchar(255) NOT NULL,
  `userId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributeorderdetails`
--

CREATE TABLE `attributeorderdetails` (
  `id` int NOT NULL,
  `attributeId` int DEFAULT NULL,
  `orderDetailId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` int NOT NULL,
  `attrName` varchar(255) NOT NULL,
  `attrValue` varchar(255) NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `attrName`, `attrValue`, `price`, `createAt`) VALUES
(69, 'size', 'S', 0, '2024-12-08 16:32:41'),
(70, 'size', 'M', 5000, '2024-12-08 16:32:41'),
(71, 'size', 'L', 10000, '2024-12-08 16:32:41'),
(72, 'size', 'XL', 15000, '2024-12-08 16:32:41'),
(73, 'size', 'XXL', 20000, '2024-12-08 16:32:41'),
(74, 'size', '36', 0, '2024-12-08 16:33:31'),
(75, 'size', '37', 5000, '2024-12-08 16:33:31'),
(76, 'size', '38', 10000, '2024-12-08 16:33:31'),
(77, 'size', '39', 15000, '2024-12-08 16:33:31'),
(78, 'size', '40', 20000, '2024-12-08 16:33:31'),
(79, 'size', '41', 25000, '2024-12-08 16:33:31'),
(80, 'Loại vải', 'Thum co giãn', 0, '2024-12-08 16:34:35'),
(81, 'Loại vải', 'Thun lạnh', 5000, '2024-12-08 16:34:35'),
(82, 'Loại vải', 'mè caro', 10000, '2024-12-08 16:34:35');

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
-- Table structure for table `cartitemdetails`
--

CREATE TABLE `cartitemdetails` (
  `id` int NOT NULL,
  `cartItemId` int DEFAULT NULL,
  `productAttributeId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cartitems`
--

CREATE TABLE `cartitems` (
  `id` int NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `price` int NOT NULL DEFAULT '0',
  `cartId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `wards` varchar(255) NOT NULL,
  `arrdessDetail` varchar(255) NOT NULL,
  `orderId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
  `paymnetMethod` enum('cash','transfer') NOT NULL DEFAULT 'cash',
  `shippingFee` int DEFAULT '0',
  `description` varchar(255) DEFAULT NULL,
  `errorMessge` varchar(255) DEFAULT NULL,
  `userId` int DEFAULT NULL,
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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

-- --------------------------------------------------------

--
-- Table structure for table `productattributes`
--

CREATE TABLE `productattributes` (
  `id` int NOT NULL,
  `attributeId` int DEFAULT NULL,
  `productId` int DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  `createAt` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
(31, 'lesitoan', 'lesitoan@gmail.com', NULL, '$2a$10$MRmlDK1vfMejgMcEYc5T4e.OqYMjq4CL2GoKo4gRW4gu0dox31Z16', '2024-12-05 21:38:05', 'user'),
(34, '1dsds', 'lesitoan2@gmail.com', NULL, '$2a$10$DuKsxV2n9ePlIJCdEM4QX..jw1x1fKxwvjdgLoHk7FfqtJFPW0eOy', '2024-12-05 21:46:53', 'user'),
(35, 'admin', 'admin@gmail.com', NULL, '$2a$10$wDXsHd6dZKQsXENe2zBQaurnarfWtjugoStdm0zb.NEBYHcscFo7a', '2024-12-07 12:38:58', 'admin');

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
(10, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzEsInVzZXJOYW1lIjoibGVzaXRvYW4iLCJyb2xlIjoidXNlciIsImlhdCI6MTczMzU1NjIxMiwiZXhwIjoxNzMzNzI5MDEyfQ.EyZs1vEnB21TUne5u40VomPo8_qaEvcn8dvucIz6C4k', 31),
(11, 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MzUsInVzZXJOYW1lIjoiYWRtaW4iLCJyb2xlIjoiYWRtaW4iLCJpYXQiOjE3MzQwODU4NTYsImV4cCI6MTczNDE3MjI1Nn0.W33tJtGuwsoAa3r_K6mr5oUmV2gSbTfN1I5twmul86E', 35);

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
-- Indexes for table `attributeorderdetails`
--
ALTER TABLE `attributeorderdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attributeId` (`attributeId`),
  ADD KEY `orderDetailId` (`orderDetailId`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attr_unique` (`attrName`,`attrValue`,`price`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `cartitemdetails`
--
ALTER TABLE `cartitemdetails`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cartItemId` (`cartItemId`),
  ADD KEY `productAttributeId` (`productAttributeId`);

--
-- Indexes for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cartId` (`cartId`);

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
  ADD KEY `attributeId` (`attributeId`),
  ADD KEY `productId` (`productId`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributeorderdetails`
--
ALTER TABLE `attributeorderdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `cartitemdetails`
--
ALTER TABLE `cartitemdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cartitems`
--
ALTER TABLE `cartitems`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `continents`
--
ALTER TABLE `continents`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `images`
--
ALTER TABLE `images`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `leagues`
--
ALTER TABLE `leagues`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderaddresses`
--
ALTER TABLE `orderaddresses`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orderdetails`
--
ALTER TABLE `orderdetails`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productassociations`
--
ALTER TABLE `productassociations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `productattributes`
--
ALTER TABLE `productattributes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `uservalidations`
--
ALTER TABLE `uservalidations`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `users` (`id`);

--
-- Constraints for table `attributeorderdetails`
--
ALTER TABLE `attributeorderdetails`
  ADD CONSTRAINT `attributeorderdetails_ibfk_1` FOREIGN KEY (`attributeId`) REFERENCES `attributes` (`id`),
  ADD CONSTRAINT `attributeorderdetails_ibfk_2` FOREIGN KEY (`orderDetailId`) REFERENCES `orderdetails` (`id`);

--
-- Constraints for table `cartitemdetails`
--
ALTER TABLE `cartitemdetails`
  ADD CONSTRAINT `cartitemdetails_ibfk_1` FOREIGN KEY (`cartItemId`) REFERENCES `cartitems` (`id`),
  ADD CONSTRAINT `cartitemdetails_ibfk_2` FOREIGN KEY (`productAttributeId`) REFERENCES `productattributes` (`id`);

--
-- Constraints for table `cartitems`
--
ALTER TABLE `cartitems`
  ADD CONSTRAINT `cartitems_ibfk_1` FOREIGN KEY (`cartId`) REFERENCES `carts` (`id`);

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
  ADD CONSTRAINT `productattributes_ibfk_1` FOREIGN KEY (`attributeId`) REFERENCES `attributes` (`id`),
  ADD CONSTRAINT `productattributes_ibfk_2` FOREIGN KEY (`productId`) REFERENCES `products` (`id`);

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
