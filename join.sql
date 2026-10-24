SELECT
    b.name,
    m.form_score,
    m.date_score,
    m.act_score,
    m.gift_score,
    m.interest_score,
    m.total_score
FROM boyfriend b
INNER JOIN matches m
    ON b.score_id = m.score_id;

SELECT
    b.name,
    d.date_id,
    d.when_
FROM boyfriend b
LEFT JOIN date d
    ON b.bf_id = d.bf_id;

SELECT
    g.gift,
    g.price,
    dd.place,
    b.name
FROM boyfriend b
JOIN date d
    ON b.bf_id = d.bf_id
JOIN date_details dd
    ON d.date_id = dd.date_id
RIGHT JOIN gifts g
    ON dd.details_id = g.details_id;

SELECT
    b.name,
    d.when_,
    dd.place,
    dd.activity,
    g.gift,
    g.price
FROM boyfriend b
INNER JOIN date d
    ON b.bf_id = d.bf_id
INNER JOIN date_details dd
    ON d.date_id = dd.date_id
LEFT JOIN gifts g
    ON dd.details_id = g.details_id;

SELECT b.name
FROM boyfriend b
JOIN matches m
    ON b.score_id = m.score_id
WHERE m.total_score > 7
UNION
SELECT b.name
FROM boyfriend b
WHERE b.money_amount > 200;