-- Student Queries

use AIS

-- check personal details (student 1)
EXEC readUserProcedure -- pass

-- update phone no (student 1)
EXEC EditProcedure @phone=018282828282 -- pass

-- read own details of student (student 2)
EXEC readUserProcedure -- pass

-- delete result (should fail) (student 4)
delete from result -- fail

-- select from lecturer table (should fail) (student 2)
select * from lecturer -- fail 

-- insert details into student table (should fail) 
Insert Into Student (ID, SystemPwd_E, Name, Phone) Values ('S1111','S1111','Ramasamy','012345678') -- fail

