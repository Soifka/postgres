CREATE TABLE faculties(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CONSTRAINT "faculty_name_must_be_specified" CHECK(name != '')
);

CREATE TABLE groups(
    id serial PRIMARY KEY,
    code varchar(256) NOT NULL CONSTRAINT "group_code_must_be_specified" CHECK(code != '') UNIQUE,
    faculty_id int REFERENCES faculties(id)
);

CREATE TABLE students(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CONSTRAINT "student_name_must_be_specified" CHECK(name != ''), 
    surname varchar(256) NOT NULL CONSTRAINT "student_surname_must_be_specified" CHECK(surname != ''),
    group_id int REFERENCES groups(id) 
);

CREATE TABLE teachers(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CONSTRAINT "teacher_name_must_be_specified" CHECK(name != ''),
    surname varchar(256) NOT NULL CONSTRAINT "teacher_surname_must_be_specified" CHECK(surname != '')  
);

CREATE TABLE subjects(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CONSTRAINT "subject_name_must_be_specified" CHECK(name != ''),
    teacher_id int REFERENCES teachers(id)
);

ALTER TABLE teachers ADD COLUMN subject_id int REFERENCES subjects(id);

CREATE TABLE exams(
    student_id int REFERENCES students(id),
    subject_id int REFERENCES subjects(id),
    date date CONSTRAINT "exam_date_must_be_valid" CHECK(date <= current_date) DEFAULT current_date,
    grade smallint NOT NULL CONSTRAINT "grade_must_be_valid" CHECK(grade > 0 AND grade < 5),
    PRIMARY KEY(student_id, subject_id)
);


INSERT INTO faculties (name) VALUES
('Engineering'),
('Economics'),
('Information Technology');

INSERT INTO groups (code, faculty_id) VALUES
('EN-0101', 1),
('EN-0102', 1),
('EC-0201', 2),
('EC-0202', 2),
('IT-0301', 3),
('IT-0302', 3);

INSERT INTO students (name, surname, group_id) VALUES
('Alex', 'Biver', 1),
('Jane', 'Doe', 1),
('Mike', 'Rutoff', 2),
('Bob', 'Zorin', 2),
('Kate', 'Filova', 3),
('Ivan', 'Ivanov', 3),
('Vladimir', 'Krasnov', 4),
('Lily', 'Rogova', 4),
('Maxim', 'Torr', 5),
('Julia', 'Cute', 5),
('Igor', 'First', 6),
('Natasha', 'Koroleva', 6);

INSERT INTO teachers (name, surname,) VALUES