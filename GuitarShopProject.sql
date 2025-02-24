USE my_guitar_shop;
-- view tables
SHOW TABLES;
-- desribe tables to understand structure
DESCRIBE orders;
DESCRIBE customers;
DESCRIBE products;
DESCRIBE order_items;
-- What is the best selling product?
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;
-- Which month had the highest quanitiy of orders?
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, SUM(oi.quantity) AS total_sold
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY total_sold DESC
LIMIT 1;
-- Which customers make the most orders?
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, customer_name
ORDER BY total_orders DESC
LIMIT 5;
-- What is the average price of a product at this store?
SELECT AVG(list_price)
FROM products;
-- What states are the most products shipped to?
SELECT a.state, SUM(oi.quantity) AS total_shipped
FROM orders o 
JOIN addresses a ON o.customer_id = a.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN customers c ON o.ship_address_id = c.shipping_address_id
GROUP BY a.state
ORDER BY total_shipped DESC
LIMIT 5;
-- What is the longest and shortest amount of days between ordering and shipping?
SELECT 
	MAX(DATEDIFF(ship_date, order_date)) AS longest_time,
    MIN(DATEDIFF(ship_date, order_date)) AS shortest_time
FROM orders;
-- Which category of product has the highest max price?
SELECT c.category_name, MAX(p.list_price) as max_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY max_price DESC;
-- What is the average price of each product category?
SELECT c.category_name, AVG(p.list_price) as avg_price
FROM products p
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY avg_price DESC;
-- Which product category has the highest revenue?
SELECT c.category_name, SUM(oi.quantity * p.list_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
-- Which product has the highest revenue?
SELECT p.product_name, SUM(oi.quantity * p.list_price) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC;






