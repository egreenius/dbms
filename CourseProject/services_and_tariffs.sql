-- Запрос возвращает список услуг банка и то, в какой тарифный план входит или не входит та или иная услуга.
-- Этот же запрос реализован в представлении List_of_Services
SELECT 
	s.name as `Service Name`, 
    s.description as `Service Description`, 
	s2.Basic as `Tariff - Basic`,
    s3.Standard as `Tariff - Standard`,
    s4.Advanced as `Tariff - Advanced`
FROM 
	services s,
        (
			SELECT s1.id, IF(ISNULL(ts.tariffs_id), '-', '+') Basic 
			FROM services s1 
			LEFT JOIN (
						SELECT  ts1.tariffs_id tariffs_id, ts1.services_id services_id
						FROM tariffs_services ts1
						INNER JOIN tariffs t ON ts1.tariffs_id = t.id AND t.name = 'Basic'
						) ts 
			ON s1.id = ts.services_id	
		) s2,
        (
			SELECT s1.id, IF(ISNULL(ts.tariffs_id), '-', '+') Standard 
			FROM services s1 
			LEFT JOIN (
						SELECT  ts1.tariffs_id tariffs_id, ts1.services_id services_id
						FROM tariffs_services ts1
						INNER JOIN tariffs t ON ts1.tariffs_id = t.id AND t.name = 'Standard'
						) ts 
			ON s1.id = ts.services_id	
		) s3,
        (
			SELECT s1.id, IF(ISNULL(ts.tariffs_id), '-', '+') Advanced 
			FROM services s1 
			LEFT JOIN (
						SELECT  ts1.tariffs_id tariffs_id, ts1.services_id services_id
						FROM tariffs_services ts1
						INNER JOIN tariffs t ON ts1.tariffs_id = t.id AND t.name = 'Advanced'
						) ts 
			ON s1.id = ts.services_id	
		) s4

WHERE s.id = s2.id AND s.id = s3.id AND s.id = s4.id