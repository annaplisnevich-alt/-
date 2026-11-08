-- общее количество парней
SELECT COUNT(*) AS total_boyfriends FROM boyfriend;

-- общая сумма денег всех парней
SELECT SUM(money_amount) AS total_money FROM boyfriend;

-- среднее количество денег
SELECT AVG(money_amount) AS average_money FROM boyfriend;

-- самый бедный и самый богатый
SELECT MIN(money_amount) AS poorest, MAX(money_amount) AS richest FROM boyfriend;

-- количество парней по каждому году рождения
SELECT EXTRACT(YEAR FROM birth_date) AS birth_year, COUNT(*) AS guys_count FROM boyfriend
GROUP BY birth_year
ORDER BY birth_year;

-- GROUP BY по двум столбцам (тип подарка и его цена)
SELECT gift, price, COUNT(*) AS times_gifted FROM gifts
GROUP BY gift, price
ORDER BY price DESC;

-- парни, у которых общая сумма подарков больше 300
SELECT bf_id, SUM(price) AS total_gift_value FROM date_details
JOIN gifts ON date_details.details_id = gifts.details_id
GROUP BY bf_id
HAVING SUM(price) > 300
ORDER BY total_gift_value DESC;

-- года рождения, в которые родилось не менее 3 парней
SELECT EXTRACT(YEAR FROM birth_date) AS birth_year, COUNT(*) AS count FROM boyfriend
GROUP BY birth_year
HAVING COUNT(*) >= 3;

-- количество парней с деньгами > 10000 по годам
SELECT EXTRACT(YEAR FROM birth_date) AS birth_year, COUNT(*) AS rich_guys FROM boyfriend
WHERE money_amount > 10000
GROUP BY birth_year
ORDER BY rich_guys DESC;

-- количество уникальных имен (у нас все очень нишевые и имена не повторяются)
SELECT COUNT(DISTINCT name) AS unique_names FROM boyfriend;

-- средний общий балл
SELECT ROUND(AVG(total_score), 2) AS average_total_score FROM matches;

-- группировка парней по уровню богатства
SELECT 
    CASE 
        WHEN money_amount = 0 THEN 'Broke'
        WHEN money_amount < 50000 THEN 'Middle'
        ELSE 'Rich'
    END AS wealth_status,
    COUNT(*) AS count
FROM boyfriend
GROUP BY wealth_status
ORDER BY count DESC;

-- общая стоимость подарков по каждому свиданию, отсортировано по убыванию общей стоимости 
-- (но у нас на каждом свидании был 1 подарок, поэтому выведется просто цена каждого подарка по убыванию)
SELECT date_id, SUM(price) AS total_price FROM gifts
GROUP BY date_id
ORDER BY total_price DESC;

-- самый дорогой подарок за каждый год (но у нас все свидания в 2026, поэтому выведется просто самый дорогой подарок за 2026)
SELECT EXTRACT(YEAR FROM date.when_) AS meeting_year, MAX(gifts.price) AS most_expensive_gift FROM date
JOIN gifts ON date.date_id = gifts.date_id
GROUP BY meeting_year
ORDER BY meeting_year;

-- года, где средний form_score > 5 (я забыла, что такое form_score :(( )
SELECT EXTRACT(YEAR FROM boyfriend.birth_date) AS birth_year, AVG(matches.form_score) AS avg_form FROM boyfriend
JOIN matches ON boyfriend.score_id = matches.score_id
GROUP BY birth_year
HAVING AVG(matches.form_score) > 5
ORDER BY avg_form DESC;