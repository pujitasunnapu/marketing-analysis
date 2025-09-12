USE MarketingAnalytics;

SELECT
	*
FROM dbo.customers;

SELECT
	*
FROM dbo.geography;

-- Query to join customers data with geography data to enrich customer data with geographical information.
SELECT
	c.CustomerID,
	c.CustomerName,
	c.Email,
	c.Gender,
	c.Age,
	g.Country,
	g.City
FROM
	dbo.customers c
LEFT JOIN
	dbo.geography g
ON
	c.GeographyID = g.GeographyID;