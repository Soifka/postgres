DROP TABLE users;

CREATE TABLE books(
    id serial PRIMARY KEY,
    author varchar(256),
    name varchar(256),
    year varchar(4),
    publisher varchar(256),
    category varchar(256),
    synopsys text,
    quantity int,
    status varchar(100)
);

ALTER TABLE books ADD CONSTRAINT "quantity_lower_zero" CHECK(quantity >= 0);

ALTER TABLE books ADD CONSTRAINT "author_name_empty" CHECK(author != '' AND name != ''); 
ALTER TABLE books ADD CONSTRAINT "author_name_unique" UNIQUE(author, name);