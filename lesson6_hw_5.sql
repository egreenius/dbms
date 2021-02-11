/*
Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
*/
-- активность считаем по суммарному кол-ву сообщений, лайков и постов
-- основной запрос. выводит информацию об активности пользователей и их идентификаторы. Выводим только первые 10 записей
SELECT
	t1.user_id,
    count_m + count_p + count_l activity
FROM
	(
		-- подзапрос, выводящий таблицу с кол-вом сообщений каждого пользователей
		SELECT
			from_users_id user_id,
			COUNT(*) count_m
		FROM 
			messages m
		GROUP BY from_users_id
	) t1,
    (
		-- подзапрос, выводящий таблицу с кол-вом постов каждого пользователей
		SELECT
			users_id  user_id,
			COUNT(*) count_p
		FROM
			posts p
		GROUP BY users_id
	) t2,
    (
		-- подзапрос, выводящий таблицу с кол-вом "лайков" каждого пользователей
		SELECT
			users_id user_id,
			COUNT(*) count_l
		FROM
			reaction l
		GROUP BY users_id
	) t3
WHERE
	t1.user_id = t2.user_id AND t1.user_id = t3.user_id
ORDER BY activity LIMIT 10
