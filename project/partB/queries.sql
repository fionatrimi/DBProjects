
/* Αριθμός ταινιών ανά είδος(genres) */
SELECT
y.x->'name' "name",COUNT(id)
FROM "Movies".movies_metadata2,
LATERAL (SELECT jsonb_array_elements(genres::jsonb)x)y
GROUP BY y.x

/* Αριθμός από ratings ανά χρήστη */
select userid, count(userid)
from "Movies".ratings_small
group by userid;


/*Μέση βαθμολογία (rating) ανά είδος (ταινίας)*/
SELECT
y.x->'name' "name", round(avg(rating::numeric), 2)
from "Movies".movies_metadata2 as mm2
INNER JOIN "Movies".ratings_small as r ON r.movieid = mm2.id,
LATERAL (SELECT jsonb_array_elements(genres::jsonb)x)y
GROUP BY y.x

/* Μέση βαθμολογία (rating) ανά χρήστη */
select userid, 
round(avg(rating::numeric), 2) as avg_rating_per_user
from "Movies".ratings_small
group by userid

/*Αριθμός από ratings ανά χρήστη*/
SELECT userid, COUNT(rating) AS count_ratings_per_user
FROM "Movies".ratings_small
GROUP BY userid

