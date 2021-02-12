/*
(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
Поля from, to и label содержат английские названия городов, поле name — русское. 
Выведите список рейсов flights с русскими названиями городов.
*/

SELECT 
	id, 
    c.name Откуда, 
    c1.name Куда 
FROM 
	flights f JOIN cities c 
ON f.from = c.label
JOIN cities c1 
ON f.to = c1.label
ORDER BY f.id