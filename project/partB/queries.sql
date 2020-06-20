/* Αριθμός από ratings ανά χρήστη */
select userid, count(userid)
from "Movies".ratings_small
group by userid;
