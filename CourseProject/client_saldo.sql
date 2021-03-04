/* 
Скрипт возвращающий список клиентов банка с указанием тарифного плана и совокупного баланса на всех счетах
каждого клиента. Совокупный баланс считается с учетом актуальных (последних) на момент исполнения запроса
курсов валют и выражается в базовой валюте (в данном случае в рублях). 
Этот же скрипт используется в представлении List_of_Clients
*/
SELECT 
	c.code `Client Code`,
    IF(c.residence = 1, 'Резидент', 'Нерезидент') Residence,
    c.citizenship Citizenship,
    CONCAT(p.first_name, ' ', p.last_name) `Client Name`,
    tr.name `Tariff Name`,
    FORMAT(IF(ISNULL(t2.Rub_Balance), 0, t2.Rub_Balance), 2) `Total balance in rubbles`
FROM clients c LEFT JOIN
(
	SELECT a.client_id, SUM(IF(ISNULL(t1.rate), a.balance, a.balance * t1.rate)) Rub_Balance FROM accounts a
	LEFT JOIN (
				SELECT cur_2_sell, rate FROM rates r
				JOIN (
						SELECT MAX(`timestamp`) tid FROM rates r1
						GROUP BY r1.cur_2_sell, r1.cur_2_buy
						HAVING r1.cur_2_buy = 1
					) t ON r.`timestamp` = t.tid AND r.cur_2_buy = 1
				) t1 ON a.cur_id = t1.cur_2_sell AND a.acc_type = 'cu'
	GROUP BY a.client_id
) t2 ON c.id = t2.client_id
JOIN profiles p ON c.users_id = p.users_id 
JOIN tariffs tr ON c.tariffs_id = tr.id
ORDER BY c.code