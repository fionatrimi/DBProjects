UPDATE  "Calendar"
SET 
price = REPLACE(price,'$','');

UPDATE  "Calendar"
SET 
price = REPLACE(price,',','');

UPDATE  "Calendar"
SET 
adjusted_price = REPLACE(adjusted_price,'$','');

UPDATE  "Calendar"
SET 
adjusted_price = REPLACE(adjusted_price,',','');

ALTER TABLE "Calendar"
	ALTER COLUMN price TYPE decimal USING price::numeric;

ALTER TABLE "Calendar"
	ALTER COLUMN adjusted_price TYPE decimal USING adjusted_price::numeric;

ALTER TABLE "Calendar"
	ALTER COLUMN available TYPE boolean ;