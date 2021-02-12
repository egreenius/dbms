/*
Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT 
	IF(c.name is NOT NULL, c.name, 'Неопределено') Catalog, 
    p.name Products 
FROM catalogs c RIGHT JOIN products p 
ON c.id = p.catalog_id

