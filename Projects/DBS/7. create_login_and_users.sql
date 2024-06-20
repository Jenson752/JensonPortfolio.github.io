-- Create login for Admin, lecturers and students

USE Master
GO

-- Create login and user for admin
CREATE LOGIN Admin001 WITH PASSWORD = 'Admin001@12345';

use AIS
go

CREATE USER Admin001 for login Admin001;
ALTER ROLE DBAdmin ADD MEMBER Admin001;
GO

-- Create login for Lecturer, user create as DBAdmin user
-- Lec 1
CREATE LOGIN Lec001 WITH PASSWORD = 'Lec001@12345'
EXEC InsertLecturerLoginInfo 'Lec001', 'Lec001@12345'
-- Lec 2
CREATE LOGIN Lec002 WITH PASSWORD = 'Lec002@12345'
EXEC InsertLecturerLoginInfo 'Lec002', 'Lec002@12345'
-- Lec 3
CREATE LOGIN Lec003 WITH PASSWORD = 'Lec003@12345'
EXEC InsertLecturerLoginInfo 'Lec003', 'Lec003@12345'
-- Lec 4
CREATE LOGIN Lec004 WITH PASSWORD = 'Lec004@12345'
EXEC InsertLecturerLoginInfo 'Lec004', 'Lec004@12345'
GO

-- Create login for Student, user create as DBAdmin user
-- student 1
CREATE LOGIN Std001 WITH PASSWORD = 'Std001@12345'
EXEC InsertStudentLoginInfo 'Std001', 'Std001@12345'
-- student 2
CREATE LOGIN Std002 WITH PASSWORD = 'Std002@12345'
EXEC InsertStudentLoginInfo 'Std002', 'Std002@12345'
-- student 3
CREATE LOGIN Std003 WITH PASSWORD = 'Std003@12345'
EXEC InsertStudentLoginInfo 'Std003', 'Std003@12345'
-- student 4
CREATE LOGIN Std004 WITH PASSWORD = 'Std004@12345'
EXEC InsertStudentLoginInfo 'Std004', 'Std004@12345'
GO

-- View Login Creation
use AIS
select * from student
select * from Lecturer
