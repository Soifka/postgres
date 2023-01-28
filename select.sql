-- "склеивание" столбцов
SELECT id, first_name || ' ' || last_name AS "full name" FROM users;

-- "склеивание" столбцов с помощью функции concat
SELECT id, concat(first_name, ' ', last_name) AS "full name" FROM users;


-- функция char_length возвращает количество символов в строке

/*
Task
Найти всех юзеров, полное имя (имя + фамилия) которых больше 10 символов
*/

--> решение (вариант 1)
SELECT * FROM users WHERE char_length(concat(first_name, ' ', last_name)) > 10;

-- или
SELECT id, concat(first_name, ' ', last_name) AS "full name" 
FROM users
WHERE char_length(concat(first_name, ' ', last_name)) > 10;

--> решение (вариант 2) с использованием подзапроса
SELECT * 
FROM (
    SELECT id, concat(first_name, ' ', last_name) AS "full name"
    FROM users   --> получаем табличное выражение
) AS "FN"   --> табличному выражению нужно обязательно присвоить alias
WHERE char_length("FN"."full name") > 10;