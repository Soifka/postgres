/*
Task

Створити таблицю workers:
- id
- name
- salary,
- birthday

1. Додайте робітника з ім'ям Олег, з/п 300
2. Додайте робітницю Ярославу, з/п 350
3. Додайте двох нових працівників одним запитом - 
    Сашу, з/п 1000
    Машу, з/п 200
4. Встановити Олегу з/п 500
5. Всім, у кого з/п більше 500, врізати з/п до 400
6. Вибрати всіх робітників, чия з/п більше 400
7. Вибрати робітника з id = 4
8. Дізнатися з/п та вік Жені
9. Знайти робітника з ім'ям "Petya"
10. Вибрати робітників у віці 27 років або з з/п > 800
11. Вибрати всіх робітників у віці від 25 до 28 років
12. Вибрати всіх співробітників, що народились у вересні
13. Видалити робітника з id = 4
14. Видалити Олега
15. Видалити всіх робітників старших за 30 років

*/

CREATE TABLE workers(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK(name != ''),
    salary int NOT NULL CHECK(salary > 0),
    date_of_birth date NOT NULL
);


INSERT INTO workers (name, salary, date_of_birth)
VALUES (
    'Evgenii',
    600,
    '1990-09-11'
  );

INSERT INTO workers (name, salary, date_of_birth)
VALUES(
    'Petya',
    850,
    '1984-12-07'
  );


--1 Додайте робітника з ім'ям Олег, з/п 300
INSERT INTO workers (name, salary, date_of_birth)
VALUES (
    'Oleg',
    300,
    '1979-05-13'
  );

--2 Додайте робітницю Ярославу, з/п 350
INSERT INTO workers (name, salary, date_of_birth)
VALUES (
    'Yaroslava',
    350,
    '1996-01-20'
  );  

--3 Додайте двох нових працівників одним запитом - Сашу, з/п 1000; Машу, з/п 200
INSERT INTO workers (name, salary, date_of_birth)
VALUES (
    'Sasha',
    1000,
    '1996-04-23'
  ),
  (
    'Masha',
    200,
    '1998-08-01'
  );

--4 Встановити Олегу з/п 500
UPDATE workers SET salary = 500 WHERE name = 'Oleg';

--5 Всім, у кого з/п більше 500, врізати з/п до 400
UPDATE workers SET salary = 400 WHERE salary > 500;

--6 Вибрати всіх робітників, чия з/п більше 400
SELECT * FROM workers WHERE salary > 400;

--7 Вибрати робітника з id = 4
SELECT * FROM workers WHERE id = 4;

--8 Дізнатися з/п та вік Жені
SELECT name, salary, extract(years from age(date_of_birth)) AS age FROM workers WHERE name = 'Evgenii';

--9 Знайти робітника з ім'ям "Petya"
SELECT * FROM workers WHERE name = 'Petya';

--10 Вибрати робітників у віці 27 років або з з/п > 800
SELECT * FROM workers WHERE extract(years from age(date_of_birth)) = 27 OR salary > 800;

--11 Вибрати всіх робітників у віці від 25 до 28 років
SELECT *, extract(years from age(date_of_birth)) AS age FROM workers WHERE extract(years from age(date_of_birth)) BETWEEN 25 AND 28;

--12 Вибрати всіх співробітників, що народились у вересні
SELECT * FROM workers WHERE extract(month from date_of_birth) = 9;

--- решение №12 с поздапросом ---
SELECT * FROM (
  SELECT *, extract(month from date_of_birth) AS "month_of_birth" FROM workers
) AS "subquery" WHERE month_of_birth = 9;

--13 Видалити робітника з id = 4
DELETE FROM workers WHERE id = 4;

--14 Видалити Олега
DELETE FROM workers WHERE name = 'Oleg';

--15 Видалити всіх робітників старших за 30 років
DELETE FROM workers WHERE extract(years from age(date_of_birth)) > 30
RETURNING *;
