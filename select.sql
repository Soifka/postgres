SELECT * FROM users;

SELECT id, first_name FROM users;

SELECT id, last_name FROM users WHERE id > 15 AND id < 26;

SELECT id, first_name, is_subscribe FROM users WHERE is_subscribe = true;

/*
Это отработает точно так же, как предыдущая строка

SELECT id, first_name, is_subscribe FROM users WHERE is_subscribe
*/

SELECT * FROM users WHERE height IS NOT NULL;

SELECT * FROM users WHERE id % 2 = 0;

SELECT * FROM users WHERE height > 1.5;

SELECT * FROM users WHERE gender = 'male' AND is_subscribe;