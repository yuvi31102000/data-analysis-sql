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

