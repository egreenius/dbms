/*
(по желанию) Пусть имеется любая таблица с календарным полем created_at. 
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/
-- вспомогательный запрос
SELECT * FROM shop.products
WHERE 
	created_at < (SELECT MIN(created_at) FROM 
					(SELECT created_at FROM shop.products ORDER BY created_at DESC LIMIT 5) as t1);
-- основной запрос
DELETE FROM shop.products
WHERE 
	created_at < (SELECT MIN(created_at) FROM 
					(SELECT created_at FROM shop.products ORDER BY created_at DESC LIMIT 5) as t1);
-- проверочный запрос
SELECT * FROM shop.products