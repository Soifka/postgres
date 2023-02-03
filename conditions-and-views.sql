ALTER TABLE orders
ADD COLUMN status boolean;

UPDATE orders 
SET status = true
WHERE id % 2 = 0;

UPDATE orders 
SET status = false
WHERE id % 2 != 0;

SELECT id, created_at, customer_id, status AS order_status   --> alias for attribute
FROM orders
ORDER BY id;


---- CASE ----

-- 1 syntax
CASE
    WHEN condition_1 = true
    THEN result_1
    WHEN condition_2 = true
    THEN result_2
    ......
    ELSE result
END;

/*
Вывести все заказы следующим образом:
- если status = true, написать "выполнен"
- если status = false, написать "новый заказ"
*/

SELECT id, created_at, customer_id, (
    CASE
        WHEN status = TRUE
        THEN 'выполнен'
        WHEN status = FALSE
        THEN 'новый заказ'
        ELSE 'другой статус'
    END    
) AS status
FROM orders
ORDER BY id;


-- 2 syntax
CASE condition WHEN value_1 THEN result_1
                WHEN value_2 THEN result_2
                ...........
                ELSE default_result
END;

/*
Вытащить месяц рождения юзера 
и на его основе вывести в какое время года родился юзер
*/

SELECT *, (
    CASE extract(month from birthday)
        WHEN 1 THEN 'winter'
        WHEN 2 THEN 'winter'
        WHEN 3 THEN 'spring'
        WHEN 4 THEN 'spring'
        WHEN 5 THEN 'spring'
        WHEN 6 THEN 'summer'
        WHEN 7 THEN 'summer'
        WHEN 8 THEN 'summer'
        WHEN 9 THEN 'autumn'
        WHEN 10 THEN 'autumn'
        WHEN 11 THEN 'autumn'
        WHEN 12 THEN 'winter'
        ELSE 'unknown'
    END
)
FROM users; 


/*
Вывести юзеров так, 
чтобы в поле гендер у них было указано "женщина", "мужчина" или "другое"
*/

--- syntax 2 ---
SELECT id, first_name, last_name, email, (
    CASE gender
        WHEN 'male' THEN 'мужчина'
        WHEN 'female' THEN 'женщина'
        ELSE 'другое'
    END    
) AS gender
FROM users
ORDER BY id;


/*
На основе возраста пользователя 
вывести в отдельной колонке, совершеннолетний он или нет
*/

--- syntax 1 ---
SELECT *, (
    CASE
        WHEN extract(years from age(birthday)) >= 18 
        THEN 'совершеннолетний'
        WHEN extract(years from age(birthday)) < 18 
        THEN 'несовершеннолетний'
        ELSE 'другое'
    END    
) AS "Совершеннолетие"
FROM users
ORDER BY id;


/*
Вывести пользователей с информацией об их заказах в следующем виде:
- если у пользователя 3 и более заказов, то он "постоянный клиент"
- если у пользователя от 1 до 3 заказов - "активный клиент"
- если 0 заказов, то "новый клиент"
*/

--- решение с WITH ---
WITH users_with_orders AS (
    SELECT u.*, count(*) AS orders_quantity
    FROM users AS u
    JOIN orders AS o  --> нужен именно LEFT JOIN
    ON u.id = o.customer_id
    GROUP BY u.id
)
SELECT *, (
    CASE
        WHEN users_with_orders.orders_quantity >= 3
        THEN 'постоянный клиент'
        WHEN users_with_orders.orders_quantity < 3 AND users_with_orders.orders_quantity > 0
        THEN 'активный клиент'
        ELSE 'новый клиент'
    END    
) AS customer_status
FROM users_with_orders;


------------
SELECT *, (
    CASE
        WHEN users_with_orders.orders_quantity >= 3
        THEN 'постоянный клиент'
        WHEN users_with_orders.orders_quantity < 3 AND users_with_orders.orders_quantity > 0
        THEN 'активный клиент'
        ELSE 'новый клиент'
    END    
) AS customer_status
FROM (
    SELECT u.*, count(*) AS orders_quantity
    FROM users AS u
    JOIN orders AS o  --> нужен именно LEFT JOIN
    ON u.id = o.customer_id
    GROUP BY u.id
) AS users_with_orders;


--- mentor's resolve ---
SELECT u.id, u.first_name, u.last_name, u.email, count(o.id), (
    CASE
        WHEN count(o.id) >= 3
        THEN 'постоянный клиент'
        WHEN count(o.id) BETWEEN 1 AND 2
        THEN 'активный клиент'
        WHEN count(o.id) = 0
        THEN 'новый клиент'
        ELSE 'клиент без статуса'
    END    
)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id, u.first_name, u.last_name, u.email;

-------------------------------------------------------------------------

INSERT INTO users (
    first_name,
    last_name,
    email,
    gender,
    is_subscribe,
    birthday
  )
VALUES (
    'Marsel',
    'Derby',
    'marsel@mail.com',
    'male',
    true,
    '2000-01-01'
);


SELECT u.id, u.first_name, u.last_name, u.email, count(o.id), (
    CASE
        WHEN count(o.id) >= 3
        THEN 'постоянный клиент'
        WHEN count(o.id) BETWEEN 1 AND 2
        THEN 'активный клиент'
        WHEN count(o.id) = 0
        THEN 'новый клиент'
        ELSE 'клиент без статуса'
    END    
)
FROM users AS u
LEFT JOIN orders AS o  --> нужен именно LEFT JOIN, чтобы получить и юзеров без заказов
ON u.id = o.customer_id
GROUP BY u.id, u.first_name, u.last_name, u.email
ORDER BY count(o.id);

-------------------------------------------------------------


--- Найти все телефоны, цена которых больше 3000 ---

--- v1
SELECT count(*)
FROM products
WHERE price > 3000;

--- v2
SELECT sum(
    CASE WHEN price > 3000 THEN 1
    ELSE 0
    END
)
FROM products;

------------------------------------

---- COALESCE ---- (заменяет NULL указанным значением)
SELECT COALESCE(NULL, 12, 24) ---> 12
       COALESCE(NULL, NULL, NULL) --> NULL


UPDATE products
SET description = 'Super smartphone. Real flagman'
WHERE id % 2 = 0;

SELECT id, brand, model, price, COALESCE(description, 'This model has not description')
FROM products;