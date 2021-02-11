/*
Определить кто больше поставил лайков (всего) - мужчины или женщины?
*/
-- базовый запрос. Выводит информацию о том, какого пола был пользователь, поставивший лайк
/*
SELECT
    (SELECT gender FROM `profiles` WHERE users_id = r1.users_id) gender
FROM 
	reaction r1
*/
-- основной запрос. Выводит информацию о максимальном количестве поставленных лайков каким то полом
SELECT IF(COUNT(*) >1, 'Победила любовь!', IF(gender = 'f', 'Женщины поставили лайков больше', 'Мужчины поставили лайков больше')) result, gender, max_count 
FROM
	(
    -- первая таблица, выводит информацию о количестве лайков соответствующего пола
	SELECT 
		gender, COUNT(gender) g_count
	FROM
		(
			-- базовый запрос
			SELECT
				(SELECT gender FROM `profiles` WHERE users_id = r1.users_id) gender
			FROM 
			reaction r1 
		) t1
	GROUP BY gender
    ) t3,
    (
    -- вторая таблица, выводит информацию о максимальном количестве лайков
	SELECT
		MAX(g_count) as max_count
	FROM
		(
		SELECT 
			gender, COUNT(gender) g_count
		FROM
			(
				SELECT
					(SELECT gender FROM `profiles` WHERE users_id = r1.users_id) gender
				FROM 
				reaction r1 
			) t1
		GROUP BY gender
		) t2
	) t4
WHERE
	-- находим соответствие между максимальным количеством лайков и половой принадлежности победителей. Может вернуть более одного значения
	t3.g_count = t4.max_count
GROUP BY gender






