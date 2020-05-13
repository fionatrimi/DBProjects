Εμφανιζει για καθε room τα amenities του

SELECT r.id,am.amenity_name
FROM "Room" as r
INNER JOIN "Room_Amenities" as ra ON ra.room_id = r.id
INNER JOIN "Amenity" as am ON am.amenity_id = ra.amenity_id
ORDER BY(r.id)


Select l.id , l.name
FROM "Listings" as l
INNER JOIN "Price" as p ON p.id = l.id
INNER JOIN "Room" as r on r.id = l.id
INNER JOIN "Room_Amenities" AS ra ON ra.room_id = r.id
INNER JOIN "Amenity" AS am ON am.amenity_id = ra.amenity_id
WHERE am.amenity_name IN ('Dishwasher','Dryer')
GROUP BY l.id
HAVING COUNT(am.amenity_name)=2


--Υπηρεσιες που διατιθενται σε παραπανω απο 100 δωματια
SELECT COUNT(r_a.room_id), am.amenity_name
FROM
("Room_Amenities" r_a INNER JOIN "Amenity" am ON r_a.amenity_id = am.amenity_id)
GROUP BY am.amenity_name
HAVING COUNT(r_a.room_id) > 100
