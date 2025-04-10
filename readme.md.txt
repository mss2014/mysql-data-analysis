# 📊 MySQL Sample Database – Query & Index Optimization Guide

This project uses the [MySQL Sample Database](https://www.mysqltutorial.org/mysql-sample-database.aspx) to demonstrate how to extract and analyze data using SQL. It also covers how to use indexes to improve query performance.

## 📁 Contents
- `mysqlsampledatabase.sql` – The SQL file to set up the sample database.
- SQL query examples for:
  - SELECT, WHERE, ORDER BY, GROUP BY
  - JOINs (INNER, LEFT, RIGHT)
  - Subqueries
  - Aggregate functions (SUM, AVG)
  - Creating views
  - Query optimization using indexes

---

## 🚀 Getting Started

### 1. Import the Sample Database
2. Connect to MySQL
🔍 Examples
• Get customers in the USA
SELECT customerName, country
FROM customers
WHERE country = 'USA';
(1.png)

• Show total sales for each product
SELECT p.productCode, p.productName, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName
ORDER BY total_sales DESC;
(7.png)

• Find customers with more than 3 orders
SELECT customerName
FROM customers
WHERE customerNumber IN (SELECT customerNumber
  FROM orders
  GROUP BY customerNumber
  HAVING COUNT(orderNumber) > 3);
(5.png)

⚡ Make Queries Faster with Indexes
What is an Index?
An index helps MySQL find data faster, like a book’s table of contents.

• Create an Index
CREATE INDEX idx_orders_customerNumber ON orders(customerNumber);
(10.1)

• This helps speed up queries like:
SELECT * FROM orders WHERE customerNumber = 103;

• Check if MySQL uses the index
EXPLAIN SELECT * FROM orders WHERE customerNumber = 103;
(10.2)

• Remove an Index
DROP INDEX idx_orders_customerNumber ON orders;

🧠 Extra: Create a View
A view is like a saved query you can use later.

Example: total sales by customer
CREATE VIEW customer_sales AS
SELECT c.customerName, SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName;
(9.png)

This project is licensed under the MIT License.
