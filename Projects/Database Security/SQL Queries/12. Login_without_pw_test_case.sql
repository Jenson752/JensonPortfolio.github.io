-- owner run

use ais

EXEC InsertLecturerLoginInfo 'Lec006', 'no password'

execute as user ='Admin001'

CREATE USER Lec006 without LOGIN;
EXEC CreateLecturerUser 'Lec006', 'Ali', 0166666666, 'CS'

revert



EXEC InsertStudentLoginInfo 'Std006', 'no password'

execute as user ='Admin001'

CREATE USER Std006 without LOGIN;
EXEC CreateStudentUser 'Std006', 'JingXian', 0122222222 

revert