-- Create Database Encryption
-- Create DMK in master server to perform TDE
USE master;

-- Create a Database Master Key (DMK) if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE symmetric_key_id = 101)
BEGIN
    CREATE MASTER KEY
    ENCRYPTION BY PASSWORD = 'MASTERKEY@12345';
END;

-- Check all exist keys
USE master;
SELECT * FROM sys.symmetric_keys
SELECT * FROM sys.certificates

-- Create certificate
CREATE CERTIFICATE AIS_TDE WITH SUBJECT = 'AIS Database Encryption';

-- Perform encryption to the database for encryption
USE AIS;

GO

CREATE DATABASE ENCRYPTION KEY
WITH ALGORITHM = AES_256
ENCRYPTION BY SERVER CERTIFICATE AIS_TDE;

GO

ALTER DATABASE AIS
SET ENCRYPTION ON;
GO

-- Check information of the encryption
USE master;
SELECT db_name(a.database_id) AS DBName , a.encryption_state_desc, 
a.encryptor_type , *-- , b.name as 'DEK Encrypted By'
FROM sys.dm_database_encryption_keys a
INNER JOIN sys.certificates b ON a.encryptor_thumbprint = b.thumbprint
-------------------------------


-- Create Password Encryption
USE AIS
CREATE CERTIFICATE PW_ENCRYPT_CERT   
   WITH SUBJECT = 'Password Encryption';  
GO
--------------------------------