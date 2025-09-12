USE MarketingAnalytics;

SELECT
	COUNT(*)
FROM customer_reviews;

-- Query to clean whitespace issues in the ReviewText column
SELECT
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	-- Cleans up the ReviewText by replacing double spaces with single spaces to ensure the text is more readable and standardize
	REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(ReviewText)), '    ', ' '), '   ', ' '), '  ', ' ') AS ReviewText
-- INTO customer_reviews_clean
FROM customer_reviews;