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

INSERT INTO "Movies".Movies_Metadata2(id)
SELECT DISTINCT id
	FROM "Movies".Movies_Metadata


UPDATE "Movies".Movies_Metadata2 as md2
SET
adult  = md.adult ,
belongs_to_collection  = md.belongs_to_collection,
budget   = md.budget  ,
genres   = md.genres ,
homepage   = md.homepage  ,
imdb_id   = md.imdb_id ,
original_language   = md.original_language  ,
original_title   = md.original_title ,
overview   = md.overview  ,
popularity   = md.popularity ,
poster_path   = md.poster_path  ,
production_companies   = md.production_companies ,
production_countries    = md.production_countries  ,
release_date    = md.release_date   ,
revenue    = md.revenue  ,
runtime    = md.runtime  ,
spoken_languages    = md.spoken_languages   ,
status    = md.status  ,
tagline     = md.tagline   ,
title     = md.title    ,
video     = md.video   ,
vote_average      = md.vote_average     ,
vote_count      = md.vote_count    

FROM "Movies".Movies_Metadata as md
WHERE md2.id = md.id;


INSERT INTO "Movies".Links2(tmdbid)
SELECT DISTINCT tmdbid
	FROM "Movies".Links_backup
	
UPDATE "Movies".Links2 as l2
SET
movieid = l.movieid,
imdbid = l.imdbid
FROM "Movies".Links_backup as l
WHERE l2.tmdbid = l.tmdbid

DELETE FROM "Movies".Links2 WHERE tmdbid NOT IN(
SELECT id FROM "Movies".Movies_Metadata2)

DELETE FROM "Movies".ratings_small WHERE movieid NOT IN(
SELECT id FROM "Movies".Movies_Metadata2)
