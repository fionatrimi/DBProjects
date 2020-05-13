Εμφανιζει για καθε room τα amenities του

SELECT r.id,am.amenity_name
FROM "Room" as r
INNER JOIN "Room_Amenities" as ra ON ra.room_id = r.id
INNER JOIN "Amenity" as am ON am.amenity_id = ra.amenity_id
ORDER BY(r.id)

-- Εμφανιζει το listing(id,name,price) με την χαμηλοτερη τιμη που εχει ως υπηρεσιες dishwasher και dryer --
with cte as (
	SELECT l.id , l.name ,p.price as price
			FROM "Listings" as l
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


--Υπηρεσιες που διατιθενται σε παραπανω απο 100 δωματια
SELECT COUNT(r_a.room_id), am.amenity_name
FROM
("Room_Amenities" r_a INNER JOIN "Amenity" am ON r_a.amenity_id = am.amenity_id)
GROUP BY am.amenity_name
HAVING COUNT(r_a.room_id) > 100
