/*
(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/

USE `shop`;
DROP procedure IF EXISTS `do_million`;

-- процедура, которая вставляет в таблицу users количество записе переданное в параметре
DELIMITER $$
USE `shop`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `do_million`(n INT)
BEGIN
  DECLARE v1 INT DEFAULT 1;
  DECLARE f_name VARCHAR(50) DEFAULT 'My_First_Name_';
  DECLARE l_name VARCHAR(50) DEFAULT 'My_Last_Name_';
  START TRANSACTION; -- включам транзацию, чтобы уменьшить время отработку создания\ обновления индексов и т.д.
  WHILE v1 <= n DO
    INSERT `users` (id, `name`, `birthday_at`) VALUES 
    (
		NULL, CONCAT(f_name, CAST(v1 as CHAR), ' ', l_name, CAST(v1 as CHAR)), '2000-01-01'
    );
    SET v1 = v1 + 1;
  END WHILE;
  COMMIT;
END$$

DELIMITER ;
;