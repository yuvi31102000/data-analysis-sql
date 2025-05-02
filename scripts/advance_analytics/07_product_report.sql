/* ---------------------------------------------------------------------------------------
Product Report:

Purpose:
This report consolidates key product metrics and behaviors, providing insights into product performance, 
sales trends, and customer interaction with products over time.

Highlights:
1. Retrieves essential product details including product name, category, subcategory, and cost.
2. Segments products based on revenue to classify them as High-Performers, Mid-Range, or Low-Performers.
3. Aggregates product-level metrics such as:
   - Total orders
   - Total sales
   - Total quantity sold
   - Total customers engaged
   - Product lifespan (in months)
4. Calculates key performance indicators (KPIs):
   - Recency: The number of months since the last sale.
   - Average Order Revenue (AOR): Average revenue per order for each product.
   - Average Monthly Revenue: Average revenue per product per month over its lifespan.
-------------------------------------------------------------------------------------------*/

-- Create or alter the product report view
CREATE OR ALTER VIEW gold.report_products AS

-- Base query retrieves essential fields for each product and related sales information
WITH base_query AS
(
	SELECT
		s.order_number,
		s.product_key,
		s.customer_key,
		s.order_date,
		s.sales_amount,
		s.qunatity,
		p.product_number,
		p.product_name,
		p.category,
		p.subcategory,
		p.cost
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_product p ON s.product_key = p.product_key
	WHERE order_date IS NOT NULL
),

-- Aggregates product-level metrics such as total sales, quantity, and number of customers
product_aggregations AS
(
SELECT 
    product_key,
	product_number,
	product_name,
	category,
	subcategory,
	cost,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(qunatity) AS total_quantity,
	COUNT(DISTINCT customer_key) AS total_customers,
	MAX(order_date) AS last_sale_date,
	DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS product_lifespan,
	ROUND(AVG(CAST(sales_amount AS FLOAT)/ NULLIF(qunatity,0)), 2) AS avg_selling_price
FROM base_query
GROUP BY product_key, product_number, product_name, category, subcategory, cost
)

-- Selects and classifies products, calculating KPIs such as average order revenue and monthly revenue
SELECT 
	product_key,
	product_number,
	product_name,
	category,
	subcategory,
	cost,
	total_orders,
	total_sales,
	-- Classify products by sales performance
	CASE
		WHEN total_sales > 50000 THEN 'High Performer'
		WHEN total_sales >= 10000 THEN 'Mid Range'
		ELSE 'Low Performer'
	END AS product_segments,
	total_quantity,
	total_customers,
	last_sale_date,
	-- Calculate recency (months since last sale)
	DATEDIFF(MONTH, last_sale_date, GETDATE()) recency,
	product_lifespan,
	avg_selling_price,
	-- Calculate the average revenue per order
	CASE 
		WHEN total_orders = 0 THEN 0
		ELSe total_sales / total_orders
	END AS avg_order_revenue,
	-- Calculate the average monthly revenue
	CASE 
		WHEN product_lifespan = 0 THEN total_sales
		ELSE total_sales / product_lifespan
	END AS avg_monthly_revenue
FROM product_aggregations;
