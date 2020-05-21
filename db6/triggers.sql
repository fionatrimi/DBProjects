CREATE OR REPLACE FUNCTION set_host_listings()
RETURNS TRIGGER AS
'BEGIN
	IF TG_OP = ''INSERT'' THEN
		UPDATE "Host_6"
		SET host_listings_count=host_listings_count+1
		WHERE id=NEW.id;
		RETURN NEW;
	ELSIF TG_OP = ''DELETE'' THEN
		UPDATE "Host_6"
		SET host_listings_count=host_listings_count-1
		WHERE id=OLD.id;
		RETURN OLD;
	END IF;
	--return null;
END;'
LANGUAGE plpgsql;

CREATE TRIGGER setter_host_listings AFTER INSERT OR DELETE
ON "Listing_6"
FOR EACH ROW
EXECUTE PROCEDURE set_host_listings();
