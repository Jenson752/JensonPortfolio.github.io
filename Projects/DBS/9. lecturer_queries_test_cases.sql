-- Lecturer Queries
USE AIS



-- Check personal details (Lec1 Example) pass
EXEC readLecturerProcedure -- Output: Pass

-- Update name (Lec1 Example) pass
EXEC EditLecturerProcedure @LecName='AliNew' -- Pass

-- view student table (Lec 2 example) fail
SELECT * FROM Student -- Output: Failed

-- Select student records from table (lec 3 example) pass
SELECT ID, Name, Phone FROM Student -- Output: Pass

-- Select details from lec table, but only self detail can be shown (Lec 4 Example) Pass
SELECT * FROM Lecturer -- Output: Failed (Created a procedure to run this function)

-- Each lecturer add 1 - 2 rows in the result table (pass)
EXEC InsertAcaDataProcedure 'Std001', 'MA101', 'A' -- Lec 1 test (pass)
EXEC InsertAcaDataProcedure 'Std002', 'DBS32', 'B' -- lec 2 test (pass)
EXEC InsertAcaDataProcedure 'Std003', 'CS102', 'C' -- Lec 3 test (pass)
EXEC InsertAcaDataProcedure 'Std001', 'CS102', 'A' -- Lec 4 test (pass)

-- Select results, only results from same department will be shown (Lec 2)
EXEC ViewMarksByDepartment

-- lec 4 delete a row that was newly created by other lec 3 (row must not be deleted)
EXEC InsertAcaDataProcedure 'Std004', 'DBS32', 'A' -- Lec 3 test (pass)

EXEC UpdateOrRemoveAcademicData @isdelete=1; -- lec 4 test (fail)

-- Lec 3 delete own newly inserted row
EXEC UpdateOrRemoveAcademicData @isdelete=1; -- lec 3 test (pass)

