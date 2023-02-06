--- Подзапросы ---
--- IN, NOT IN, SOME, ANY, EXISTS, ALL ---

/*
Найти всех пользователей, которые делали заказы
*/

SELECT * FROM users AS u
WHERE u.id IN (
    SELECT customer_id FROM orders
);


/*
Найти всех пользователей, которые не делали никаких заказов
*/

SELECT * FROM users AS u
WHERE u.id NOT IN (
    SELECT customer_id FROM orders
);

/*
Найти телефоны, которые никто не заказывал
*/

SELECT * FROM products AS p
WHERE p.id NOT IN (
    SELECT product_id FROM orders_to_products
);


---- EXISTS ----> возвращает значение boolean

-- этот SELECT вернет всю инфу о юзере с id = 250
SELECT * FROM users
WHERE id = 250;

-- этот SELECT вернет true
SELECT EXISTS
(SELECT * FROM users
WHERE id = 250);


/*
Найти всех пользователей, которые делали заказы
*/
SELECT * FROM users AS u
WHERE EXISTS
(
    SELECT * FROM orders AS o
    WHERE u.id = o.customer_id
);

--> проверяем, делал ли какой-то конкретный юзер заказы
SELECT EXISTS
(SELECT * FROM orders AS o
WHERE o.customer_id = 255);


--- SOME, ANY ---
/*
Найти всех пользователей, которые делали заказы
*/
SELECT * FROM users AS u
WHERE u.id = ANY (
    SELECT customer_id FROM orders
);

SELECT * FROM users AS u
WHERE u.id = SOME (
    SELECT customer_id FROM orders
);


---- ALL --> возвращает true, если все строки соответствуют условию
/*
Найти телефоны, которые никто не заказывал
*/

SELECT * FROM products AS p
WHERE p.id != ALL (
    SELECT product_id FROM orders_to_products
);


---- TASK ----
/*
Найти все телефоны, которые покупал пользователь с id = 260
*/

WITH all_orders AS (
    SELECT * FROM orders
    WHERE customer_id = 260
)
SELECT * FROM products
WHERE id IN (
    SELECT otp.product_id FROM orders_to_products AS otp 
    WHERE otp.order_id IN (
    SELECT id FROM all_orders
    )
);

--- mentor's resolve ---
SELECT * FROM products AS p
WHERE p.id = ANY (
    SELECT product_id FROM orders_to_products AS otp
    WHERE order_id = SOME (
        SELECT id FROM orders AS o 
        WHERE customer_id = 260
    )
);

--- решение с JOIN --->
SELECT * FROM products AS p
JOIN orders_to_products AS otp
ON otp.product_id = p.id
JOIN orders AS o
ON otp.order_id = o.id
WHERE o.customer_id = 260;

-------------------------