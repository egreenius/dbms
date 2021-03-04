-- Запрос возвращает список курсов валют 
SELECT DISTINCT r.`timestamp`, cs.code Sell, cb.code Buy, r.rate Rate FROM rates r
    JOIN (
			SELECT MAX(`timestamp`) tid FROM rates r
			JOIN currencies cs ON cs.id = cur_2_sell
			JOIN currencies cb ON cb.id = cur_2_buy
			GROUP BY cs.code, cb.code			
		) g ON r.`timestamp` = g.tid
	JOIN currencies cs ON cs.id = cur_2_sell
	JOIN currencies cb ON cb.id = cur_2_buy