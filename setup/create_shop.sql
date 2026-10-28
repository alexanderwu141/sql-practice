-- create_shop.sql : builds the practice database for Phase 1.
-- Run from the sql-practice folder:  duckdb data/shop.duckdb < setup/create_shop.sql
-- Safe to re-run: it deletes the old tables first.

DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  customer_id     INTEGER PRIMARY KEY,
  first_name      VARCHAR,
  city            VARCHAR,
  state           VARCHAR,
  signup_date     DATE,
  referral_source VARCHAR          -- how they heard about the shop; NULL = unknown
);

CREATE TABLE products (
  product_id   INTEGER PRIMARY KEY,
  product_name VARCHAR,
  category     VARCHAR,
  price        DECIMAL(8,2),       -- current list price
  cost         DECIMAL(8,2)        -- what the shop pays the supplier
);

CREATE TABLE orders (
  order_id       INTEGER PRIMARY KEY,
  customer_id    INTEGER,
  order_date     DATE,
  status         VARCHAR,          -- delivered, shipped, cancelled, returned
  promised_date  DATE,             -- delivery date promised at checkout
  delivered_date DATE              -- NULL if not delivered (yet)
);

CREATE TABLE order_items (
  order_id   INTEGER,
  product_id INTEGER,
  quantity   INTEGER,
  unit_price DECIMAL(8,2)          -- price actually paid per unit (can differ from list price)
);

CREATE TABLE events (
  event_id   INTEGER PRIMARY KEY,
  user_id    INTEGER,              -- 1-15 are customers; 16-20 browsed without an account
  event_time TIMESTAMP,
  event_type VARCHAR               -- visit, view_product, add_to_cart, checkout, purchase
);

INSERT INTO customers VALUES
  (1, 'Maya', 'Los Angeles', 'CA', '2026-01-03', 'instagram'),
  (2, 'Jordan', 'Austin', 'TX', '2026-01-05', 'google'),
  (3, 'Priya', 'San Diego', 'CA', '2026-01-09', NULL),
  (4, 'Leo', 'Brooklyn', 'NY', '2026-01-14', 'friend'),
  (5, 'Jasmine', 'Seattle', 'WA', '2026-01-20', 'instagram'),
  (6, 'Carlos', 'Los Angeles', 'CA', '2026-02-02', 'google'),
  (7, 'Hana', 'Portland', 'OR', '2026-02-06', NULL),
  (8, 'Jake', 'Houston', 'TX', '2026-02-11', 'google'),
  (9, 'Nina', 'Queens', 'NY', '2026-02-19', 'friend'),
  (10, 'Omar', 'San Jose', 'CA', '2026-03-01', 'instagram'),
  (11, 'Grace', 'Dallas', 'TX', '2026-03-08', NULL),
  (12, 'Ben', 'Spokane', 'WA', '2026-03-15', 'google'),
  (13, 'Sofia', 'Los Angeles', 'CA', '2026-03-27', 'friend'),
  (14, 'Ethan', 'Brooklyn', 'NY', '2026-04-10', NULL),
  (15, 'Julia', 'Oakland', 'CA', '2026-04-22', 'instagram');

INSERT INTO products VALUES
  (1, 'Trail Hoodie', 'Apparel', 45.00, 18.00),
  (2, 'Wool Beanie', 'Apparel', 22.00, 7.00),
  (3, 'Rain Shell Jacket', 'Apparel', 120.00, 55.00),
  (4, '2-Person Tent', 'Camping', 189.00, 95.00),
  (5, 'Sleeping Bag', 'Camping', 89.00, 40.00),
  (6, 'Camp Stove', 'Camping', 89.00, 38.00),
  (7, 'Enamel Mug', 'Kitchen', 14.00, 4.00),
  (8, 'Pour-Over Coffee Kit', 'Kitchen', 38.00, 15.00),
  (9, 'Water Bottle', 'Accessories', 24.00, 8.00),
  (10, 'Headlamp', 'Accessories', 32.00, 12.00);

INSERT INTO orders VALUES
  (101, 1, '2026-01-04', 'delivered', '2026-01-09', '2026-01-08'), (102, 2, '2026-01-07', 'delivered', '2026-01-12', '2026-01-13'),
  (103, 1, '2026-01-18', 'delivered', '2026-01-23', '2026-01-21'), (104, 3, '2026-01-25', 'delivered', '2026-01-30', '2026-01-30'),
  (105, 4, '2026-01-28', 'cancelled', '2026-02-02', NULL), (106, 5, '2026-02-01', 'delivered', '2026-02-06', '2026-02-08'),
  (107, 2, '2026-02-09', 'delivered', '2026-02-14', '2026-02-13'), (108, 6, '2026-02-12', 'delivered', '2026-02-17', '2026-02-17'),
  (109, 7, '2026-02-15', 'returned', '2026-02-20', '2026-02-19'), (110, 1, '2026-02-22', 'delivered', '2026-02-27', '2026-02-28'),
  (111, 8, '2026-02-27', 'delivered', '2026-03-04', '2026-03-02'), (112, 9, '2026-03-03', 'delivered', '2026-03-08', '2026-03-07'),
  (113, 3, '2026-03-06', 'delivered', '2026-03-11', '2026-03-14'), (114, 6, '2026-03-11', 'delivered', '2026-03-16', '2026-03-15'),
  (115, 10, '2026-03-14', 'delivered', '2026-03-19', '2026-03-19'), (116, 4, '2026-03-19', 'delivered', '2026-03-24', '2026-03-25'),
  (117, 11, '2026-03-24', 'cancelled', '2026-03-29', NULL), (118, 2, '2026-03-29', 'delivered', '2026-04-03', '2026-04-01'),
  (119, 12, '2026-04-02', 'delivered', '2026-04-07', '2026-04-06'), (120, 5, '2026-04-08', 'delivered', '2026-04-13', '2026-04-13'),
  (121, 13, '2026-04-12', 'delivered', '2026-04-17', '2026-04-19'), (122, 1, '2026-04-17', 'delivered', '2026-04-22', '2026-04-21'),
  (123, 9, '2026-04-23', 'returned', '2026-04-28', '2026-04-28'), (124, 6, '2026-04-28', 'delivered', '2026-05-03', '2026-05-01'),
  (125, 10, '2026-05-03', 'delivered', '2026-05-08', '2026-05-09'), (126, 3, '2026-05-09', 'delivered', '2026-05-14', '2026-05-13'),
  (127, 8, '2026-05-15', 'delivered', '2026-05-20', '2026-05-20'), (128, 12, '2026-05-21', 'cancelled', '2026-05-26', NULL),
  (129, 13, '2026-05-26', 'delivered', '2026-05-31', '2026-05-30'), (130, 1, '2026-06-02', 'delivered', '2026-06-07', '2026-06-07'),
  (131, 2, '2026-06-08', 'delivered', '2026-06-13', '2026-06-17'), (132, 11, '2026-06-14', 'delivered', '2026-06-19', '2026-06-18'),
  (133, 6, '2026-06-20', 'shipped', '2026-06-25', NULL), (134, 9, '2026-06-25', 'shipped', '2026-06-30', NULL),
  (135, 5, '2026-06-28', 'shipped', '2026-07-03', NULL);

INSERT INTO order_items VALUES
  (101, 3, 1, 120.00), (101, 7, 3, 14.00), (102, 2, 2, 22.00), (103, 6, 1, 89.00),
  (104, 1, 1, 45.00), (104, 4, 1, 189.00), (104, 9, 2, 24.00), (105, 2, 1, 22.00),
  (105, 4, 1, 189.00), (106, 7, 2, 14.00), (106, 1, 1, 45.00), (106, 9, 1, 24.00),
  (107, 1, 1, 45.00), (107, 7, 1, 14.00), (107, 9, 2, 24.00), (108, 5, 1, 89.00),
  (109, 3, 1, 120.00), (109, 2, 2, 22.00), (110, 9, 1, 24.00), (110, 3, 1, 120.00),
  (111, 4, 1, 189.00), (111, 6, 1, 89.00), (111, 1, 2, 45.00), (112, 1, 2, 45.00),
  (113, 8, 3, 38.00), (114, 7, 2, 14.00), (114, 6, 1, 71.20), (114, 4, 1, 151.20),
  (115, 6, 1, 71.20), (115, 5, 1, 71.20), (116, 3, 1, 96.00), (117, 2, 2, 22.00),
  (118, 9, 1, 24.00), (118, 8, 3, 38.00), (119, 5, 1, 89.00), (119, 2, 1, 22.00),
  (120, 7, 1, 14.00), (120, 3, 1, 120.00), (120, 9, 1, 24.00), (121, 7, 3, 14.00),
  (121, 1, 1, 45.00), (122, 6, 1, 89.00), (122, 9, 1, 24.00), (122, 8, 2, 38.00),
  (123, 8, 1, 38.00), (123, 2, 1, 22.00), (124, 2, 3, 22.00), (124, 1, 3, 45.00),
  (125, 8, 3, 38.00), (125, 5, 1, 89.00), (126, 6, 1, 89.00), (126, 1, 2, 45.00),
  (127, 3, 1, 120.00), (127, 2, 2, 22.00), (128, 4, 1, 189.00), (129, 3, 1, 120.00),
  (129, 4, 1, 189.00), (130, 7, 1, 14.00), (130, 8, 1, 38.00), (131, 7, 1, 14.00),
  (131, 5, 1, 89.00), (132, 9, 3, 24.00), (132, 5, 1, 89.00), (133, 6, 1, 89.00),
  (133, 7, 1, 14.00), (134, 2, 1, 22.00), (135, 4, 1, 189.00);

INSERT INTO events VALUES
  (1, 1, '2026-06-04 10:07:00', 'visit'), (2, 1, '2026-06-04 10:11:00', 'view_product'),
  (3, 1, '2026-06-04 10:15:00', 'add_to_cart'), (4, 1, '2026-06-04 10:19:00', 'checkout'),
  (5, 1, '2026-06-04 10:23:00', 'purchase'), (6, 2, '2026-06-07 11:14:00', 'visit'),
  (7, 2, '2026-06-07 11:18:00', 'view_product'), (8, 2, '2026-06-07 11:22:00', 'add_to_cart'),
  (9, 2, '2026-06-07 11:26:00', 'checkout'), (10, 2, '2026-06-07 11:30:00', 'purchase'),
  (11, 3, '2026-06-10 12:21:00', 'visit'), (12, 3, '2026-06-10 12:25:00', 'view_product'),
  (13, 3, '2026-06-10 12:29:00', 'view_product'), (14, 3, '2026-06-10 12:33:00', 'add_to_cart'),
  (15, 4, '2026-06-13 13:28:00', 'visit'), (16, 5, '2026-06-16 14:35:00', 'visit'),
  (17, 5, '2026-06-16 14:39:00', 'view_product'), (18, 5, '2026-06-16 14:43:00', 'add_to_cart'),
  (19, 5, '2026-06-16 14:47:00', 'checkout'), (20, 6, '2026-06-19 15:42:00', 'visit'),
  (21, 6, '2026-06-19 15:46:00', 'view_product'), (22, 6, '2026-06-19 15:50:00', 'view_product'),
  (23, 6, '2026-06-19 15:54:00', 'add_to_cart'), (24, 6, '2026-06-19 15:58:00', 'checkout'),
  (25, 6, '2026-06-19 16:02:00', 'purchase'), (26, 7, '2026-06-22 16:49:00', 'visit'),
  (27, 7, '2026-06-22 16:53:00', 'view_product'), (28, 8, '2026-06-25 17:56:00', 'visit'),
  (29, 8, '2026-06-25 18:00:00', 'view_product'), (30, 9, '2026-06-01 09:03:00', 'visit'),
  (31, 9, '2026-06-01 09:07:00', 'view_product'), (32, 9, '2026-06-01 09:11:00', 'view_product'),
  (33, 9, '2026-06-01 09:15:00', 'add_to_cart'), (34, 9, '2026-06-01 09:19:00', 'checkout'),
  (35, 9, '2026-06-01 09:23:00', 'purchase'), (36, 10, '2026-06-04 10:10:00', 'visit'),
  (37, 10, '2026-06-04 10:14:00', 'view_product'), (38, 11, '2026-06-07 11:17:00', 'visit'),
  (39, 11, '2026-06-07 11:21:00', 'view_product'), (40, 11, '2026-06-07 11:25:00', 'add_to_cart'),
  (41, 11, '2026-06-07 11:29:00', 'checkout'), (42, 11, '2026-06-07 11:33:00', 'purchase'),
  (43, 12, '2026-06-10 12:24:00', 'visit'), (44, 12, '2026-06-10 12:28:00', 'view_product'),
  (45, 12, '2026-06-10 12:32:00', 'view_product'), (46, 13, '2026-06-13 13:31:00', 'visit'),
  (47, 13, '2026-06-13 13:35:00', 'view_product'), (48, 13, '2026-06-13 13:39:00', 'add_to_cart'),
  (49, 14, '2026-06-16 14:38:00', 'visit'), (50, 15, '2026-06-19 15:45:00', 'visit'),
  (51, 15, '2026-06-19 15:49:00', 'view_product'), (52, 15, '2026-06-19 15:53:00', 'view_product'),
  (53, 16, '2026-06-22 16:52:00', 'visit'), (54, 16, '2026-06-22 16:56:00', 'view_product'),
  (55, 16, '2026-06-22 17:00:00', 'add_to_cart'), (56, 17, '2026-06-25 17:59:00', 'visit'),
  (57, 18, '2026-06-01 09:06:00', 'visit'), (58, 18, '2026-06-01 09:10:00', 'view_product'),
  (59, 18, '2026-06-01 09:14:00', 'view_product'), (60, 18, '2026-06-01 09:18:00', 'add_to_cart'),
  (61, 18, '2026-06-01 09:22:00', 'checkout'), (62, 19, '2026-06-04 10:13:00', 'visit'),
  (63, 20, '2026-06-07 11:20:00', 'visit'), (64, 20, '2026-06-07 11:24:00', 'view_product');

SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL SELECT 'products', COUNT(*) FROM products
UNION ALL SELECT 'orders', COUNT(*) FROM orders
UNION ALL SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL SELECT 'events', COUNT(*) FROM events;