/*
(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи. 
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел. 
Вызов функции FIBONACCI(10) должен возвращать число 55.
*/

-- DDL скрипт для создания функции FIBONACCI
USE `shop`;
DROP function IF EXISTS `FIBONACCI`;

USE `shop`;
DROP function IF EXISTS `shop`.`FIBONACCI`;
;

DELIMITER $$
USE `shop`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `FIBONACCI`(pos INT) RETURNS int
    DETERMINISTIC
BEGIN
	DECLARE i INT DEFAULT 2;
	DECLARE f INT DEFAULT 1;
	DECLARE prev_f INT DEFAULT 0;
    DECLARE f1 INT;
	-- базовые случаи
	IF pos = 0 THEN 
		RETURN 0;
	END IF;
	IF pos = 1 THEN
		RETURN 1;
	END IF;
	-- основной цикл
	WHILE i <= pos DO
		SET f1 = f;
		SET f = f + prev_f;
		SET prev_f = f1;
        SET i = i + 1;
	END WHILE;

	RETURN f;
END$$

DELIMITER ;
;

-- проверка
select shop.FIBONACCI(10);