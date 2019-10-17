-- Get all actors that have been in the same films as the most popular actor
-- OPTION: Try to get it all in one go, or do this in steps (see HINTS on the repo)

WITH films_with_actor107 AS (
	WITH most_popular_actor AS (
		SELECT 
		fa.actor_id,
		COUNT(f.film_id) AS films_appeared
		FROM film f
		INNER JOIN film_actor fa ON f.film_id=fa.film_id 
		GROUP BY fa.actor_id
		ORDER BY films_appeared DESC 
		LIMIT 1
	)
	SELECT 
	f.film_id
	FROM film f
	INNER JOIN film_actor fa ON f.film_id=fa.film_id
	WHERE fa.actor_id = (
		SELECT 
		actor_id
		FROM most_popular_actor
	)
)

SELECT 
DISTINCT fa.actor_id,
a.first_name,
a.last_name
FROM film f
INNER JOIN film_actor fa ON f.film_id=fa.film_id
INNER JOIN actor a ON fa.actor_id=a.actor_id
WHERE f.film_id IN (
	SELECT 
	* 
	FROM 
	films_with_actor107
)
AND fa.actor_id != 107
ORDER BY actor_id ASC