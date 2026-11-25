-- самый бедный и самый богатый
SELECT MIN(money_amount) AS poorest, MAX(money_amount) AS richest FROM boyfriend;

-- количество парней по каждому году рождения
SELECT EXTRACT(YEAR FROM birth_date) AS birth_year, COUNT(*) AS guys_count FROM boyfriend
GROUP BY birth_year
ORDER BY birth_year;

-- группировка парней по уровню богатства
SELECT 
    CASE 
        WHEN money_amount = 0 THEN 'Broke'
        WHEN money_amount < 50000 THEN 'Middle'
        ELSE 'Rich'
    END 
    AS wealth_status,
    COUNT(*) AS count
FROM boyfriend
GROUP BY wealth_status
ORDER BY count DESC;

-- самый дорогой подарок за каждый год 
SELECT EXTRACT(YEAR FROM date.when_) AS meeting_year, MAX(gifts.price) AS most_expensive_gift FROM date
JOIN gifts ON date.date_id = gifts.date_id
GROUP BY meeting_year
ORDER BY meeting_year;

-- количество уникальных имен 
SELECT COUNT(DISTINCT name) AS unique_names FROM boyfriend;