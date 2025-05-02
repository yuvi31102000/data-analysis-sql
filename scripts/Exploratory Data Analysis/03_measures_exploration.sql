-- ================================================================
-- Measures Exploration
-- ================================================================

-- Calculate the total revenue generated from all orders.
SELECT SUM(sales_amount) AS total_sales 
FROM gold.fact_sales;

-- Compute the total quantity of items sold across all transactions.
SELECT SUM(qunatity) AS items_sold 
FROM gold.fact_sales;

-- Determine the average selling price per item.
SELECT AVG(price) AS avg_price 
FROM gold.fact_sales;

-- Count the total number of distinct orders placed.
-- Note: A single order can contain multiple products.
SELECT COUNT(DISTINCT order_number) AS order_count 
FROM gold.fact_sales;

-- Count the total number of unique products available in the dataset.
SELECT COUNT(DISTINCT product_number) AS products_count 
FROM gold.dim_product;

-- Count the total number of customers listed in the customer dimension.
SELECT COUNT(customer_id) AS customers_count
FROM gold.dim_customer;

-- Determine the number of distinct customers who have made at least one purchase.
SELECT COUNT(DISTINCT customer_key) AS cust_count 
FROM gold.fact_sales;


-- Consolidated summary of key business metrics.
-- Includes totals for sales, quantity, customers, products, and average price.
SELECT 
    'Total Sales' AS measure_name, 
    SUM(sales_amount) AS measure_value 
FROM gold.fact_sales
UNION ALL
SELECT 
    'Total Quantity', 
    SUM(qunatity) 
FROM gold.fact_sales
UNION ALL
SELECT 
    'Average Price',
    AVG(price) 
FROM gold.fact_sales
UNION ALL
SELECT 
    'Orders Count',
    COUNT(DISTINCT order_number)
FROM gold.fact_sales
UNION ALL
SELECT 
    'Products Count',
    COUNT(DISTINCT product_number) 
FROM gold.dim_product
UNION ALL
SELECT 
    'Customers Count',
    COUNT(customer_id)
FROM gold.dim_customer
UNION ALL
SELECT 
    'Customers with Orders',
    COUNT(DISTINCT customer_key)
FROM gold.fact_sales;
