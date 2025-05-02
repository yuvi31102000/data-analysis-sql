-- ============================================================================
-- Time Series Analysis: Monthly Sales and Customer Trends
-- ============================================================================

-- This query analyzes how key business metrics evolve over time (monthly):
--   - Total Sales Revenue
--   - Number of Unique Customers
--   - Total Quantity of Items Sold
-- 
-- Grouping by Year and Month of the order date allows tracking seasonal patterns,
-- identifying growth or decline trends, and evaluating business performance over time.
-- 
-- Useful for: 
--   - Detecting seasonality in sales
--   - Monitoring customer acquisition over time
--   - Planning inventory and marketing campaigns

SELECT 
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS customer_count,
    SUM(qunatity) AS total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date);
