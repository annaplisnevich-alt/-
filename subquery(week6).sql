-- парни, у которых балл > 35
SELECT name FROM boyfriend
WHERE score_id IN (SELECT score_id FROM matches WHERE total_score > 35);

-- парни, у которых балл больше, чем хотя бы у одного парня с деньгами = 0
SELECT name FROM boyfriend
WHERE score_id IN (
    SELECT score_id FROM matches 
    WHERE total_score > ANY (
        SELECT total_score FROM matches 
        JOIN boyfriend ON matches.score_id = boyfriend.score_id 
        WHERE money_amount = 0
    )
);

-- парни, у которых балл больше, чем у всех парней с деньгами = 0
SELECT name FROM boyfriend
WHERE score_id IN (
    SELECT score_id FROM matches 
    WHERE total_score > ALL (
        SELECT total_score FROM matches 
        JOIN boyfriend ON matches.score_id = boyfriend.score_id 
        WHERE money_amount = 0
    )
);

-- парни, которые подарили подарок дороже 400
SELECT name FROM boyfriend b
WHERE EXISTS (
    SELECT 1 FROM date d 
    JOIN gifts g ON d.date_id = g.date_id 
    WHERE d.bf_id = b.bf_id AND g.price > 400
);

-- парни, которые не подарили ни одного подарка за 0
SELECT name FROM boyfriend b
WHERE NOT EXISTS (
    SELECT 1 FROM date d 
    JOIN gifts g ON d.date_id = g.date_id 
    WHERE d.bf_id = b.bf_id AND g.price = 0
);

-- имя и его макс. балл
SELECT name, (SELECT total_score FROM matches WHERE matches.score_id = boyfriend.score_id) AS match_score FROM boyfriend;

-- средний балл за активность среди тех, кто лайкнут
SELECT AVG(act_score) AS avg_act_score_liked
FROM (
    SELECT act_score FROM matches 
    WHERE score_id IN (
        SELECT score_id FROM boyfriend 
        JOIN accept ON boyfriend.bf_id = accept.bf_id 
        WHERE is_liked = TRUE
    )
) AS liked_guys;

-- выборка лайкнутых парней
WITH Liked AS (
    SELECT bf_id FROM accept WHERE is_liked = TRUE
)
SELECT name FROM boyfriend WHERE bf_id IN (SELECT bf_id FROM Liked);

-- считаем статистику по дорогим подаркам
WITH ExpensiveGifts AS (
    SELECT * FROM gifts WHERE price > 100
)
SELECT COUNT(*) AS count_expensive, AVG(price) AS avg_price FROM ExpensiveGifts;

-- парни, родившиеся в тот же год, что и Nikita
SELECT name FROM boyfriend 
WHERE EXTRACT(YEAR FROM birth_date) IN (
    SELECT EXTRACT(YEAR FROM birth_date) FROM boyfriend WHERE name = 'Nikita'
);

-- разница между деньгами парня и средней стоимостью подарка
SELECT name, money_amount, money_amount - (SELECT AVG(price) FROM gifts) AS diff_from_avg_gift FROM boyfriend;

-- парни, чей общий балл выше среднего
WITH AvgScore AS (
    SELECT AVG(total_score) as avg_t FROM matches
)
SELECT name FROM boyfriend b
JOIN matches m ON b.score_id = m.score_id
WHERE m.total_score > (SELECT avg_t FROM AvgScore);

-- находим парней, чьи общие баллы выше среднего, и выводим их имя, балл и средний балл по всей базе
WITH Stats AS (
    SELECT AVG(total_score) AS global_avg FROM matches
)
SELECT b.name, m.total_score, ROUND(s.global_avg, 2) AS average_score FROM boyfriend b
JOIN matches m ON b.score_id = m.score_id
CROSS JOIN Stats s
WHERE m.total_score > s.global_avg
ORDER BY m.total_score DESC;

-- парни, у которых есть оценка 10 хотя бы по 1 из критериев
SELECT name FROM boyfriend b
WHERE EXISTS (
    SELECT 1 FROM matches m 
    WHERE m.score_id = b.score_id 
    AND (m.form_score = 10 OR m.date_score = 10 OR m.act_score = 10 OR m.gift_score = 10 OR m.interest_score = 10)
);

-- парни, которые дарили подарки больше 100
SELECT name FROM boyfriend 
WHERE bf_id IN (
    SELECT d.bf_id FROM date d
    JOIN gifts g ON d.date_id = g.date_id
    WHERE g.price > 100
);

-- парни, которые не дарили подарки больше 100
SELECT name FROM boyfriend 
WHERE bf_id NOT IN (
    SELECT d.bf_id FROM date d
    JOIN gifts g ON d.date_id = g.date_id
    WHERE g.price > 100
);