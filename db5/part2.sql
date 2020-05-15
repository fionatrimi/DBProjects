--ΠΡΕΠΕΙ ΚΑΤΙ ΝΑ ΑΛΛΑΞΟΥΜΕ ΓΙΑ ΝΑ ΕΧΟΥΜΕ ΚΑΙ 2 OUTER JOIN, κατα τα αλλα τα εχουμε κανει ολα

--Εμφανιζει για καθε room τα amenities του
SELECT ra.room_id,am.amenity_name
	FROM "Room_Amenities" as ra 
	INNER JOIN "Amenity" as am ON am.amenity_id = ra.amenity_id
ORDER BY(ra.room_id)


-- Εμφανιζει το listing(id,name,price) με την χαμηλοτερη τιμη που εχει ως υπηρεσιες dishwasher και dryer --
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


--Εμφαφανίζει τις υπηρεσιες που διατιθενται σε παραπανω απο 100 δωματια
SELECT COUNT(r_a.room_id), am.amenity_name
FROM
("Room_Amenities" r_a INNER JOIN "Amenity" am ON r_a.amenity_id = am.amenity_id)
GROUP BY am.amenity_name
HAVING COUNT(r_a.room_id) > 100

--Εμφαφανίζει τα ID και τις 0_0_0_0 συντεταγμένες των δωματίων που διαθέτουν Netflix
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
INNER JOIN "Geolocation" AS geo
ON geo.properties_neighbourhood=neig.neighbourhood

--Εμφανίζει τα ονόματα των host που διαθέτουν δωματια με 3 κρεβάτια, 3 άτομα και απαντάνε εντώς μιας ώρας
SELECT h.name, h.id
FROM
	(SELECT li.host_id
	FROM 
		(SELECT id 
		 FROM "Room" ro
		 WHERE beds=3 AND accommodates=3) AS r
	INNER JOIN "Listing" AS li 
	ON li.id=r.id) AS host_ID
INNER JOIN "Host" AS h
ON h.id = host_ID.host_id
WHERE h.response_time='within an hour'

// αυτο ειναι το ιδιο με το παραπανω απλα χωρις subquery select. Νομιζω γενικα μπορουμε να τα αποφυγουμε δω τα subqueries//
SELECT h.name,h.id,COUNT(h.id)
	FROM "Host" as h
	INNER JOIN "Listings" as l ON l.host_id = h.id
	INNER JOIN "Room" as r ON r.id = l.id 
	INNER JOIN "Room_Amenities" as ra ON ra.room_id = r.id
	WHERE r.beds=3 AND r.accommodates=3 AND h.response_time = 'within an hour'
