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

UPDATE "Movies".Keywords2 as k2
SET
keywords = k.keywords
FROM "Movies".Keywords as k
WHERE k2.id = k.id
