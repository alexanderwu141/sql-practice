-- Week 1, Day 2: Counting and summarising

-- 2.1 How many customers are there
SELECT COUNT(*) AS n_customers
FROM customers;

-- 2.2 How many orders have each status, most common first
SELECT status, COUNT(*) AS n_orders
FROM orders
GROUP BY status
ORDER BY n_orders DESC;

-- 2.3 Average list price per category, rounded to 2 decimals, highest first
SELECT category, ROUND(AVG(price), 2) AS avg_price
FROM products
GROUP BY category
ORDER BY avg_price DESC;

-- 2.4 The earliest and latest order dates, in one row with two columns
SELECT MIN(order_date), MAX(order_date)
FROM orders;

-- 2.5 States with at least 3 customers, with the count
SELECT state, COUNT(*) AS n_customers
FROM customers
GROUP BY state
HAVING COUNT(*) >= 3;

-- 2.6 Total units sold per product, most first, ties broken by product ID
SELECT product_id, SUM(quantity) AS units
FROM order_items
GROUP BY product_id
ORDER BY units DESC, product_id;
-- There are 9 rows when there are 10 products because one of the products didn't sell.

-- 2.7 In one query, show COUNT(*), COUNT(referral_source) and COUNT(DISTINCT referral_source)
SELECT COUNT(*), COUNT(referral_source), COUNT(DISTINCT referral_source)
FROM customers;
-- 15 is the number of rows, so the number of customers. 11 is the number of rows of referral_source customers that are not NULL. 3 is the number of different values in the column.

-- 2.8 How many different customers have placed at least one order? Use only the orders table
SELECT COUNT(DISTINCT customer_id)
FROM orders;