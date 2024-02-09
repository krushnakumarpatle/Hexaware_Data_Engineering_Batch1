CREATE DATABASE SQL_Coding_Challenge;
USE SQL_Coding_Challenge;

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10, 2)
);

CREATE TABLE order_details (
    detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(8, 2),
    FOREIGN KEY(order_id) REFERENCES orders(order_id)
);

INSERT INTO orders VALUES (1, 101, '2022-01-01', 150.00);
INSERT INTO orders VALUES (2, 102, '2022-01-02', 200.00);

INSERT INTO order_details VALUES (1, 1, 'Product A', 2, 50.00);
INSERT INTO order_details VALUES (2, 1, 'Product B', 3, 30.00);
INSERT INTO order_details VALUES (3, 2, 'Product A', 1, 80.00);
INSERT INTO order_details VALUES (4, 2, 'Product C', 2, 60.00);

-- Over and Partition by Clause
SELECT
    order_id,
    product_name,
    quantity,
    SUM(quantity) OVER (PARTITION BY order_id) AS total_quantity
FROM
    order_details;
    
-- Calculate subtotal for each order
SELECT
    order_id,
    SUM(quantity) AS total_quantity,
    SUM(price * quantity) AS subtotal_amount
FROM
    order_details
GROUP BY
    order_id;
    
-- Calculate total quantity and total amount for all orders
SELECT
    SUM(quantity) AS total_quantity,
    SUM(price * quantity) AS total_amount
FROM
    order_details;
    
-- INNER JOIN:
SELECT
    o.order_id,
    od.product_name,
    od.quantity
FROM
    orders o
INNER JOIN
    order_details od ON o.order_id = od.order_id;
    
-- LEFT JOIN: 
SELECT
    o.order_id,
    od.product_name,
    od.quantity
FROM
    orders o
LEFT JOIN
    order_details od ON o.order_id = od.order_id;
   
-- RIGHT JOIN
SELECT
    o.order_id,
    od.product_name,
    od.quantity
FROM
    orders o
RIGHT JOIN
    order_details od ON o.order_id = od.order_id;
    
-- CROSS JOIN: 
SELECT
    o.order_id,
    od.product_name,
    od.quantity
FROM
    orders o
CROSS JOIN
    order_details od;
    
-- SELF JOIN: 
SELECT
    o1.order_id AS order1_id,
    o1.total_amount AS order1_total,
    o2.order_id AS order2_id,
    o2.total_amount AS order2_total
FROM
    orders o1
JOIN
    orders o2 ON o1.total_amount > o2.total_amount;

-- FULL JOIN:
SELECT o.order_id, od.product_name, od.quantity
FROM orders o
LEFT JOIN order_details od ON o.order_id = od.order_id
UNION
SELECT o.order_id, od.product_name, od.quantity
FROM orders o
RIGHT JOIN order_details od ON o.order_id = od.order_id
WHERE o.order_id IS NULL;








    






