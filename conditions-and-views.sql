--- получаем всех пользователей (в том числе тех, которые заказов не делали) и количество их заказов 
SELECT u.*, count(o.id) AS orders_amount
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.email
ORDER BY orders_amount; 

--- создаем представление (VIEW); это как бы виртуальная таблица
CREATE VIEW users_with_orders_amount AS (
    SELECT u.*, count(o.id) AS orders_amount
    FROM users AS u
    LEFT JOIN orders AS o
    ON u.id = o.customer_id
    GROUP BY u.id, u.email
    ORDER BY orders_amount 
);

--- далее обращаемся к представлению как к обычной таблице
SELECT * FROM users_with_orders_amount;

--- Вытащить email все юзеров, которые имеют один заказ
SELECT email FROM users_with_orders_amount
WHERE orders_amount = 1;


---- ключевое слово REPLACE позволяет перезаписать представление при необходимости
--> например, если поменялась структура таблиц
CREATE OR REPLACE VIEW users_with_orders_amount AS (
    SELECT u.*, count(o.id) AS orders_amount
    FROM users AS u
    LEFT JOIN orders AS o
    ON u.id = o.customer_id
    GROUP BY u.id, u.email
    ORDER BY orders_amount 
);


----- TASKS (views) -----

---1  Сделать представление, которое хранит заказы с их стоимостью ---

CREATE OR REPLACE VIEW orders_with_their_cost AS (
    SELECT otp.order_id, sum(p.price * otp.quantity) AS order_cost
    FROM products AS p
    JOIN orders_to_products AS otp
    ON p.id = otp.product_id
    GROUP BY otp.order_id 
);

--- mentor's resolve ---
CREATE VIEW orders_with_price AS (
    SELECT o.id, o.customer_id, sum(p.price * otp.quantity) AS order_sum, o.status
    FROM orders AS o
    JOIN orders_to_products AS otp
    ON o.id = otp.order_id
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY o.id
);
-------------------------------

---2  Вывести юзеров с суммой, которую они потратили в нашем магазине
SELECT u.*, sum(owtc.order_cost) AS customer_orders_cost
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id 
JOIN orders_with_their_cost AS owtc
ON o.id = owtc.order_id
GROUP BY u.id;


--- mentor's resolve ---
SELECT u.id, u.email, sum(owp.order_sum)
FROM users AS u
JOIN orders_with_price AS owp 
ON u.id = owp.customer_id
GROUP BY u.id;

----------------------------------

--- уже существующие VIEW можно использовать при создании других VIEW ---
CREATE OR REPLACE VIEW users_with_orders_cost AS (
    SELECT u.*, sum(owtc.order_cost) AS customer_orders_cost
    FROM users AS u
    JOIN orders AS o
    ON u.id = o.customer_id 
    JOIN orders_with_their_cost AS owtc
    ON o.id = owtc.order_id
    GROUP BY u.id
);

--- топ-10 покупателей, потративших в нашем магазине наибольшую сумму денег
SELECT * FROM users_with_orders_cost
ORDER BY customer_orders_cost DESC
LIMIT 10;