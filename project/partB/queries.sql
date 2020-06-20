/* Αριθμός από ratings ανά χρήστη */
select userid, count(userid)
from "Movies".ratings_small
group by userid;

/*Αριθμός ταινιών ανά είδος(genres)*/
SELECT
y.x->'name' "name",COUNT(id)
FROM "Movies".movies_metadata2,
LATERAL (SELECT jsonb_array_elements(genres::jsonb)x)y
GROUP BY y.x
