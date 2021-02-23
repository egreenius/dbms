/*
Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
catalogs и products в таблицу logs помещается время и дата создания записи, 
название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

DROP TABLE IF EXISTS `shop`.`logs`;
CREATE TABLE `shop`.`logs` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `table_name` VARCHAR(255) NOT NULL,
  `raw_id` INT UNSIGNED NOT NULL,
  `raw_name` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = ARCHIVE;  -- ключ для определения типа базы данных

-- создаем триггер на таблицу users
-- вопрос: как вместо хардкода имени таблицы, достать ее из самой базы данных?
DROP TRIGGER IF EXISTS `shop`.`users_AFTER_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`root`@`localhost` TRIGGER `users_AFTER_INSERT` AFTER INSERT ON `users` FOR EACH ROW BEGIN
INSERT INTO logs (id, `date`, `time`, `table_name`, raw_id, raw_name) VALUES 
(
	NULL, DATE(NOW()), TIME(NOW()), 'users', NEW.id, NEW.name
);
END$$
DELIMITER ;


-- создаем триггер на таблицу catalogs
DROP TRIGGER IF EXISTS `shop`.`catalogs_AFTER_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`catalogs_AFTER_INSERT` AFTER INSERT ON `catalogs` FOR EACH ROW
BEGIN
INSERT INTO logs (id, `date`, `time`, `table_name`, raw_id, raw_name) VALUES 
(
	NULL, DATE(NOW()), TIME(NOW()), 'catalogs', NEW.id, NEW.name
);
END$$
DELIMITER ;

-- создаем триггер на таблицу products
DROP TRIGGER IF EXISTS `shop`.`products_AFTER_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`products_AFTER_INSERT` AFTER INSERT ON `products` FOR EACH ROW
BEGIN
INSERT INTO logs (id, `date`, `time`, `table_name`, raw_id, raw_name) VALUES 
(
	NULL, DATE(NOW()), TIME(NOW()), 'products', NEW.id, NEW.name
);
END$$
DELIMITER ;
