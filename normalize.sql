CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    department varchar(300),
    position varchar(300),
    car_avaliability boolean
);

INSERT INTO employees (name, position, car_avaliability)
VALUES 
('John', 'HR', false),
('Jane', 'Sales', false),
('Jake', 'Fullstack JS developer', false),
('Andrew', 'Top manager driver', true);

CREATE TABLE positions(
    name varchar(300) PRIMARY KEY,
    department varchar(300),
    car_avaliability boolean
);

INSERT INTO positions (name, car_avaliability)
VALUES (
    'HR',
    false
  ),
  (
    'Sales',
    false
  ),
  (
    'Full stack JS developer',
    false
  ),
  (
    'Top manager driver',
    true
  );

DROP TABLE employees;

CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    position varchar(300) REFERENCES positions(name)
);

INSERT INTO employees (name, position)
VALUES 
('John', 'HR'),
('Jane', 'Sales'),
('Jake', 'Full stack JS developer'),
('Andrew', 'Top manager driver');


SELECT e.id, e.name, e.position, p.car_avaliability 
FROM employees AS e
JOIN positions AS p
ON e.position = p.name;