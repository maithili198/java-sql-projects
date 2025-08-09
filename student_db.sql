-- Create database
CREATE DATABASE student_db;
USE student_db;

-- Create tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    credits INT
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    grade CHAR(2),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Insert sample students
INSERT INTO students (student_id, name, age) VALUES
(1, 'Alice Johnson', 20),
(2, 'Bob Smith', 22),
(3, 'Charlie Brown', 19);

-- Insert sample courses
INSERT INTO courses (course_id, course_name, credits) VALUES
(101, 'Database Systems', 4),
(102, 'Java Programming', 3),
(103, 'Web Development', 3);

-- Insert enrollments
INSERT INTO enrollments (student_id, course_id, grade) VALUES
(1, 101, 'A'),
(1, 102, 'B'),
(2, 101, 'B'),
(3, 103, 'A');

-- Example join query: list students with their courses
SELECT s.name, c.course_name, e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Example aggregate: average grade per course (grade values simplified to numeric for demo)
-- (In real DB, you'd map grades to GPA points for averaging)

-- Stored procedure: enroll a student in a course
DELIMITER //
CREATE PROCEDURE EnrollStudent(IN p_student_id INT, IN p_course_id INT, IN p_grade CHAR(2))
BEGIN
    INSERT INTO enrollments (student_id, course_id, grade) 
    VALUES (p_student_id, p_course_id, p_grade);
END //
DELIMITER ;
