-- ============================================================================
-- Part-to-Whole Analysis
-- ============================================================================

-- This query performs a part-to-whole analysis to determine how much each product category contributes to the overall sales.
-- It calculates the total sales for each category, and then finds the percentage of overall sales that each category contributes.
-- The purpose is to identify which categories are the largest contributors to sales, which can inform business decisions about
-- resource allocation, product strategy, and marketing efforts.

-- Purpose:
--   - To evaluate the relative importance of different categories in driving total sales.
--   - To help identify high-performing categories and underperforming categories.
--   - Useful for targeted marketing, inventory planning, and identifying growth opportunities.

WITH category_sales AS
(
	SELECT 
		p.category,  -- The category of the product
		SUM(s.sales_amount) AS total_sales  -- Total sales for each category
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_product p ON s.product_key = p.product_key  -- Joining sales data with product category
	GROUP BY p.category  -- Grouping by product category to calculate total sales per category
)
SELECT 
	category,  -- Category name
	total_sales,  -- Total sales amount for the category
	SUM(total_sales) OVER() AS overall_sales,  -- Overall sales (sum of all categories' sales)
	CONCAT(ROUND(CAST(total_sales AS FLOAT)/ SUM(total_sales) OVER() * 100, 2), '%') AS sales_percentage  -- Percentage of overall sales contributed by each category
FROM category_sales
ORDER BY sales_percentage DESC;  -- Sorting by sales percentage to show the largest contributors first
