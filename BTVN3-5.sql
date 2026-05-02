
CREATE DATABASE EDU_PRO;
USE EDU_PRO;
-- drop database EDU_PRO; 

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(12,2) NOT NULL CHECK (salary > 0)
);


CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    tuition_fee DECIMAL(12,2) NOT NULL CHECK (tuition_fee > 0),

    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);


CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender BOOLEAN NOT NULL
    -- 1 = Nam, 0 = Nữ
);


CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    score DECIMAL(4,2) NULL CHECK (score BETWEEN 0 AND 10),

    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- THÊM DỮ LIỆU
INSERT INTO teachers (full_name, salary)
VALUES
('Nguyen Van A', 15000000),
('Tran Thi B', 18000000),
('Le Van C', 20000000);

INSERT INTO courses (course_name, teacher_id, credits, tuition_fee)
VALUES
('IT Fundamentals', 1, 3, 2500000),
('Advanced IT', 1, 4, 3000000),
('Database Systems', 2, 3, 2800000),
('Web Development', 2, 4, 3200000),
('Business English', 3, 2, 2000000),
('Graphic Design', NULL, 3, 2700000);

INSERT INTO students (full_name, date_of_birth, gender)
VALUES
('Student 1', '2003-01-10', 1),
('Student 2', '2003-02-15', 0),
('Student 3', '2003-03-20', 1),
('Student 4', '2003-04-12', 0),
('Student 5', '2003-05-08', 1),
('Student 6', '2003-06-17', 0),
('Student 7', '2003-07-25', 1),
('Student 8', '2003-08-30', 0),
('Student 9', '2003-09-14', 1),
('Student 10', '2003-10-21', 0);

INSERT INTO enrollments (student_id, course_id, date, score)
VALUES
(1, 1, '2026-04-01', 8.5),
(2, 1, '2026-04-01', 7.0),
(3, 2, '2026-04-02', 9.0),
(4, 2, '2026-04-02', 6.5),
(5, 3, '2026-04-03', 8.0),
(6, 3, '2026-04-03', 7.5),
(7, 4, '2026-04-04', 9.2),
(8, 4, '2026-04-04', 8.8),
(9, 5, '2026-04-05', 6.9),
(10, 5, '2026-04-05', 7.7),
(1, 3, '2026-04-06', 8.4),
(2, 4, '2026-04-06', 7.2),
(3, 5, '2026-04-06', 9.1),
(4, 6, '2026-04-07', NULL),
(5, 6, '2026-04-07', NULL);

SET SQL_SAFE_UPDATES = 0;
UPDATE teachers
SET salary = salary * 1.10
WHERE id IN (
    SELECT DISTINCT teacher_id
    FROM courses
    WHERE course_name LIKE '%IT%'
);

SELECT 
    c.id AS course_id,
    c.course_name,
    t.full_name AS teacher_name
FROM courses c
LEFT JOIN teachers t 
    ON c.teacher_id = t.id;
    
    SELECT *
FROM students
WHERE YEAR(date_of_birth) = 2005;

SELECT 
    s.id AS student_id,
    s.full_name AS student_name,
    e.score
FROM enrollments e
JOIN students s 
    ON e.student_id = s.id
JOIN courses c 
    ON e.course_id = c.id
WHERE c.course_name = 'Lập trình Web'
ORDER BY e.score DESC;

SELECT 
    s.full_name AS student_name,
    c.course_name,
    t.full_name AS teacher_name
FROM enrollments e
JOIN students s 
    ON e.student_id = s.id
JOIN courses c 
    ON e.course_id = c.id
LEFT JOIN teachers t 
    ON c.teacher_id = t.id;
    
    SELECT 
    t.full_name AS teacher_name,
    COUNT(c.id) AS total_courses
FROM teachers t
LEFT JOIN courses c 
    ON t.id = c.teacher_id
GROUP BY t.id, t.full_name;

SELECT 
    c.course_name,
    c.tuition_fee * COUNT(e.id) AS total_revenue
FROM courses c
LEFT JOIN enrollments e 
    ON c.id = e.course_id
GROUP BY c.id, c.course_name, c.tuition_fee;


SELECT 
    s.full_name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e 
    ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) >= 3;


SELECT 
    c.course_name,
    AVG(e.score) AS average_score
FROM courses c
JOIN enrollments e 
    ON c.id = e.course_id
WHERE e.score IS NOT NULL
GROUP BY c.id, c.course_name
HAVING AVG(e.score) < 5.0;
CREATE DATABASE EDU_PRO;
USE EDU_PRO;
-- drop database EDU_PRO; 

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    salary DECIMAL(12,2) NOT NULL CHECK (salary > 0)
);


CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    teacher_id INT NULL,
    credits INT NOT NULL CHECK (credits > 0),
    tuition_fee DECIMAL(12,2) NOT NULL CHECK (tuition_fee > 0),

    FOREIGN KEY (teacher_id) REFERENCES teachers(id)
);


CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender BOOLEAN NOT NULL
    -- 1 = Nam, 0 = Nữ
);


CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    date DATE NOT NULL,
    score DECIMAL(4,2) NULL CHECK (score BETWEEN 0 AND 10),

    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (course_id) REFERENCES courses(id)
);

-- THÊM DỮ LIỆU
INSERT INTO teachers (full_name, salary)
VALUES
('Nguyen Van A', 15000000),
('Tran Thi B', 18000000),
('Le Van C', 20000000);

INSERT INTO courses (course_name, teacher_id, credits, tuition_fee)
VALUES
('IT Fundamentals', 1, 3, 2500000),
('Advanced IT', 1, 4, 3000000),
('Database Systems', 2, 3, 2800000),
('Web Development', 2, 4, 3200000),
('Business English', 3, 2, 2000000),
('Graphic Design', NULL, 3, 2700000);

INSERT INTO students (full_name, date_of_birth, gender)
VALUES
('Student 1', '2003-01-10', 1),
('Student 2', '2003-02-15', 0),
('Student 3', '2003-03-20', 1),
('Student 4', '2003-04-12', 0),
('Student 5', '2003-05-08', 1),
('Student 6', '2003-06-17', 0),
('Student 7', '2003-07-25', 1),
('Student 8', '2003-08-30', 0),
('Student 9', '2003-09-14', 1),
('Student 10', '2003-10-21', 0);

INSERT INTO enrollments (student_id, course_id, date, score)
VALUES
(1, 1, '2026-04-01', 8.5),
(2, 1, '2026-04-01', 7.0),
(3, 2, '2026-04-02', 9.0),
(4, 2, '2026-04-02', 6.5),
(5, 3, '2026-04-03', 8.0),
(6, 3, '2026-04-03', 7.5),
(7, 4, '2026-04-04', 9.2),
(8, 4, '2026-04-04', 8.8),
(9, 5, '2026-04-05', 6.9),
(10, 5, '2026-04-05', 7.7),
(1, 3, '2026-04-06', 8.4),
(2, 4, '2026-04-06', 7.2),
(3, 5, '2026-04-06', 9.1),
(4, 6, '2026-04-07', NULL),
(5, 6, '2026-04-07', NULL);

SET SQL_SAFE_UPDATES = 0;
UPDATE teachers
SET salary = salary * 1.10
WHERE id IN (
    SELECT DISTINCT teacher_id
    FROM courses
    WHERE course_name LIKE '%IT%'
);

SELECT 
    c.id AS course_id,
    c.course_name,
    t.full_name AS teacher_name
FROM courses c
LEFT JOIN teachers t 
    ON c.teacher_id = t.id;
    
    SELECT *
FROM students
WHERE YEAR(date_of_birth) = 2005;

SELECT 
    s.id AS student_id,
    s.full_name AS student_name,
    e.score
FROM enrollments e
JOIN students s 
    ON e.student_id = s.id
JOIN courses c 
    ON e.course_id = c.id
WHERE c.course_name = 'Lập trình Web'
ORDER BY e.score DESC;

SELECT 
    s.full_name AS student_name,
    c.course_name,
    t.full_name AS teacher_name
FROM enrollments e
JOIN students s 
    ON e.student_id = s.id
JOIN courses c 
    ON e.course_id = c.id
LEFT JOIN teachers t 
    ON c.teacher_id = t.id;
    
       SELECT 
    t.full_name AS teacher_name,
    COUNT(c.id) AS total_courses
FROM teachers t
LEFT JOIN courses c 
    ON t.id = c.teacher_id
GROUP BY t.id, t.full_name;

SELECT 
    c.course_name,
    c.tuition_fee * COUNT(e.id) AS total_revenue
FROM courses c
LEFT JOIN enrollments e 
    ON c.id = e.course_id
GROUP BY c.id, c.course_name, c.tuition_fee;


SELECT 
    s.full_name AS student_name,
    COUNT(e.course_id) AS total_courses
FROM students s
JOIN enrollments e 
    ON s.id = e.student_id
GROUP BY s.id, s.full_name
HAVING COUNT(e.course_id) >= 3;


SELECT 
    c.course_name,
    AVG(e.score) AS average_score
FROM courses c
JOIN enrollments e 
    ON c.id = e.course_id
WHERE e.score IS NOT NULL
GROUP BY c.id, c.course_name
HAVING AVG(e.score) < 5.0;