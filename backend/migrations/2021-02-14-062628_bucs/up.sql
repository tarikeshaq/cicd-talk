-- Your SQL goes here
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE courses (
    name TEXT NOT NULL,
    number INTEGER NOT NULL,
    PRIMARY KEY(name, number)
);

CREATE TABLE prereqs (
    course_name TEXT NOT NULL,
    course_number INTEGER NOT NULL,
    prereq_name TEXT NOT NULL,
    prereq_number INTEGER NOT NULL,
    FOREIGN KEY (prereq_name, prereq_number) REFERENCES courses (name, number),
    FOREIGN KEY (course_name, course_number) REFERENCES courses (name, number),
    PRIMARY KEY (course_name, course_number, prereq_name, prereq_number)
);

CREATE TABLE enrollments (
    user_id SERIAL NOT NULL,
    course_name TEXT NOT NULL,
    course_number INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (course_name, course_number) REFERENCES courses (name, number),
    PRIMARY KEY (user_id, course_name, course_number)
);
