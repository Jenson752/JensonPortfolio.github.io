-- Admin Queries

USE AIS
GO

SELECT * FROM Result

-- GRANT Permission 
-- grant permission for lec to view student details, without pw
GRANT SELECT ON Student TO Lecturer;
DENY SELECT ON Student(SystemPWD_E) TO Lecturer;
GO

-- CREATE PROCEDURES IN CREATING USERS FOR Student and Lecturer
CREATE PROCEDURE CreateStudentUser 
    @StuID VARCHAR(100),
	@StuName VARCHAR(100),
	@Phone Varchar(100)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @StuCount INT;

	-- Check if StuID already exists in the Student table
    SELECT @StuCount = COUNT(*)
    FROM Student
    WHERE ID = @StuID;

    IF @StuCount = 1
    BEGIN


		DECLARE @SQL NVARCHAR(MAX);

		SET @SQL = N'CREATE USER ' + QUOTENAME(@StuID) + N' FOR LOGIN ' + QUOTENAME(@StuID) + N';' +
				   N'ALTER ROLE Student ADD MEMBER ' + QUOTENAME(@StuID) + N';';

		-- Execute dynamic SQL
		EXEC sp_executesql @SQL;
	   	 

		-- Update name if already exists
        UPDATE Student
        SET Name = @StuName,
            Phone = @Phone
        WHERE ID = @StuID;


		END
    ELSE
    BEGIN
        PRINT 'StuID did not exists in the Student table. Skipping insertion.';
    END
END
GO

CREATE PROCEDURE CreateLecturerUser
    @LecID VARCHAR(100),
	@LecName VARCHAR(100),
	@Phone Varchar(100),
	@Department Varchar(100)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @LecCount INT;

	-- Check if StuID already exists in the Student table
    SELECT @LecCount = COUNT(*)
    FROM Lecturer
    WHERE ID = @LecID;

    IF @LecCount = 1
    BEGIN


		DECLARE @SQL NVARCHAR(MAX);

		SET @SQL = N'CREATE USER ' + QUOTENAME(@LecID) + N' FOR LOGIN ' + QUOTENAME(@LecID) + N';' +
				   N'ALTER ROLE Lecturer ADD MEMBER ' + QUOTENAME(@LecID) + N';';

		-- Execute dynamic SQL
		EXEC sp_executesql @SQL;
	   	 

		-- Update name if already exists
        UPDATE Lecturer
        SET Name = @LecName,
            Phone = @Phone,
			Department = @Department
        WHERE ID = @LecID;


		END
    ELSE
    BEGIN
        PRINT 'LecID did not exists in the Lecture table. Skipping insertion.';
    END
END
GO

-- CREATE PROCEDURES AND GRANT PERMISSION FOR Lecturer and Student
-- 1. Procedures and Permission for Lecturer
GRANT VIEW DEFINITION ON CERTIFICATE::PW_ENCRYPT_CERT TO lecturer;
GRANT CONTROL ON CERTIFICATE::PW_ENCRYPT_CERT TO lecturer;
GO

-- create procedure to read lecturer own data
ALTER PROCEDURE readLecturerProcedure
AS
BEGIN
    -- Get the original login name of the user
    DECLARE @OriginalLoginName NVARCHAR(100);
    SET @OriginalLoginName = ORIGINAL_LOGIN();

    -- Assuming the user has already authenticated and you have their unique system user ID
    DECLARE @loggedInUserID NVARCHAR(100);
    SET @loggedInUserID = (SELECT ID FROM Lecturer WHERE ID = @OriginalLoginName);

    -- View own details and decrypt the encrypted password
    SELECT 
        ID,
        Name,
        Phone,
        CONVERT(VARCHAR(MAX), DECRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), SystemPwd_E)) AS SystemPwd,
		Department
    FROM 
        Lecturer 
    WHERE 
        ID = @loggedInUserID;

END
GO
-- grant permission
GRANT EXECUTE ON readLecturerProcedure TO Lecturer;
GO

-- create procedure to edit or update lecturer own data
ALTER PROCEDURE EditLecturerProcedure
    @Pwd VARCHAR(100) = NULL,
    @LecName VARCHAR(100) = NULL,
    @Phone VARCHAR(100) = NULL,
    @SystemPwd_E VARCHAR(100) = NULL
AS
BEGIN
    -- Get the original login name of the user
    DECLARE @OriginalLoginName NVARCHAR(100);
    SET @OriginalLoginName = ORIGINAL_LOGIN();

    -- Assuming the user has already authenticated and you have their unique system user ID
    DECLARE @loggedInUserID NVARCHAR(100);
    SET @loggedInUserID = (SELECT ID FROM Lecturer WHERE ID = @OriginalLoginName);

    -- Update own details based on provided parameters
    IF @LecName IS NOT NULL
        UPDATE Lecturer SET Name = @LecName WHERE ID = @loggedInUserID;

    IF @Phone IS NOT NULL
        UPDATE Lecturer SET Phone = @Phone WHERE ID = @loggedInUserID;

    IF @Pwd IS NOT NULL
	BEGIN

	    DECLARE @EncryptedPassword VARBINARY(MAX);
		SELECT @EncryptedPassword = ENCRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), @Pwd);

		UPDATE Lecturer SET SystemPwd_E = @EncryptedPassword WHERE ID = @loggedInUserID;
	END


	    -- View own details and decrypt the encrypted password
    SELECT 
        ID,
        Name,
        Phone,
        CONVERT(VARCHAR(MAX), DECRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), SystemPwd_E)) AS SystemPwd,
		Department
    FROM 
        Lecturer 
    WHERE 
        ID = @loggedInUserID;

END
GO
-- grant permission
GRANT EXECUTE ON EditLecturerProcedure TO Lecturer;
GO

-- Create procedure to insert academic data
CREATE PROCEDURE InsertAcaDataProcedure (
    @StudentID VARCHAR(6) = NULL, 
    @SubjectCode VARCHAR(5) = NULL,
    @Grade VARCHAR(2) = NULL
)
AS
BEGIN
  -- Declare variables
  DECLARE @OriginalLoginName NVARCHAR(100);
  DECLARE @LecturerID VARCHAR(6);
  DECLARE @StudentExists BIT;
  DECLARE @SubjectExists BIT;
  DECLARE @AssessmentDate DATE;
  DECLARE @ExistingRecordCount INT;

  -- Get the original login name of the user
  SET @OriginalLoginName = ORIGINAL_LOGIN();

  -- Check if StudentID exists in Student table
  SELECT @StudentExists = CASE WHEN EXISTS (
      SELECT 1
      FROM Student
      WHERE ID = @StudentID
    ) THEN 1 ELSE 0 END;

  -- Check if SubjectCode exists in Subject table
  SELECT @SubjectExists = CASE WHEN EXISTS (
      SELECT 1
      FROM Subject
      WHERE Code = @SubjectCode
    ) THEN 1 ELSE 0 END;

  -- Check if there are existing records with the same student ID and subject code combination
  SELECT @ExistingRecordCount = COUNT(*)
  FROM Result
  WHERE StudentID = @StudentID AND SubjectCode = @SubjectCode;

  -- If StudentID and SubjectCode exist and there are no existing records with the same combination
  IF (@StudentExists = 1 AND @SubjectExists = 1 AND @ExistingRecordCount = 0)
  BEGIN
    -- Get the current date for AssessmentDate
    SET @AssessmentDate = GETDATE();

    -- Insert data
    INSERT INTO Result (StudentID, LecturerID, SubjectCode, AssessmentDate, Grade)
    VALUES (@StudentID, @OriginalLoginName, @SubjectCode, @AssessmentDate, @Grade);
  END
  ELSE
  BEGIN
    -- Handle case where student or subject doesn't exist or duplicate record exists
    DECLARE @ErrorMessage NVARCHAR(MAX);
    IF @StudentExists = 0
      SET @ErrorMessage = 'Student ID ' + @StudentID + ' does not exist.';
    ELSE IF @SubjectExists = 0
      SET @ErrorMessage = 'Subject code ' + @SubjectCode + ' does not exist.';
    ELSE
      SET @ErrorMessage = 'A record with the same combination of Student ID and Subject Code already exists.';
    RAISERROR(@ErrorMessage, 16, 1); 
  END
END
GO
-- grant permission
GRANT EXECUTE ON InsertAcaDataProcedure TO Lecturer;
GO

-- update & remove any acamdeic details for the records they added
ALTER PROCEDURE UpdateOrRemoveAcademicData
    @ID INT = NULL,
    @StudentID VARCHAR(6) = NULL,
    @LecturerID VARCHAR(6) = NULL,
    @SubjectCode VARCHAR(5) = NULL,
    @AssessmentDate DATE = NULL,
    @Grade VARCHAR(2) = NULL,
    @IsDelete BIT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CurrentLecturerID VARCHAR(100);
    SET @CurrentLecturerID = SUSER_NAME(); -- Get the current lecturer's ID

    -- Delete the record if IsDelete is true
    IF @IsDelete = 1
    BEGIN
        IF @ID IS NULL
        BEGIN
            -- Check if the current user is the lecturer who inserted the row with the highest ID
            IF @CurrentLecturerID = (SELECT LecturerID FROM result WHERE id = (SELECT MAX(id) FROM result))
            BEGIN
                DELETE FROM result WHERE id = (SELECT MAX(id) FROM result); -- Delete the row with the highest ID
            END
        END
        ELSE
        BEGIN
            -- Delete the record with the specified ID if it belongs to the current lecturer
            DELETE FROM Result WHERE ID = @ID AND LecturerID = @CurrentLecturerID;
        END
    END
    ELSE
    BEGIN
        -- Update StudentID if provided
        IF @StudentID IS NOT NULL
            UPDATE Result SET StudentID = @StudentID WHERE ID = @ID;

        -- Update LecturerID if provided
        IF @LecturerID IS NOT NULL
            UPDATE Result SET LecturerID = @LecturerID WHERE ID = @ID;

        -- Update SubjectCode if provided
        IF @SubjectCode IS NOT NULL
            UPDATE Result SET SubjectCode = @SubjectCode WHERE ID = @ID;

        -- Update AssessmentDate if provided
        IF @AssessmentDate IS NOT NULL
            UPDATE Result SET AssessmentDate = @AssessmentDate WHERE ID = @ID;

        -- Update Grade if provided
        IF @Grade IS NOT NULL
            UPDATE Result SET Grade = @Grade WHERE ID = @ID;
    END
END;
GO
-- grant permission
GRANT EXECUTE ON UpdateOrRemoveAcademicData TO Lecturer;
GO

-- view all students' id, name and phone number
CREATE PROCEDURE ViewAllStudents
AS
BEGIN
    SELECT ID, Name, Phone
    FROM Student;
END
GO
-- grant permission
GRANT EXECUTE ON ViewAllStudents TO Lecturer;
GO

-- view all marks for all students where results were entered by the lecturers from the same department
ALTER PROCEDURE ViewMarksByDepartment
AS
BEGIN
    SELECT s.ID, s.Name, r.Grade
    FROM Result r
    JOIN Student s ON r.StudentID = s.ID
    JOIN Lecturer l ON r.LecturerID = l.ID
    WHERE l.Department = (select Department from Lecturer 
	where ID = SUSER_NAME());
END
GO
GRANT EXECUTE ON ViewMarksByDepartment TO Lecturer;
GO

-- #####################################################################
-- 2. Procedures and Permission for Student
-- Grant permission to use the certificate for encryption
GRANT VIEW DEFINITION ON CERTIFICATE::PW_ENCRYPT_CERT TO Student;
GRANT CONTROL ON CERTIFICATE::PW_ENCRYPT_CERT TO Student;
go

-- create procedure to read student own data
CREATE PROCEDURE readUserProcedure
AS
BEGIN
    -- Get the original login name of the user
    DECLARE @OriginalLoginName NVARCHAR(100);
    SET @OriginalLoginName = ORIGINAL_LOGIN();

    -- Assuming the user has already authenticated and you have their unique system user ID
    DECLARE @loggedInUserID NVARCHAR(100);
    SET @loggedInUserID = (SELECT ID FROM Student WHERE ID = @OriginalLoginName);

    -- View own details and decrypt the encrypted password
    SELECT 
        ID,
        Name,
        Phone,
        CONVERT(VARCHAR(MAX), DECRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), SystemPwd_E)) AS SystemPwd
    FROM 
        Student 
    WHERE 
        ID = @loggedInUserID;

END
GO
-- grant permission
GRANT EXECUTE ON readUserProcedure TO Student;
GO

-- create procedure to read student's result data
Create PROCEDURE readStudentResultProcedure
AS
BEGIN
    -- Get the original login name of the user
    DECLARE @OriginalLoginName NVARCHAR(100);
    SET @OriginalLoginName = ORIGINAL_LOGIN();

    -- Assuming the user has already authenticated and you have their unique system user ID
    DECLARE @loggedInUserID NVARCHAR(100);
    SET @loggedInUserID = (SELECT StudentID FROM Result WHERE StudentID = @OriginalLoginName);

    -- View own details and decrypt the encrypted password
    SELECT 
        ID,
        StudentID,
		LecturerID,
		SubjectCode,
		AssessmentDate,
        Grade
    FROM 
        Result
    WHERE 
        StudentID = @loggedInUserID;

END
GO
-- grant permission
GRANT EXECUTE ON readStudentResultProcedure TO Student;
GO

-- create procedure to edit or update student own data
ALTER PROCEDURE EditProcedure
    @Pwd VARCHAR(100) = NULL,
    @StuName VARCHAR(100) = NULL,
    @Phone VARCHAR(100) = NULL,
    @SystemPwd_E VARCHAR(100) = NULL
AS
BEGIN
    -- Get the original login name of the user
    DECLARE @OriginalLoginName NVARCHAR(100);
    SET @OriginalLoginName = ORIGINAL_LOGIN();

    -- Assuming the user has already authenticated and you have their unique system user ID
    DECLARE @loggedInUserID NVARCHAR(100);
    SET @loggedInUserID = (SELECT ID FROM Student WHERE ID = @OriginalLoginName);

    -- Update own details based on provided parameters
    IF @StuName IS NOT NULL
        UPDATE Student SET Name = @StuName WHERE ID = @loggedInUserID;

    IF @Phone IS NOT NULL
        UPDATE Student SET Phone = @Phone WHERE ID = @loggedInUserID;

    IF @Pwd IS NOT NULL
	BEGIN

	    DECLARE @EncryptedPassword VARBINARY(MAX);
		SELECT @EncryptedPassword = ENCRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), @Pwd);

		UPDATE Student SET SystemPwd_E = @EncryptedPassword WHERE ID = @loggedInUserID;
	END


	    -- View own details and decrypt the encrypted password
    SELECT 
        ID,
        Name,
        Phone,
        CONVERT(VARCHAR(MAX), DECRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), SystemPwd_E)) AS SystemPwd
    FROM 
        Student 
    WHERE 
        ID = @loggedInUserID;

END
GO
-- grant permission
GRANT EXECUTE ON EditProcedure TO Student;
GO


-- CREATE USER FOR Student and Lecturer
-- 1. create user for students
EXEC CreateStudentUser 'Std001', 'JingXian', 0122222222 
EXEC CreateStudentUser 'Std002', 'Jenson', 0133333333 
EXEC CreateStudentUser 'Std003', 'YongHong', 0144444444
EXEC CreateStudentUser 'Std004', 'kaiLun', 0155555555

-- 2. create user for lecturer
EXEC CreateLecturerUser 'Lec001', 'Ali', 0166666666, 'CS'
EXEC CreateLecturerUser 'Lec002', 'Thomas', 0177777777, 'CS'
EXEC CreateLecturerUser 'Lec003', 'Abu', 0188888888, 'Engineering'
EXEC CreateLecturerUser 'Lec004', 'Raj', 0199999999, 'Engineering'
GO

USE AIS
select * from Student
select * from Lecturer


-- CREATE VIEW
-- create view to view lectuer details without password

CREATE VIEW LecturerDetailView
AS
SELECT ID, Name, Phone, Department
FROM Lecturer;

SELECT * FROM LecturerDetailView; 
GO

-- create view to view student details without password
CREATE VIEW StudentDetailView
AS
SELECT ID, Name, Phone
FROM Student;

SELECT * FROM StudentDetailView;


-- Try to view lecturer table (should be fail)
SELECT * FROM Lecturer -- Output: Failed


-- Try to view result table (should be fail)
SELECT * FROM Result -- Output: Failed


-- Try to delete from result table (should be fail)
DELETE FROM Result -- Output: Failed


