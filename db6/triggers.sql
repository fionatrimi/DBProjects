--TRIGGER EKFWNHSHS

CREATE OR REPLACE FUNCTION set_host_listings()
RETURNS TRIGGER AS $emp$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE "Host"
		SET host_listings_count=host_listings_count+1
		WHERE NEW.host_id = "Host".id;
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		UPDATE "Host"
		SET host_listings_count=host_listings_count-1
		WHERE OLD.host_id = "Host".id;
		RETURN OLD;
	END IF;
	--return null;
END;
$emp$
LANGUAGE plpgsql

CREATE TRIGGER setter_host_listings AFTER INSERT OR DELETE
ON "Listing"
FOR EACH ROW
EXECUTE PROCEDURE set_host_listings();

--DIKO MAS TRIGGER, UPDATES NUMBER OF REVIEWS OF A LISTING

CREATE OR REPLACE FUNCTION update_number_of_reviews()
RETURNS TRIGGER AS $emp2$
BEGIN
	IF TG_OP = 'INSERT' THEN
		UPDATE "Listing"
		SET number_of_reviews = number_of_reviews + 1
		WHERE NEW.listing_id = "Listing".id; 
		RETURN NEW;
	ELSIF TG_OP = 'DELETE' THEN
		UPDATE "Listing"
		SET number_of_reviews = number_of_reviews - 1
		WHERE OLD.listing_id = "Listing".id;
		RETURN OLD;
	END IF;
	--return null;
END;
$emp2$
LANGUAGE plpgsql;

CREATE TRIGGER insert_delete_reviews_trigger AFTER INSERT OR DELETE
ON "Review"
FOR EACH ROW
EXECUTE PROCEDURE update_number_of_reviews();

