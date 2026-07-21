-- ============================================
-- EduTrack SA - Exercise 02
-- Querying, Sorting, and Filtering Data
-- ============================================

USE edutrack_sa;

-- ============================================
-- SORTING QUERIES
-- ============================================

-- Task 1: List all trainees sorted by surname in ascending order (A-Z)
SELECT *
FROM trainees
ORDER BY surname ASC;

-- Task 2: List all courses sorted by duration in descending order (longest first)
SELECT *
FROM courses
ORDER BY duration DESC;

-- Task 3: Retrieve the 3 most recently enrolled records using LIMIT
SELECT *
FROM enrolments
ORDER BY enrolment_date DESC
LIMIT 3;

-- ============================================
-- FILTERING QUERIES
-- ============================================

-- Task 4: List trainees filtered by a specific province (e.g., 'Western Cape')
SELECT *
FROM trainees
WHERE province = 'Western Cape';

-- Task 5: Find trainees whose first name starts with a specific letter using LIKE wildcard (%)
-- Example: first names starting with 'J'
SELECT *
FROM trainees
WHERE first_name LIKE 'J%';

-- Task 6: Filter courses by a specific duration using comparison operators
-- Example: courses longer than 10 days/weeks
SELECT *
FROM courses
WHERE duration > 10;

-- Task 7: Filter enrolments by status (e.g., 'Active', 'Completed', 'Dropped')
SELECT *
FROM enrolments
WHERE status = 'Active';

-- ============================================
-- AGGREGATE QUERIES
-- ============================================

-- Task 8: Total trainee count in the database
SELECT COUNT(*) AS total_trainees
FROM trainees;

-- Task 9: Average course duration
SELECT AVG(duration) AS average_duration
FROM courses;

-- Task 10: Maximum course duration
SELECT MAX(duration) AS maximum_duration
FROM courses;

-- Task 11: Enrolment count per course
SELECT course_id, COUNT(*) AS enrolment_count
FROM enrolments
GROUP BY course_id;

-- ============================================
-- GROUPING QUERIES
-- ============================================

-- Task 12: Trainee count per province
SELECT province, COUNT(*) AS trainee_count
FROM trainees
GROUP BY province;

-- Task 13: Provinces with more than one trainee using HAVING
SELECT province, COUNT(*) AS trainee_count
FROM trainees
GROUP BY province
HAVING COUNT(*) > 1;

-- ============================================
-- COMBINED / ADVANCED QUERIES
-- ============================================

-- Task 14: Select with WHERE and ORDER BY combined
-- List active enrolments sorted by most recent first
SELECT *
FROM enrolments
WHERE status = 'Active'
ORDER BY enrolment_date DESC;

-- Task 15: SELECT with WHERE conditions using logical operators (AND, OR)
-- Example: trainees from 'Gauteng' OR 'KwaZulu-Natal'
SELECT *
FROM trainees
WHERE province = 'Gauteng' OR province = 'KwaZulu-Natal';

-- Task 16: SELECT with WHERE using comparison operators (>, <, =, !=)
-- Example: courses with duration not equal to 5
SELECT *
FROM courses
WHERE duration != 5;

-- ============================================
-- STRETCH GOALS (Optional)
-- ============================================

-- Task 17: Retrieve the 2nd and 3rd most recently enrolled records using LIMIT and OFFSET
SELECT *
FROM enrolments
ORDER BY enrolment_date DESC
LIMIT 2 OFFSET 1;

-- Task 18: Find all trainees whose email ends with '.co.za'
SELECT *
FROM trainees
WHERE email LIKE '%.co.za';

-- Task 19: Show each facilitator's full name and the number of courses they facilitate,
-- but only include facilitators who facilitate more than one course
SELECT
    f.first_name,
    f.surname,
    COUNT(cf.course_id) AS courses_facilitated
FROM facilitators f
JOIN course_facilitators cf ON f.facilitator_id = cf.facilitator_id
GROUP BY f.facilitator_id, f.first_name, f.surname
HAVING COUNT(cf.course_id) > 1;
