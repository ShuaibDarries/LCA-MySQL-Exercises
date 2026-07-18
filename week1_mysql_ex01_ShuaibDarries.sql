-- =============================================
-- EduTrack SA Database Design
-- Week 1, Exercise 01
-- =============================================

-- Task 1: Create the database
-- This creates the main database for the EduTrack SA online learning platform.
CREATE DATABASE IF NOT EXISTS edutrack_sa;

-- Select the database to use for all subsequent operations.
USE edutrack_sa;

-- =============================================
-- Task 2 & 3: Create tables with constraints
-- =============================================

-- Facilitators table: stores teacher/facilitator information.
-- Normalised to 3NF: every column depends only on facilitator_id.
CREATE TABLE IF NOT EXISTS facilitators (
    facilitator_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20)
);

-- Courses table: stores course offerings.
-- facilitator_id is a FOREIGN KEY linking to the facilitators table.
-- Normalised to 3NF: course data is separate; no repeating groups.
CREATE TABLE IF NOT EXISTS courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration_weeks INT NOT NULL,
    facilitator_id INT,
    FOREIGN KEY (facilitator_id) REFERENCES facilitators(facilitator_id)
);

-- Trainees table: stores student/trainee information.
-- Normalised to 3NF: trainee data is separate from enrolments.
CREATE TABLE IF NOT EXISTS trainees (
    trainee_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    province VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Enrolments table: links trainees to courses.
-- This is a junction table that resolves the many-to-many relationship
-- between trainees and courses, while also storing enrolment-specific data.
-- Normalised to 3NF: all non-key attributes depend fully on the enrolment_id.
CREATE TABLE IF NOT EXISTS enrolments (
    enrolment_id INT AUTO_INCREMENT PRIMARY KEY,
    trainee_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolment_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (trainee_id) REFERENCES trainees(trainee_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    CONSTRAINT chk_status CHECK (status IN ('Active', 'Completed', 'Withdrawn'))
);

-- =============================================
-- Task 4: Insert realistic data (South African names & provinces)
-- =============================================

-- Insert facilitators
INSERT INTO facilitators (first_name, last_name, email, phone) VALUES
('Lindiwe', 'Nkos', 'lindiwe.nkosi@edutrack.co.za', '0821234567'),
('Thabo', 'Mokoena', 'thabo.mokoena@edutrack.co.za', '0832345678'),
('Sipho', 'Dlamini', 'sipho.dlamini@edutrack.co.za', '0843456789'),
('Amahle', 'Buthelezi', 'amahle.buthelezi@edutrack.co.za', '0854567890'),
('Johannes', 'Pretorius', 'johannes.pretorius@edutrack.co.za', '0865678901');

-- Insert courses
INSERT INTO courses (course_name, duration_weeks, facilitator_id) VALUES
('Introduction to Web Development', 8, 1),
('Advanced JavaScript & Vue.js', 12, 2),
('Database Design with MySQL', 6, 3),
('UI/UX Design Fundamentals', 10, 4),
('Python for Data Science', 14, 5);

-- Insert trainees (South African names and provinces)
INSERT INTO trainees (first_name, last_name, email, province) VALUES
('Zanele', 'Mahlangu', 'zanele.mahlangu@gmail.com', 'Gauteng'),
('Bongani', 'Zulu', 'bongani.zulu@yahoo.com', 'KwaZulu-Natal'),
('Nosipho', 'Sithole', 'nosipho.sithole@outlook.com', 'Western Cape'),
('Andile', 'Mthembu', 'andile.mthembu@gmail.com', 'Gauteng'),
('Lerato', 'Khumalo', 'lerato.khumalo@webmail.co.za', 'Mpumalanga'),
('Sibusiso', 'Ndlovu', 'sibusiso.ndlovu@gmail.com', 'Eastern Cape');

-- Insert enrolments
INSERT INTO enrolments (trainee_id, course_id, enrolment_date, status) VALUES
(1, 1, '2025-01-15', 'Active'),
(2, 2, '2025-02-01', 'Active'),
(3, 3, '2025-01-20', 'Completed'),
(4, 1, '2025-03-05', 'Active'),
(5, 4, '2025-02-10', 'Withdrawn'),
(6, 5, '2025-01-08', 'Completed'),
(1, 3, '2025-04-01', 'Active'),
(3, 4, '2025-03-15', 'Active');

-- =============================================
-- Task 5: Verification SELECT queries
-- =============================================

-- Verify all facilitators were inserted correctly
SELECT * FROM facilitators;

-- Verify all courses were inserted correctly
SELECT * FROM courses;

-- Verify all trainees were inserted correctly
SELECT * FROM trainees;

-- Verify all enrolments were inserted correctly
SELECT * FROM enrolments;

-- Verify foreign key relationships: show courses with their facilitators
SELECT 
    c.course_id,
    c.course_name,
    c.duration_weeks,
    CONCAT(f.first_name, ' ', f.last_name) AS facilitator_name
FROM courses c
JOIN facilitators f ON c.facilitator_id = f.facilitator_id;

-- Verify enrolments with trainee and course details
SELECT 
    e.enrolment_id,
    CONCAT(t.first_name, ' ', t.last_name) AS trainee_name,
    t.province,
    c.course_name,
    e.enrolment_date,
    e.status
FROM enrolments e
JOIN trainees t ON e.trainee_id = t.trainee_id
JOIN courses c ON e.course_id = c.course_id;

-- =============================================
-- Stretch Goal 20: Display full name and province of trainees from Gauteng only
-- =============================================
SELECT 
    CONCAT(first_name, ' ', last_name) AS full_name,
    province
FROM trainees
WHERE province = 'Gauteng';
