create database Extra_Assignment_3;
Use Extra_Assignment_3;

CREATE TABLE Id_Management (
    ID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `Name` VARCHAR(50) NOT NULL,
    Birthdate DATE NOT NULL,
    Gender ENUM('Male', 'Femael', 'Unknown'),
    IsdeleteFlag ENUM('Active', 'Delete')
);