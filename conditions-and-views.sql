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
