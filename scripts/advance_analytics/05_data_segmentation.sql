-- ============================================================================
-- Data Segmentation: Segmenting Products and Customers for Business Insights
-- ============================================================================

-- The following queries segment products into different cost ranges and customers into spending behavior groups.
-- This analysis helps in understanding the distribution of products and customers based on their financial characteristics.
-- Segmenting data enables businesses to target specific groups with tailored strategies.

-- ============================================================================
-- Product Segmentation: Segmenting Products into Cost Ranges
-- ============================================================================

-- This query categorizes products based on their cost into four distinct ranges:
-- 1. 'Below 100'
-- 2. '100-500'
-- 3. '500-1000'
-- 4. 'Above 1000'

-- The query counts how many products fall into each cost range and orders the results by the product counts in descending order.
-- This segmentation helps businesses understand how many products belong to each cost segment, which can inform pricing strategies, 
-- marketing efforts, and inventory management.

SELECT 
    cost_range,  -- The cost range for each product
	COUNT(product_name) AS prod_counts  -- The number of products in each cost range
FROM
(
	SELECT 
        product_key,
		product_name,  -- Product name
		cost,  -- Product cost
		CASE
			WHEN cost < 100 THEN 'Below 100'  -- Products with cost below 100
			WHEN cost BETWEEN 100 AND 500 THEN '100-500'  -- Products with cost between 100 and 500
			WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'  -- Products with cost between 500 and 1000
			ELSE 'Above 1000'  -- Products with cost above 1000
        END AS cost_range  -- Categorizing products into cost ranges
	FROM gold.dim_product  -- Querying the product dimension table
) AS s 
GROUP BY cost_range  -- Grouping by cost range to count products in each segment
ORDER BY prod_counts DESC;  -- Ordering by product count in descending order to highlight the largest segments


-- ============================================================================
-- Customer Segmentation: Grouping Customers by Spending Behavior
-- ============================================================================

-- This query segments customers into three categories based on their spending behavior:
-- 1. **VIP**: Customers with at least 12 months of history and spending more than €5,000.
-- 2. **Regular**: Customers with at least 12 months of history but spending €5,000 or less.
-- 3. **New**: Customers with less than 12 months of history.

-- The query then counts how many customers fall into each of these segments.
-- This segmentation can be useful for targeting specific customer groups with tailored marketing or loyalty programs.
-- For example, businesses may want to offer special deals to VIP customers or incentivize regular customers to increase their spending.

WITH customer_spending AS
(
	SELECT 
		c.customer_key,  -- Customer unique identifier
		SUM(s.sales_amount) AS total_sales,  -- Total spending by the customer
		MIN(s.order_date) AS first_order,  -- First order date
		MAX(s.order_date) AS last_order,  -- Last order date
		DATEDIFF(MONTH, MIN(s.order_date), MAX(s.order_date)) AS customer_lifespan  -- Customer lifespan in months
	FROM gold.fact_sales s  -- Fact table for sales data
	LEFT JOIN gold.dim_customer c ON s.customer_key = c.customer_key  -- Joining with customer dimension table
	GROUP BY c.customer_key  -- Grouping by customer to calculate their total sales and lifespan
),
customer_status AS
(
	SELECT 
		customer_key,  -- Customer unique identifier
		total_sales,  -- Total spending
		customer_lifespan,  -- Customer lifespan in months
		CASE 
			WHEN customer_lifespan >= 12 AND total_sales > 5000 THEN 'VIP'  -- VIP if more than 12 months and > €5,000 spending
			WHEN customer_lifespan >= 12 AND total_sales <= 5000 THEN 'Regular'  -- Regular if more than 12 months and <= €5,000 spending
			ELSE 'New'  -- New if less than 12 months
		END AS customer_segments  -- Segmenting customers based on the defined criteria
	FROM customer_spending  -- Using the data from the previous query
)
SELECT 
	customer_segments,  -- The segment (VIP, Regular, or New)
	COUNT(customer_key) AS customer_counts  -- The number of customers in each segment
FROM customer_status  -- Querying the segmented customer data
GROUP BY customer_segments;  -- Grouping by customer segment to get the count of customers in each group
