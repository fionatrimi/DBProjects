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
	amenity_id int,
	PRIMARY KEY (room_id,amenity_id)
);

ALTER TABLE "Room_Amenities_Temp"
ADD FOREIGN KEY (room_id) REFERENCES"Room"(id);	
			       

ALTER TABLE "Room_Amenities_Temp"
ADD FOREIGN KEY (amenity_id) REFERENCES tempAmenity(amenity_id)	;		       

WITH cte_room_amenities(room_id,amenity_name) as(
    SELECT id as room_id, unnest(string_to_array(amenities,',')) as amenity_name 
	from "Room" as r
)
INSERT INTO "Room_Amenities_Temp"
SELECT DISTINCT room_id , tempAmenity.amenity_id
	FROM cte_room_amenities,tempAmenity
	WHERE cte_room_amenities.amenity_name = tempAmenity.amenity_name;
