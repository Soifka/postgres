DROP TABLE orders;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(64) NOT NULL CHECK(first_name != ''),
    last_name varchar(64) NOT NULL CONSTRAINT last_name_not_empty CHECK(last_name != ''),
    email text NOT NULL CHECK(email != '') UNIQUE,
    gender varchar(30),
    is_subscribe boolean NOT NULL,
    birthday date CHECK(birthday < current_date),
    foot_size smallint,
    height numeric(3, 2) CONSTRAINT too_high_user CHECK(height < 3.0)
);

INSERT INTO users (first_name, last_name, email, gender,is_subscribe, birthday, foot_size, height) VALUES
('Ivanna', 'Petrova', 'i.petrova@gmail.com', 'female', true, '1970-09-15', 38, 1.68),
('Petr', 'Sodorov', 'p.sidorov@gmail.com', 'male', false, '1970-09-15', 43, 1.88);


CREATE TABLE orders(
    id serial PRIMARY KEY,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    customer_id int REFERENCES users(id)
);

CREATE TABLE orders_to_products(
    order_id int REFERENCES orders(id),
    product_id int REFERENCES products(id),
    quantity int,
    PRIMARY KEY(order_id, product_id)
);

INSERT INTO orders VALUES(1);

INSERT INTO orders (customer_id) VALUES(2);

INSERT INTO orders_to_products (order_id, product_id, quantity) VALUES
    (2, 4, 1),
    (2, 5, 1)
;