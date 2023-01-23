CREATE TABLE trainers(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL
);


CREATE TABLE teams(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL,
    trainer_id int REFERENCES trainers(id)
);


ALTER TABLE trainers ADD COLUMN team_id int REFERENCES teams(id);