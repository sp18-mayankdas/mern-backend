-- Enum type for gender
CREATE TYPE gender_enum AS ENUM ('Male', 'Female', 'Other');

-- Create students table
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  age INT CHECK (age > 3 AND age < 25),
  gender gender_enum,
  email VARCHAR(50) NOT NULL UNIQUE,
  phone VARCHAR(15),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create courses table
CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  course_name VARCHAR(100) NOT NULL,
  duration INTERVAL,
  fees DECIMAL(10, 3),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create enrollments table
CREATE TABLE enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id),
  FOREIGN KEY (course_id) REFERENCES courses(id),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ENUM type for status
CREATE TYPE enrollment_status AS ENUM ('Enrolled', 'Dropped');

-- Create student_status Table
CREATE TABLE student_status (
  id SERIAL PRIMARY KEY,
  enrollment_id INT NOT NULL,
  status enrollment_status NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
  FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id)
);

-- Retrieve all records from students
SELECT * FROM students
ORDER BY id ASC;

-- Retrieve all records from courses
SELECT * FROM courses
ORDER BY id ASC;

-- Retrieve all records from enrollments
SELECT * FROM enrollments
ORDER BY enrollment_id ASC;

-- Retrieve all records from student_status
SELECT * FROM student_status
ORDER BY id ASC;

-- Insert data into students
INSERT INTO students (name, age, gender, email, phone) VALUES
('Ankit Sharma',    22, 'Male',   'ankit.sharma@example.com',   '9876543201'),
('Riya Verma',      21, 'Female', 'riya.verma@example.com',     '9876543202'),
('Vikram Joshi',    23, 'Male',   'vikram.joshi@example.com',   '9876543203'),
('Sanya Mehta',     20, 'Female', 'sanya.mehta@example.com',    '9876543204'),
('Rahul Kumar',     22, 'Male',   'rahul.kumar@example.com',    '9876543205'),
('Priya Singh',     19, 'Female', 'priya.singh@example.com',    '9876543206'),
('Arjun Patel',     21, 'Male',   'arjun.patel@example.com',    '9876543207'),
('Neha Gupta',      24, 'Female', 'neha.gupta@example.com',     '9876543208'),
('Aman Trivedi',    18, 'Male',   'aman.trivedi@example.com',   '9876543209'),
('Pooja Soni',      22, 'Female', 'pooja.soni@example.com',     '9876543210');

-- Insert data into courses
INSERT INTO courses (course_name, duration, fees) VALUES
('Physics', INTERVAL '3 months', 29999.999),
('Math', INTERVAL '4 months', 34999.500),
('Chemistry', INTERVAL '2 months', 19999.750),
('English', INTERVAL '6 months', 45999.250),
('Computer Science', INTERVAL '3 months', 28999.990);

-- Insert data into enrollments 
INSERT INTO enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-05-10'),
(1, 2, '2024-05-11'),
(1, 3, '2024-06-01'),
(2, 1, '2024-05-13'),
(2, 2, '2024-06-04'),
(2, 3, '2024-06-07'),
(3, 2, '2024-06-12'),
(3, 5, '2024-06-25'),
(4, 1, '2024-06-10'),
(5, 5, '2024-06-18'),
(6, 4, '2024-07-01'),
(7, 3, '2024-07-02'),
(7, 2, '2024-07-03'),
(8, 2, '2024-07-05'),
(9, 1, '2024-07-07');

-- Insert data into student_status 
INSERT INTO student_status (enrollment_id, status) VALUES
(2, 'Enrolled'),
(3, 'Dropped'),
(4, 'Completed'),
(5, 'Enrolled'),
(6, 'Dropped'),
(7, 'Completed'),
(8, 'Enrolled'),
(9, 'Dropped'),
(10, 'Completed'),
(11, 'Enrolled'),
(12, 'Dropped'),
(13, 'Completed'),
(14, 'Enrolled'),
(15, 'Dropped');

-- Remove all records from students 
TRUNCATE TABLE students CASCADE;

-- Remove all records from courses
TRUNCATE TABLE courses CASCADE;

-- Remove all records from enrollments
TRUNCATE TABLE enrollments CASCADE;

-- List all students with their enrolled courses
SELECT s.name AS student_name, c.course_name
FROM students s
JOIN enrollments e ON s.id = e.student_id
JOIN courses c ON c.id = e.course_id
ORDER BY s.name, c.course_name;

-- Students enrolled in each course
SELECT c.course_name, COUNT(e.student_id) AS enrolled_students
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.course_name;

-- Students not enrolled in any course
SELECT s.*
FROM students s
LEFT JOIN enrollments e ON s.id = e.student_id
WHERE e.student_id IS NULL;

-- Students enrolled in more than one course
SELECT s.id, s.name, COUNT(e.course_id) AS num_courses
FROM students s
RIGHT JOIN enrollments e ON s.id = e.student_id
GROUP BY s.id, s.name
HAVING COUNT(e.course_id) > 1;

-- Courses without any enrolled students
SELECT c.*
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
WHERE e.course_id IS NULL;

-- Student enrolled most recently
SELECT s.*, e.enrollment_date
FROM enrollments e
JOIN students s ON e.student_id = s.id
ORDER BY e.enrollment_date DESC
LIMIT 1;

-- Update fee for Math course
UPDATE courses
SET fees = 5500
WHERE course_name = 'Math';

-- Remove all enrollments for a dropped-out student
DELETE FROM enrollments
WHERE student_id IN (
  SELECT e.student_id
  FROM enrollments e
  JOIN student_status s ON e.enrollment_id = s.enrollment_id
  GROUP BY e.student_id
  HAVING COUNT(e.student_id) = COUNT(e.student_id) FILTER (WHERE s.status = 'Dropped')
);

-- Update duration for a course
UPDATE courses
SET duration = INTERVAL '18 weeks'
WHERE course_name = 'Computer Science';

-- Add unique constraint to phone column
ALTER TABLE students
ADD UNIQUE (phone);

-- Add an index on enrollment_date column
CREATE INDEX idx_enrollmentdate ON enrollments(enrollment_date);

-- Add CHECK constraint for minimum course fee
ALTER TABLE courses
ADD CHECK (fees >= 1000);


