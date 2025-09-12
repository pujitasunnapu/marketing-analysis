USE MarketingAnalytics;

SELECT
	*
FROM dbo.products;


-- Query to categorize products based on their price
SELECT
	ProductID, -- Selects the unique identifier for each products
	ProductName, -- Selects the name of each products
	Price, -- Selects the price of each product
	-- Category -- Selects the product category for each produts

	CASE
		WHEN Price < 50 THEN 'Low' 
		WHEN Price BETWEEN 50 AND 200 THEN 'Medium'
		ELSE 'High'
	END AS PriceCategory -- Names the new column as PriceCategory
FROM
	dbo.products;