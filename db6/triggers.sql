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
LANGUAGE plpgsql;

CREATE TRIGGER setter_host_listings AFTER INSERT OR DELETE
ON "Listing_6"
FOR EACH ROW
EXECUTE PROCEDURE set_host_listings();

------------------------------2nd WAY----------------------------------------------
CREATE FUNCTION incr_host_listings()
RETURNS TRIGGER AS
'BEGIN
		UPDATE "Host_6b"
		SET host_listings_count=host_listings_count+1
		WHERE id=NEW.id;
		RETURN NEW;
END;'
LANGUAGE plpgsql;

CREATE TRIGGER incr_count AFTER INSERT
ON "Listing_6b"
FOR EACH ROW
EXECUTE PROCEDURE incr_host_listings();


CREATE FUNCTION decr_host_listings()
RETURNS TRIGGER AS
'BEGIN
		UPDATE "Host_6b"
		SET host_listings_count=host_listings_count-1
		WHERE id=OLD.id;
		RETURN OLD;
END;'
LANGUAGE plpgsql;

CREATE TRIGGER decr_count AFTER DELETE
ON "Listing_6b"
FOR EACH ROW
EXECUTE PROCEDURE decr_host_listings();
