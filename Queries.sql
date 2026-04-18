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