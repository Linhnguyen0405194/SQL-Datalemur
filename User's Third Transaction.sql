WITH ranking AS
(
SELECT *,
       ROW_NUMBER() OVER(PARTITION BY user_id
                         ORDER BY transaction_date ASC) AS rank_date
FROM transactions
)

SELECT user_id, spend, transaction_date
FROM ranking
WHERE rank_date = 3;
