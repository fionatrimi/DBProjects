SELECT COUNT(R.listing_id) as number_of_reviews_reviewers, R.reviewer_name
FROM "Reviews" as R
INNER JOIN "Listings" as L 
ON R.listing_id = L.id
WHERE L.neighbourhood_cleansed='ΑΓΙΟΣ ΝΙΚΟΛΑΟΣ'
GROUP BY R.reviewer_name
HAVING COUNT(R.listing_id)>2;