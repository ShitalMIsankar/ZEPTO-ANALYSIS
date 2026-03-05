🛒 Zepto SQL Data Analysis Project

📌 Project Overview

This project focuses on data exploration, cleaning, and analysis of a Zepto product dataset using SQL.

The goal is to extract meaningful insights about:

💰 Product pricing

🏷️ Discounts

📦 Inventory availability

📊 Category-level revenue

This project demonstrates how SQL can transform raw product data into actionable business insights for quick-commerce platforms.

📂 Dataset Description

The dataset contains product-level information such as:

Column Name	Description
🆔 sku_id	Unique identifier for each product
🏷️ category	Product category
📝 name	Product name
💰 mrp	Maximum Retail Price
🔖 discount_percent	Discount offered
📦 available_quantity	Available stock quantity
💸 discounted_selling_price	Final selling price after discount
⚖️ weight_in_gms	Product weight
❌ out_of_stock	Stock availability status
📊 quantity	Pack quantity
🛠️ Database Setup
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

🔍 Data Exploration

Initial exploration was done to understand the dataset.

Steps included:

🔢 Counting total rows

👀 Viewing sample records

⚠️ Checking for NULL values

🏷️ Identifying unique product categories

📦 Checking stock availability

🔁 Detecting duplicate product names

Example query:

SELECT COUNT(*) FROM zepto_analysis;

🧹 Data Cleaning

Cleaning the dataset ensures accurate analysis.

❌ Removing Invalid Price Data

Products with MRP = 0 were removed.

DELETE FROM zepto_analysis
WHERE mrp = 0;

💱 Converting Paise to Rupees

Prices were converted from paise → rupees.

UPDATE zepto_analysis
SET mrp = mrp / 100.0,
discounted_selling_price = discounted_selling_price / 100.0;

📊 Data Analysis Queries
🥇 Top 10 Best Discounted Products
SELECT name, mrp, discount_percent
FROM zepto_analysis
ORDER BY discount_percent DESC
LIMIT 10;


📌 Insight: Finds products offering the highest discounts.

🚫 High MRP Products That Are Out of Stock
SELECT name, mrp
FROM zepto_analysis
WHERE out_of_stock = 'TRUE' AND mrp > 300
ORDER BY mrp DESC;


📌 Insight: Identifies high-value products currently unavailable.

💰 Estimated Revenue by Category
SELECT category,
SUM(discounted_selling_price * available_quantity) AS total_revenue
FROM zepto_analysis
GROUP BY category
ORDER BY total_revenue;


📌 Insight: Estimates potential category-level revenue.

💎 Premium Products with Low Discounts
SELECT name, mrp, discount_percent
FROM zepto_analysis
WHERE mrp > 500 AND discount_percent < 10;


📌 Insight: Finds expensive products with minimal discounts.

🏷️ Categories with Highest Average Discounts
SELECT category,
ROUND(AVG(discount_percent),2) AS avg_discount
FROM zepto_analysis
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;


📌 Insight: Shows which categories provide better deals for customers.

⚖️ Price Per Gram Analysis
SELECT name, weight_in_gms, discounted_selling_price,
ROUND(discounted_selling_price/weight_in_gms,2) AS price_per_gram
FROM zepto_analysis
WHERE weight_in_gms >= 100
ORDER BY price_per_gram;


📌 Insight: Helps determine best-value products.

📦 Product Weight Categorization

Products are grouped into:

🪶 Low (<1000g)

📦 Medium (1000g–5000g)

🏋️ Bulk (>5000g)

CASE 
WHEN weight_in_gms < 1000 THEN 'Low'
WHEN weight_in_gms < 5000 THEN 'Medium'
ELSE 'Bulk'
END

⚖️ Total Inventory Weight per Category
SELECT category,
SUM(weight_in_gms * available_quantity) AS total_weight
FROM zepto_analysis
GROUP BY category;


📌 Insight: Useful for warehouse storage and logistics planning.

📈 Key Insights

✅ Some products offer very high discounts, attracting customers.
📉 High-priced products sometimes go out of stock quickly, showing high demand.
🏷️ Discount strategies vary across categories.
💰 Price-per-gram analysis helps identify value-for-money products.
📦 Inventory weight analysis helps in logistics planning.

🧰 Tools Used

🐘 PostgreSQL

💻 SQL

📊 Data Analysis Techniques

🎯 Project Outcome

This project demonstrates how SQL can be used to:

🔍 Explore datasets

🧹 Clean inconsistent data

📊 Generate business insights

💰 Analyze product pricing and discounts

These insights can help businesses improve pricing strategies, inventory management, and promotional campaigns.
