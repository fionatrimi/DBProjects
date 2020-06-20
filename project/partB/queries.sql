
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

/* Μέση βαθμολογία (rating) ανά χρήστη */
select userid, 
round(avg(rating::numeric), 2) as avg_rating_per_user
from "Movies".ratings_small
group by userid
