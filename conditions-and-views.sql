--- ENUM ---
----- order status -->
-- true - заказ выполнен
-- false - заказ не выполнен


--- получим все выполненные заказы ---

SELECT * FROM orders
WHERE status = true;


DROP VIEW users_with_orders_cost;
DROP VIEW users_with_orders_amount;
DROP VIEW orders_with_their_cost;
DROP VIEW orders_with_price;
 

--- создадим новы тип данных для поля status, чтобы добавить вариантов для статуса заказа -->
-- (new, processing, shiped, done)

CREATE TYPE order_status AS ENUM('new', 'processing', 'shiped', 'done');

ALTER TABLE orders
ALTER COLUMN status TYPE order_status;  --> этот вариант не сработает


ALTER TABLE orders
ALTER COLUMN status TYPE order_status
USING(
    CASE status
    WHEN false THEN 'processing'
    WHEN true THEN 'done'
    ELSE 'new'
    END
)::order_status;

--- ::order_status --> это CAST, приведение типов данных


INSERT INTO orders (customer_id, status) VALUES 
(255, 'new');

SELECT * FROM orders
WHERE customer_id = 255;

UPDATE orders
SET status = 'shiped'
WHERE id = 611;

SELECT * FROM orders
WHERE id = 611;