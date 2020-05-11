UPDATE "Room"
SET
amenities = REPLACE(amenities,'{','');

UPDATE "Room"
SET
amenities = REPLACE(amenities,'}','');


CREATE TABLE tempAmenity AS
(	SELECT DISTINCT unnest(string_to_array(amenities,',')) as amenity_name
	FROM "Room"
);
                         
                        
UPDATE tempAmenity
SET
amenity_name = REPLACE (amenity_name,'"','');
			       
ALTER TABLE tempAmenity
ADD COLUMN amenity_id SERIAL PRIMARY KEY;			       
												 
                  
CREATE TABLE "Room_Amenities_Temp"(
	room_id int,
	amenity_id int
);

WITH cte_room_amenities(room_id,amenity_name) as(
    SELECT id as room_id, unnest(string_to_array(amenities,',')) as amenity_name 
	from "Room" as r
)
INSERT INTO "Room_Amenities_Temp"
SELECT room_id , tempAmenity2.amenity_id
	FROM cte_room_amenities,tempAmenity2
	WHERE cte_room_amenities.amenity_name = tempAmenity2.amenity_name;
