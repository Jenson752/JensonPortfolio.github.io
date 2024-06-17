-- 1. Create Roles
USE AIS

-- Create Admin Role
CREATE ROLE DBAdmin;
-- Create Student Role
CREATE ROLE Student;
-- Create Lecturer Role
CREATE ROLE Lecturer;

-- 2. Grant Permissions to Role
-- 2.1 Grant Permissions to DBAdmin
GRANT CONTROL ON DATABASE::[AIS] TO DBAdmin; -- full control on database
GRANT ALTER ANY ROLE TO DBAdmin;




-- Owner do
deny VIEW DEFINITION ON CERTIFICATE::PW_ENCRYPT_CERT TO DBAdmin 
deny CONTROL ON CERTIFICATE::PW_ENCRYPT_CERT TO DBAdmin; -- control on cert


--owner grant premission to lecturer and student 
GRANT VIEW DEFINITION ON CERTIFICATE::PW_ENCRYPT_CERT TO lecturer;
GRANT CONTROL ON CERTIFICATE::PW_ENCRYPT_CERT TO lecturer;
GO

GRANT VIEW DEFINITION ON CERTIFICATE::PW_ENCRYPT_CERT TO Student;
GRANT CONTROL ON CERTIFICATE::PW_ENCRYPT_CERT TO Student;
go






-- permissions for managing student and lecturer data, excluding password management
GRANT SELECT, INSERT, UPDATE, DELETE ON Student TO DBAdmin;
--DENY SELECT, UPDATE ON Student TO DBAdmin;
DENY UPDATE ON Student(SystemPwd_E) TO DBAdmin;

GRANT INSERT, UPDATE, DELETE ON Lecturer TO DBAdmin;
DENY SELECT ON Lecturer TO DBAdmin;




DENY UPDATE ON Lectuer(SystemPwd_E) TO DBAdmin;




DENY Select, Insert, Update, Delete ON Subject TO DBAdmin;
DENY Select, Insert, Update, Delete ON Result TO DBAdmin;


deny select, update, insert on LecturerAuditLog to DBAdmin
deny select, update, insert on ResultAuditLog to DBAdmin
deny select, update, insert on StudentAuditLog to DBAdmin
deny select, update, insert on SubjectAuditLog to DBAdmin



--GRANT EXECUTE ON CreateUserAndEncryptPassword_Std TO DBAdmin
--GO

--GRANT EXECUTE ON CreateUserAndEncryptPassword_Lec TO DBAdmin
--GO



-- 2.2: Grant Student and Lecturer permission will be tested on DBAdmin user


-- Owner insert subject code
INSERT INTO Subject (Code, Title)
VALUES
('DBS32','Database Security'),
('MA101', 'Calculus'),
('CS102', 'Data Structures');






-- #############################################################
USE AIS
delete from result where id = (SELECT MAX(ID) FROM RESULT);

SELECT * FROM RESULT

delete from result

DBCC CHECKIDENT ('Result', RESEED, 1);
