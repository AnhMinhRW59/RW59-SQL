create database Testing_System_Assignment_2;
Use Testing_System_Assignment_2;

CREATE TABLE Department (
    Department_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Department_name VARCHAR(50) NOT NULL
);

CREATE TABLE Chuc_Vu (
    id_ChucVu INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    ten_ChucVu ENUM('Dev', 'Test', 'ScrumMaster', 'PM')
);

CREATE TABLE `Account` (
    Account_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Email VARCHAR(100) DEFAULT 'unknow',
    User_name VARCHAR(50) NOT NULL,
    Full_name VARCHAR(50) NOT NULL,
    Department_id INT,
    id_ChucVu INT,
    Create_date DATE NOT NULL,
    FOREIGN KEY (Department_id)
        REFERENCES department (Department_id),
    FOREIGN KEY (id_ChucVu)
        REFERENCES chuc_vu (id_ChucVu)
);
CREATE TABLE `Group` (
    Group_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Group_name VARCHAR(50) NOT NULL,
    creator_id INT NOT NULL,
    create_date DATE NOT NULL,
    FOREIGN KEY (Creator_id)
        REFERENCES `Account` (Account_id)
);

CREATE TABLE GroupAccount (
    Group_id INT,
    Account_id INT,
    Join_date DATE,
    FOREIGN KEY (Group_id)
        REFERENCES `Group` (Group_id),
    FOREIGN KEY (Account_id)
        REFERENCES `Account` (Account_id),
    CONSTRAINT `GroupAcc_Pk` PRIMARY KEY (Group_id , Account_id)
);	

CREATE TABLE TypeQuestion (
    Type_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Type_name ENUM('Essay', 'Multiple-Choice')
);

CREATE TABLE CategoryQuestion (
    Category_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Category_name VARCHAR(50)
);

CREATE TABLE Question (
    Question_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Content VARCHAR(255) NOT NULL,
    Category_id INT NOT NULL,
    Type_id INT NOT NULL,
    Creator_id INT NOT NULL,
    Creat_date DATE,
    FOREIGN KEY (Category_id)
        REFERENCES CategoryQuestion (Category_id),
    FOREIGN KEY (Type_id)
        REFERENCES TypeQuestion (Type_id),
    FOREIGN KEY (Creator_id)
        REFERENCES `Account` (Account_id)
);

CREATE TABLE Answer (
    Answer_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Content VARCHAR(255) DEFAULT 'ngu',
    Question_id INT,
    is_Correct ENUM('T', 'F'),
    FOREIGN KEY (Question_id)
        REFERENCES Question (Question_id)
);

CREATE TABLE Exam (
    Exam_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    `Code` INT NOT NULL,
    Title VARCHAR(50) NOT NULL,
    Category_id INT NOT NULL,
    Duration INT NOT NULL,
    Creator_id INT NOT NULL,
    Creat_date DATE,
    FOREIGN KEY (Creator_id)
        REFERENCES `Account` (Account_id),
    FOREIGN KEY (Category_id)
        REFERENCES CategoryQuestion (Category_id)
);

CREATE TABLE ExamQuestion (
    Exam_id INT,
    Question_id INT,
    FOREIGN KEY (Exam_id)
        REFERENCES Exam (Exam_id)
        );


insert into Department (department_id, department_name)
value ('1', 'phong hieu truong'), ('2', 'phong hieu pho'), ('3', 'phong giao vien'), ('4', 'phong tap vu'), ('5', 'phong bao ve'); 

insert into chuc_vu (id_chucvu, ten_chucvu)
value ('1', 'Pm'), ('2', 'ScrumMaster'), ('3', 'Test'), ('4', 'Dev');

insert into `account` (Account_id, email, user_name, full_name, department_id, id_chucvu, create_date)
value 
	('555', 'MinhKhue_Dao@gmail.com', 'Minh Khue', 'Dao Minh Khue', '1', '1', '2000-08-25'),
	('389', 'DiemKieu_Tran@gmail.com', 'Kieu Diem', 'Tran Diem Kieu', '2', '2', '2000-12-12'),
	('325', 'TramAnh_Tran@gmail.com', 'Tran Tram', 'Tran Tram Anh', '2', '2', '2002-05-15'),
	('865', 'Nguyet_Cat@gmail.com', 'Nguyet Cat', 'Hoang Nguyet Cat', '3', '3', '2002-06-28'),
	('654', 'ThaiHoa_Nguyen@gmail.com', 'Thai Hoa', 'Nguyen Thai Hoa', '3', '3', '2001-07-30'),
	('568', 'Bac_Nguyen@gmail.com', 'BAC', 'Nguyen Van Bac', '3', '4', '2002-09-09'),
	('698', 'HaMi_Kieu@gmail.com', 'Ha Mi', 'Kieu Ha Mi', '3', '4', '2005-12-29'),
	('845', 'TuanTran@gmail.com', 'Tuan', 'Tran Tuan', '5', '4', '2008-09-01'),
	('965', 'HaoNam@gmail.com', 'Nam Lun', 'Tran Hao Nam', '3', '4', '2006-12-15'),
	('625', 'Hoang_Ngan@gmail.com', 'Ngan_Hoang', 'Hoang Thao Ngan', '4', '4', '2007-06-06');
    
insert into `group` (group_id, group_name, creator_id, create_date)
value 
	('1', 'CBCA', '555', '2000-05-05'),
	('2', 'CBCNV', '389', '2001-05-05'),
    ('3', 'GV', '325', '2002-06-12'),
    ('4', 'QuestionForExam', '325', '2005-12-24'),
    ('5', 'Students', '625', '2001-05-05');
    
insert into GroupAccount (Group_id, Account_id, Join_date)
value
	('1', '555', '2000-05-05'),
    ('1', '389', '2001-12-13'),
    ('2', '625', '2007-06-10'),
    ('2', '965', '2006-12-17'),
    ('4', '654', '2001-08-05'),
	('5', '845', '2010-08-10');
    
insert into TypeQuestion (Type_id, type_name)
value 
	('1', 'Essay'),
    ('2', 'Multiple-Choice');
    
insert into CategoryQuestion (Category_id, Category_name)
value
	('1', 'Java'),
    ('2', '.NET'),
    ('3', 'Sql'),
    ('4', 'Postman'),
    ('5', 'Ruby');
    
insert into Question (Question_id, Content, Category_id, Type_id, Creator_id, Creat_date)
value 
	('1', 'abcklz', '1', '2', '625', '2010-06-08'),
    ('2', 'abcklo', '2', '2', '965', '2012-06-08'),
    ('3', 'abcklx', '3', '1', '965', '2014-08-08'),
    ('4', 'abcklm', '4', '2', '845', '2020-12-12'),
    ('5', 'abckln', '5', '1', '654', '2022-04-08');
    
insert into Answer (Answer_id, Content, Question_id, Is_correct)
value
	('1', 'asdfsdf', '4', 'T'),
    ('2', 'scvzcxv', '5', 'T'),
    ('3', 'xcvbfsf', '1', 'F'),
    ('4', 'uioyuio', '3', 'F'),
    ('5', 'erytbnm', '2', 'F');
    
insert into Exam (Exam_id, `code`, Title, Category_id, Creator_id, Creat_date, Duration)
value
	('1', '2685', 'nothing', '2', '654', '2014-08-08', '60'),
    ('2', '6895', 'in', '4', '845', '2019-12-05', '60'),
    ('3', '4852', 'your', '4', '845', '2019-03-07', '120'),
    ('4', '2586', 'Eyes', '5', '654', '2022-02-19', '120'),
    ('5', '9856', 'Mylove', '3', '625', '2022-08-15', '180');
    
insert into ExamQuestion (Exam_id, Question_id)
value
	('1', '1'),
    ('2', '1'),
    ('3', '4'),
    ('4', '3'),
    ('5', '2');
    
    
    
    
    
    
    
    


