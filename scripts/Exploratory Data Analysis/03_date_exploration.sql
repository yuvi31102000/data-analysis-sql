-- ================================================================
-- Date Exploration
-- ================================================================

-- Retrieve the earliest and latest order dates from the fact_sales table.
-- Also calculate the total duration of available sales data in years and months.
-- This helps understand the time range covered in the dataset.
SELECT 
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) AS order_range_years,
    DATEDIFF(MONTH, MIN(order_date), MAX(order_date)) AS order_range_months
FROM gold.fact_sales;

-- Identify the birthdates of the oldest and youngest customers.
-- Also compute their respective ages based on the current date.
-- Useful for understanding customer age demographics.
SELECT 
    MIN(birth_date) AS oldest_customer,
    DATEDIFF(YEAR, MIN(birth_date), GETDATE()) AS oldest_customer_age,
    MAX(birth_date) AS youngest_customer,
    DATEDIFF(YEAR, MAX(birth_date), GETDATE()) AS youngest_customer_age
FROM gold.dim_customer;
