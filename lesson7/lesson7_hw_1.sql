/*
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.
*/

SELECT DISTINCT `name` 
FROM users u JOIN orders o 
ON u.id = o.user_id