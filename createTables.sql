-- Tasarımını yaptığınız tabloları oluşturan sql ifadeleri buraya yazınız.
-- veri tiplerine, nullable olma durumuna, default değerine ve tablolar arası foreign key kullanımına dikkat.

--www.itopya.com -- teknoloji marketin aşırı detaya kaçılmadan veritabanı tasarımı.

CREATE TABLE `products_orders`(
    `product_order_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_id` SMALLINT NOT NULL,
    `order_id` SMALLINT NOT NULL,
    `order_quantity` BIGINT NOT NULL,
    `discount_rate` DOUBLE(8, 2) NULL COMMENT '0 = no discount'
);
CREATE TABLE `products`(
    `product_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `product_fullname` VARCHAR(255) NOT NULL,
    `category_id` SMALLINT NOT NULL,
    `supplier_id` SMALLINT NOT NULL,
    `stock_quantity` BIGINT NOT NULL,
    `unit_price` DECIMAL(8, 2) NOT NULL,
    `product_serial_no` VARCHAR(255) NULL,
    `product_model_no` CHAR(36) NOT NULL
);
ALTER TABLE
    `products` ADD UNIQUE `products_product_fullname_unique`(`product_fullname`);
ALTER TABLE
    `products` ADD UNIQUE `products_product_model_no_unique`(`product_model_no`);
CREATE TABLE `roles`(
    `role_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `role_name` VARCHAR(255) NOT NULL,
    `description` TEXT NOT NULL,
    `isActive` TINYINT(1) NULL DEFAULT '1'
);
CREATE TABLE `users`(
    `user_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_name` VARCHAR(255) NOT NULL,
    `user_surname` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `adress` VARCHAR(255) NOT NULL,
    `city` VARCHAR(255) NOT NULL,
    `registered_date` DATE NOT NULL,
    `isActive` TINYINT(1) NULL DEFAULT '1'
);
ALTER TABLE
    `users` ADD UNIQUE `users_email_unique`(`email`);
CREATE TABLE `categories`(
    `category_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `category_name` VARCHAR(255) NOT NULL,
    `employee_id` SMALLINT NOT NULL
);
CREATE TABLE `orders`(
    `order_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `user_id` SMALLINT NOT NULL,
    `order_date` DATETIME NOT NULL,
    `delivery_date` DATETIME NULL,
    `abortion_date` DATETIME NULL,
    `order_note` LONGTEXT NULL,
    `order_code` CHAR(36) NOT NULL,
    `status` CHAR(255) NOT NULL DEFAULT 'O' COMMENT 'O:Ongoing
D:Delivered
A:Aborted'
);
ALTER TABLE
    `orders` ADD UNIQUE `orders_order_code_unique`(`order_code`);
CREATE TABLE `suppliers`(
    `supplier_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `supplier_title` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `isActive` TINYINT(1) NULL DEFAULT '1'
);
CREATE TABLE `employees`(
    `employee_id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `employee_name` VARCHAR(255) NOT NULL,
    `employee_surname` VARCHAR(255) NOT NULL,
    `province` VARCHAR(255) NOT NULL,
    `role_id` SMALLINT NOT NULL,
    `working_status` CHAR(255) NOT NULL DEFAULT 'D' COMMENT 'D: On Duty
V: On Vacation',
    `spouse_employee_id` SMALLINT NULL,
    `isActive` TINYINT(1) NULL DEFAULT '1'
);
ALTER TABLE
    `products` ADD CONSTRAINT `products_supplier_id_foreign` FOREIGN KEY(`supplier_id`) REFERENCES `suppliers`(`supplier_id`);
ALTER TABLE
    `orders` ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY(`user_id`) REFERENCES `users`(`user_id`);
ALTER TABLE
    `products_orders` ADD CONSTRAINT `products_orders_product_id_foreign` FOREIGN KEY(`product_id`) REFERENCES `products`(`product_id`);
ALTER TABLE
    `categories` ADD CONSTRAINT `categories_employee_id_foreign` FOREIGN KEY(`employee_id`) REFERENCES `employees`(`employee_id`);
ALTER TABLE
    `products_orders` ADD CONSTRAINT `products_orders_order_id_foreign` FOREIGN KEY(`order_id`) REFERENCES `orders`(`order_id`);
ALTER TABLE
    `products` ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY(`category_id`) REFERENCES `categories`(`category_id`);
ALTER TABLE
    `employees` ADD CONSTRAINT `employees_role_id_foreign` FOREIGN KEY(`role_id`) REFERENCES `roles`(`role_id`);