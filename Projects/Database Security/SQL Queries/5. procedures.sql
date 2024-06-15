-- Create Procedures
USE AIS
GO

-- 1. Insert Login ID and password (encrypted) into student and lec tables

CREATE PROCEDURE InsertStudentLoginInfo
    @StuID VARCHAR(100),
    @Pwd Varchar(100)
AS
BEGIN
	DECLARE @name varchar(100);
	SET @name = 'pending insert user name'

    -- Encrypt the password
    DECLARE @EncryptedPassword VARBINARY(MAX);
    SELECT @EncryptedPassword = ENCRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), @Pwd);

    -- Insert into Student table
    INSERT INTO Student(ID, SystemPwd_E, Name)
    VALUES (@StuID, @EncryptedPassword, @name);
END
GO

CREATE PROCEDURE InsertLecturerLoginInfo
    @LecID VARCHAR(100),
    @Pwd Varchar(100)
AS
BEGIN
	DECLARE @name varchar(100);
	SET @name = 'pending insert user name'

    -- Encrypt the password
    DECLARE @EncryptedPassword VARBINARY(MAX);
    SELECT @EncryptedPassword = ENCRYPTBYCERT(Cert_ID('PW_ENCRYPT_CERT'), @Pwd);

    -- Insert into Student table
    INSERT INTO Lecturer(ID, SystemPwd_E, Name)
    VALUES (@LecID, @EncryptedPassword, @name);
END
GO

-- 2. Procedures for Student and Lecturer functions will be tested on DBADMIN user




