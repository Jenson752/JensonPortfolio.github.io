# Academic Information System (AIS) Security Enhancement Project (Use Case)

## Overview
This project aims to enhance the security features of the Academic Information System (AIS) at AP College. The focus is on implementing robust database security methodologies to protect sensitive data, manage user permissions effectively, and ensure compliance with security standards.

## Project Goals

- Implement comprehensive security measures to safeguard AIS database from threats.
- Ensure adherence to security best practices and compliance with specified security requirements.
- Enhance data protection, user access management, and auditing capabilities within the system.

## Methodologies for Database Security Implementation

### Security Requirements and Implementation

### 1. Permission Management

#### 1.1 Authentication
- **Login Creation and Management**: 
  - DB Admins are responsible for creating and managing user logins.
  - User IDs are created for students and lecturers, mapped to their respective roles to facilitate access and management.

#### 1.2 Authorization (Privilege Control)
- **Role Definitions**:
  - **DB Admins**: Have broad control over the database, including user and permission management, but are restricted from accessing sensitive academic data and user passwords directly.
  - **Lecturers**: Can view and update their personal information, manage academic records for their students, and view relevant student data within their department.
  - **Students**: Can view and update their own personal details and academic results, with no access to other students' information.

- **Least Privilege Principle**:
  - Permissions are granted based on the minimum level required for each role to perform their tasks.
  - Regular reviews ensure that roles maintain only necessary access rights.

#### 1.3 Access Control Mechanisms
- **Role-Based Security**:
  - Permissions are managed using predefined SQL Server roles, streamlining control by assigning access based on roles rather than individual users.

- **Views**:
  - Database views are utilized to filter and restrict access to sensitive information, ensuring DB Admins and other roles only see non-sensitive data.

- **Stored Procedures**:
  - Operations are performed via stored procedures to enforce business rules and security policies, minimizing direct access to tables.

- **Dynamic Data Masking and Row-Level Security (RLS)**:
  - Sensitive data fields are masked to prevent unauthorized viewing.
  - Row-Level Security is implemented to ensure users can only access records relevant to their own role or identity, enhancing data isolation and protection.
    
### 2. Data Protection

#### 2.1 Data Classification

- **Identify Data Categories**:
  - Classify data into categories such as personal information (e.g., student names, addresses), academic records (e.g., grades, course enrollments), and administrative data (e.g., user credentials).

- **Assign Sensitivity Levels**:
  - Determine sensitivity levels (e.g., public, confidential, sensitive) for each data category based on regulatory requirements and organizational policies.

#### 2.2 Transparent Data Encryption (TDE)
- Encrypts the entire AIS database to protect data at rest.

### 2.3 Column-Level Encryption
- Provides selective encryption for specific sensitive columns, such as passwords.

### 2.4 Row-Level Security (RLS)
- Restricts data access at the row level based on user roles or identities.

### 2.5 Backup 
- **Full Database Backup**:
  - Performed comprehensive backups of the AIS database to safeguard against data loss, capturing all data, schema, and configuration settings.
- **Transaction Log Backup**:
  - Regularly backed up transaction logs to enable point-in-time recovery and maintain transaction integrity.
- **Master Key and Certificate Backup**:
  - Backed up essential cryptographic keys and certificates to ensure the recoverability of encrypted data.
- **Backup Automation**:
  - Implemented automated backup processes to maintain data protection and minimize potential data loss (Recovery Point Objective of 6 hours).

### 3. Auditing and Logging

#### Audit Trail

#### 3.1 SQL Server Built-in Auditing

- **DDL Auditing**:
  - Enable SQL Server Audit to monitor and log Data Definition Language (DDL) changes such as schema modifications (e.g., table creations, alterations, drops).
  - Configure audit specifications to capture schema changes at the server or database level.

- **Permission Changes**:
  - Utilize SQL Server Audit to track changes in database permissions, including role assignments and permission grants/restrictions.
  - Define audit actions to record permission changes for auditing and compliance purposes.

- **Login and Logout Events**:
  - Implement SQL Server Audit to capture successful and unsuccessful login attempts, as well as logout events.
  - Configure audit specifications to monitor user sessions and login activities.

#### 3.2 Trigger-based Auditing (DML Auditing)

- **Data Modification Logging**:
  - Implement triggers on critical tables to log Data Manipulation Language (DML) changes such as inserts, updates, and deletes.
  - Design trigger logic to capture before and after values of modified data into an audit table for detailed tracking and historical analysis.

### 4. testing and Validation

- [**Test Cases Document:**](https://docs.google.com/document/d/e/2PACX-1vTLrtkxHvd2Zuxte3WI94YkSJcX3xi_TiihFGAezLPl3Nv8wKKflRB7ikvCmEZqnQ/pub) Included SQL scripts for testing security measures and validating database functionalities.
