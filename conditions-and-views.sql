ALTER TABLE orders
ADD COLUMN status boolean;

UPDATE orders 
SET status = true
WHERE id % 2 = 0;

UPDATE orders 
SET status = false
WHERE id % 2 != 0;

SELECT id, created_at, customer_id, status AS order_status   --> alias for attribute
FROM orders
ORDER BY id;


---- CASE ----

-- 1 syntax
CASE
    WHEN condition_1 = true
    THEN result_1
    WHEN condition_2 = true
    THEN result_2
    ......
    ELSE result
END;

/*
Вывести все заказы следующим образом:
- если status = true, написать "выполнен"
- если status = false, написать "новый заказ"
*/

SELECT id, created_at, customer_id, (
    CASE
        WHEN status = TRUE
        THEN 'выполнен'
        WHEN status = FALSE
        THEN 'новый заказ'
        ELSE 'другой статус'
    END    
) AS status
FROM orders
ORDER BY id;


-- 2 syntax
CASE condition WHEN value_1 THEN result_1
                WHEN value_2 THEN result_2
                ...........
                ELSE default_result
END;

/*
Вытащить месяц рождения юзера 
и на его основе вывести в какое время года родился юзер
*/

SELECT *, (
    CASE extract(month from birthday)
        WHEN 1 THEN 'winter'
        WHEN 2 THEN 'winter'
        WHEN 3 THEN 'spring'
        WHEN 4 THEN 'spring'
        WHEN 5 THEN 'spring'
        WHEN 6 THEN 'summer'
        WHEN 7 THEN 'summer'
        WHEN 8 THEN 'summer'
        WHEN 9 THEN 'autumn'
        WHEN 10 THEN 'autumn'
        WHEN 11 THEN 'autumn'
        WHEN 12 THEN 'winter'
        ELSE 'unknown'
    END
)
FROM users; 