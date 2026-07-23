-- ============================================
-- EduTrack SA - Week 1, Exercise 03
-- SQL Joins and Data Manipulation
-- ============================================
USE edutrack_sa;


-- ============================================
-- TASK 1: INNER JOIN
-- Combine data from two or three tables in a 
-- single query.
--
-- Key Feature: Enrolment list joining trainees,
-- enrolments, and courses; course and facilitator
-- name pairing.
-- ============================================

-- 1a. INNER JOIN: Enrolment list joining trainees, enrolments, and courses.
--     Returns only trainees who are enrolled in at least one course.
SELECT 
    t.trainee_id,
    t.first_name AS trainee_first_name,
    t.last_name  AS trainee_last_name,
    c.course_id,
    c.course_name,
    e.enrolment_date,
    e.status
FROM trainees t
INNER JOIN enrolments e ON t.trainee_id = e.trainee_id
INNER JOIN courses c    ON e.course_id  = c.course_id;

-- 1b. INNER JOIN: Course and facilitator name pairing.
--     Returns every course together with the facilitator who teaches it.
SELECT 
    c.course_id,
    c.course_name,
    c.duration_weeks,
    f.facilitator_id,
    CONCAT(f.first_name, ' ', f.last_name) AS facilitator_full_name,
    f.email AS facilitator_email
FROM courses c
INNER JOIN facilitators f ON c.facilitator_id = f.facilitator_id;


-- ============================================
-- TASK 2: LEFT JOIN
-- Include trainees who may not be enrolled in 
-- any course.
--
-- Key Feature: Full trainee list with course name,
-- including trainees with no enrolment showing NULL.
-- ============================================

SELECT 
    t.trainee_id,
    t.first_name,
    t.last_name,
    t.email,
    t.province,
    c.course_name,
    e.enrolment_date,
    e.status
FROM trainees t
LEFT JOIN enrolments e ON t.trainee_id = e.trainee_id
LEFT JOIN courses c    ON e.course_id  = c.course_id;


-- ============================================
-- TASK 3: RIGHT JOIN
-- Include courses that may have no trainees 
-- enrolled.
--
-- Key Feature: Full course list with trainee names,
-- including courses with no trainees showing NULL.
-- ============================================

SELECT 
    c.course_id,
    c.course_name,
    c.duration_weeks,
    t.trainee_id,
    t.first_name AS trainee_first_name,
    t.last_name  AS trainee_last_name,
    e.enrolment_date,
    e.status
FROM trainees t
RIGHT JOIN enrolments e ON t.trainee_id = e.trainee_id
RIGHT JOIN courses c    ON e.course_id  = c.course_id;


-- ============================================
-- TASK 4: UPDATE
-- Change specific records without affecting 
-- other rows.
--
-- Key Feature: Province change and enrolment 
-- status change using WHERE conditions.
-- ============================================

-- 4a. UPDATE: Change a trainee's province.
--     The WHERE clause targets a single trainee by name so no other rows are affected.
UPDATE trainees 
SET province = 'Western Cape' 
WHERE first_name = 'Lindiwe' 
  AND last_name  = 'Nkosi';

-- 4b. UPDATE: Change an enrolment's status.
--     The WHERE clause targets a single enrolment record so no other rows are affected.
UPDATE enrolments 
SET status = 'Completed' 
WHERE trainee_id = 1 
  AND course_id  = 1;


-- ============================================
-- TASK 5: DELETE
-- Remove a specific record from the database.
--
-- Key Feature: Removal of a specific enrolment 
-- record using ORDER BY and LIMIT.
-- ============================================

-- Delete the single most recent enrolment record.
-- ORDER BY + LIMIT ensures only one specific record is removed.
DELETE FROM enrolments 
ORDER BY enrolment_date DESC 
LIMIT 1;


-- ============================================
-- TASK 6: MINI CHALLENGE
-- A single query combining JOIN, WHERE, GROUP BY,
-- HAVING, and ORDER BY.
-- ============================================

-- Report: total active/completed enrolments per course.
-- Only include courses with 2 or more such enrolments.
-- Results are ordered by enrolment count (highest first),
-- then alphabetically by course name.
SELECT 
    c.course_id,
    c.course_name,
    c.duration_weeks,
    COUNT(e.enrolment_id) AS total_enrolments
FROM courses c
INNER JOIN enrolments e ON c.course_id = e.course_id
WHERE e.status IN ('Active', 'Completed')
GROUP BY c.course_id, c.course_name, c.duration_weeks
HAVING COUNT(e.enrolment_id) >= 2
ORDER BY total_enrolments DESC, c.course_name ASC;


-- ============================================
-- STRETCH GOAL 1 (Optional)
-- Find the facilitator with the most trainees 
-- across all of their courses combined.
-- ============================================

SELECT 
    f.facilitator_id,
    CONCAT(f.first_name, ' ', f.last_name) AS facilitator_full_name,
    COUNT(e.enrolment_id) AS total_trainees
FROM facilitators f
INNER JOIN courses c    ON f.facilitator_id = c.facilitator_id
INNER JOIN enrolments e ON c.course_id      = e.course_id
WHERE e.status IN ('Active', 'Completed')
GROUP BY f.facilitator_id, f.first_name, f.last_name
ORDER BY total_trainees DESC
LIMIT 1;


-- ============================================
-- STRETCH GOAL 2 (Optional)
-- In a single SQL block with comments:
--   - Add a new facilitator
--   - Create a new course assigned to them
--   - Enrol two existing trainees in that course
-- ============================================

START TRANSACTION;

-- Step 1: Insert the new facilitator
INSERT INTO facilitators (first_name, last_name, email, phone) 
VALUES ('Thabo', 'Molefe', 'thabo.molefe@edutrack.co.za', '0823456789');

-- Capture the newly generated facilitator_id
SET @new_facilitator_id = LAST_INSERT_ID();

-- Step 2: Create a new course assigned to the new facilitator
INSERT INTO courses (course_name, duration_weeks, facilitator_id) 
VALUES ('Advanced Database Design', 8, @new_facilitator_id);

-- Capture the newly generated course_id
SET @new_course_id = LAST_INSERT_ID();

-- Step 3: Enrol two existing trainees in the new course
-- (Adjust trainee_id values if 1 and 2 do not exist in your data)
INSERT INTO enrolments (trainee_id, course_id, enrolment_date, status) 
VALUES 
    (1, @new_course_id, CURDATE(), 'Active'),
    (2, @new_course_id, CURDATE(), 'Active');

COMMIT;


-- ============================================
-- STRETCH GOAL 3 (Optional)
-- Find all trainees enrolled in more than one course.
-- ============================================

SELECT 
    t.trainee_id,
    t.first_name,
    t.last_name,
    t.email,
    COUNT(DISTINCT e.course_id) AS number_of_courses
FROM trainees t
INNER JOIN enrolments e ON t.trainee_id = e.trainee_id
WHERE e.status IN ('Active', 'Completed')
GROUP BY t.trainee_id, t.first_name, t.last_name, t.email
HAVING COUNT(DISTINCT e.course_id) > 1;
