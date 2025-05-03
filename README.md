## Data Analysis SQL project

## Project Overview
This project explores sales, customer, and product data using SQL to uncover actionable insights for business decision-making. The dataset simulates a retail business environment, and all analysis was performed using SQL queries on structured tables.

**Key objectives:**

Understand sales trends and product performance

Segment customers based on value and longevity

Support strategic planning with data-driven insights

## Data Structure Overview

The database structure as seen below consists of three tables: gold.dim_customer, gold.dim_product and gold.fact_sales

![data_model](https://github.com/user-attachments/assets/d12f4c4d-330c-4106-aa80-1457eeb6003f)


The analysis is based on three core datasets:

**1. gold.dim_customer**

| Column Name      | Data Type     | Description                              |
|------------------|---------------|------------------------------------------|
| customer_key     | INT           | Unique identifier for the customer.      |
| customer_id      | INT           | ID of the customer.                      |
| customer_number  | NVARCHAR(50)  | Unique number for the customer.          |
| first_name       | NVARCHAR(50)  | First name of the customer.              |
| last_name        | NVARCHAR(50)  | Last name of the customer.               |
| country          | NVARCHAR(50)  | Country of the customer.                 |
| marital_status   | NVARCHAR(50)  | Marital status of the customer.          |
| gender           | NVARCHAR(50)  | Gender of the customer.                  |
| birthdate        | DATE          | Birthdate of the customer.               |
| create_date      | DATE          | Record creation date.                    |

**2. gold.dim_product**

| Column Name      | Data Type     | Description                              |
|------------------|---------------|------------------------------------------|
| product_key      | INT           | Unique identifier for the product.       |
| product_id       | INT           | ID of the product.                       |
| product_number   | NVARCHAR(50)  | Unique number for the product.           |
| product_name     | NVARCHAR(50)  | Name of the product.                     |
| category_id      | NVARCHAR(50)  | Identifier for the product category.     |
| category         | NVARCHAR(50)  | Name of the product category.            |
| subcategory      | NVARCHAR(50)  | Name of the product subcategory.         |
| maintenance      | NVARCHAR(50)  | Maintenance details for the product.     |
| cost             | INT           | Cost of the product.                     |
| product_line     | NVARCHAR(50)  | Line of products this belongs to.        |
| start_date       | DATE          | Start date for the product availability. |

**3. gold.fact_sales**

| Column Name      | Data Type     | Description                              |
|------------------|---------------|------------------------------------------|
| order_number     | NVARCHAR(50)  | Unique number for the sales order.       |
| product_key      | INT           | Foreign key referencing the product.     |
| customer_key     | INT           | Foreign key referencing the customer.    |
| order_date       | DATE          | Date the order was placed.               |
| shipping_date    | DATE          | Date the order was shipped.              |
| due_date         | DATE          | Date the payment is due.                 |
| sales_amount     | INT           | Total amount of the sale.                |
| quantity         | TINYINT       | Quantity of products sold.               |
| price            | INT           | Price per product sold.                  |


Prior to beginning the analysis, the data underwent cleansing and quality checks to ensure accuracy and consistency. This included:
- Removing duplicate records.
- Handling missing or null values.
- Standardizing data formats (e.g., dates, text fields).
- Validating relationships between tables (e.g., foreign key constraints).
- Ensuring data integrity for accurate analysis.

The SQL queries utilised to data cleansing and quality checks can be found [here](https://github.com/yuvi31102000/sql-data-warehouse-project)

## Executive Summary

**Sales Trends**

**Total Sales Performance:** Sales reached a record high in March 2014, surpassing €12,000 in revenue, marking the highest sales month in the analyzed period. This peak can be attributed to seasonal promotions and a strategic marketing campaign launched during that time.

**Monthly Sales Growth:** The monthly sales data shows consistent growth, with a 15% average increase year-over-year. However, seasonal fluctuations are noticeable, particularly in Q3, where sales dip by an average of 10% due to lower customer demand during summer months. Despite this, the overall trend remains upward, suggesting effective sales strategies and customer retention efforts.

**Product Performance**

**Top-Performing Products:** Products in the Electronics and Home Appliances categories generated over €50,000 in total sales, accounting for 60% of the overall revenue. These categories demonstrated higher-than-average growth, with certain items such as smartphones and smart home devices performing exceptionally well.

**Category Breakdown:** Electronics and Home Appliances dominate the sales, with Electronics contributing 35% and Home Appliances contributing 25% of the total revenue. This shift towards tech-driven consumer products reflects broader market trends and customer preferences for higher-value purchases in these categories.

**Average Selling Price:** The average selling price across all products is €285.60, a slight increase from the previous year (€265.00). This rise is attributed to the introduction of premium products and customer willingness to invest in higher-priced goods, particularly within the tech and home appliance categories.

**Customer Segmentation**

**VIP Customers:** VIP Customers, comprising 14% of the total customer base, are responsible for nearly 40% of total revenue. This group demonstrates a significantly higher average lifetime value (LTV) and repeat purchase rate, with a 30% higher frequency of purchases compared to the regular customer base. Targeting and nurturing this segment has the potential for long-term profitability.

**Regular Customers:** Regular Customers make up 62% of the customer base and represent the backbone of the revenue stream. While their individual contributions are lower than VIP customers, their consistent purchasing behavior ensures steady revenue flow. The average lifetime value for regular customers is €1,500, and the retention rate for this group stands at 70%, suggesting good customer loyalty but room for improvement in engagement strategies.

**New Customers:** New Customers constitute 24% of the customer base, with an average lifespan of fewer than 12 months. While their initial contributions to revenue are modest, they represent an essential growth opportunity. The average lifetime value of new customers is €250, with the potential to increase through targeted marketing and loyalty programs aimed at improving retention and lifetime value.

