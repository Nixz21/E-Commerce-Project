# E-commerce Database Tasks

This repository contains my work for the mentorship tasks on basic e-commerce database design.

## Files
- `ERD.png`
- `Tables.sql`
- `Data.sql`
- `Queries.sql`

## Entity Relationships
- Category to Product = One-to-Many
- Customer to Orders = One-to-Many
- Orders to Product = Many-to-Many through
- Orders to Order_details = One-to-Many
- Product to Order_details = One-to-Many

## ER Diagram
![ER Diagram](ERDiagram.png)

## Table Creation Script

```sql
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    product_id SERIAL PRIMARY KEY,
    category_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price NUMERIC(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price NUMERIC(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

```
## Sample Data
```sql
INSERT INTO category (category_name) VALUES
('Electronics'),
('Clothing');

INSERT INTO product (category_id, name, description, price, stock_quantity) VALUES
(1, 'Laptop', 'Gaming laptop', 450.00, 10),
(1, 'Mouse', 'Wireless mouse', 20.00, 50),
(2, 'T-Shirt', 'Cotton shirt', 15.00, 100);

INSERT INTO customer (first_name, last_name, email, password) VALUES
('Ali', 'Ahmed', 'ali@example.com', 'pass123'),
('Sara', 'Mohammed', 'sara@example.com', 'pass456');

INSERT INTO orders (customer_id, order_date, total_amount) VALUES
(1, '2026-04-10', 470.00),
(2, '2026-04-10', 30.00),
(1, '2026-04-15', 520.00);

INSERT INTO order_details (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 450.00),
(1, 2, 1, 20.00),
(2, 3, 2, 15.00),
(3, 1, 1, 450.00),
(3, 2, 1, 70.00);
```
## Queries
```sql
-- daily report of the total revenue for a specific date.
SELECT order_date, SUM(total_amount) AS daily_total_revenue
FROM orders
WHERE order_date = '2026-04-10'
GROUP BY order_date;

-- monthly report of the top-selling products in a given month.
SELECT 
    p.product_id,
    p.name AS product_name,
    SUM(od.quantity) AS total_quantity_sold
FROM product p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
WHERE o.order_date >= '2026-04-01'
  AND o.order_date < '2026-05-01'
GROUP BY p.product_id, p.name
ORDER BY total_quantity_sold DESC;

-- customers who have placed orders totaling more than $500 in the past month.
SELECT
    c.customer_id,
    c.first_name || ' ' || c.last_name AS customer_name,
    SUM(o.total_amount) AS total_order_amount
FROM customer c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date >= CURRENT_DATE - INTERVAL '1 month'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING SUM(o.total_amount) > 500;
```
## Denormalization
We can apply denormalization between Customer and Orders by storing some customer information, such as first_name, last_name, or email, directly in the Orders table in addition to customer_id. This reduces the need for joins when generating reports and can improve read performance. However, it increases data redundancy and may cause update inconsistency if customer information changes.
