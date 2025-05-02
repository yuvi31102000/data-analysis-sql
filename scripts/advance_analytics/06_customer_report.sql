/* ---------------------------------------------------------------------------------------
Customer Report:

Purpose:
This report consolidates key customer metrics and behaviors for analysis, categorizing customers 
based on their purchase history and segmenting them by age and spending patterns.

Highlights:
1. Segments customers into categories such as VIP, Regular, and New.
2. Aggregates customer-level metrics including total orders, total sales, and total quantity purchased.
3. Calculates key performance indicators (KPIs) such as recency, average order value, and average monthly spend.
-------------------------------------------------------------------------------------------*/

-- Create or alter the customer report view
CREATE OR ALTER VIEW gold.report_customers AS

-- Base query retrieves essential fields from the fact_sales and dim_customer tables
WITH base_query AS
(
	SELECT 
		s.order_number,
		s.product_key,
		s.order_date,
		s.sales_amount,
		s.qunatity,
		c.customer_key,
		c.customer_number,
		CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
		DATEDIFF(YEAR, c.birth_date, GETDATE()) AS customer_age
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_customer c ON s.customer_key = c.customer_key
	WHERE order_date IS NOT NULL
),

-- Aggregates customer-level metrics such as total orders, total sales, and customer lifespan
customer_aggregations AS
(
	SELECT 
		customer_key,
		customer_number,
		customer_name,
		customer_age,
		COUNT(DISTINCT order_number) AS total_orders,
		SUM(sales_amount) AS total_sales,
		SUM(qunatity) AS total_qunatity,
		COUNT(DISTINCT product_key) AS total_products,
		MAX(order_date) AS last_order_date,
		DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS customer_lifespan
	FROM base_query
	GROUP BY customer_key, customer_number, customer_name, customer_age
)

-- Selects the final report data with calculated segments and KPIs
SELECT 
  customer_key,
	customer_number,
	customer_name,
	customer_age,
	CASE 
		WHEN customer_age < 20 THEN 'Under 20'
		WHEN customer_age BETWEEN 20 AND 29 THEN '20-29'
		WHEN customer_age BETWEEN 30 AND 39 THEN '30-39'
		WHEN customer_age BETWEEN 40 AND 49 THEN '40-49'
	    ELSE '50 and above'
	END AS age_group,
	CASE 
		WHEN customer_lifespan >= 12 AND total_sales > 5000 THEN 'VIP'
		WHEN customer_lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segments,
	total_orders,
    total_sales,
    total_qunatity,
    total_products,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) as recency,
	customer_lifespan,
	CASE 
		WHEN total_orders = 0 THEN 0
	    ELSE total_sales / total_orders 
	END AS avg_order_value,
	CASE 
		WHEN customer_lifespan = 0 THEN total_sales
		ELSE total_sales / customer_lifespan 
	END AS avg_monthly_spend
FROM customer_aggregations;
