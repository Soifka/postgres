-- Alias ("псевдонимы для колонок/таблиц") --
-- Псевдоним нужно писать в кавычках, если он не на английском языке; если
-- на английском, то можно без кавычек

SELECT *, extract(years from age(birthday)) AS age FROM users
WHERE extract(years from age(birthday)) BETWEEN 20 AND 40;

SELECT 
first_name AS "Имя", 
last_name AS "Фамилия", 
id AS "Личный номер" 
FROM users;

SELECT * FROM orders_to_products AS "Чек"  --> псевдонимы для таблиц используются в подзапросах