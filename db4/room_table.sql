CREATE TABLE temp_room AS
(
    SELECT
    id, accommodates, bathrooms,
    bedrooms, beds, bed_type,
    amenities, square_feet,
    price, weekly_price, 
    monthly_price, security_deposit
    FROM temp_listings
);

ALTER TABLE temp_room
ADD FOREIGN KEY (id) REFERENCES temp_listings(id);

ALTER TABLE temp_listings
DROP accommodates,
DROP bathrooms,
DROP bedrooms,
DROP beds,
DROP bed_type,
DROP amenities,
DROP square_feet,
DROP price,
DROP weekly_price, 
DROP monthly_price,
DROP security_deposit;
