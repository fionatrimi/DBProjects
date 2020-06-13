ALTER TABLE "Movies".Movies_Metadata2
ADD PRIMARY KEY (id);

ALTER TABLE Ratings_Small
ADD FOREGN KEY (movieid) REFRENCES Movies_Metadata(id);

ALTER TABLE Links
ADD FOREGN KEY (tmdbid) REFRENCES Movies_Metadata(id);

ALTER TABLE Crew
ADD FOREGN KEY (movieid) REFRENCES Movies_Metadata(id);
