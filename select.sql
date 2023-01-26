SELECT * FROM users;

SELECT id, first_name FROM users;

SELECT id, last_name FROM users WHERE id >= 15 AND id <= 26;

/* другой способ ---> (id 15 и 26 будут включены в ответ на SELECT) */
SELECT * FROM users WHERE id BETWEEN 15 AND 26;

SELECT id, first_name, is_subscribe FROM users WHERE is_subscribe = true;

/*
Это отработает точно так же, как предыдущая строка

SELECT id, first_name, is_subscribe FROM users WHERE is_subscribe
*/

SELECT * FROM users WHERE height IS NOT NULL;

SELECT * FROM users WHERE id % 2 = 0;

SELECT * FROM users WHERE height > 1.5;

SELECT * FROM users WHERE gender = 'male' AND is_subscribe;

SELECT * FROM users WHERE first_name = 'Laura';


SELECT * FROM users WHERE first_name IN ('Anton', 'Laura', 'Mali', 'Eino');

SELECT * FROM users WHERE id BETWEEN 170 AND 200;

-----------------

/*

для шаблонов поиска:
% --> заменяет любое количество любых символов
_ --> заменяет один любой символ

*/

SELECT * FROM users WHERE first_name LIKE 'A%';
SELECT * FROM users WHERE first_name LIKE '____';
SELECT * FROM users WHERE first_name LIKE 'M___';
SELECT * FROM users WHERE first_name LIKE '%a';

-----------------

ALTER TABLE users ADD COLUMN weight int CHECK (weight > 0);

UPDATE users SET weight = 60;

UPDATE users SET weight = 90 WHERE gender = 'male';

UPDATE employees SET salary = salary * 1.2 WHERE work_hours > 150;

INSERT INTO users (
    first_name,
    last_name,
    email,
    gender,
    is_subscribe,
    birthday,
    foot_size,
    height,
    weight
  )
VALUES (
    'Bill',
    'Zubik',
    'mail@mail',
    'male',
    true,
    '1988-01-25',
    43,
    1.85,
    88
  ) RETURNING id;

  UPDATE users SET weight = 90 WHERE id = 270 RETURNING *;

  DELETE FROM users WHERE id = 270 RETURNING first_name;

