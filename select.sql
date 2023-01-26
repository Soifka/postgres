SELECT id, first_name, last_name, birthday, age(birthday) FROM users;

SELECT id, first_name, last_name, birthday, EXTRACT("years" FROM AGE(birthday)) FROM users;

SELECT id, first_name, last_name, birthday, make_interval(19, 8) FROM users WHERE id = 270;

/*

1. Отримати всіх повнолітніх користувачів чоловічої статі.

2. Отримати всіх користувачів-жінок, ім'я яких починається на "А".

3. Отримати всіх користувачів, вік яких від 20 до 40 років.

4. Отримати всіх користувачів, які народились у вересні.

5. Всім користувачам, які народились 6 листопада, змінити підписку на true.

6. Отримати всіх користувачів, які старші за 65 років.

7. Всім користувачам чоловічого роду віком 40 до 50 років встановити вагу = 95.

*/


--1 

SELECT *, EXTRACT(years FROM AGE(birthday)) as age FROM users WHERE gender = 'male' AND EXTRACT(years FROM AGE(birthday)) >= 70;

--2

SELECT * FROM users WHERE gender = 'female' AND first_name LIKE 'A%';

--3

SELECT *, EXTRACT(years FROM AGE(birthday)) as age FROM users WHERE EXTRACT(years FROM AGE(birthday)) BETWEEN 20 AND 40;

--4

SELECT * FROM users WHERE EXTRACT(month from birthday) = 9;

--5

UPDATE users SET is_subscribe = true WHERE EXTRACT(month from birthday) = 11 AND EXTRACT(day from birthday) = 6;
SELECT * FROM users WHERE EXTRACT(month from birthday) = 11 AND EXTRACT(day from birthday) = 6;

--6

SELECT *, EXTRACT(years FROM AGE(birthday)) as age FROM users WHERE EXTRACT(years FROM AGE(birthday)) > 65;

--7

UPDATE users SET weight = 95 WHERE gender = 'male' AND EXTRACT(years from age(birthday)) BETWEEN 40 AND 50;
SELECT * FROM users WHERE gender = 'male' AND EXTRACT(years from age(birthday)) BETWEEN 40 AND 50;