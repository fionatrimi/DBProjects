/* Query (Prwto QUERY ekfwnishs): 
  explain analyze SELECT "Host".id, COUNT(*) FROM "Listing", "Host" WHERE "Host".id="Listing".host_id GROUP BY "Host".id;  */
create index IX_hosts_id on "Listing" (host_id);
--drop index ix_hosts_id;
 
 /* Query (Deftero QUERY ekfwnishs):
    explain analyze SELECT L.id, price FROM "Listing" L, "Price" P WHERE guests_included > 5 AND price > 40; */
create index IX_prices_guests on "Price" (id, price, guests_included);
--drop index IX_prices_guests;


---------QUERIES APO THN 5h ERGASIA------------------
/*Query 1 */
--Den iparxoyn indexes poy thn epitaxinoun
--Dokimasame kapoia (deite plans.txt gia perissoteres leptomereies)

/*Query 2 */
CREATE INDEX IX_price ON "Price" (price);
CREATE INDEX IX_room_amenities_amenity_id ON "Room_Amenities" (amenity_id);
--drop index IX_price;
--drop index IX_room_amenities_amenity_id;

/*Query 3 */
--Den iparxoyn indexes poy thn epitaxinoun
--Dokimasame kapoia (deite plans.txt gia perissoteres leptomereies)

/* Query 4 */
CREATE INDEX IX_room_amenities_amenity_id ON "Room_Amenities" (amenity_id);
--drop index IX_room_amenities_amenity_id;

/* Query 5 */
CREATE INDEX IX_room_beds_accommodates ON "Room"(beds,accommodates);
--drop index IX_room_beds_accommodates;
