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