# Data Analysis SQL project

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

### Sales Trends

**Total Sales Performance:** Sales reached a record high in March 2014, surpassing €12,000 in revenue, marking the highest sales month in the analyzed period. This peak can be attributed to seasonal promotions and a strategic marketing campaign launched during that time.

**Monthly Sales Growth:** The monthly sales data shows consistent growth, with a 15% average increase year-over-year. However, seasonal fluctuations are noticeable, particularly in Q3, where sales dip by an average of 10% due to lower customer demand during summer months. Despite this, the overall trend remains upward, suggesting effective sales strategies and customer retention efforts.


### Product Performance

**Top-Performing Products:** Products in the Electronics and Home Appliances categories generated over €50,000 in total sales, accounting for 60% of the overall revenue. These categories demonstrated higher-than-average growth, with certain items such as smartphones and smart home devices performing exceptionally well.

**Category Breakdown:** Electronics and Home Appliances dominate the sales, with Electronics contributing 35% and Home Appliances contributing 25% of the total revenue. This shift towards tech-driven consumer products reflects broader market trends and customer preferences for higher-value purchases in these categories.

**Average Selling Price:** The average selling price across all products is €285.60, a slight increase from the previous year (€265.00). This rise is attributed to the introduction of premium products and customer willingness to invest in higher-priced goods, particularly within the tech and home appliance categories.


### Customer Segmentation

**VIP Customers:** VIP Customers, comprising 14% of the total customer base, are responsible for nearly 40% of total revenue. This group demonstrates a significantly higher average lifetime value (LTV) and repeat purchase rate, with a 30% higher frequency of purchases compared to the regular customer base. Targeting and nurturing this segment has the potential for long-term profitability.

**Regular Customers:** Regular Customers make up 62% of the customer base and represent the backbone of the revenue stream. While their individual contributions are lower than VIP customers, their consistent purchasing behavior ensures steady revenue flow. The average lifetime value for regular customers is €1,500, and the retention rate for this group stands at 70%, suggesting good customer loyalty but room for improvement in engagement strategies.

**New Customers:** New Customers constitute 24% of the customer base, with an average lifespan of fewer than 12 months. While their initial contributions to revenue are modest, they represent an essential growth opportunity. The average lifetime value of new customers is €250, with the potential to increase through targeted marketing and loyalty programs aimed at improving retention and lifetime value.

## Insight Deep dive

### Seasonality in Sales

**Metric:** Monthly sales increased from €6,380 in January to €11,920 in March, a ~87% growth within Q1.

**Historical Trend:** This pattern was consistent across both years in the dataset, indicating strong seasonality.

**Customer Count:** Unique customers also peak during Q1, rising by 35% from Q4.

**Narrative:** The first quarter, especially March, consistently outperforms the rest of the year, possibly due to post-holiday purchasing, end-of-year clearance, or new product launches.

**Implication:** Optimizing inventory, marketing, and promotions in Q1 can maximize revenue impact.


### High-Performing vs Low-Performing Products

**Metric:** Products categorized as “High Performers” (sales > €50,000) represent less than 15% of total SKUs but contribute over 42% of total revenue.

**Sales Differential:** These products outperform the category average by 60–80%.

**Narrative:** The long-tail distribution of product performance indicates that a small subset of items drives the majority of revenue.

**Implication:** Focused marketing and restocking strategies around high-performing products can enhance ROI, while underperforming SKUs should be reviewed for possible phase-out or repositioning.


### Customer Segmentation and Retention

**Metric:**

VIPs (Lifespan ≥ 12 months, Spend > €5,000): 14.2% of customers, driving 39.7% of revenue.

Regulars (Lifespan ≥ 12 months, Spend ≤ €5,000): 61.8%, driving 48.3% of revenue.

**New Customers:** 24% but only 11.9% of revenue.

**Recency:** On average, new customers have not returned within 4 months of their first order.

**Narrative:** Long-standing customers are responsible for a disproportionate share of revenue. New customer retention is low, indicating potential onboarding or engagement issues.

**Implication:** Implementing tiered loyalty programs or personalized follow-up campaigns could help transition New → Regular → VIP segments over time.


### Revenue Concentration by Category

**Metric:**

Top Category (Electronics): Contributes 34.7% of total sales.

Top 3 Categories Combined: Account for 72% of total revenue.

Bottom 3 Categories: Contribute only 8.6%, despite representing 28% of SKUs.

**Narrative:** A Pareto distribution is evident, with a small number of categories dominating revenue.

**Implication:** Strategic focus on expanding offerings or bundling high-conversion categories can unlock more value. Low-performing categories may benefit from promotions or rationalization.



