CREATE TABLE A
(
  v char(3),
  t int
);

CREATE TABLE B
(
  v char(3)
);

INSERT INTO A VALUES
('xxx', 1),
('xxy', 1),
('xxz', 1),
('xyx', 2),
('xyy', 2),
('xyz', 2),
('yxx', 3),
('yxy', 3),
('yxz', 3);


INSERT INTO B VALUES
('zxx'), ('xxx'), ('zxz'), ('yxz'), ('xyx');

SELECT * FROM A, B;


--- UNION - объединение ---
--> (результат содержит: все из А + все из В + общее для А и В (то, что есть и там, и там) в одном экземпляре) ---

--- INTERSECT - пересечение ---
--> (результат содержит: общее для А и В в одном экземпляре) ---

--- MINUS - вычитание ---
--> (при вычитании А из В результат содержит: все из А кроме того, что является общим для А и В) ---


--- UNION ---
SELECT v FROM A
UNION
SELECT * FROM B; 

--- INTERSECT ---
SELECT v FROM A
INTERSECT
SELECT * FROM B; 

--- MINUS ---
SELECT v FROM A
EXCEPT
SELECT * FROM B; 


INSERT INTO users (
    first_name,
    last_name,
    email,
    gender,
    is_subscribe,
    birthday
  )
VALUES (
    'Barbara',
    'Lion',
    'null@email.com',
    'female',
    true,
    '1984-03-27'
  ),
  (
    'George',
    'Michael',
    'geo@mail.com',
    'male',
    false,
    '1979-01-18'
  ),
  (
    'Lina',
    'Kodi',
    'kodi@mail.com',
    'female',
    true,
    '1993-06-15'
  );

--- найти id юзеров, которые делали заказы
SELECT id FROM users
INTERSECT
SELECT customer_id FROM orders;


--- найти id юзеров, которые никогда не делали заказы
SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders;


------------------------------------

-- соединение таблиц --
SELECT * FROM A, B
WHERE A.v = B.v;

SELECT A.v AS "id", A.t AS "price", B.v AS "phone_id" FROM A, B
WHERE A.v = B.v;

--> можно сократить с помощью JOIN
SELECT * 
FROM A JOIN B
ON A.v = B.v;


--- найти все заказы юзера, у которого id = 181 ---

SELECT * FROM users
JOIN orders
ON users.id = orders.customer_id
WHERE users.id = 181;

--- то же самое с использованием alias ---
SELECT u.*, o.id AS "order_id" FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
WHERE u.id = 181;


-----------------------------

SELECT * 
FROM A 
JOIN B ON A.v = B.v
JOIN products ON A.t = products.id - 400;


--- найти id всех заказов, в которых были заказаны телефоны Huawei ---

SELECT *
FROM products
JOIN orders_to_products
ON products.id = orders_to_products.product_id
WHERE products.brand = 'Huawei';

--- то же самое с использованием alias ---
SELECT *
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
WHERE p.brand = 'Huawei';

--- посчитать количество заказов, в которых были заказаны телефоны Huawei --- 
SELECT count(*)
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
WHERE p.brand = 'Huawei';

--- какой бренд продавался чаще всего (топ продаж) ---
SELECT p.brand, count(*) AS "quantity"
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY p.brand
ORDER BY "quantity" DESC;