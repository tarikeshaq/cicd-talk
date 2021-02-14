-- Your SQL goes here
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE courses (
    name TEXT NOT NULL,
    number TEXT NOT NULL,
    PRIMARY KEY(name, number)
);

CREATE TABLE prereqs (
    course_name TEXT NOT NULL,
    course_number TEXT NOT NULL,
    prereq_name TEXT NOT NULL,
    prereq_number TEXT NOT NULL,
    FOREIGN KEY (prereq_name, prereq_number) REFERENCES courses (name, number),
    FOREIGN KEY (course_name, course_number) REFERENCES courses (name, number),
    PRIMARY KEY (course_name, course_number, prereq_name, prereq_number)
);

CREATE TABLE enrollments (
    user_id SERIAL NOT NULL,
    course_name TEXT NOT NULL,
    course_number TEXT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users (id),
    FOREIGN KEY (course_name, course_number) REFERENCES courses (name, number),
    PRIMARY KEY (user_id, course_name, course_number)
);

-- Inserting courses
INSERT INTO courses 
VALUES 
-- First year courses
    ('COMM', '101'), ('COMM', '186E'), ('COMM', '292'),
    ('CPSC', '110'), ('CPSC', '121'), ('ECON', '101'),
    ('ECON', '102'), ('MATH', '104'), ('MATH', '105'),
    ('WRDS', '150B'),
-- Second year courses
    ('COMM', '202'), ('COMM', '205'), ('COMM', '290'),
    ('COMM', '291'), ('COMM', '293'), ('COMM', '295'),
    ('COMM', '298'), ('CPSC', '210'), ('CPSC', '213'),
    ('CPSC', '221'),
-- Third year courses
    ('COMM', '203'), ('COMM', '296'), ('COMM', '390'),
    ('COMM', '394'), ('COMM', '438'), ('CPSC', '304'),
    ('CPSC', '310'), ('CPSC', '320'),
-- Of of those two is required in third year, other in fourth
    ('COMM', '204'), ('COMM', '393'),
-- one of the following is required in third year
    ('CPSC', '313'), ('CPSC', '317'), ('CPSC', '319'),
    ('CPSC', '322'), ('CPSC', '330'), ('CPSC', '344'),
-- Fourth year courses
    ('COMM', '395'), ('COMM', '335'), ('COMM', '436'),
-- One of the following is required in fourth year
    ('COMM', '336'), ('COMM', '435'), ('COMM', '439'),
    ('COMM', '456'),
-- One of the following capstones is required
    ('COMM', '466'), ('COMM', '483'), ('COMM', '486M'),
    ('COMM', '491'), ('COMM', '492'), ('COMM', '497'),
    ('COMM', '498'),
-- Three credits from 300 level CPSC courses is required,
-- so we insert all of them
    ('CPSC', '340'),
-- We need 6 credits from 400 level CPSC courses
-- so we insert all of them
    ('CPSC', '404'), ('CPSC', '406'), ('CPSC', '410'),
    ('CPSC', '411'), ('CPSC', '415'), ('CPSC', '416'),
    ('CPSC', '417'), ('CPSC', '418'), ('CPSC', '420'),
    ('CPSC', '421'), ('CPSC', '422'), ('CPSC', '425'),
    ('CPSC', '427'), ('CPSC', '430'), ('CPSC', '436V'),
    ('CPSC', '440'), ('CPSC', '444'), ('CPSC', '445'),
    ('CPSC', '448A'), ('CPSC', '448B'), ('CPSC', '448C'),
    ('CPSC', '449'), ('CPSC', '490'), ('CPSC', '491'),
-- Additional optional courses one might take to satisfy
-- prereqs
    ('MATH', '221'), ('MATH', '200');

-- We now insert all the pre-reqs... This is could be 
-- done with a script, but that's not very dependable
INSERT INTO prereqs
VALUES
    ('MATH', '105', 'MATH', '104'),
    ('COMM', '291', 'COMM', '290'),
    ('COMM', '395', 'ECON', '101'),
    ('COMM', '295', 'ECON', '102'),
    ('COMM', '298', 'COMM', '290'),
    ('COMM', '298', 'COMM', '293'),
    ('COMM', '298', 'COMM', '295'),
    ('CPSC', '210', 'CPSC', '110'),
    ('CPSC', '213', 'CPSC', '121'),
    ('CPSC', '213', 'CPSC', '210'),
    ('CPSC', '221', 'CPSC', '210'),
    ('CPSC', '221', 'CPSC', '121'),
    ('COMM', '203', 'COMM', '292'),
    ('COMM', '203', 'ECON', '101'),
    ('COMM', '203', 'ECON', '102'),
    ('COMM', '296', 'COMM', '293'),
    ('COMM', '296', 'COMM', '295'),
    ('COMM', '390', 'WRDS', '150B'),
    ('COMM', '394', 'COMM', '295'),
    ('COMM', '438', 'COMM', '205'),
    ('CPSC', '304', 'CPSC', '221'),
    ('CPSC', '310', 'CPSC', '213'),
    ('CPSC', '310', 'CPSC', '221'),
    ('CPSC', '320', 'CPSC', '221'),
    ('CPSC', '320', 'COMM', '291'),
    ('CPSC', '313', 'CPSC', '213'),
    ('CPSC', '313', 'CPSC', '221'),
    ('CPSC', '317', 'CPSC', '213'),
    ('CPSC', '317', 'CPSC', '221'),
    ('CPSC', '319', 'CPSC', '310'),
    ('CPSC', '322', 'CPSC', '221'),
    ('CPSC', '330', 'CPSC', '210'),
    ('CPSC', '340', 'CPSC', '221'),
    ('CPSC', '340', 'MATH', '221'),
    ('CPSC', '340', 'MATH', '200'),
    ('CPSC', '340', 'COMM', '291'),
    ('CPSC', '344', 'CPSC', '210'),
    ('CPSC', '404', 'CPSC', '304'),
    ('CPSC', '404', 'CPSC', '213'),
    ('CPSC', '410', 'CPSC', '310'),
    ('CPSC', '415', 'CPSC', '313'),
    ('CPSC', '416', 'CPSC', '313'),
    ('CPSC', '416', 'CPSC', '317'),
    ('CPSC', '417', 'CPSC', '313'),
    ('CPSC', '417', 'COMM', '291'),
    ('CPSC', '418', 'CPSC', '320'),
    ('CPSC', '418', 'CPSC', '313'),
    ('CPSC', '420', 'CPSC', '320'),
    ('CPSC', '422', 'CPSC', '322'),
    ('CPSC', '425', 'CPSC', '221'),
    ('CPSC', '425', 'MATH', '221'),
    ('CPSC', '425', 'MATH', '200'),
    ('CPSC', '440', 'CPSC', '340'),
    ('CPSC', '440', 'CPSC', '320'),
    ('COMM', '335', 'COMM', '205'),
    ('COMM', '435', 'COMM', '205'),
    ('COMM', '436', 'COMM', '335'),
    ('COMM', '336', 'COMM', '205'),
    ('COMM', '439', 'COMM', '335'),
    ('COMM', '456', 'COMM', '335'),
    ('COMM', '491', 'COMM', '390'),
    ('COMM', '491', 'COMM', '395'),
    ('COMM', '492', 'COMM', '390'),
    ('COMM', '492', 'COMM', '395'),
    ('COMM', '497', 'COMM', '390'),
    ('COMM', '497', 'COMM', '395'),
    ('COMM', '498', 'COMM', '390'),
    ('COMM', '498', 'COMM', '395'),
    ('MATH', '221', 'MATH', '104'),
    ('MATH', '200', 'MATH', '105');
