create table Credits2(
   casting text,
   crew text,
   id int
);

INSERT INTO "Movies".Credits2(id)
SELECT DISTINCT id
	FROM "Movies".Credits

UPDATE "Movies".Credits2 as c2
SET
casting = c.casting,
crew = c.crew
FROM "Movies".Credits as c
WHERE c2.id = c.id

DROP TABLE "Movies".Credits;

ALTER TABLE "Movies".Credits2   
    RENAME TO Credits;    

create table "Movies".Keywords2(
   id int,
   keywords text
);

INSERT INTO "Movies".Keywords2(id)
SELECT DISTINCT id
	FROM "Movies".Keywords

UPDATE "Movies".Keywords2 as k2
SET
keywords = k.keywords
FROM "Movies".Keywords as k
WHERE k2.id = k.id

DROP TABLE "Movies".Keywords;

ALTER TABLE "Movies".Keywords2   
    RENAME TO Keywords;

create table "Movies".Movies_Metadata2(
   adult varchar(10),
   belongs_to_collection varchar(190),
   budget int,
   genres varchar(270),
   homepage varchar(250),
   id int,
   imdb_id varchar(10),
   original_language varchar(10),
   original_title varchar(110),
   overview varchar(1000),
   popularity varchar(10),
   poster_path varchar(40),
   production_companies varchar(1260),
   production_countries varchar(1040),
   release_date date,
   revenue int,
   runtime varchar(10),
   spoken_languages varchar(770),
   status varchar(20),
   tagline varchar(300),
   title varchar(110),
   video varchar(10),
   vote_average varchar(10),
   vote_count int
);

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


DROP TABLE "Movies".Movies_Metadata;

ALTER TABLE "Movies".Movies_Metadata2   
    RENAME TO Movies_Metadata;

create table "Movies".Links2(
   movieId int,
   imdbId int,
   tmdbId int
);

INSERT INTO "Movies".Links2(tmdbid)
SELECT DISTINCT tmdbid
	FROM "Movies".Links
	
UPDATE "Movies".Links2 as l2
SET
movieid = l.movieid,
imdbid = l.imdbid
FROM "Movies".Links as l
WHERE l2.tmdbid = l.tmdbid

DROP TABLE "Movies".Links;

ALTER TABLE "Movies".Links2   
    RENAME TO Links;

DELETE FROM "Movies".Links WHERE tmdbid NOT IN(
SELECT id FROM "Movies".Movies_Metadata)

DELETE FROM "Movies".ratings_small WHERE movieid NOT IN(
SELECT id FROM "Movies".Movies_Metadata)
