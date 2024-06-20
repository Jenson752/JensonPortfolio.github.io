-- DML Auditing
Use AIS;
GO

-- Using Triggers for Auditing Table Changes
-- 1. Create Student Audit Table and triggers
CREATE TABLE StudentAuditLog(
	AuditLog_Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Action nvarchar(50) NOT NULL,
	PreviousRecord XML NULL,
	NewRecord XML NULL,
	ModifiedTime datetime NOT NULL
)
GO

CREATE TRIGGER StudentAudit_Trigger
on Student
AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
   SET NOCOUNT ON;
   DECLARE @PreviousRecord AS XML
   DECLARE @NewRecord AS XML

   DECLARE @Action VARCHAR(10)

   IF EXISTS(SELECT * FROM deleted)
		SELECT @Action = 'DELETE'
   IF EXISTS(SELECT * FROM inserted)
		IF EXISTS(SELECT * FROM deleted)
			SELECT @Action = 'UPDATE'
		ELSE 
			SELECT @Action = 'INSERT'

   SET @PreviousRecord = (SELECT *
    FROM Deleted FOR XML PATH('Student'), TYPE, ROOT('Record')) 
    -- READ THE PREVIOUS / CURRENT STATE OF THE RECORD
   SET @NewRecord = (SELECT * FROM Inserted FOR XML
    PATH('Student'), TYPE, ROOT('Record')) 
    -- -- READ THE NEW STATE OF THE RECORD

   INSERT INTO StudentAuditLog
  (
    Action
   ,PreviousRecord
   ,NewRecord
   ,ModifiedTime
  )
   VALUES
  (
    @Action
   ,@PreviousRecord
   ,@NewRecord
   ,GETDATE()
  )
END
GO

-- 2. Create Lecturer Audit Table and triggers
CREATE TABLE LecturerAuditLog(
	AuditLog_Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Action nvarchar(50) NOT NULL,
	PreviousRecord XML NULL,
	NewRecord XML NULL,
	ModifiedTime datetime NOT NULL
)
GO

CREATE TRIGGER LecturerAudit_Trigger
on Lecturer
AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
   SET NOCOUNT ON;
   DECLARE @PreviousRecord AS XML
   DECLARE @NewRecord AS XML

   DECLARE @Action VARCHAR(10)

   IF EXISTS(SELECT * FROM deleted)
		SELECT @Action = 'DELETE'
   IF EXISTS(SELECT * FROM inserted)
		IF EXISTS(SELECT * FROM deleted)
			SELECT @Action = 'UPDATE'
		ELSE 
			SELECT @Action = 'INSERT'

   SET @PreviousRecord = (SELECT *
    FROM Deleted FOR XML PATH('Lecturer'), TYPE, ROOT('Record')) 
    -- READ THE PREVIOUS / CURRENT STATE OF THE RECORD
   SET @NewRecord = (SELECT * FROM Inserted FOR XML
    PATH('Lecturer'), TYPE, ROOT('Record')) 
    -- -- READ THE NEW STATE OF THE RECORD

   INSERT INTO LecturerAuditLog
  (
    Action
   ,PreviousRecord
   ,NewRecord
   ,ModifiedTime
  )
   VALUES
  (
    @Action
   ,@PreviousRecord
   ,@NewRecord
   ,GETDATE()
  )
END
GO

-- 3. Create Subject Audit Table and triggers
CREATE TABLE SubjectAuditLog(
	AuditLog_Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Action nvarchar(50) NOT NULL,
	PreviousRecord XML NULL,
	NewRecord XML NULL,
	ModifiedTime datetime NOT NULL
)
GO

CREATE TRIGGER SubjectAudit_Trigger
on Subject
AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
   SET NOCOUNT ON;
   DECLARE @PreviousRecord AS XML
   DECLARE @NewRecord AS XML

   DECLARE @Action VARCHAR(10)

   IF EXISTS(SELECT * FROM deleted)
		SELECT @Action = 'DELETE'
   IF EXISTS(SELECT * FROM inserted)
		IF EXISTS(SELECT * FROM deleted)
			SELECT @Action = 'UPDATE'
		ELSE 
			SELECT @Action = 'INSERT'

   SET @PreviousRecord = (SELECT *
    FROM Deleted FOR XML PATH('Subject'), TYPE, ROOT('Record')) 
    -- READ THE PREVIOUS / CURRENT STATE OF THE RECORD
   SET @NewRecord = (SELECT * FROM Inserted FOR XML
    PATH('Subject'), TYPE, ROOT('Record')) 
    -- -- READ THE NEW STATE OF THE RECORD

   INSERT INTO SubjectAuditLog
  (
    Action
   ,PreviousRecord
   ,NewRecord
   ,ModifiedTime
  )
   VALUES
  (
    @Action
   ,@PreviousRecord
   ,@NewRecord
   ,GETDATE()
  )
END
GO

-- 4. Create Result Audit Table and triggers
CREATE TABLE ResultAuditLog(
	AuditLog_Id int NOT NULL IDENTITY(1,1) PRIMARY KEY,
	Action nvarchar(50) NOT NULL,
	PreviousRecord XML NULL,
	NewRecord XML NULL,
	ModifiedTime datetime NOT NULL
)
GO

CREATE TRIGGER ResultAudit_Trigger
on Result
AFTER INSERT, DELETE, UPDATE
AS 
BEGIN
   SET NOCOUNT ON;
   DECLARE @PreviousRecord AS XML
   DECLARE @NewRecord AS XML

   DECLARE @Action VARCHAR(10)

   IF EXISTS(SELECT * FROM deleted)
		SELECT @Action = 'DELETE'
   IF EXISTS(SELECT * FROM inserted)
		IF EXISTS(SELECT * FROM deleted)
			SELECT @Action = 'UPDATE'
		ELSE 
			SELECT @Action = 'INSERT'

   SET @PreviousRecord = (SELECT *
    FROM Deleted FOR XML PATH('Result'), TYPE, ROOT('Record')) 
    -- READ THE PREVIOUS / CURRENT STATE OF THE RECORD
   SET @NewRecord = (SELECT * FROM Inserted FOR XML
    PATH('Result'), TYPE, ROOT('Record')) 
    -- -- READ THE NEW STATE OF THE RECORD

   INSERT INTO ResultAuditLog
  (
    Action
   ,PreviousRecord
   ,NewRecord
   ,ModifiedTime
  )
   VALUES
  (
    @Action
   ,@PreviousRecord
   ,@NewRecord
   ,GETDATE()
  )
END
GO






----------------------------------------------------
INSERT Student ([ID],[Name],[Phone],[SystemPwd])
VALUES (1,'kailun','01221212121', 'pwkl')

SELECT * FROM Student

UPDATE Student
SET 
   SystemPwd = 'new_pw2'
WHERE ID = 1

SELECT * FROM StudentAuditLog