-- ============================================================
-- DATABASE SCRIPT FOR PROFILE MANAGEMENT SYSTEM (APACHE DERBY)
-- Individual Assignment 2 - CSC584 Enterprise Programming
-- ============================================================

-- INSTRUCTIONS:
-- Please connect to the Apache Derby database using the following credentials:
-- JDBC URL: jdbc:derby://localhost:1527/StudentProfilesDB;create=true
-- Username: app
-- Password: 123
-- 
-- Execute this script to create the table and insert sample data.

-- ============================================================
-- 1. CREATE PROFILE TABLE
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
-- 2. CREATE INDEXES FOR BETTER SEARCH PERFORMANCE
-- ============================================================

CREATE INDEX idx_name ON Profile(name);
CREATE INDEX idx_programme ON Profile(programme);
CREATE INDEX idx_email ON Profile(email);

-- ============================================================
-- 3. INSERT SAMPLE DATA (For Testing)
-- ============================================================

INSERT INTO Profile (studentID, name, programme, email, hobbies, introduction)
VALUES 
('2023002', 'Siti Nur Azalea', 'CS240 BACHELOR OF INFORMATION TECHNOLOGY (HONS.)', 'siti@student.edu.my', 'Photography, Music, Travelling', 'Love capturing moments and exploring new cultures through photography and travel.'),
('2023003', 'Muhammad Rizki', 'CS230 BACHELOR OF COMPUTER SCIENCE (HONS.)', 'rizki@student.edu.my', 'Sports, Coding, Gaming', 'Athlete and programmer. Interested in mobile app development.'),
('2023004', 'Nurul Aini Binti Hassan', 'CS255 BACHELOR OF COMPUTER SCIENCE (HONS) COMPUTER NETWORKS', 'nurul@student.edu.my', 'Reading, Cooking, Music', 'Passionate about network security and culinary arts.');

-- ============================================================
-- END OF DATABASE SCRIPT
-- ============================================================
