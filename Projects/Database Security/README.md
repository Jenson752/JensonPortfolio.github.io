# Academic Information System (AIS) Security Enhancement Project (Use Case)

## Overview
This project aims to enhance the security features of the Academic Information System (AIS) at AP College. The focus is on implementing robust database security methodologies to protect sensitive data, manage user permissions effectively, and ensure compliance with security standards.

## Project Goals

- Implement comprehensive security measures to safeguard AIS database from threats.
- Ensure adherence to security best practices and compliance with specified security requirements.
- Enhance data protection, user access management, and auditing capabilities within the system.

## Methodologies for Database Security

### 1. Database Design and Security Architecture
- Describe the initial database architecture and identify security vulnerabilities.
- Outline the strategies and methodologies used to enhance database security.

### 2. Security Requirements and Implementation

#### 2.1 Permission Management
- **Authorization Matrix:** Define SQL roles for DB Admins, Students, and Lecturers with least privilege principles.
- **Access Control:** Implement methods used to enforce access control, including views, stored procedures, and role-based security.

#### 2.2 Data Protection
- **Data Classification:** Classify data based on sensitivity levels (e.g., personal information, academic records).
- **Encryption and Hashing:** Implement encryption mechanisms for sensitive data fields and hashing for passwords.

### 2.3 Auditing and Logging

#### Audit Trail

##### SQL Server Built-in Auditing

- **DDL Auditing**:
  - Enable SQL Server Audit to monitor and log Data Definition Language (DDL) changes such as schema modifications (e.g., table creations, alterations, drops).
  - Configure audit specifications to capture schema changes at the server or database level.

- **Permission Changes**:
  - Utilize SQL Server Audit to track changes in database permissions, including role assignments and permission grants/restrictions.
  - Define audit actions to record permission changes for auditing and compliance purposes.

- **Login and Logout Events**:
  - Implement SQL Server Audit to capture successful and unsuccessful login attempts, as well as logout events.
  - Configure audit specifications to monitor user sessions and login activities.

##### Trigger-based Auditing (DML Auditing)

- **Data Modification Logging**:
  - Implement triggers on critical tables to log Data Manipulation Language (DML) changes such as inserts, updates, and deletes.
  - Design trigger logic to capture before and after values of modified data into an audit table for detailed tracking and historical analysis.

### 3. Documentation and Validation

#### 3.1 Data Dictionary
- Provide an updated Data Dictionary detailing database entities, attributes, and their security classifications.

#### 3.2 Testing and Validation
- **Test Cases Document:** Include SQL scripts for testing security measures and validating database functionalities (`DBS_TestCases_<group number>.docx`).
