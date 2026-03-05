Zepto SQL Data Analysis
Project Overview

This project performs data exploration, cleaning, and analysis on a Zepto product dataset using SQL. The objective is to derive meaningful insights about product pricing, discounts, inventory availability, and category-level revenue.

The analysis demonstrates how SQL can be used to transform raw data into useful business insights for quick-commerce platforms.

Dataset Description

The dataset contains product-level information such as:

Column Name	Description
sku_id	- Unique identifier for each product
category -	Product category
name	- Product name
mrp	- Maximum Retail Price
discount_percent	- Discount offered on product
available_quantity - Quantity available in stock
discounted_selling_price	- Final selling price after discount
weight_in_gms	- Product weight
out_of_stock - Stock availability status
quantity -	Pack quantity


Database Setup

Create Database
CREATE DATABASE ZEPTO;

Create Table
CREATE TABLE zepto_analysis (
   sku_id serial PRIMARY KEY,
   category VARCHAR(120),
   name VARCHAR(150) NOT NULL,
   mrp NUMERIC(8,2),
   discount_percent NUMERIC(5,2),
   available_quantity INTEGER,
   discounted_selling_price NUMERIC(8,2),
   weight_in_gms INTEGER,
   out_of_stock TEXT,
   quantity INTEGER
);

Data Exploration

Initial exploration was performed to understand the dataset structure.


Key steps included:
Counting total rows
Viewing sample records
Checking for NULL values
Identifying unique product categories
Checking stock availability
Detecting duplicate product names

Example query:
SELECT COUNT(*) FROM zepto_analysis;


Data Cleaning

1.Data cleaning steps included -
Removing Invalid Price Data
Products with MRP = 0 were removed.

DELETE FROM zepto_analysis
WHERE mrp = 0;

2.Converting Paise to Rupees -
The prices were converted from paise to rupees.

UPDATE zepto_analysis
SET mrp = mrp / 100.0,
discounted_selling_price = discounted_selling_price / 100.0;


Data Analysis Queries

1. Top 10 Best Discounted Products -
   
SELECT name, mrp, discount_percent
FROM zepto_analysis
ORDER BY discount_percent DESC
LIMIT 10;

2. High MRP Products That Are Out of Stock -
   
SELECT name, mrp
FROM zepto_analysis
WHERE out_of_stock = 'TRUE' AND mrp > 300
ORDER BY mrp DESC;

3. Estimated Revenue by Category -
   
SELECT category,
SUM(discounted_selling_price * available_quantity) AS total_revenue
FROM zepto_analysis
GROUP BY category
ORDER BY total_revenue;

4. Premium Products with Low Discounts -
   
SELECT name, mrp, discount_percent
FROM zepto_analysis
WHERE mrp > 500 AND discount_percent < 10;

5. Categories with Highest Average Discount -
   
SELECT category,
ROUND(AVG(discount_percent),2) AS avg_discount
FROM zepto_analysis
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

6. Price Per Gram Analysis -
   
SELECT name, weight_in_gms, discounted_selling_price,
ROUND(discounted_selling_price/weight_in_gms,2) AS price_per_gram
FROM zepto_analysis
WHERE weight_in_gms >= 100
ORDER BY price_per_gram;

7. Product Weight Categorization -

Products were grouped into three categories:

Low (<1000g)

Medium (1000g–5000g)

Bulk (>5000g)

CASE 
WHEN weight_in_gms < 1000 THEN 'Low'
WHEN weight_in_gms < 5000 THEN 'Medium'
ELSE 'Bulk'
END

8. Total Inventory Weight per Category -
   
SELECT category,
SUM(weight_in_gms * available_quantity) AS total_weight
FROM zepto_analysis
GROUP BY category;



Key Insights

Some products offer very high discounts, providing better value for customers.

High-priced products are sometimes out of stock, indicating strong demand.

Discount levels vary significantly across product categories.

Price-per-gram analysis helps identify cost-effective products.

Inventory weight analysis provides insights for warehouse management.



Tools Used

SQL

PostgreSQL

Data Analysis Techniques



Project Outcome

This project demonstrates how SQL can be used to:

Explore large datasets

Clean inconsistent data

Generate business insights

Perform product and pricing analysis

These insights can help businesses optimize pricing strategies, inventory management, and promotional campaigns.
