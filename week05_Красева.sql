-- вывести парней и все подарки, которые они дарили
SELECT b.name, g.gift
FROM boyfriend b
LEFT JOIN date d  ON b.bf_id = d.bf_id
LEFT JOIN gifts g ON d.date_id = g.date_id;

-- показать парней и их статус (понравился/не понравился)
SELECT b.name, a.is_liked
FROM boyfriend b
FULL JOIN accept a ON b.bf_id = a.bf_id;

-- полная информация о свидании (имя, дата, место, активность, балл) из 4 таблиц
SELECT b.name, d.when_, dd.place, dd.activity, m.total_score
FROM boyfriend b
JOIN date d ON b.bf_id = d.bf_id
JOIN date_details dd ON d.date_id = dd.date_id
JOIN matches m ON b.score_id = m.score_id;

-- вывод всех парней, кроме тех, у кого общий балл больше 35.
SELECT name FROM boyfriend
EXCEPT
SELECT b.name 
FROM boyfriend b
JOIN matches m ON b.score_id = m.score_id
WHERE m.total_score > 35;

-- парни, которые получили лайк и имеют больше 50 тысяч на счету
SELECT b.name 
FROM boyfriend b 
JOIN accept a ON b.bf_id = a.bf_id 
WHERE a.is_liked = TRUE
INTERSECT  
SELECT b.name 
FROM boyfriend b 
WHERE b.money_amount > 50000;

-- информация о свидании понравившихся парней
SELECT b.name, d.when_, dd.place, dd.activity
FROM boyfriend b
JOIN accept a ON b.bf_id = a.bf_id
JOIN date d ON b.bf_id = d.bf_id
JOIN date_details dd ON d.date_id = dd.date_id
WHERE a.is_liked = TRUE;