-- ================================================================
-- Ranking Analysis: Best and Worst Performers
-- ================================================================

-- Identify the top 5 best-selling products based on total revenue.
-- This helps highlight which products contribute the most to business income.
SELECT 
    * 
FROM
(
    SELECT 
        p.product_name,
        SUM(s.sales_amount) AS total_revenue,
        ROW_NUMBER() OVER(ORDER BY SUM(s.sales_amount) DESC) AS top_product
    FROM gold.fact_sales s
    LEFT JOIN gold.dim_product p ON s.product_key = p.product_key
    GROUP BY p.product_name
) AS ranked_products
WHERE ranked_products.top_product <= 5;

-- Identify the bottom 5 products by total sales revenue.
-- Useful for evaluating underperforming products that may need review or discontinuation.
SELECT TOP 5
    p.product_name,
    SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_product p ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC;

-- Find the 3 customers who placed the fewest orders.
-- This helps identify low-engagement customers for potential reactivation campaigns.
SELECT TOP 3
    c.customer_key,
    c.first_name,
    c.last_name,
    COUNT(DISTINCT order_number) AS order_counts
FROM gold.fact_sales s
LEFT JOIN gold.dim_customer c ON s.customer_key = c.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY order_counts ASC;
