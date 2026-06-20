-- ============================================================
-- DATABASE SCRIPT FOR PROFILE MANAGEMENT SYSTEM
-- Individual Assignment 2 - CSC584 Enterprise Programming
-- ============================================================

-- ============================================================
-- 1. DROP DATABASE IF EXISTS 
-- ============================================================
DROP DATABASE IF EXISTS StudentProfilesDB;

-- ============================================================
-- 2. CREATE DATABASE
-- ============================================================
CREATE DATABASE StudentProfilesDB;

-- ============================================================
-- 3. USE THE DATABASE
-- ============================================================
USE StudentProfilesDB;

-- ============================================================
-- 4. CREATE PROFILE TABLE
-- ============================================================

CREATE TABLE Profile (
    studentID VARCHAR(20) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    programme VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    hobbies VARCHAR(255),
    introduction VARCHAR(500),
    createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- 5. CREATE INDEXES FOR BETTER SEARCH PERFORMANCE
-- ============================================================

CREATE INDEX idx_name ON Profile(name);
CREATE INDEX idx_programme ON Profile(programme);
CREATE INDEX idx_email ON Profile(email);

-- ============================================================
-- 6. SAMPLE DATA (For testing)
-- ============================================================

-- INSERT INTO Profile (studentID, name, programme, email, hobbies, introduction)
-- VALUES 
-- ('2023001', 'Ahmad bin Ali', 'CS230 BACHELOR OF COMPUTER SCIENCE (HONS.)', 'ahmad@student.edu.my', 'Reading, Gaming, Coding', 'I am a passionate student interested in web development and artificial intelligence.'),
-- ('2023002', 'Siti Nur Azalea', 'CS240 BACHELOR OF INFORMATION TECHNOLOGY (HONS.)', 'siti@student.edu.my', 'Photography, Music, Travelling', 'Love capturing moments and exploring new cultures through photography and travel.'),
-- ('2023003', 'Muhammad Rizki', 'CS230 BACHELOR OF COMPUTER SCIENCE (HONS.)', 'rizki@student.edu.my', 'Sports, Coding, Gaming', 'Athlete and programmer. Interested in mobile app development.'),
-- ('2023004', 'Nurul Aini Binti Hassan', 'CS255 BACHELOR OF COMPUTER SCIENCE (HONS) COMPUTER NETWORKS', 'nurul@student.edu.my', 'Reading, Cooking, Music', 'Passionate about network security and culinary arts.');

-- ============================================================
-- 7. DATABASE VERIFICATION
-- ============================================================
/*
 * Run these queries to verify the database setup:
 * 
 * SHOW DATABASES;
 * USE StudentProfilesDB;
 * SHOW TABLES;
 * DESCRIBE Profile;
 * SELECT * FROM Profile;
 */

-- ============================================================
-- END OF DATABASE SCRIPT
-- ============================================================
