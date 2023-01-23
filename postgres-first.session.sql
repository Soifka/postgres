DROP TABLE chats;


CREATE TABLE messages(
    id serial PRIMARY KEY,
    author_id int REFERENCES members(id),
    chat_id int REFERENCES chats(id),
    text text NOT NULL,
    send_at timestamp NOT NULL DEFAULT current_timestamp,
    is_read boolean DEFAULT false,
    FOREIGN KEY(chat_id, member_id)
);


CREATE TABLE members(
    id serial PRIMARY KEY,
    nickname varchar(50) NOT NULL CONSTRAINT "nickname_must_be_specified" CHECK(nickname != '')
);


CREATE TABLE chats(
    id serial PRIMARY KEY,
    chat_name varchar(100) NOT NULL CONSTRAINT "chat_name_must_be_specified" CHECK(chat_name != ''),
    owner_id int REFERENCES members(id),
    started_at timestamp NOT NULL DEFAULT current_timestamp,
    is_private boolean DEFAULT false
);


CREATE TABLE chats_to_members(
    chat_id int REFERENCES chats(id),
    member_id int REFERENCES members(id),
    PRIMARY KEY(chat_id, member_id)
);


INSERT INTO members (nickname) VALUES
('John'),
('Jane'),
('Anna'),
('Mike'),
('Alex')
;


INSERT INTO chats (chat_name, owner_id) VALUES
('Party on Friday', 3),
('School chat', 2);


INSERT INTO messages (author_id, chat_id, text) VALUES
(3, 1, 'Hi, everybody! My party will be on Friday'),
(2, 2, 'Hello');


INSERT INTO messages (author_id, chat_id, text) VALUES
(5, 1, 'Great! I will come');