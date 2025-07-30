-- create table students
CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  age INT CHECK (age > 3 AND age < 25),
  gender VARCHAR(10),
  email VARCHAR(50) NOT NULL UNIQUE,
  phone VARCHAR(15)
);

-- create table courses
CREATE TABLE courses (
  id SERIAL PRIMARY KEY,
  course_name VARCHAR(100) NOT NULL,
  duration INTERVAL,
  fees DECIMAL(10, 3)
);

-- create table enrollments
CREATE TABLE enrollments (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INT NOT NULL,
  course_id INT NOT NULL,
  enrollment_date DATE NOT NULL,
  FOREIGN KEY (student_id) REFERENCES students(id) ON DELETE CASCADE,
  FOREIGN KEY (course_id) REFERENCES courses(id) ON DELETE CASCADE
);

-- select all columns from student table
select * from students;

-- select all columns from course table
select * from courses;

-- select all columns from enrollments table
select * from enrollments;

-- Data Population into students table 
INSERT INTO students (name, age, gender, email, phone) VALUES
('Ankit Sharma', 22, 'Male', 'ankit.sharma@example.com', '9876543210'),
('Riya Verma', 21, 'Female', 'riya.verma@example.com', '9876543211'),
('Vikram Joshi', 23, 'Male', 'vikram.joshi@example.com', '9876543212'),
('Sanya Mehta', 20, 'Female', 'sanya.mehta@example.com', '9876543213'),
('Aditya Roy', 24, 'Male', 'aditya.roy@example.com', '9876543214'),
('Megha Kapoor', 19, 'Female', 'megha.kapoor@example.com', '9876543215'),
('Rohan Malik', 22, 'Male', 'rohan.malik@example.com', '9876543216'),
('Tanya Batra', 18, 'Female', 'tanya.batra@example.com', '9876543217'),
('Kunal Singh', 21, 'Male', 'kunal.singh@example.com', '9876543218'),
('Isha Arora', 20, 'Female', 'isha.arora@example.com', '9876543219');

-- Data Population into courses table 
INSERT INTO courses (course_name, duration, fees) VALUES
('Web Development Bootcamp', INTERVAL '3 months', 29999.999),
('Data Science with Python', INTERVAL '4 months', 34999.500),
('UI/UX Design Mastery', INTERVAL '2 months', 19999.750),
('Full Stack Java Developer', INTERVAL '6 months', 45999.250),
('Mobile App Development', INTERVAL '3 months', 28999.990);


-- Data Population into enrollments table 
INSERT INTO Enrollments (Student_ID, Course_ID, Enrollment_Date) VALUES
(4, 1, '2024-01-15'),
(5, 2, '2024-02-20'),
(6, 3, '2024-03-10'),
(7, 4, '2024-01-25'),
(8, 5, '2024-02-14'),
(9, 1, '2024-03-18'),
(10, 2, '2024-04-01'),
(11, 3, '2024-04-12'),
(12, 4, '2024-05-05'),
(13, 5, '2024-05-20'),
(4, 2, '2024-06-01'),
(5, 3, '2024-06-15'),
(6, 5, '2024-06-30'),
(7, 1, '2024-07-10'),
(8, 4, '2024-07-20');

-- deleting all the records from students table
truncate table students cascade


