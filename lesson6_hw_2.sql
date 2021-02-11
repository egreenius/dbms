/*
Пусть задан некоторый пользователь. 
Из всех друзей этого пользователя найдите человека, который больше всех общался с нашим пользователем.
*/
/*
Понял задачу так, что нужно найти пользователя, который имеет больше всего суммарное количество 
сообщений, которые он писал нашему пользователю и которые наш пользователь писал этому пользователю.
Как решить задачу без UNION к сожалению не придумал. 
Если есть такое решение, подскажите пожалуйста!
UPDATE. Решение без UNION нашел, оно внизу.
*/
/* этот запрос вернет только одну запись. В случае, если у нас несколько пользователей имеют о
динаковое максимальное количество сообщений,  ответ будет не совсем корректным. 
*/
SELECT resp_id, Count(*) count_mes FROM 
  (
  -- выбираем респондентов, которые писали нашему пользователю из числа друзей
	SELECT from_users_id as resp_id FROM messages WHERE to_users_id = 84 AND from_users_id IN
		(
			SELECT
				from_users_id
			FROM friend_requests
			WHERE
				`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
		)
	-- объединяем со вторым набором (знаю еще не проходили объединение, но не знаю как сделать по другому :()
    UNION ALL 
    -- выбираем респондентов, которым писал наш пользователей из числа друзей
	SELECT to_users_id as resp_id FROM messages WHERE from_users_id = 84 AND to_users_id IN
        (
			SELECT
				from_users_id
			FROM friend_requests
			WHERE
			`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
		)
    ) as t1
    GROUP BY t1.resp_id
    ORDER BY COUNT(*) DESC LIMIT 1;
    
/* этот запрос вернет несколько записе, даже если несколько пользователей имеют одинаковое максимальное 
количество сообщений. То есть этот запрос считаю более корректным.
*/
SELECT resp_id, count_mes 
FROM (
		-- этот запрос вернет таблицу, в которой второй колонкой будет суммарное количество сообщений
        -- от респондента в первой колонке
		SELECT resp_id, Count(*) count_mes FROM 
		  (
			-- выбираем респондентов, которые писали нашему пользователю из числа друзей
			SELECT from_users_id as resp_id FROM messages WHERE to_users_id = 84 AND from_users_id IN
				(
					SELECT
						from_users_id
					FROM friend_requests
					WHERE
						`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
				)
			-- объединяем со вторым набором (знаю еще не проходили объединение, но не знаю как сделать по другому :()
			UNION ALL 
            -- выбираем респондентов, которым писал наш пользователей из числа друзей
			SELECT to_users_id as resp_id FROM messages WHERE from_users_id = 84 AND to_users_id IN
				(
					SELECT
						from_users_id
					FROM friend_requests
					WHERE
					`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
				)
			) as t1
			GROUP BY t1.resp_id
	) t3,
	(
		-- этот запрос вернет максимальное  количество сообщенийс нашим пользователем от какого то конкретного пользователя
        SELECT MAX(count_mes) max_mes FROM
			(
				-- это повторение запроса выше, чтобы посчитать максимальное количество сообщений
				SELECT resp_id, Count(*) count_mes FROM 
				  (
					-- выбираем респондентов, которые писали нашему пользователю из числа друзей
					SELECT from_users_id as resp_id FROM messages WHERE to_users_id = 84 AND from_users_id IN
						(
							SELECT
								from_users_id
							FROM friend_requests
							WHERE
								`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
						)
					-- объединяем со вторым набором (знаю еще не проходили объединение, но не знаю как сделать по другому :()
					UNION ALL 
                    -- выбираем респондентов, которым писал наш пользователей из числа друзей
					SELECT to_users_id as resp_id FROM messages WHERE from_users_id = 84 AND to_users_id IN
						(
							SELECT
								from_users_id
							FROM friend_requests
							WHERE
							`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
						)
					) as t1
					GROUP BY t1.resp_id
			) t2
		) t4
-- оставляем только пользователей, написавших+получивших максимальное количество сообщений от/к нашему пользователю
WHERE t3.count_mes = t4.max_mes;

/*
понял как решить задачу без UNION!
Основное решение здесь!
*/
-- основной запрос. В теории запись может оказаться не одна. То есть какие то друзья нашего пользователя могли отправить и получить одинаковое количество сообщений
SELECT 'Пользователь(и), кто больше всего общалисьм с нашим пользователей с id = 84' result, resp_id user_id, max_count 
FROM
	(
		-- запрос формирует таблицу с кол-вом сообщений с нашим пользователем, которыми обменялись его друзья
		SELECT 
			IF(from_users_id = 84, to_users_id, from_users_id) resp_id,
			COUNT(*) count
		FROM 
			messages 
		WHERE
			(
			to_users_id = 84 AND from_users_id IN
				(
					SELECT
						from_users_id
					FROM friend_requests
					WHERE
						`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
				)
			)
			OR
			(
			from_users_id = 84 AND to_users_id IN
				(
					SELECT
						from_users_id
					FROM friend_requests
					WHERE
						`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
				)
			)
		GROUP BY resp_id
	) as t1,
    (
		-- запрос выбирает максимальное количество сообщений и пользователя, с которым общался наш пользователь
		SELECT
			MAX(count) max_count
        FROM
        (
			SELECT 
				IF(from_users_id = 84, to_users_id, from_users_id) resp_id,
				COUNT(*) count
			FROM 
				messages 
			WHERE
				(
				to_users_id = 84 AND from_users_id IN
					(
						SELECT
							from_users_id
						FROM friend_requests
						WHERE
							`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
					)
				)
				OR
				(
				from_users_id = 84 AND to_users_id IN
					(
						SELECT
							from_users_id
						FROM friend_requests
						WHERE
							`status` = 1 AND (from_users_id = 84 OR to_users_id = 84)
					)
				)
			GROUP BY resp_id
        ) as t3
    ) as t2
WHERE
	t1.count = t2.max_count
