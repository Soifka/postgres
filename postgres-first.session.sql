DROP TABLE users;

CREATE TABLE products(
    id serial PRIMARY KEY,
    brand varchar(200) NOT NULL CHECK(brand != ''),
    model varchar(300) NOT NULL CHECK(model != ''),
    description text, 
    category varchar(200) NOT NULL CHECK(category != ''),
    price numeric(10, 2) NOT NULL CHECK(price > 0),
    discounted_price numeric(10, 2) CHECK(discounted_price < price)
);

INSERT INTO products (brand, model, category, price) VALUES 
('Samsung', 'Galaxy S10', 'smartphone', 2000),
('Huawei', 'P30', 'smartphone', 5000),
('iPhone', '14X', 'smartphone', 3000),
('Asus', 'Vivobook', 'laptop', 10000),
('HP', '213542 PRO', 'laptop', 9000);


INSERT INTO products (brand, model, category, price) VALUES 
('Samsung', 'Galaxy S10', 'smartphone', 2000),
('Huawei', 'P30', 'smartphone', 5000);


ALTER TABLE products 
ADD CONSTRAINT "unique_brand_model_pair" UNIQUE(brand, model);


ALTER TABLE products
ADD COLUMN quantity int CHECK(quantity >= 0);


ALTER TABLE products 
ADD CONSTRAINT "product_quantity_check" CHECK(quantity >= 0);


ALTER TABLE products 
DROP CONSTRAINT "product_quantity_check" CHECK(quantity >= 0);