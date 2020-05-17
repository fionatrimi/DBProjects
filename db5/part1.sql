UPDATE "Room"
SET
amenities = REPLACE(amenities,'{','');

UPDATE "Room"
SET
amenities = REPLACE(amenities,'}','');


CREATE TABLE "Amenity" AS
(	SELECT DISTINCT unnest(string_to_array(amenities,',')) as amenity_name
	FROM "Room"
);
                         
                        
UPDATE "Amenity"
SET
amenity_name = REPLACE (amenity_name,'"','');
			       
ALTER TABLE "Amenity"
ADD COLUMN amenity_id SERIAL PRIMARY KEY;			       
												 
                  
CREATE TABLE "Room_Amenities"(
	room_id int,
	amenity_id int,
	PRIMARY KEY (room_id,amenity_id)
);
			       			       

WITH cte_room_amenities(room_id,amenity_name) as(
    SELECT id as room_id, unnest(string_to_array(amenities,',')) as amenity_name 
	from "Room" as r
)
INSERT INTO "Room_Amenities"
SELECT DISTINCT room_id , "Amenity".amenity_id
	FROM cte_room_amenities,"Amenity"
	WHERE cte_room_amenities.amenity_name = "Amenity".amenity_name;
				 
ALTER TABLE "Room"
ADD PRIMARY KEY (id);				 

ALTER TABLE "Room_Amenities"
ADD FOREIGN KEY (room_id) REFERENCES "Room"(id);	
			       

ALTER TABLE "Room_Amenities"
ADD FOREIGN KEY (amenity_id) REFERENCES "Amenity"(amenity_id)	;		
				 
---drop column---
