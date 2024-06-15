-- Create Database
Create Database AIS;

USE AIS; 
 
 -- Create Tables 
Create Table Student( 
ID varchar(6) primary key, 
SystemPwd_E varBinary(Max), 
Name varchar(100) not null, 
Phone varchar(20) 
) 
 
Create Table Lecturer( 
ID varchar(6) primary key, 
SystemPwd_E varBinary(Max), 
Name varchar(100) not null, 
Phone varchar(20), 
Department varchar(30) 
) 
 
Create Table Subject 
( 
Code varchar(5) primary key, 
Title varchar(30) 
) 
 
Create Table Result 
( 
ID int primary key identity (1,1), 
StudentID varchar(6) references Student(ID), 
LecturerID varchar(6) references Lecturer(ID), 
SubjectCode varchar(5) references Subject(Code), 
AssessmentDate date, 
Grade varchar(2) 
) 

