SELECT name, birth_date FROM boyfriend
WHERE birth_date BETWEEN '1992-01-01' AND '1995-12-31'; 

SELECT * FROM accept 
WHERE is_liked = TRUE;

SELECT name, birth_date, money_amount FROM boyfriend
WHERE (birth_date >= '1990-01-01' AND birth_date < '2000-01-01')
OR money_amount > 1000000;

SELECT name, money_amount FROM boyfriend
WHERE money_amount BETWEEN 10000 AND 50000;

SELECT name FROM boyfriend
WHERE name LIKE 'A%'
OR name LIKE 'E%'
OR name LIKE 'I%'
OR name LIKE 'O%'
OR name LIKE 'U%';

SELECT name, money_amount FROM boyfriend 
ORDER BY money_amount  DESC;

SELECT bf_id, name FROM boyfriend 
WHERE name LIKE '%67%' 
OR name LIKE '%76%';

SELECT DISTINCT score_id, total_score FROM matches
ORDER BY total_score;


SELECT boyfriend.name, date.when_, date_details.place, date_details.activity FROM boyfriend
JOIN date ON boyfriend.bf_id = date.bf_id
JOIN date_details ON date.date_id = date_details.date_id
WHERE boyfriend.name = 'Nikita';

