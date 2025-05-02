-- ============================================================================
-- Performance Analysis
-- ============================================================================

-- This query analyzes the yearly performance of products by comparing their sales to:
--   1. The average sales performance of each product over time.
--   2. The sales performance of the previous year.

-- Useful for:
--   - Identifying products with sales growth or decline trends.
--   - Pinpointing products that have surpassed or fallen short of their historical sales performance.
--   - Gaining insights into the effectiveness of promotional strategies or seasonal variations.

WITH yearly_product_sales AS
(
	SELECT 
		YEAR(s.order_date) AS order_year,   -- Extracts the year from the order date
		p.product_name,                      -- Product name from the product dimension table
		SUM(s.sales_amount) AS current_total_sales  -- Total sales amount for the product in the given year
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_product p ON s.product_key = p.product_key  -- Joins product details to the sales data
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(s.order_date), p.product_name  -- Grouping by year and product name
)
SELECT 
	order_year,                                       -- Year of the sales
	product_name,                                     -- Product name
	current_total_sales,                              -- Sales for the product in the current year
	AVG(current_total_sales) OVER(PARTITION BY product_name) AS avg_sales,   -- Average sales of the product across all years
	current_total_sales - AVG(current_total_sales) OVER(PARTITION BY product_name) AS diff_avg,  -- Difference between current sales and average
	CASE 
		WHEN current_total_sales - AVG(current_total_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above avg'  -- If current sales are above the average
		WHEN current_total_sales - AVG(current_total_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below avg'  -- If current sales are below the average
		ELSE 'avg'  -- If current sales match the average
	END AS avg_change,
	LAG(current_total_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) AS previous_year_sales, -- Sales of the product in the previous year
	current_total_sales - LAG(current_total_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) AS sales_diff,  -- Difference between current and previous year's sales
	CASE 
		WHEN current_total_sales - LAG(current_total_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) > 0 THEN 'Increase'  -- If sales increased compared to the previous year
		WHEN current_total_sales - LAG(current_total_sales) OVER(PARTITION BY product_name ORDER BY order_year ASC) < 0 THEN 'Decrease'  -- If sales decreased compared to the previous year
		ELSE 'No change'  -- If sales remained the same compared to the previous year
	END AS sales_change
FROM yearly_product_sales
ORDER BY product_name, order_year;   -- Sorting the results by product and year
