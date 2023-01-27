-- найти максимальный вес
SELECT max(weight) FROM users;

-- найти минимальный вес
SELECT min(weight) FROM users;

-- найти сумму веса всех юзеров
SELECT sum(weight) FROM users;

-- найти средний вес
SELECT avg(weight) FROM users;

-- найти количество записей в таблице
SELECT count(id) FROM users;

-- найти средний вес по группам пользователей
SELECT gender, avg(weight) FROM users
GROUP BY gender;

-- средний вес юзеров, которые родились после 1970 года
SELECT avg(weight) 
FROM users
WHERE extract(years from birthday) > 1970;

-- средний вес мужчин, которым 27 лет
SELECT avg(weight) 
FROM users
WHERE extract(years from age(birthday)) = 27 AND gender = 'male';

-- средний возраст всех пользователей
SELECT avg(extract(years from age(birthday))) 
FROM users;

-- минимальный и максимальный возраст пользователей
SELECT min(extract(years from age(birthday))), max(extract(years from age(birthday))) 
FROM users;

-- минимальный и максимальный возраст пользователей (отдельно мужчин и женщин)
SELECT gender, min(extract(years from age(birthday))), max(extract(years from age(birthday))) 
FROM users
GROUP BY gender;

-- кол-во пользователей-мужчин
SELECT count(id)
FROM users
WHERE gender = 'male';

-- кол-во пользователей (отдельно мужчин и женщин)
SELECT gender, count(id)
FROM users
GROUP BY gender;