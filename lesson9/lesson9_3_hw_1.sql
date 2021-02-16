/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. 
 С 06:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".
*/

-- скрипт для создания хранимой процедуры
CREATE DEFINER=`root`@`localhost` PROCEDURE `hello`()
BEGIN
	SET @dt := TIME(NOW());
	SELECT 
		CASE 
			WHEN @dt BETWEEN '06:00' AND '12:00' THEN 'Доброе утро!' 
			WHEN @dt BETWEEN '12:00' AND '18:00' THEN 'Добрый день!'
			WHEN @dt BETWEEN '18:00' AND '00:00' THEN 'Доброй ночи!'
			ELSE 'Привет, полуночник!'
		  END;
END;

-- DDL скрипт по созданию хранимой процедуры
USE `shop`;
DROP procedure IF EXISTS `shop`.`hello`;
;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `hello`()
BEGIN
	SET @dt := TIME(NOW());
	SELECT
		CASE 
			WHEN @dt BETWEEN '06:00' AND '12:00' THEN 'Доброе утро!' 
			WHEN @dt BETWEEN '12:00' AND '18:00' THEN 'Добрый день!'
			WHEN @dt BETWEEN '18:00' AND '00:00' THEN 'Доброй ночи!'
			ELSE 'Привет, полуночник!'
		  END;
END$$

DELIMITER ;
;
-- вызов хранимой процедуры
CALL hello()