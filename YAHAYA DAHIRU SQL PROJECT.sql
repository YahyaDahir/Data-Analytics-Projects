CREATE DATABASE sales_performance;

USE sales_performance;

CREATE TABLE sales_performance (
order_id VARCHAR(20),
customer_name VARCHAR(100),
gender VARCHAR(20),
region VARCHAR(50),
product_category VARCHAR(50),
product_name VARCHAR(100),
quantity VARCHAR(20),
unit_price VARCHAR(20),
sales_amount VARCHAR(20),
order_date VARCHAR(50),
payment_method VARCHAR(50)
);

INSERT INTO sales_performance VALUES
('ORD001','John Musa','Male','Abuja','Electronics','Laptop','2','350000','700000','2025-01-15','Card'),
('ORD002','Mary Ali','Female','Lagos','Fashion','Sneakers','3','25000','75000','2025-01-17','Cash'),
('ORD003','Ahmed Bello','Male','Kano','Electronics','Phone','1','180000','180000','2025-01-18','Transfer'),
('ORD004','Sarah James','Female','Abj','Groceries','Rice','5','15000','75000','2025/01/19','Cash'),
('ORD005','David Mark','Male','ABUJA ','Electronics','Laptop','2','350000','700000','15-01-2025','Card'),
('ORD006','Grace Dan','Female','','Fashion','Bag','2','12000','24000','2025-01-20','Cash'),
('ORD007','John Musa','Male','Abuja','Electronics','Laptop','2','350000','700000','2025-01-15','Card'),
('ORD008','Fatima Sule','Female','Kaduna','Groceries','Beans','','10000','50000','2025-01-21','Transfer'),
('ORD009','Ibrahim Lawal','Male','Lagos','Electronics','Tablet','1','','95000','2025-01-22','Card'),
('ORD010','Aisha Yusuf','Female','Kano','Fashion','Dress','4','15000','60000','2025-13-01','Cash');

SELECT * FROM sales_performance

DESCRIBE sales_performance;


SELECT order_id, customer_name,
 COUNT(*) AS duplicate_count
FROM sales_performance
GROUP BY order_id, customer_name
HAVING COUNT(*) > 1;

SELECT *
FROM sales_performance
WHERE region = ''
   OR quantity = ''
   OR unit_price = '';

CREATE TABLE cleaned_sales_performance AS
SELECT * FROM sales_performance;

SELECT customer_name, product_name, order_date, COUNT(*) AS total_duplicates
FROM cleaned_sales_performance
GROUP BY customer_name, product_name, order_date
HAVING COUNT(*) > 1;

SET SQL_SAFE_UPDATES = 0;

DELETE c1
FROM cleaned_sales_performance c1
JOIN cleaned_sales_performance c2
ON c1.customer_name = c2.customer_name
AND c1.product_name = c2.product_name
AND c1.order_date = c2.order_date
AND c1.order_id > c2.order_id;

SET SQL_SAFE_UPDATES = 1;

SELECT * FROM cleaned_sales_performance;

UPDATE cleaned_sales_performance
SET region = TRIM(region);

UPDATE cleaned_sales_performance
SET region = 'Abuja'
WHERE region IN ('Abj', 'ABUJA');

SELECT DISTINCT region
FROM cleaned_sales_performance;

SELECT *
FROM cleaned_sales_performance
WHERE region = '';

UPDATE cleaned_sales_performance
SET region = 'Unknown'
WHERE region = '';

SELECT *
FROM cleaned_sales_performance
WHERE quantity = '';

UPDATE cleaned_sales_performance
SET quantity = '1'
WHERE quantity = '';

SELECT * 
FROM cleaned_sales_performance
WHERE unit_price = '';

UPDATE cleaned_sales_performance
SET unit_price = '95000'
WHERE unit_price = '';


USE sales_performance;

SHOW TABLES;


SELECT order_date
FROM cleaned_sales_performance;

UPDATE cleaned_sales_performance
SET order_date = REPLACE(order_date,
'/', '-');


UPDATE cleaned_sales_performance
SET order_date =
STR_TO_DATE(order_date, '%d-%m-%Y')
WHERE order_date LIKE '__-__-____';

UPDATE cleaned_sales_performance
SET order_date = '2025-01-13'
WHERE order_date = '2025-13-01';


ALTER TABLE cleaned_sales_performance
MODIFY quantity INT,
MODIFY unit_price DECIMAL(10,2),
MODIFY sales_amount DECIMAL(10,2),
MODIFY order_date DATE;


SELECT * FROM cleaned_sales_performance;

### BUSINES ANALYSIS QUERIES

### Total Revenue
SELECT SUM(sales_amount) AS
total_revenue 
FROM cleaned_sales_performance;


### Top Performing Region
SELECT region,
SUM(sales_amount) AS total_sales
FROM cleaned_sales_performance
GROUP BY region 
ORDER BY total_sales DESC;


### Best Selling Product Category
SELECT product_category,
SUM(sales_amount) AS total_sales
FROM cleaned_sales_performance
GROUP BY product_category
ORDER BY total_sales DESC;


### Top Customers
SELECT customer_name,
SUM(sales_amount) AS total_spent
FROM cleaned_sales_performance
GROUP BY customer_name
ORDER BY total_spent DESC;


### Payment Method Analysis
SELECT payment_method, 
COUNT(*) AS total_transactions
FROM cleaned_sales_performance
GROUP BY payment_method;


### Monthly Sales Trend
SELECT MONTH(order_date) AS
sales_month,
SUM(sales_amount) AS monthly_sales
FROM cleaned_sales_performance
GROUP BY sales_month;


SELECT *
FROM cleaned_sales_performance;








