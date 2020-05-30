/* Query: 
  explain analyze SELECT "Host".id, COUNT(*) FROM "Listing", "Host" WHERE "Host".id="Listing".host_id GROUP BY "Host".id;  */
create index IX_hosts_id on "Listing" (host_id);
 
 /* Query:
    explain analyze SELECT L.id, price FROM "Listing" L, "Price" P WHERE guests_included > 5 AND price > 40; */
create index IX_prices_guests on "Price" (id, price, guests_included);

/* Query 4 */
CREATE INDEX IX_room_amenities_amenity_od ON "Room_Amenities" (amenity_id);

/* Query 5 */
CREATE INDEX IX_room_beds_accommodates ON "Room"(beds,accommodates);
