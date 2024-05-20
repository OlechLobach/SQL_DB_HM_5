CREATE DATABASE Hospital;
GO

USE Hospital;
GO

CREATE TABLE Departments (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Building INT NOT NULL CHECK (Building BETWEEN 1 AND 5),
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Doctors (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0)
);

CREATE TABLE DoctorsExaminations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StartTime TIME NOT NULL CHECK (StartTime BETWEEN '08:00' AND '18:00'),
    EndTime TIME NOT NULL CHECK (EndTime > StartTime),
    DoctorId INT NOT NULL FOREIGN KEY REFERENCES Doctors(Id),
    ExaminationId INT NOT NULL FOREIGN KEY REFERENCES Examinations(Id),
    WardId INT NOT NULL FOREIGN KEY REFERENCES Wards(Id)
);

CREATE TABLE Donations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Amount MONEY NOT NULL CHECK (Amount > 0),
    Date DATE NOT NULL DEFAULT GETDATE() CHECK (Date <= GETDATE()),
    DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id),
    SponsorId INT NOT NULL FOREIGN KEY REFERENCES Sponsors(Id)
);

CREATE TABLE Examinations (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Sponsors (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Wards (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(20) NOT NULL UNIQUE,
    Places INT NOT NULL CHECK (Places >= 1),
    DepartmentId INT NOT NULL FOREIGN KEY REFERENCES Departments(Id)
);