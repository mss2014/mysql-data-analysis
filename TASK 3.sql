use classicmodels;
show tables;
select * from orderdetails;

-- 1.Listing all customers from the USA, ordered by their name
SELECT customerName, country
FROM customers
WHERE country = 'USA'
ORDER BY customerName;

-- 2.Counting number of customers per country
SELECT country, COUNT(*) AS num_customers
FROM customers
GROUP BY country
ORDER BY num_customers DESC;

-- 3.INNER JOIN: Listing orders with customer names
SELECT orders.orderNumber, customers.customerName, orders.orderDate
FROM orders
INNER JOIN customers ON orders.customerNumber = customers.customerNumber;

-- 4.LEFT JOIN: Showing all customers and their orders (if any)
SELECT customers.customerName, orders.orderNumber
FROM customers
LEFT JOIN orders ON customers.customerNumber = orders.customerNumber;

-- 5.Finding customers who have placed more than 3 orders
SELECT customerName
FROM customers
WHERE customerNumber IN (SELECT customerNumber FROM orders GROUP BY customerNumber HAVING COUNT(orderNumber) > 3);

-- 6.Finding products with above average price
SELECT productName, buyPrice
FROM products
WHERE buyPrice > (SELECT AVG(buyPrice) FROM products);

-- 7.Total sales per product
SELECT p.productCode, p.productName, SUM(quantityOrdered * priceEach) AS total_sales
FROM orderdetails o INNER JOIN products p ON o.productCode = p.productCode
GROUP BY p.productCode, p.productName
ORDER BY total_sales DESC;


-- 8.Average order value
SELECT AVG(total) AS avg_order_value
FROM (SELECT orderNumber, SUM(quantityOrdered * priceEach) AS total
    FROM orderdetails GROUP BY orderNumber) AS order_totals;

-- 9.Creating a view showing total sales per customer
CREATE VIEW customer_sales AS
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM customers c JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName;

-- Using the view
SELECT * FROM customer_sales
ORDER BY total_sales DESC;

-- 10.Creating index on orders table for faster joins on customerNumber
CREATE INDEX idx_orders_customerNumber ON orders(customerNumber);
SELECT * FROM orders WHERE customerNumber = 103;
EXPLAIN SELECT * FROM orders WHERE customerNumber = 103;

