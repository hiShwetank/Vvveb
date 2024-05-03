DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `order_id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `invoice_no` varchar(64) NOT NULL DEFAULT '0',
  `customer_order_id` varchar(64) NOT NULL DEFAULT '0',
  `invoice_prefix` varchar(26) NOT NULL DEFAULT 'I-',
  `site_id` tinyint(6) NOT NULL DEFAULT '0',
  `site_name` varchar(64) NOT NULL,
  `user_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `user_group_id` INT UNSIGNED NOT NULL DEFAULT '0',
  `first_name` varchar(32) NOT NULL,
  `last_name` varchar(32) NOT NULL,
  `email` varchar(96) NOT NULL,
  `phone_number` varchar(32) NOT NULL DEFAULT '',
-- billing
  `billing_first_name` varchar(32) NOT NULL,
  `billing_last_name` varchar(32) NOT NULL,
  `billing_company` varchar(60) NOT NULL DEFAULT '',
  `billing_address_1` varchar(191) NOT NULL,
  `billing_address_2` varchar(191) NOT NULL DEFAULT '',
  `billing_city` varchar(128) NOT NULL DEFAULT '',
  `billing_post_code` varchar(10) NOT NULL DEFAULT '',
  `billing_country_id` INT UNSIGNED NOT NULL,
  `billing_region` varchar(128) NOT NULL DEFAULT '',
  `billing_region_id` INT UNSIGNED NOT NULL,
--  `billing_fields` text,
  `payment_method` varchar(128) NOT NULL DEFAULT '',
  `payment_data` text,
-- shipping
  `shipping_first_name` varchar(32) NOT NULL DEFAULT '',
  `shipping_last_name` varchar(32) NOT NULL DEFAULT '',
  `shipping_company` varchar(60) NOT NULL DEFAULT '',
  `shipping_address_1` varchar(191) NOT NULL DEFAULT '',
  `shipping_address_2` varchar(191) NOT NULL DEFAULT '',
  `shipping_city` varchar(128) NOT NULL DEFAULT '',
  `shipping_post_code` varchar(10) NOT NULL DEFAULT '',
  `shipping_country` varchar(128) NOT NULL DEFAULT '',
  `shipping_country_id` INT UNSIGNED NOT NULL DEFAULT 0,
  `shipping_region` varchar(128) NOT NULL  DEFAULT '',
  `shipping_region_id` INT UNSIGNED NOT NULL DEFAULT 0,
--  `shipping_fields` text,
  `shipping_method` varchar(128) NOT NULL DEFAULT '',
  `shipping_data` text,
  `total` decimal(15,4) NOT NULL DEFAULT '0.0000',
  `order_status_id` INT UNSIGNED NOT NULL DEFAULT '0',
  `language_id` INT UNSIGNED NOT NULL,
  `currency_id` INT UNSIGNED NOT NULL,
  `currency_code` varchar(3) NOT NULL DEFAULT '',
  `currency_value` decimal(15,8) NOT NULL DEFAULT '1.00000000',
  `notes` text,
  `remote_ip` varchar(40) NOT NULL DEFAULT '',
  `forwarded_for_ip` varchar(40) NOT NULL DEFAULT '',
  `user_agent` varchar(191) NOT NULL DEFAULT '',
  `created_at` datetime NOT NULL DEFAULT current_timestamp,
  `updated_at` datetime NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`order_id`),
  KEY `order_status_id` (`site_id`,`order_status_id`,`created_at`),
  KEY `customer_order_id` (`customer_order_id`,`order_status_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;
