-- Сортировка --

-- ASC - сортировка по возрастанию (работает с ORDER BY по умолчанию)
-- DESC - сортировка по убыванию

SELECT * FROM users
ORDER BY birthday DESC;

SELECT * FROM (
  SELECT *, extract(years from age(birthday)) AS age FROM users 
  ) AS "test"
  ORDER BY age;


-- пользователи с одинаковой датой рождения группируются и внутри своей группы не сортируются
UPDATE users
SET birthday = '1988-07-27'
WHERE id BETWEEN 250 AND 260;  

SELECT * FROM users
WHERE id BETWEEN 250 AND 260
ORDER BY birthday DESC;

-- дополнительная сортировка внутри такой группы --->
SELECT * FROM users
ORDER BY birthday,
         first_name ASC;

-- можно указать и более 2 принципов сортировки         
--------------------------------------------------------


-- отбираем 3 позиции с наименьшим количеством
SELECT * FROM products
ORDER BY quantity ASC
LIMIT 3;


/*
1. Відсортувати юзерів за віком (кількістю повних років)
2. Відсортуйте телефони за ціною, від найдорожчого до найдешевшого
3. Виведіть топ-5 телефонів, які частіше за все купують (більше за все продано)
4*. Знайти кількість однорічок (кількість юзерів з однаковою кількістю повних років)
*/

--1 
SELECT * FROM (
  SELECT *, extract(years from age(birthday)) AS age 
  FROM users 
) AS "table_with_age"
ORDER BY "table_with_age".age;

--2
SELECT * FROM products
ORDER BY price DESC;

--3
SELECT product_id, sum(quantity) 
FROM orders_to_products
GROUP BY product_id
ORDER BY sum(quantity) DESC
LIMIT 5;

--4
/* нужно переделать
SELECT * FROM (
  SELECT *, extract(years from age(birthday)) AS age FROM users 
) AS "table_with_age"
count(*) GROUP BY "table_with_age".age;
*/

-- вариант без подзапроса
SELECT count(*), extract(years from age(birthday)) AS age
FROM users
GROUP BY age
ORDER BY age;

SELECT count(*) AS count, extract(years from age(birthday)) AS age
FROM users
GROUP BY age
ORDER BY count DESC;


--- HAVING ---

-- получить всех юзеров, 
SELECT count(*), extract(years from age(birthday)) AS age
FROM users
GROUP BY age
HAVING count(*) >= 6
ORDER BY age;


SELECT sum(quantity), brand
FROM products
GROUP BY brand
HAVING sum(quantity) > 5000;


SELECT product_id, sum(quantity)
FROM orders_to_products
GROUP BY product_id
HAVING sum(quantity) > 50;
