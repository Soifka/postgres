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


--- юзеры и количество их заказов ---

SELECT count(*), u.* 
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id;

--- LEFT JOIN ---

-- найти всех пользователей, которые не делали заказы -->

SELECT * FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
WHERE o.customer_id IS NULL;

-- вариант с вычитанием -->
SELECT *
FROM users
WHERE id IN (
  SELECT id FROM users
  EXCEPT
  SELECT customer_id FROM orders
);

-------------------------------------------

--- Task 31.01.2023 ---

INSERT INTO products (
    brand,
    model,
    category,
    price,
    quantity
  )
VALUES (
    'LG',
    'model 1',
    'phones',
    1500,
    5
  );


--- Знайдіть всі телефони, які ніхто ніколи не купував --->
SELECT * FROM products AS p
LEFT JOIN orders_to_products AS otp
ON p.id = otp.product_id
WHERE otp.order_id IS NULL;


/*
1. Знайти повну вартість кожного замовлення.
2. Знайти кількість позицій в кожному замовленні.
3. Знайти найпопулярніший товар.
4. Прорахувати середній чек по всьому магазину.
5. Витягти всі замовлення вище середнього чека.
6. Витягти всіх користувачів, в яких кількість замовлень вище середньої.
7. Витягти користуачів та кількість телефонів, які вони замовляли (кількість замовлень * quantity)
*/


--1  Знайти повну вартість кожного замовлення.
SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY otp.order_id
ORDER BY otp.order_id;


--2  Знайти кількість позицій в кожному замовленні.
SELECT order_id, sum(quantity) AS products_in_order
FROM orders_to_products
GROUP BY order_id
ORDER BY order_id;


--3  Знайти найпопулярніший товар.
SELECT otp.product_id, concat(p.brand, ', ', p.model) AS product_name, sum(otp.quantity) AS total_sold
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY otp.product_id, product_name
ORDER BY total_sold DESC
LIMIT 3;

--- решение с подзапросом ---
SELECT bestsellers.product_id, products.brand, products.model, bestsellers.total_sold 
FROM (
  SELECT product_id, sum(quantity) AS total_sold
  FROM orders_to_products
  GROUP BY product_id
  ORDER BY total_sold DESC
  LIMIT 3
) AS bestsellers
LEFT JOIN products
ON bestsellers.product_id = products.id
ORDER BY total_sold DESC;

--- mentor's resolve ---
SELECT p.id, p.brand, p.model, sum(otp.quantity) AS total_sold
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY p.id
ORDER BY total_sold DESC
LIMIT 1;
-----------------------


--4  Прорахувати середній чек по всьому магазину.
SELECT avg(subquery.order_price) AS average_order_price 
FROM (
  SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
  FROM products AS p
  JOIN orders_to_products AS otp
  ON p.id = otp.product_id
  GROUP BY otp.order_id
) AS subquery;


--5  Витягти всі замовлення вище середнього чека.  !!!!!!!!!!!!
SELECT subquery.* FROM (
  SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
  FROM products AS p
  JOIN orders_to_products AS otp
  ON p.id = otp.product_id
  GROUP BY otp.order_id
) AS subquery
WHERE subquery.order_price > avg(subquery.order_price);

--- mentor's resolve ---
SELECT subquery.*
FROM (
  SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
  FROM products AS p
  JOIN orders_to_products AS otp
  ON p.id = otp.product_id
  GROUP BY otp.order_id
) AS subquery
WHERE subquery.order_price > (
  SELECT avg(subquery.order_price) 
  FROM (
    SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
    FROM products AS p
    JOIN orders_to_products AS otp
    ON p.id = otp.product_id
    GROUP BY otp.order_id
  ) AS subquery
);

/*

WITH ...alias... AS table
SELECT.......

*/

WITH owc AS (
  SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
  FROM products AS p
  JOIN orders_to_products AS otp
  ON p.id = otp.product_id
  GROUP BY otp.order_id
)
SELECT owc.*
FROM owc
WHERE owc.order_price > (
  SELECT avg(owc.order_price) 
  FROM owc
);
-------------------------------


--6  Витягти всіх користувачів, в яких кількість замовлень вище середньої.
--- mentor's resolve ---
WITH orders_with_counts AS (
  SELECT customer_id, count(*) AS orders_count
  FROM orders
  GROUP BY customer_id
)
SELECT users.id, users.first_name, users.last_name, orders_with_counts.orders_count
FROM orders_with_counts
JOIN users
ON users.id = orders_with_counts.customer_id
WHERE orders_with_counts.orders_count > (
  SELECT avg(orders_with_counts.orders_count)
  FROM orders_with_counts
);


--7  Витягти користуачів та кількість телефонів, які вони замовляли (кількість замовлень * quantity)
SELECT u.id, concat(u.first_name, ' ', u.last_name) AS customer_name, sum(subquery.products_in_order) AS total_products_bought
FROM (
  SELECT o.id AS order_id, o.customer_id, sum(otp.quantity) AS products_in_order
  FROM orders AS o
  JOIN orders_to_products AS otp
  ON o.id = otp.order_id
  GROUP BY o.id, o.customer_id
  ORDER BY o.customer_id
) AS subquery
JOIN users AS u
ON u.id = subquery.customer_id
GROUP BY u.id, customer_name;


--- mentor's resolve ---
SELECT u.id, u.first_name, u.last_name, sum(otp.quantity)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
GROUP BY u.id;