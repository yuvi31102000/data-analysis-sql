-- ============================================================================
-- Cumulative analysis
-- ============================================================================

-- This query performs a cumulative analysis of monthly sales trends and the moving average 
-- of the average sales price over time. The key components of the analysis are:
--   1. **Total Sales Per Month**: The sum of sales for each month.
--   2. **Running Total of Sales**: The cumulative sales from the beginning of the dataset up to the current month.
--   3. **Moving Average of Price**: The moving average of the average price per month, offering insights into pricing trends over time.

 
-- Useful for:
--   - Monitoring sales performance over a period.
--   - Understanding pricing trends and their impact on sales.
--   - Identifying periods of significant growth or decline.

SELECT 
	*,
	SUM(total_sales) OVER(ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total_sales, -- Cumulative sales up to current month
	AVG(avg_price) OVER(ORDER BY order_month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS moving_avg_price -- Moving average of price over time
FROM
(
	SELECT 
		DATETRUNC(MONTH, order_date) AS order_month,    -- Truncates the order date to the first of each month
		SUM(sales_amount) AS total_sales,               -- Total sales for the month
		AVG(price) AS avg_price                         -- Average price for the month
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(MONTH, order_date)            -- Group by the truncated month
) AS s;
