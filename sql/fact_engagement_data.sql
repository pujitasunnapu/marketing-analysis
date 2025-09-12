USE MarketingAnalytics;

SELECT * FROM dbo.engagement_data;

-- Query to clean and normalize the engagemenr_data table
SELECT
	EngagementID,
	ContentID,
	CampaignID,
	ProductID,
	UPPER(REPLACE(ContentType, 'Socialmedia', 'Social Media')) AS ContentType, -- Replaces "Socialmedia" with "Social Media" and then converts all ContentType values to uppercase
	LEFT(ViewsClicksCombined, CHARINDEX('-', ViewsClicksCombined) - 1) AS Views, -- Extracts the Views part from the ViewsClicksCombined column by taking the substring before the '-' character
	RIGHT(ViewsClicksCombined, LEN(ViewsClicksCombined) - CHARINDEX('-', ViewsClicksCombined)) AS Clicks, -- Extracts the Clicks part from the ViewsClicksCombined column by taking the substring after the '-' character
	Likes,
	-- Converts the EngagementDate to the dd.mm.yyy format
	FORMAT(CONVERT(DATE, EngagementDate), 'dd.MM.yyy') AS EngagementDate
FROM
	engagement_data
WHERE
	ContentType ! = 'Newsletter'; -- Filter out rows where ContentType is 'Newsletter' as these are nor relevant for our analysis