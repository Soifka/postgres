DROP TABLE users;

CREATE TABLE users(
    first_name varchar(64) NOT NULL CONSTRAINT first_name_not_empty CHECK(first_name != ''),
    last_name varchar(64) NOT NULL CHECK(last_name != ''),
    email text NOT NULL CHECK(email != '') UNIQUE,
    gender varchar(30),
    is_subscribed boolean NOT NULL,
    day_of_birth date CHECK(day_of_birth < current_date),
    foot_size smallint,
    height numeric(3, 2) CONSTRAINT too_high_user CHECK(height < 3.00)
);

INSERT INTO users VALUES
('Ivanna', 'Petrova', 'i.petrova@gmail.com', 'female', true, '1970-09-15', 38, 1.68),
('Petr', 'Sodorov', 'p.sidorov@gmail.com', 'male', false, '1970-09-15', NULL, 1.88);


INSERT INTO users VALUES
(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO users VALUES
('Alex', 'Brok', 'mail@google.com', 'male', true, '2023-05-13', 43, 1.80);