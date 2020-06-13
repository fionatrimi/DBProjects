ALTER TABLE "Movies".Movies_Metadata2
ADD PRIMARY KEY (id);

ALTER TABLE "Movies".Credits2
ADD PRIMARY KEY (id);

ALTER TABLE "Movies".Ratings_Small
ADD FOREIGN KEY (movieid) REFERENCES "Movies".Movies_Metadata2(id);

ALTER TABLE "Movies".Links2
ADD FOREIGN KEY (tmdbid) REFERENCES "Movies".Movies_Metadata2(id);

ALTER TABLE "Movies".Credits2
ADD FOREIGN KEY (id) REFERENCES "Movies".Movies_Metadata2(id);

ALTER TABLE "Movies".Keywords2
ADD PRIMARY KEY (id);

ALTER TABLE "Movies".Keywords2
ADD FOREIGN KEY (id) REFERENCES "Movies".Movies_Metadata2(id);
