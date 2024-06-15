-- backup DBinto server 1
USE [master];
GO

BACKUP DATABASE [AIS]
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\AIS_full_backup.bak'
WITH NOFORMAT, NOINIT,
NAME = N'AIS_full_backup-Full Database Backup', SKIP, NOREWIND, NOUNLOAD, STATS = 10;
GO


---- backup LOG
BACKUP LOG AIS TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\AIS_log_backup.bak' WITH NORECOVERY;
go

--SELECT * FROM fn_my_permissions (NULL, 'DATABASE');  


BACKUP MASTER KEY TO FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\master_key_backup'
    ENCRYPTION BY PASSWORD = 'MASTERKEY@12345';



-- backup CERTIFICATE
BACKUP CERTIFICATE AIS_TDE
TO FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\AIS_TDE_backup_CERT.cer'
WITH PRIVATE KEY 
(
    FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\AIS_TDE_backup_CERT.prvk',
    ENCRYPTION BY PASSWORD = 'MASTERKEY@12345'
);

use AIS
go

BACKUP CERTIFICATE PW_ENCRYPT_CERT
TO FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\PW_Encryption_backup_CERT.cer'
WITH PRIVATE KEY 
(
    FILE = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER1\MSSQL\Backup\PW_Encryption_backup_CERT.prvk',
    ENCRYPTION BY PASSWORD = 'MASTERKEY@12345'
);

USE master
RESTORE DATABASE AIS;