CREATE TABLE `filial_points` (
  `id_filial_point` int NOT NULL AUTO_INCREMENT,
  `index_filial_point` longtext NOT NULL,
  `city_filial_point` longtext NOT NULL,
  `disctrict_filial_point` longtext NOT NULL,
  PRIMARY KEY (`id_filial_point`)
);

CREATE TABLE `item_categories` (
  `id_item_category` int NOT NULL AUTO_INCREMENT,
  `name_item_category` varchar(100) NOT NULL,
  PRIMARY KEY (`id_item_category`)
);

CREATE TABLE `items` (
  `articule_item` varchar(6) NOT NULL,
  `name_item` varchar(100) NOT NULL,
  `measurement_item` enum('шт.') NOT NULL,
  `price_item` decimal(7,2) NOT NULL,
  `id_supplier_item` int NOT NULL,
  `id_manufacture_item` int NOT NULL,
  `category_item` int NOT NULL,
  `discount_item` int NOT NULL,
  `count_in_storage_item` int NOT NULL,
  `description_item` longtext NOT NULL,
  `photo_item` longblob,
  PRIMARY KEY (`articule_item`),
  KEY `fk_supplier_suppliers_idx` (`id_supplier_item`),
  KEY `fk_manufacture_manufactures_idx` (`id_manufacture_item`),
  KEY `fk_category_item_categories_idx` (`category_item`),
  CONSTRAINT `fk_category_item_categories` FOREIGN KEY (`category_item`) REFERENCES `item_categories` (`id_item_category`),
  CONSTRAINT `fk_manufacture_manufactures` FOREIGN KEY (`id_manufacture_item`) REFERENCES `manufactures` (`id_manufacture`),
  CONSTRAINT `fk_supplier_suppliers` FOREIGN KEY (`id_supplier_item`) REFERENCES `suppliers` (`id_supplier`)
);

CREATE TABLE `manufactures` (
  `id_manufacture` int NOT NULL AUTO_INCREMENT,
  `name_manufacture` varchar(100) NOT NULL,
  PRIMARY KEY (`id_manufacture`)
);

CREATE TABLE `order_imports` (
  `id_order_import` int NOT NULL AUTO_INCREMENT,
  `date_order_import` date NOT NULL,
  `date_of_delivery_order_import` date NOT NULL,
  `id_filial_point_order_import` int NOT NULL,
  `id_client_order_import` int NOT NULL,
  `code_order_import` varchar(6) NOT NULL,
  `status_order_import` enum('Новый','Завершен') NOT NULL,
  PRIMARY KEY (`id_order_import`),
  KEY `fk_id_pickup_points_idx` (`id_filial_point_order_import`),
  KEY `fk_id_client_user_imports_idx` (`id_client_order_import`),
  CONSTRAINT `fk_id_client_user_imports` FOREIGN KEY (`id_client_order_import`) REFERENCES `user_imports` (`id_user_import`),
  CONSTRAINT `fk_id_filial_points` FOREIGN KEY (`id_filial_point_order_import`) REFERENCES `filial_points` (`id_filial_point`)
);

CREATE TABLE `order_items` (
  `id_order_item` int NOT NULL,
  `articul_item` varchar(6) NOT NULL,
  `count_item` int NOT NULL,
  PRIMARY KEY (`id_order_item`,`articul_item`),
  KEY `fk_articul_item_items_idx` (`articul_item`),
  CONSTRAINT `fk_articul_item_items` FOREIGN KEY (`articul_item`) REFERENCES `items` (`articule_item`),
  CONSTRAINT `fk_id_order_order_imports` FOREIGN KEY (`id_order_item`) REFERENCES `order_imports` (`id_order_import`)
);

CREATE TABLE `suppliers` (
  `id_supplier` int NOT NULL AUTO_INCREMENT,
  `name_supplier` varchar(100) NOT NULL,
  PRIMARY KEY (`id_supplier`)
);

CREATE TABLE `user_imports` (
  `id_user_import` int NOT NULL AUTO_INCREMENT,
  `role_user_import` enum('Администратор','Менеджер','Авторизированный клиент') NOT NULL,
  `surname_user_import` varchar(100) NOT NULL,
  `name_user_import` varchar(100) NOT NULL,
  `lastname_user_import` varchar(100) NOT NULL,
  `login_user_import` varchar(100) NOT NULL,
  `password_user_import` varchar(45) NOT NULL,
  PRIMARY KEY (`id_user_import`)
);