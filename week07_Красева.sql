-- добавить нового парня с уникальным именем
INSERT INTO boyfriend (name, birth_date, money_amount) 
VALUES ('Leonid', '2001-05-15', 12000);

-- повышение баланса нового парня
UPDATE boyfriend 
SET money_amount = money_amount + 5000 
WHERE name = 'Leonid';

-- удалить парня по имени Leonid
DELETE FROM boyfriend 
WHERE name = 'Leonid';

-- транзакция: изменить баланс двух парней
BEGIN;
UPDATE boyfriend SET money_amount = money_amount - 10000 WHERE name = 'Nikita';
UPDATE boyfriend SET money_amount = money_amount + 10000 WHERE name = 'John';
COMMIT;

-- представление со всей информацией по свиданиям
CREATE VIEW view_full_date_info AS
SELECT b.name, d.when_, dd.place, dd.activity, m.total_score
FROM boyfriend b
JOIN date d ON b.bf_id = d.bf_id
JOIN date_details dd ON d.date_id = dd.date_id
JOIN matches m ON b.score_id = m.score_id;
-- просмотреть эту информацию
SELECT * FROM view_full_date_info;

-- представление о информации о свиданиях понравивштихся парней
CREATE VIEW view_liked_guys_dates AS
SELECT b.name, d.when_, dd.place, dd.activity
FROM boyfriend b
JOIN accept a ON b.bf_id = a.bf_id
JOIN date d ON b.bf_id = d.bf_id
JOIN date_details dd ON d.date_id = dd.date_id
WHERE a.is_liked = TRUE;
-- просмотр
SELECT * FROM view_liked_guys_dates;