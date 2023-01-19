DROP TABLE messages;

CREATE TABLE messages(
    id serial PRIMARY KEY,
    body text NOT NULL CHECK(body != ''),
    author varchar(256) NOT NULL CHECK(author != ''),
    created_at timestamp DEFAULT current_timestamp,
    is_read boolean DEFAULT false
);

INSERT INTO messages (body, author) VALUES (
    'How are you?',
    'Jane'
);

INSERT INTO messages (author, body) VALUES 
('Mike', 'I am fine'),
('Mike', 'I am fine'),
('Mike', 'I am fine');

INSERT INTO messages VALUES (
    2,
    'How are you?',
    'Jane'
);