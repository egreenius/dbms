/*
Создайте представление, которое выводит название name товарной позиции 
из таблицы products и соответствующее название каталога name из таблицы catalogs.
*/
-- Создание представления (отображения)
CREATE VIEW prod_name AS 
SELECT 
	p.name `Product Name`, 
    IF(c.name is NOT NULL, c.name, 'Неопределеная позиция каталога') `Catalog Name` 
FROM 
	products p LEFT JOIN catalogs c
	ON p.catalog_id = c.id

-- вызов предтавления
SELECT * FROM prod_name