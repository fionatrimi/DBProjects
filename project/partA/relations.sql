ALTER TABLE "Movies".Movies_Metadata
ADD PRIMARY KEY (id);

ALTER TABLE "Movies".Credits
ADD PRIMARY KEY (id);

ALTER TABLE "Movies".Ratings_Small
ADD FOREIGN KEY (movieid) REFERENCES "Movies".Movies_Metadata(id);

ALTER TABLE "Movies".Links
ADD FOREIGN KEY (tmdbid) REFERENCES "Movies".Movies_Metadata(id);

ALTER TABLE "Movies".Credits
ADD FOREIGN KEY (id) REFERENCES "Movies".Movies_Metadata(id);

ALTER TABLE "Movies".Keywords
ADD PRIMARY KEY (id);

ALTER TABLE "Movies".Keywords
ADD FOREIGN KEY (id) REFERENCES "Movies".Movies_Metadata(id);
