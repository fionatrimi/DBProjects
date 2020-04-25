/*1. TOP 50 Δωματια με τις περισσοτερες κριτικες που ειναι διαθεσιμα για το IOYNIO 2020
50 rows affected
*/
SELECT DISTINCT LS.listing_url ,LS.name,LS.number_of_reviews
FROM "Listings" as LS
INNER JOIN "Calendar" AS CL 
ON CL.listing_id = LS.id
WHERE available='t' and date BETWEEN '2020-06-01' AND '2020-06-30'
ORDER BY LS.number_of_reviews desc
LIMIT 50;


/*2. Περιοχή με τα λιγοτερα σπιτια
1 rows affected
*/
WITH cte_min_neighbourhood as(
    SELECT COUNT(L.id) as number_of_houses,L.neighbourhood_cleansed as neighbourhood
    FROM "Listings" as L
    GROUP BY L.neighbourhood_cleansed
)
SELECT number_of_houses,neighbourhood
FROM cte_min_neighbourhood
WHERE number_of_houses = (SELECT MIN(number_of_houses) FROM cte_min_neighbourhood);


/*3. Περιοχες που εχουν διαθεσιμα σπιτια με 6 υπνοδωματια
12 rows affected
*/
SELECT DISTINCT N.neighbourhood
FROM "Neighbourhoods" AS N
INNER JOIN "Listings" AS LS ON N.neighbourhood=LS.neighbourhood_cleansed
INNER JOIN "Calendar" AS CL ON CL.listing_id = LS.id
WHERE CL.available='t' AND bedrooms = 6;


/*4. Εμφάνισε σχόλια (ποιος τα έκανε και το αντίστοιχο κατάλυμα)
που έγιναν στις 30 Μαιου 2019, για σπίτια που έχουν τηλεόραση, με 2 υπνοδωμάτια
138 rows affected
*/
SELECT R.listing_id,R.reviewer_name, R.comments, L.amenities
FROM "Reviews" R
INNER JOIN "Listings" L
ON L.id = R.listing_id
WHERE L.amenities LIKE '%TV%' 
	and L.bedrooms=2
	and R.date ='2019-05-30';


/*ΜΕ ΑΥΤΗ ΤΗΝ ΕΝΤΟΛΗ ΑΝΤΙΚΑΘΙΣΤΑΣ ΤΑ ‘,’ ΚΑΙ ΚΑΝΕΙΣ ΤΟ VALUE ΝΑ
 ΕΙΝΑΙ ΑΡΙΘΜΟΣ ΓΙΑ ΝΑ ΜΠΟΡΕΙΣ ΝΑ ΧΡΗΣΙΜΟΠΟΙΗΣΕΙΣ ΤΟ AVG
*/
--SUBSTRING(REPLACE(price,',',''),2)::numeric


/*5. Εμφάνισε το συνολικό ποσό που απαιτείται
 για την διαμονή στο κατάλυμα με σύνδεσμο https://www.airbnb.com/rooms/41681001 για τις 
 διαθέσιμες ημερομηνίες μεταξύ 29 και 31 Ιουλίου 2020
1 rows affected
*/
SELECT SUM(SUBSTRING(REPLACE(C.price,',',''),2)::numeric)
FROM "Calendar" C
INNER JOIN "Listings" L
ON L.id=C.listing_id
WHERE L.listing_url='https://www.airbnb.com/rooms/41681001'
AND C.available='t' 
AND C.date BETWEEN '2020-07-29' AND '2020-07-31';


/*6. Βρες τους κρητες που αξιολογησαν πανω απο 2 δωματια στην περιοχη ‘Αγιος Νικολαος’
69 rows affected -- ΠΡΟΣΟΧΗ -->
    -->ΟΤΑΝ ΤΡΕΧΟΥΜΕ ΤΟ QUERY ΑΥΤΟ ΣΕ ΞΕΧΩΡΙΣΤΟ ΑΡΧΕΙΟ, ΜΟΝΟ ΤΟΥ, ΤΟ ΑΠΟΤΕΛΕΣΜΑ ΕΙΝΑΙ 69 ΠΛΕΙΑΔΕΣ (ΑΥΤΟ ΙΣΧΥΕΙ ΚΑΙ ΓΙΑ ΤΟ PGADMIN4)
	-->ΑΝ ΟΜΩΣ ΤΡΕΞΟΥΜΕ ΟΛΟ ΤΟ ΑΡΧΕΙΟ ΜΕ ΟΛΑ ΤΑ QUERIES ΤΟ ΑΠΟΤΕΛΕΣΜΑ ΕΙΝΑΙ 0 ΠΛΕΙΑΔΕΣ
	   ΤΟ ΑΠΟΤΕΛΕΣΜΑ ΑΥΤΟ ΠΙΣΤΕΥΟΥΜΕ ΠΩΣ ΟΦΕΙΛΕΤΑΙ ΣΤΟ ENCONDING
	   (ΣΧΕΤΙΚΑ ΜΕ ΤΗΝ ΛΕΞΗ 'ΑΓΙΟΣ ΝΙΚΟΛΑΟΣ' ΑΚΟΜΗ ΚΑΙ ΑΝ ΕΧΟΥΜΕ ΚΑΝΕΙ SET CLIENT_ENCONDING TO 'UTF8';)
*/
SELECT COUNT(R.listing_id) as number_of_reviews_reviewers, R.reviewer_name
FROM "Reviews" as R
INNER JOIN "Listings" as L 
ON R.listing_id = L.id
WHERE L.neighbourhood_cleansed='ΑΓΙΟΣ ΝΙΚΟΛΑΟΣ'
GROUP BY R.reviewer_name
HAVING COUNT(R.listing_id)>2;


/*7.Εμφανισε ολους τους χοστς και τα σπιτια τους που εχουν νοικιαστει(αν υπαρχουν)
11316 rows affected 
*/
SELECT DISTINCT L.host_id, L.host_name, C.listing_id
FROM "Listings" as L
LEFT OUTER JOIN "Calendar" as C ON L.id = C.listing_id and C.available = 'f'
GROUP BY C.listing_id, L.host_id, L.host_name, L.id;


/*8.Μέσος όρος τιμών στην περιοχή ‘Πλάκα’
1 rows affected
*/
SELECT AVG(SUBSTRING(REPLACE(L.price,',',''),2)::numeric)
FROM "Listings" L
WHERE L.neighbourhood='Plaka';


/*9. Εμφάνισε το ακριβότερο σπίτι που είναι διαθέσιμο στις 25 Δεκ 2020
1 rows affected
*/
SELECT L.id,L.listing_url, L.price
FROM "Listings" L
INNER JOIN "Calendar" C
ON L.id=C.listing_id
WHERE 
	C.date='2020-12-25' 
	AND C.available='t'
	AND L.price=(
		SELECT MAX(price)
		FROM "Listings");


/*10. Τσεκαρει αν δεν υπαρχει καποιο neighbourhood του πινακα neighbourhooods στον πινακα geolocation και την εμφανιζει
0 rows affected
*/ 
SELECT N.neighbourhood,GL.properties_neighbourhood
FROM "Neighbourhoods" as N
LEFT OUTER JOIN "Geolocation" as GL 
ON N.neighbourhood = GL.properties_neighbourhood
WHERE GL.properties_neighbourhood IS NULL;


/* 11. Εμφανιζει τα δωματια που εχουν Wifi και τις κριτικες τους
(το limit υπάρχει για το πρακτικό λόγο ότι το αποτέλεσμα είναι πολύ μεγάλο και θέλουμε να το περιορίσουμε)
*/
SELECT L.id, L.listing_url, L.description, L.amenities,R.comments
FROM "Listings" as L
INNER JOIN "Reviews" as R 
ON R.listing_id = L.id
WHERE L.amenities LIKE '%Wifi%'
LIMIT 1000;


/*12. Εμφανίζει τις 2 πρώτες συντεταγμένες (0_0_0_0, 0_0_0_1) και σε ποια περιοχή αντιστοιχούν για δωμάτια ξενοδοχείου
230 rows affected
*/
SELECT G.geometry_coordinates_0_0_0_0, 
	   G.geometry_coordinates_0_0_0_1, 
	   L.neighbourhood_cleansed,
	   L.listing_url
FROM "Listings" L
INNER JOIN "Geolocation" G
ON L.neighbourhood_cleansed = G.properties_neighbourhood
WHERE L.room_type = 'Hotel room';