-- Create table to import into csv file into PgAdmin.
CREATE TABLE salesforcourse (
	date DATE,
	year VARCHAR(4),
	month VARCHAR(9),
	customer_age SMALLINT,
	gender TEXT,
	country TEXT,
	state TEXT,
	product_category TEXT,
	sub_category TEXT,
	quantity INT,
	unit_cost DECIMAL(9,2),
	unit_price DECIMAL(9,2),
	cost DECIMAL(9,2),
	revenue DECIMAL(9,2),
	profit DECIMAL(9,2),
	loss Decimal(9,2)
)
-- SEGMENTATION & AGGREGATION
-- 1. What is the total revenue, cost, and profit/loss for the entire dataset?
SELECT 
SUM(revenue) AS "total revenue",
SUM(cost) AS "total_cost",
SUM(profit) AS "total profit",
SUM(loss)AS "total loss"
FROM salesforcourse
22344576,20082974,2786339,524737

-- 2. What is the average unit price and unit cost?
SELECT ROUND(AVG(unit_price),2) AS "avg unit price", 
ROUND(AVG(cost),2) AS "avg cost price"
FROM salesforcourse;

-- 3. How does revenue vary by product category or subcategory?
SELECT 
product_category,
sub_category,
SUM(revenue) AS "total revenue"
FROM salesforcourse
GROUP BY product_category, sub_category
ORDER BY product_category, SUM(revenue) DESC;

--4. What is the average profit/loss by country or state
SELECT 
DISTINCT country, state,
ROUND(AVG(profit),2) AS avg_profit,
ROUND(AVG(loss),2) AS avg_loss
FROM salesforcourse
GROUP BY 1,2
HAVING AVG(profit) != 0 AND AVG(loss) != 0
ORDER BY country;

--5. Can you provide a breakdown of revenue by month?
SELECT month,
year,
SUM(revenue)
FROM salesforcourse
GROUP BY month, year
ORDER BY year;

-- 6. What is the average age of customers?
SELECT gender,
AVG(customer_age) AS avg_age
FROM salesforcourse
GROUP BY 1

-- 7. How many customers do you have in each country and state?
SELECT country,state, 
COUNT(gender) AS customer_count
FROM salesforcourse
GROUP BY 1,2
ORDER BY country;


-- 8. What is the total quantity sold for each product category?
SELECT product_category,
COUNT(quantity) AS sum_quantity
FROM salesforcourse
GROUP BY 1
ORDER BY 1;

-- 9. How does the quantity sold vary by gender?
SELECT product_category,
gender,
COUNT(quantity) AS sum_quantity
FROM salesforcourse
GROUP BY 1,2
ORDER BY 1;

-- 10. Which product categories have the highest profit margin?
SELECT product_category,
AVG(profit/revenue)*100 AS profit_margin
FROM salesforcourse
GROUP BY 1
ORDER BY 2;

--11. Can you identify the top-performing products in terms of profit?
SELECT product_category,
sub_category,
MAX(profit) AS max_profit
FROM
salesforcourse
GROUP BY
product_category, sub_category
ORDER BY
max_profit DESC;

-- 12. How does the unit cost relate to the unit price?
SELECT product_category,
ROUND(AVG(unit_cost),2) AS avg_unit_cost, 
ROUND(AVG(unit_price),2) AS avg_unit_price
FROM salesforcourse
GROUP BY product_category;


--13. How does revenue change over months?
SELECT year,
month,
product_category,
ROUND(SUM(revenue),2) AS avg_revenue 
FROM salesforcourse
GROUP BY 1,2,3
ORDER BY 2;

