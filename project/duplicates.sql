INSERT INTO "Movies".Credits2(id)
SELECT DISTINCT id
	FROM "Movies".Credits

UPDATE "Movies".Credits2 as c2
SET
casting = c.casting,
crew = c.crew
FROM "Movies".Credits as c
WHERE c2.id = c.id



INSERT INTO "Movies".Keywords2(id)
SELECT DISTINCT id
	FROM "Movies".Keywords

