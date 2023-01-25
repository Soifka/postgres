CREATE TABLE contents(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL,
    description text,
    author_id int REFERENCES users(id),
    created_at timestamp DEFAULT current_timestamp
);


CREATE TABLE reactions(
    content_id int REFERENCES contents(id) ON DELETE CASCADE,
    user_id int REFERENCES users(id),
    is_liked boolean 
);


INSERT INTO contents (name, author_id) VALUES
('funny dogs', 2);

INSERT INTO contents (name, author_id) VALUES
('little pigs', 1)
RETURNING id;

UPDATE contents SET name = 'very funny dogs' WHERE id = 2;

INSERT INTO reactions VALUES(
    1, 1, false
);

DELETE FROM contents WHERE id = 1;

DROP TABLE reactions;

DELETE FROM users WHERE id > 8;