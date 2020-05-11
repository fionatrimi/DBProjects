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
												 
                  
