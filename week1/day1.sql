-- Week 1, Day 1: picking rows and columns

-- 1.1 Show every column and every row of products
SELECT * 
FROM products;

-- 1.2 Show product_name and price, most expensive first
SELECT product_name, price
FROM products
ORDER BY price DESC;

-- 1.3 Show first name and city of every cusomter in 'CA'
SELECT first_name, city
FROM customers
WHERE state = 'CA';

-- 1.4 Show Camping products that cost less than $100
SELECT product_name, price
FROM products
WHERE category = 'Camping' and price < 100;

-- 1.5 List each state customers live in, once each, alphabetically
SELECT DISTINCT state
FROM customers
ORDER BY state;

-- 1.6 Show the ID and date of every order placed in March 2026, earliest first
SELECT order_id, order_date
FROM orders
WHERE order_date BETWEEN '2026-03-01' AND '2026-03-31'
ORDER BY order_date;

-- 1.7 Find customers whose first name starts with J
SELECT first_name
FROM customers
WHERE first_name LIKE 'J%';

-- 1.8 Show the three cheapest products with their prices
SELECT product_name, price
FROM products
ORDER BY price
LIMIT 3;

-- 1.9 Show each product's name and its margin (price minus cost), calling the new column margin, highest margin first
SELECT product_name, price - cost AS margin
FROM products
ORDER BY margin DESC;

-- 1.10 Show the ID and status of orders that were cancelled or returned
SELECT order_id, status
FROM orders
WHERE status IN ('cancelled', 'returned');