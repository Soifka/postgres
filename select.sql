/*
----- Task 30.01.2023 -----

1. Порахувати кількість телефонів, які були продані
(тобто сума всіх кількостей в замовлннях)

2. Кількість телефонів, які "є на складі"
(мається на увазі кількість телефонів саме в products)

3. Середня ціна всіх телефонів

4. Середня ціна кожного бренду

5. Сума вартості всіх телефонів, які коштують в діапазоні від 1к до 2к

6. Кількість моделей кожного бренду

7. Кількість замовлень кожного користувача, який робив замовлення
(це по ордерсам і згрупувати по id користувача)

8. Середня ціна Huawei
*/


--1
SELECT sum(quantity) FROM orders_to_products; 

--2
SELECT sum(quantity) FROM products;

--3
SELECT avg(price) FROM products;

--4
SELECT brand, avg(price) FROM products
GROUP BY brand;

--5
SELECT sum(quantity * price) FROM products
WHERE price BETWEEN 1000 AND 2000;

--6
SELECT brand, count(*) FROM products
GROUP BY brand;

--7
SELECT customer_id, count(*) FROM orders
GROUP BY customer_id;

--8
SELECT avg(price) FROM products
WHERE brand = 'Huawei';


