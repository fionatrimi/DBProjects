/* 1.	Εμφανιζει τα neighbourhoods και τα δωματια 
	που υπαρχουν σε αυτα.
	Output: 11541 rows
*/
SELECT n.neighbourhood,l.id
	FROM "Neighbourhood" as n
	LEFT OUTER JOIN "Location" as loc on loc.neighbourhood_cleansed = n.neighbourhood
	INNER JOIN "Listing" as L ON l.id = loc.id


/* 2.	Εμφανιζει το listing(id,name,price) 
	με την χαμηλοτερη τιμη που εχει ως υπηρεσιες dishwasher και dryer
	Output: 1 rows
*/
with cte as (
	SELECT l.id , l.name ,p.price as price
		FROM "Listing" as l
		INNER JOIN "Price" as p ON p.id = l.id
		INNER JOIN "Room" as r on r.id = l.id
		INNER JOIN "Room_Amenities" AS ra ON ra.room_id = r.id
		INNER JOIN "Amenity" AS am ON am.amenity_id = ra.amenity_id
		WHERE am.amenity_name IN ('Dishwasher','Dryer')
		GROUP BY l.id,p.price
	HAVING COUNT(am.amenity_name)=2
)

SELECT cte.id,cte.name,cte.price
	FROM cte
	WHERE cte.price = (SELECT MIN(cte.price) FROM cte)


/* 3.	Εμφαφανίζει τις υπηρεσιες που διατιθενται σε παραπανω απο 100 δωματια
	Output: 26 rows
*/
SELECT COUNT(r_a.room_id), am.amenity_name
	FROM "Room_Amenities" r_a 
	INNER JOIN "Amenity" am ON r_a.amenity_id = am.amenity_id
	GROUP BY am.amenity_name
HAVING COUNT(r_a.room_id) >= 100


/* 4.	Εμφαφανίζει τα ID και τις 0_0_0_0 συντεταγμένες των δωματίων που διαθέτουν Netflix
	Output: 109 rows
*/
SELECT ListingID.id, geo.geometry_coordinates_0_0_0_0 FROM "Location" loc
INNER JOIN(
	SELECT li.id 
	FROM "Listing" AS li
	INNER JOIN
		(SELECT r_a.room_id
		FROM "Room_Amenities" r_a
		INNER JOIN "Amenity" am
		ON r_a.amenity_id=am.amenity_id AND am.amenity_name= 'Netflix') AS RoomID
	ON RoomID.room_id = li.id) AS ListingID
ON loc.id = ListingID.id
INNER JOIN "Neighbourhood" AS neig
ON neig.neighbourhood = loc.neighbourhood_cleansed
LEFT OUTER JOIN "Geolocation" AS geo
ON geo.properties_neighbourhood=neig.neighbourhood


/* 5.	Εμφανίζει τα ονόματα των host που διαθέτουν 
	δωματια με 3 κρεβάτια, 
	3 άτομα 
	και απαντάνε εντώς μιας ώρας.
	Output: 37 rows
*/
SELECT h.name,h.id,COUNT(h.id)
	FROM "Host" as h
	INNER JOIN "Listing" as l ON l.host_id = h.id
	INNER JOIN "Room" as r ON r.id = l.id 
	INNER JOIN "Room_Amenities" as ra ON ra.room_id = r.id
	WHERE r.beds=3 AND r.accommodates=3 AND h.response_time = 'within an hour'
GROUP BY h.name,h.id
