WITH joined_table AS
(
 SELECT act.activity_type, act.time_spent,age.age_bucket
 FROM activities AS act
 INNER JOIN age_breakdown AS age
 ON act.user_id = age.user_id
 WHERE act.activity_type IN ('send','open')
 ),

Snapchat_open_send AS
(
 SELECT age_bucket,
        SUM(CASE WHEN activity_type = 'open' 
            THEN time_spent ELSE 0 END) AS time_spent_open,
        SUM(CASE WHEN activity_type = 'send' 
            THEN time_spent ELSE 0 END) AS time_spent_send
FROM joined_table
GROUP BY age_bucket
)

SELECT Snapchat.age_bucket,
       ROUND((time_spent_send*100.0)/(time_spent_open + time_spent_send),2) AS send_perc,
       ROUND((time_spent_open*100.0)/(time_spent_open + time_spent_send),2) AS open_perc
FROM Snapchat_open_send AS Snapchat;