create database Testing_System_Assignment_1;
Use Testing_System_Assignment_1;

CREATE TABLE Department (
    Department_id INT,
    Department_name VARCHAR(50)
);

CREATE TABLE Position (
    Position_id INT,
    position_name VARCHAR(50)
);

CREATE TABLE Account (
    Account_id INT,
    Email VARCHAR(100),
    User_name VARCHAR(50),
    Full_name VARCHAR(50),
    Department_id INT,
    Poisiton_id INT,
    Create_date DATE
);

CREATE TABLE Nhom (
    Group_id INT,
    Group_name VARCHAR(50),
    creator_id INT,
    create_date DATE
);

CREATE TABLE GroupAccount (
    Group_id INT,
    Account_id INT,
    Join_date DATE
);

CREATE TABLE TypeQuestion (
    Type_id INT,
    Type_name VARCHAR(50)
);

CREATE TABLE CategoryQuestion (
    Category_id INT,
    Category_name VARCHAR(50)
);

CREATE TABLE Question (
    Question_id INT,
    Content VARCHAR(255),
    Category_id INT,
    Type_id INT,
    Creator_id INT,
    Creat_date DATE
);

CREATE TABLE Answer (
    Answer_id INT,
    Content VARCHAR(255),
    Question_id INT,
    is_Correct VARCHAR(10)
);

CREATE TABLE Exam (
    Exam_id INT,
    `Code` INT,
    Title VARCHAR(50),
    Category_id INT,
    Duration INT,
    Creator_id INT,
    Creat_date DATE
);

CREATE TABLE ExamQuestion (
    Exam_id INT,
    Question_id INT
);
