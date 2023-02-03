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


--- 3NF

DROP TABLE employees;
DROP TABLE positions;

CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    department varchar(300),
    department_phone varchar(20)
);

INSERT INTO employees (name, department, department_phone)
VALUES 
('John Doe', 'HR-dep', '25-17-85'),
('Jane Doe', 'Sales-dep', '56-58-12'),
('Carl Mot', 'Dev-dep', '36-87-96');


CREATE TABLE departments (
    name varchar(200) PRIMARY KEY,
    phone_number varchar(20)
);

INSERT INTO departments VALUES 
('HR-dep', '25-17-85'),
('Sales-dep', '56-58-12'),
('Dev-dep', '36-87-96');

ALTER TABLE employees
DROP COLUMN department_phone;

ALTER TABLE employees
ADD FOREIGN KEY (department) REFERENCES departments(name);


--- BCNF

CREATE TABLE students(
    id serial PRIMARY KEY,
    name varchar(200)
);

CREATE TABLE teachers(
    id serial PRIMARY KEY,
    name varchar(200),
    subject varchar(200) REFERENCES subjects(name)
);

CREATE TABLE students_to_teachers(
    teacher_id int REFERENCES teachers(id),
    student_id int REFERENCES students(id),
    PRIMARY KEY (teacher_id, student_id)
);

INSERT INTO students_to_teachers VALUES
(1, 1, 'biology'),
(1, 2, 'biology'),
(2, 1, 'math'),
(2, 2, 'physics');  ----> problem! --- resolved by creating TABLE subjects

CREATE TABLE subjects(
    name varchar(200) PRIMARY KEY
);

--- after creating TABLE subjects ---->
INSERT INTO students_to_teachers VALUES
(1, 1),
(1, 2);


--- 4NF

CREATE TABLE restaurants(
    id serial PRIMARY KEY
);

CREATE TABLE delivery_services(
    id serial PRIMARY KEY
);

CREATE TABLE restaurants_to_deliveries(
    restaurant_id int REFERENCES restaurants(id),
    delivery_id int REFERENCES delivery_services(id),
    PRIMARY KEY (restaurant_id, delivery_id)
);

INSERT INTO restaurants_to_deliveries VALUES
(1, 1, 'margarita'),
(1, 2, '4cheese'),
(1, 3, 'carbonara');

CREATE TABLE pizzas(
    name varchar(200) PRIMARY KEY
);

CREATE TABLE pizzas_to_restaurants(
    pizza_type varchar(200) REFERENCES pizzas(name),
    restaurant_id int REFERENCES restaurants(id),
    PRIMARY KEY (pizza_type, restaurant_id)
);



---- Task "База данных поставки товаров" ---

CREATE TABLE prods(
    id serial PRIMARY KEY,
    name varchar(200) NOT NULL,
    price numeric(10, 2)
);

CREATE TABLE suppliers(
    supplier_id serial PRIMARY KEY,
    name varchar(200) NOT NULL,
    address varchar(300) NOT NULL,
    phone_number varchar(200)
);

CREATE TABLE contracts(
    contract_number int PRIMARY KEY,
    sign_at date,
    end_at date,
    supplier int REFERENCES supplier(supplier_id)
);

CREATE TABLE supplies(
    prod_id int REFERENCES prods(id),
    contract int REFERENCES contracts(contract_number),
    supply_id int NOT NULL,  --- serial???
    plan_prods_quantity int NOT NULL,
    PRIMARY KEY (contract, prod_id)
);

CREATE TABLE shipments(
    shipment_id int PRIMARY KEY,
    supply_id int REFERENCES supplies(supply_id),
    completed_at date,
    prods_quantity int NOT NULL
);


-------- mentor's resolve ---------

CREATE TABLE products(
    id serial PRIMARY KEY,
    name varchar(300) NOT NULL CHECK (name != '')
);

CREATE TABLE manufacturers(
    id serial PRIMARY KEY,
    name varchar(300) NOT NULL CHECK (name != ''),
    address text NOT NULL,
    phone_number varchar(20) NOT NULL
);

CREATE TABLE orders(
    id serial PRIMARY KEY,
    product_id int REFERENCES products(id),
    quantity_plan int NOT NULL,
    contract_number int NOT NULL,
    contract_date date NOT NULL,
    manufacturer_id int REFERENCES manufacturers(id),
    order_cost decimal(10, 2) NOT NULL
);

CREATE TABLE shipments(      ------ здесь нужна цена???
    id serial PRIMARY KEY,
    order_id int REFERENCES orders(id),
    shipment_date date NOT NULL
);

CREATE TABLE products_to_shipment(
    product_id int REFERENCES products(id),
    shipment_id int REFERENCES shipments(id),
    product_quantity int NOT NULL,
    PRIMARY KEY(product_id, shipment_id)
);

------------------------------------------