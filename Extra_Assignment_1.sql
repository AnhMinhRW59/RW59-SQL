create database Trainee;
use Trainee;

CREATE TABLE Trainee_Manager (
    Trainee_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    Birth_date DATE NOT NULL,
    Gender ENUM('male', 'female', 'unknown'),
    Et_iq INT NOT NULL,
    ET_gmath INT NOT NULL,
    Et_English INT NOT NULL,
    Training_class VARCHAR(50) NOT NULL,
    Evaluation_note varchar(255) NULL UNIQUE,
    VTI_account VARCHAR(50) NOT NULL UNIQUE,
    CONSTRAINT CHK_Trainee_Manager CHECK (Et_iq >= 0 AND Et_iq <= 20
        AND Et_gmath >= 0
        AND Et_gmath <= 20
        AND Et_english >= 0
        AND Et_English <= 50)
);

