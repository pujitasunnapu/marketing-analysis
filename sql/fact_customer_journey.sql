USE MarketingAnalytics;

SELECT
	*
FROM dbo.customer_journey;


-- Common Table Expression (CTE) to identify and tag duplicate records
WITH DuplicateRecords AS(
	SELECT
		JourneyID,
		CustomerID,
		ProductID,
		VisitDate,
		Stage,
		Action,
		Duration,
		ROW_NUMBER() OVER(
			-- PARTITION BY groups the rows based on the specified columns that should be unique
			PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
			-- ORDER BY defines how to order the rows within each partition (usually by a unique identifier like JourneyID)
			ORDER BY JourneyID
		) AS row_num -- This creates a new column 'row_num' that numbers each row within its partition
	FROM
		dbo.customer_journey
)


-- SELECT all records from the CTE where row_num > 1 indicating duplicate entries
SELECT
	*
FROM DuplicateRecords
WHERE row_num > 1 -- Filters out the first occurrence (row_num = 1) and only shows the duplicates (row_num > 1)
ORDER BY JourneyID;


-- Outer query selects the final cleaned and standardized data
SELECT
	JourneyID,
	CustomerID,
	ProductID,
	VisitDate,
	Stage,
	Action,
	COALESCE(Duration, avg_duration) AS Duration -- Replaces missing durations with the average duration for the corresponding date
FROM
	(
		-- Subquery to process and clean the data
		SELECT
			JourneyID,
			CustomerID,
			ProductID,
			VisitDate,
			UPPER(Stage) AS Stage,
			Action,
			Duration,
			ROUND(AVG(Duration) OVER(PARTITION BY VisitDate), 2) AS avg_duration,
			ROW_NUMBER() OVER
			(
				PARTITION BY CustomerID, ProductID, VisitDate, Stage, Action
				ORDER BY JourneyID
			) AS row_num
		FROM
			customer_journey
	) AS subquery -- Names the subquery for reference in the outer query
WHERE
	row_num = 1 -- Keeps the subquery for reference in the outer query
ORDER BY
	JourneyID;