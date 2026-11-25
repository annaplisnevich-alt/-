-- парни, которые родились с 1992 по 1995 год
SELECT name, birth_date FROM boyfriend
WHERE birth_date BETWEEN '1992-01-01' AND '1995-12-31'; 

-- парни с количеством денег от 10000 до 50000
SELECT name, money_amount FROM boyfriend
WHERE money_amount BETWEEN 10000 AND 50000;

-- парни, у которых имя начинается на гласную
SELECT name FROM boyfriend
WHERE name LIKE 'A%'
OR name LIKE 'E%'
OR name LIKE 'I%'
OR name LIKE 'O%'
OR name LIKE 'U%';

-- вывод имени и количества денег, отсортировано по убыванию количества денег
SELECT name, money_amount FROM boyfriend 
ORDER BY money_amount DESC;

-- парни с длиной имени больше 6 и количеством денег болише 20к или те, кто родились в 1999
SELECT name, birth_date, money_amount FROM boyfriend
WHERE (LENGTH(name) > 6 AND money_amount > 20000)
   OR EXTRACT(YEAR FROM birth_date) = 1999;

-- score_id тех, у кого общий балл между 25 и 35
SELECT score_id, total_score FROM matches
WHERE total_score BETWEEN 25 AND 35