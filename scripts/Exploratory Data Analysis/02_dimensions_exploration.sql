-- ================================================================
-- Dimensions Exploration 
-- ================================================================

-- Explore the list of distinct countries from the customer dimension.
-- Useful for understanding geographic distribution in the dataset.
SELECT DISTINCT 
    country 
FROM gold.dim_customer;

-- Explore product hierarchy by listing unique combinations of category, 
-- subcategory, and product name from the product dimension.
-- Helps validate product classification and ensure data consistency.
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_product
ORDER BY category, subcategory, product_name;
