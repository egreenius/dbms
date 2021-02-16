/*
В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. 
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
При попытке присвоить полям NULL-значение необходимо отменить операцию.
*/
-- DDL скрипт для создания триггеров на вставку и на обновление записей
-- триггер на вставку BEFORE INSERT
DROP TRIGGER IF EXISTS `shop`.`products_BEFORE_INSERT`;

DELIMITER $$
USE `shop`$$
CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`products_BEFORE_INSERT` BEFORE INSERT ON `products` FOR EACH ROW
BEGIN
IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN
	SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Field `name` and `description` can not be NULL at the same time';
END IF;
END$$
DELIMITER ;

-- триггер на обновление записей BEFORE UPDATE
DROP TRIGGER IF EXISTS `shop`.`products_BEFORE_UPDATE`;

DELIMITER $$
USE `shop`$$

CREATE DEFINER = CURRENT_USER TRIGGER `shop`.`products_BEFORE_UPDATE` BEFORE UPDATE ON `products` FOR EACH ROW
BEGIN
IF (NEW.name IS NULL) AND (NEW.description IS NULL) THEN
	SIGNAL SQLSTATE '45001' SET MESSAGE_TEXT = 'Field `name` and `description` can not be NULL at the same time';
END IF;
END$$
DELIMITER ;