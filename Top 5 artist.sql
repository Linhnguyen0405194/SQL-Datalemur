
WITH top_artists AS 
(
  SELECT artist_name, 
         COUNT(*) AS sum_top10
  FROM global_song_rank
  INNER JOIN songs AS s USING (song_id)
  INNER JOIN artists AS a USING (artist_id)
  WHERE rank <= 10
  GROUP BY artist_name
  ORDER BY sum_top10 DESC
),

final AS 
(
SELECT artist_name,
       DENSE_RANK() OVER (ORDER BY sum_top10 DESC) AS artist_rank
FROM top_artists
)
  
SELECT 
  artist_name,
  artist_rank
FROM final
WHERE artist_rank <= 5;