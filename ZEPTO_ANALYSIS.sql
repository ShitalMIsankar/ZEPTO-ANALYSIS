create database ZEPTO;
select * from zepto_analysis;

CREATE TABLE zepto_analysis (
   sku_id serial PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discount_percent NUMERIC(5,2),
    available_quantity INTEGER,
    discounted_selling_price NUMERIC(8,2),
    weight_in_gms INTEGER,
    out_of_stock text,
    quantity INTEGER
);

-- data exploration

-- count of rows
select count(*) from zepto_analysis;

-- sample data
SELECT * FROM zepto_analysis
LIMIT 10;

-- null values
SELECT * FROM zepto_analysis
WHERE name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discount_percent IS NULL
OR
discounted_selling_price IS NULL
OR
weight_in_gms IS NULL
OR
available_quantity IS NULL
OR
out_of_stock IS NULL
OR
quantity IS NULL;

-- different product categories
SELECT DISTINCT category
FROM zepto_analysis_1
ORDER BY category;

-- products in stock vs out of stock
SELECT out_of_stock, COUNT(sku_id)
FROM zepto_analysis
GROUP BY out_of_stock;

-- product names present multiple times
SELECT name, COUNT(sku_id) AS "Number of SKUs"
FROM zepto_analysis
GROUP BY name
HAVING count(sku_id) > 1
ORDER BY count(sku_id) DESC;

-- data cleaning

-- products with price = 0
SELECT * FROM zepto_analysis
WHERE mrp = 0 OR discounted_selling_price = 0;

DELETE FROM zepto_analysis
WHERE mrp = 0;

-- convert paise to rupees
SELECT mrp, discounted_selling_price FROM zepto_analysis;

UPDATE zepto_analysis
SET mrp = mrp / 100.0,
discounted_selling_price = discounted_selling_price / 100.0;

SELECT mrp, discounted_selling_price FROM zepto_analysis;

-- data analysis

-- Q1. Find the top 10 best-value products based on the discount percentage.

SELECT DISTINCT name, mrp, discount_percent
FROM zepto_analysis
ORDER BY discount_percent DESC
LIMIT 10;



-- Q2.What are the Products with High MRP but Out of Stock

SELECT DISTINCT name,mrp
FROM zepto_analysis
WHERE out_of_stock= "TRUE" and mrp > 300
ORDER BY mrp DESC;


-- Q3.Calculate Estimated Revenue for each category

SELECT category,
SUM(discounted_selling_price * available_quantity) AS total_revenue
FROM zepto_analysis
GROUP BY category
ORDER BY total_revenue;


-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT DISTINCT name, mrp, discount_percent
FROM zepto_analysis
WHERE mrp > 500 AND discount_percent < 10
ORDER BY mrp DESC, discount_percent DESC;


-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT category,
ROUND(AVG(discount_percent),2) AS avg_discount
FROM zepto_analysis
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;


-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name,  weight_in_gms, discounted_selling_price,
ROUND(discounted_selling_price/weight_in_gms,2) AS price_per_gram
FROM zepto_analysis
WHERE weight_in_gms >= 100
ORDER BY price_per_gram;


-- Q7.Group the products into categories like Low, Medium, Bulk.

SELECT DISTINCT name, weight_in_gms,
CASE WHEN  weight_in_gms < 1000 THEN 'Low'
	WHEN weight_in_gms < 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM zepto_analysis;


-- Q8.What is the Total Inventory Weight Per Category 

SELECT category,
SUM(weight_in_gms * available_quantity) AS total_weight
FROM zepto_analysis
GROUP BY category
ORDER BY total_weight;
