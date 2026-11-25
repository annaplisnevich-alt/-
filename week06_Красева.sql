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