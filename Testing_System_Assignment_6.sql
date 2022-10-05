-- Q1: tạo store để người dùng nhập vào tên phòng ban và in ra tất cả các account thuộc phòng ban đó

delimiter $$
create procedure pro_department(in in_department_name varchar(20))
	begin 
		SELECT 
    *
FROM
    `account` A
        JOIN
    department D ON A.Department_ID = D.Department_ID
WHERE
    D.Department_Name = in_department_name;
	end$$
delimiter ;

-- Q2: tạo store để in ra số lượng account trong mỗi group
select * from `groupaccount`;
delimiter $$
create procedure proc_acc_in_group (in in_group_id int)
begin
SELECT 
    COUNT(GA.account_id) AS 'số lượng account'
FROM
    groupaccount AS GA
        JOIN
    `group` AS G ON GA.group_id = G.group_id
GROUP BY GA.Group_id
HAVING GA.group_id = in_group_id;
end$$
delimiter ;

-- Q3: Tạo store để thống kê mỗi type Question có bao nhiêu question được tạo trong tháng hiện tại

DELIMITER $$
create procedure proc_Ques_in_month()
		begin
			SELECT 
				tq.*, COUNT(q.Type_ID) as sl_question
			FROM
				typequestion tq
					LEFT JOIN
				question q ON tq.Type_ID = q.Type_ID
			WHERE
				YEAR(q.Creat_Date) = YEAR(NOW())
					AND MONTH(q.creat_Date) = MONTH(NOW())
			GROUP BY tq.type_Id;  
		end$$
DELIMITER ;

-- Q4: tạo store để trả ra id của type Question có nhiều câu hỏi nhất

set global log_bin_trust_function_creators = 1;
DELIMITER $$
create function func_cau4() returns int
		begin
			declare typeId_co_sl_question_max int;
            SELECT 
				q.type_Id into typeId_co_sl_question_max
			FROM
				question q
			GROUP BY q.Type_ID
			HAVING count(q.question_Id) = (SELECT COUNT(q.Question_ID) c2
				FROM
					question q
				GROUP BY q.Type_ID
				ORDER BY c2 DESC
				LIMIT 1);
            return typeId_co_sl_question_max;
		end$$
DELIMITER ;

-- Q5: Sử dụng store của Question 4 để tìm ra tên của Type Question

drop procedure if exists proc_cau5;
delimiter $$
create procedure proc_cau5()
	begin 
		with typeId_co_sl_question_max as 
		(select count(Q.Type_ID) as a
		from question Q
		group by Q.Type_ID)
			select TQ.Type_Name, count(QS.Type_ID) as b
			from typequestion tq
			inner join question QS on TQ.Type_ID = QS.Type_id
			group by TQ.Type_ID  
			having b = (select max(a) from typeId_co_sl_question_max );
	end$$
delimiter ;

-- Q6: Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa chuỗi của người dùng nhập vào

DELIMITER $$
create procedure proc_cau6(
	in in_sequence varchar(255))
		begin
			SELECT 
    a.user_name AS result
FROM
    account a
WHERE
    a.user_name LIKE CONCAT('%', in_sequence, '%') 
UNION SELECT 
    g.group_Name AS result
FROM
    `group` g
WHERE
    g.Group_Name LIKE CONCAT('%', in_sequence, '%');
		end$$
DELIMITER ;


-- Q7: tạo store cho phép người dùng nhập vào thông tin FullName, email và trong store sẽ tự động gán :
-- 				username sẽ giống email nhưng bỏ phần ...@mail đi
-- 				positionID: sẽ có defaul là developer
-- 				departmentID: sẽ được cho vào 1 phòng chờ
-- 		Sau đó in ra kết quả tạo thành công

delimiter $$
create procedure proc_cau7(in in_fullname varchar(255), in in_email varchar(255))
	begin 
		declare username varchar(255) default SUBSTRING_INDEX(in_email, '@', 1);
		declare positionID int  default 5;
		declare departmentID int  default 6;
		declare createDate datetime default now();
		insert into `account` (Email, User_name, Full_Name, Department_ID, id_chucvu, Create_Date)
						value (in_email, username, in_fullname, departmentID, positionID, CreateDate);
	end$$
delimiter ;
select *  from `account`;
-- Q8: Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple_Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất

DELIMITER $$
CREATE PROCEDURE proc_cau8(IN in_typename VARCHAR(255))
	BEGIN 
		DECLARE typeid INT;
		SELECT TQ.Type_ID INTO typeid FROM typequestion TQ
		WHERE TQ.Type_Name = in_typename;
			IF in_typename = 'Essay' THEN 
				WITH cte_max_content AS (
				SELECT length(Q.content) AS a1
				FROM question AS Q
				WHERE Type_ID = typeid)
					SELECT * FROM question QS WHERE Type_ID = typeid 
				AND length(QS.content) = (SELECT max(a1) FROM cte_max_content);
			ELSEIF in_typename = 'Multiple-Choice' THEN 
				WITH cte_max_content AS (
				SELECT length(Q.content) AS a1
				FROM question AS Q
				WHERE Type_ID = typeid)
					SELECT * FROM `question` qs WHERE Type_ID = typeid 
					AND length(QS.content) = (SELECT max(a1) FROM cte_max_content);
			END IF;
	END$$
DELIMITER ;

-- Q9:  Viết 1 store cho phép người dùng xóa exam dựa vào ID

DELIMITER $$
create procedure proc_cau9(in in_examid int)
	begin 
		delete from examquestion EQ where EQ.ExamID = in_examid;
        delete from exam E where E.ExamID = in_examid;
	end$$
delimiter ;

-- Q10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi (sử dụng store ở câu 9 để xóa) 
	-- Sau đó in số lượng record đã remove từ các table liên quan trong khi removing
    
    
    
-- Q11: Viết store cho phép người dùng xóa phòng ban bằng cách nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc

DELIMITER $$
create procedure proc_cau11(in in_departmentname varchar(255))
	begin 
		declare departmentID int;
		select Department_ID into departmentID from department D where D.DepartmentName = in_departmentname;
		update `account` A set A.Department_ID = 6 where A.Department_ID = DepartmentID;
		delete from department D where D.Department_Name = in_departmentname;
	end$$
DELIMITER ;

-- Q12: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong năm nay

-- Q13: Viết store để in ra mỗi tháng có bao nhiêu câu hỏi được tạo trong 6 tháng gần đây nhất (Nếu tháng nào không có thì sẽ in ra là "không có câu hỏi nào trong tháng")