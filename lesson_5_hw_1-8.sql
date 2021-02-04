/*
 * ******************************************************************************
 * Практическое задание по теме «Операторы, фильтрация, сортировка и ограничение»
 * ******************************************************************************
 */

/*
Задание №1
Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
*/
-- создал новую таблицу user_1 в которой поля created_at и updated_at могут иметь значение NULL

UPDATE shop.users_1 SET created_at = NOW(), updated_at = NOW() WHERE created_at is NULL and updated_at is NULL;
SELECT * FROM shop.users_1;

/*
 Задание №2
 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и 
 в них долгое время помещались значения в формате 20.10.2017 8:10. Необходимо преобразовать поля к типу DATETIME, 
 сохранив введённые ранее значения.
 */
-- создал новую таблицу user_2 в которой поля created_at и updated_at первоначально имеют тип varchar и значение 
-- 20.10.2017 8:10
UPDATE shop.user_2 
	SET created_at = STR_TO_DATE(created_at,'%d.%m.%Y %h:%i'), updated_at = STR_TO_DATE(updated_at,'%d.%m.%Y %h:%i');
SELECT * FROM shop.users_2;
-- ALTER TABLE - с приведением полей created_at и updated_at к типу DATETIME прошло успешно

 /*
  * Задание №3
  * В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0, 
  * если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
  * чтобы они выводились в порядке увеличения значения value. 
  * Однако нулевые запасы должны выводиться в конце, после всех записей.
  */
SELECT `value` FROM shop.storehouses_products ORDER BY `value` = 0, `value`;


/*
 * Задание №4
 * (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае. Месяцы заданы 
 * в виде списка английских названий (may, august)
 */
SELECT *  FROM shop.users WHERE MONTHNAME(birthday_at) in ('may', 'august');

/*
 * Задание №5
 * (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса. SELECT * FROM catalogs WHERE id IN (5, 1, 2); 
 * Отсортируйте записи в порядке, заданном в списке IN.
 */
-- с использование CASE
SELECT 
	*
FROM catalogs  WHERE id IN (5, 1, 2) ORDER BY CASE id
	WHEN 5 THEN 1
	WHEN 1 THEN 2
	WHEN 2 THEN 3
END;
-- с использованием FIELD()
SELECT * FROM shop.catalogs WHERE id IN (5, 1, 2) ORDER BY FIELD(id, 5, 1, 2);

/*
 * ************************************************
 * Практическое задание теме «Агрегация данных»
 * ************************************************
 */
/*
 * Задание №1
 * Подсчитайте средний возраст пользователей в таблице users.
 */

SELECT AVG(timestampdiff(YEAR, birthday_at, NOW())) as Age FROM shop.users;


/*
 * Задание №2
 * Подсчитайте количество дней рождения, 
 * которые приходятся на каждый из дней недели. Следует учесть, 
 * что необходимы дни недели текущего года, а не года рождения.
 */
SELECT DAYNAME(CONCAT(YEAR(NOW()), '-', MONTH(birthday_at), '-', DAY(birthday_at))) as `Week Day`, COUNT(*) as `Number of Day` FROM shop.users GROUP BY `Week Day`;


/*
 * Задание №3
 * (по желанию) Подсчитайте произведение чисел в столбце таблицы.
 * 
 */
-- перемножаем поле id таблицы shop.users. Так как id - целое, результат тоже должен быть целым
SELECT CONVERT(EXP(sum(ln(id))), UNSIGNED) as mult_id FROM shop.users;
