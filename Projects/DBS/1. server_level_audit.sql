-- DDL AUDIT
-- OBJECT CHANGE AUDIT
CREATE SERVER AUDIT DDLActivities_Object_Change  
    TO FILE ( FILEPATH =   
'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA' ) ;   
GO  

-- Enable the server audit for DDL 
ALTER SERVER AUDIT DDLActivities_Object_Change   
WITH (STATE = ON) ;

-- Create Object Change Audit Specification
CREATE SERVER AUDIT SPECIFICATION [DDLActivities_Object_Change_Spec]
FOR SERVER AUDIT DDLActivities_Object_Change
ADD (DATABASE_OBJECT_CHANGE_GROUP)
WITH (STATE=ON)
GO

-- run this whole things to view audit record
DECLARE @AuditFilePath VARCHAR(8000);

Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name = 'DDLActivities_Object_Change'

select event_time, database_name, object_name, statement
from sys.fn_get_audit_file(@AuditFilePath,default,default)
where database_name = 'AIS'
--





-- run this whole things to view audit record
DECLARE @AuditFilePath VARCHAR(8000);

Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name = 'DDLActivities_Audit'

select event_time, database_name, object_name, statement
from sys.fn_get_audit_file(@AuditFilePath,default,default)
--







-- PERMISSION AUDIT
CREATE SERVER AUDIT DDLActivities_Permission_Change  
    TO FILE ( FILEPATH =   
'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA' ) ;   
GO  

-- Enable the server audit for DDL 
ALTER SERVER AUDIT DDLActivities_Permission_Change   
WITH (STATE = ON) ;

-- Create Object Change Audit Specification
CREATE SERVER AUDIT SPECIFICATION [DDLActivities_Permission_Change_Spec]
FOR SERVER AUDIT [DDLActivities_Permission_Change]
ADD (DATABASE_OBJECT_PERMISSION_CHANGE_GROUP)
WITH (STATE=ON)
GO

-- run this whole things to view audit record
DECLARE @AuditFilePath VARCHAR(8000);

Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name = 'DDLActivities_Permission_Change'

select event_time, database_name, object_name, statement
from sys.fn_get_audit_file(@AuditFilePath,default,default)
-----









-- LOGIN AUDIT
CREATE SERVER AUDIT Log_Activities_Audit
	TO FILE (FILEPATH = 
'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA' );
GO






-- Enable the server audit
ALTER SERVER AUDIT Log_Activities_Audit WITH (STATE = ON);

-- Create the audit specification
CREATE SERVER AUDIT SPECIFICATION [log_Audit_Specification]
FOR SERVER AUDIT Log_Activities_Audit
ADD (SUCCESSFUL_LOGIN_GROUP),
ADD (FAILED_LOGIN_GROUP),
ADD (LOGOUT_GROUP)
WITH (STATE = ON);
GO


-- View the log activities audit
DECLARE @AuditFilePath VARCHAR(8000);

Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name = 'Log_Activities_Audit'

SELECT 
    event_time,
    succeeded,
    server_principal_name,
    application_name,
    action_id,
    statement,
    file_name,
    session_id
FROM sys.fn_get_audit_file(@AuditFilePath,default,default)
ORDER BY event_time, action_id DESC;;
--












--  Create a Server Audit - all premission 
CREATE SERVER AUDIT Permission_Audit
	TO FILE (FILEPATH = 
'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA' );
GO

ALTER SERVER AUDIT Permission_Audit WITH (STATE = ON);


-- Step 2: Define Audit Specifications
CREATE SERVER AUDIT SPECIFICATION Permission_Audit_Spec
FOR SERVER AUDIT Permission_Audit
ADD (DATABASE_OBJECT_PERMISSION_CHANGE_GROUP),
ADD (DATABASE_PERMISSION_CHANGE_GROUP),
ADD (SCHEMA_OBJECT_PERMISSION_CHANGE_GROUP),
ADD (SERVER_OBJECT_PERMISSION_CHANGE_GROUP),
ADD (SERVER_PERMISSION_CHANGE_GROUP)
WITH (STATE = ON);



-- View the log activities audit
DECLARE @AuditFilePath VARCHAR(8000);

Select @AuditFilePath = audit_file_path
From sys.dm_server_audit_status
where name = 'Permission_Audit'

SELECT 
    event_time,
    succeeded,
    server_principal_name,
    application_name,
    action_id,
    statement,
    file_name,
    session_id
FROM sys.fn_get_audit_file(@AuditFilePath,default,default)
ORDER BY action_id DESC;
--


