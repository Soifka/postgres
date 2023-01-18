DROP TABLE users;

CREATE TABLE users(
    first_name varchar(64) NOT NULL,
    last_name varchar(64) NOT NULL,
    email text NOT NULL,
    gender varchar(30),
    is_subscribed boolean NOT NULL,
    birthday date,
    foot_size smallint,
    height numeric(3, 2)
);

INSERT INTO users VALUES
('Ivanna', 'Petrova', 'i.petrova@gmail.com', 'female', true, '1970-09-15', 38, 1.68),
('Petr', 'Sodorov', 'p.sidorov@gmail.com', 'male', false, '1970-09-15', NULL, 1.88);

INSERT INTO users VALUES
(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);