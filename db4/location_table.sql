CREATE TABLE temp_location AS
(
    SELECT id, street,
    neighbourhood, neighbourhood_cleansed, city, state,
    zipcode, market, smart_location, 
    country_code, country, latitude,
    longitude,
    is_location_exact
    FROM temp_listings
);

ALTER TABLE temp_listings
DROP COLUMN street,
DROP COLUMN neighbourhood,
DROP COLUMN neighbourhood_cleansed,
DROP COLUMN city,
DROP COLUMN state,
DROP COLUMN zipcode,
DROP COLUMN market,
DROP COLUMN mart_location, 
DROP COLUMN country_code,
DROP COLUMN country,
DROP COLUMN latitude,
DROP COLUMN longitude,
DROP COLUMN is_location_exact;

ALTER TABLE temp_location
ADD FOREIGN KEY (id) REFERENCES temp_listings(id);

ALTER TABLE temp_listings DROP foreign KEY neighbourhood_cleansed;