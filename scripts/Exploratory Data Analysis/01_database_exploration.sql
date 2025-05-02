-- ================================================================
-- Database Exploration 
-- ================================================================

-- List all tables and views available in the current database schema.
-- Useful for getting a complete overview of the database structure.
SELECT * 
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieve column-level metadata for the 'dim_customer' table.
-- Helps understand column names, data types, and nullability.
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customer';

-- Retrieve column-level metadata for the 'dim_product' table.
-- Useful for understanding the schema of product-related data.
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_product';

-- Retrieve column-level metadata for the 'fact_sales' table.
-- Assists in analyzing the fact table structure used in reporting.
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'fact_sales';
