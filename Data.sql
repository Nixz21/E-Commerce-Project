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