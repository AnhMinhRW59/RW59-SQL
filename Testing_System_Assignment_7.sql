-- Q1: Tạo trigger không cho phép người dùng nhập vào group có ngày tạo trước 1 năm trước
select * from `group`;
drop trigger if exists non_input;
delimiter $$
create trigger non_input 
before insert on `group` 
for each row 
begin 
if year(new.create_date) < year(now()) -1 then
signal SQLstate '45000' 
set message_text='không thể nhập dữ liệu vào group với những tài khoản tạo trước 30/9/2021';
end if;
end$$
delimiter ;

-- Q2: Tạo trigger Không cho phép người dùng thêm bất kỳ user nào vào department 'Sale' nữa, khi thêm thì hiện ra thông báo 'Deapartment 'sale' cannot add more user'
select * from account;
	drop trigger if exists trig_insert_dept;
	delimiter $$
	create trigger trig_insert_dept 
	before insert on `account` 
	for each row 
	begin 
	if department_id =1 then
	signal SQLstate '45000' 
	set message_text='cannot add more user';
	end if;
	end$$
	delimiter ;


-- Q3: Cấu hình 1 group có nhiều nhất là 5 user

drop trigger if exists trig_validate_insert_group_max_5_acc;
delimiter $$
create trigger trig_validate_insert_group_max_5_acc
before insert on groupaccount
for each row
begin
	declare count_acc int;
    declare message varchar(255) default concat('Cant insert account with groupId: ', new.group_Id,  '. Because this group is fulfill (5acc)');
	SELECT 
		COUNT(ga.Account_ID)
	INTO count_acc FROM
		`group` g
			JOIN
		groupaccount ga ON g.Group_ID = ga.Group_ID
	GROUP BY g.Group_ID
	HAVING g.Group_ID = new.Group_ID;
    if count_acc >= 5 then
		signal sqlstate '45000'
        set message_text = message;
    end if;
end $$
delimiter ;

-- Q4: Cấu hình 1 bài thi có nhiều nhất là 10 question

SELECT 
    *
FROM
    examquestion;
    drop trigger if exists limit_ques_in_exam;
    delimiter $$
	create trigger limit_ques_in_exam 
	before insert on `examquestion` 
	for each row 
	begin 
    declare count_ques int;
	select count(Question_id) into count_ques from examquestion where Exam_id = new.Exam_id ;
    if new.count(Question_id) > 1 then
	signal SQLstate '45000' 
	set message_text='cannot insert more question in exam';
	end if;
	end$$
	delimiter ;
    

-- Q5: tạo trigger không cho phép người dùng xóa tài khoản có email là admin@gmail.com (đây là tài khoản admin, không cho phép user xóa)
-- còn lại các tài khoản khác thì sẽ cho phép xóa và sẽ xóa tất cả các thông tin liên quan tới user đo 

DELIMITER $$
CREATE TRIGGER trig_del_acc
BEFORE DELETE ON `Account` 
FOR EACH ROW
BEGIN
DECLARE emailadmin varchar(255);
SET emailadmin = 'admin@gmail.com';
IF (OLD.Email = emailadmin) THEN 
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Khong cho phep xoa user nay';
END IF;
END $$
DELIMITER ;

-- Q6: Không sử dụng cấu hình default cho field DepartmentID của table Account 
-- tạo trigger cho phép user khi tạo account không điền vào DepartmentID thì sẽ chuyển đến "phòng chờ"

DELIMITER $$
CREATE TRIGGER trig_cre_acc
before insert ON `Account` 
FOR EACH ROW
BEGIN
IF new.department_id is null THEN
set new.department_id = 6;
END IF;
END $$
DELIMITER ;

-- Q7: Cấu hình 1 bài thi chỉ cho phép user tạo tối đa 4 answers cho mỗi question, trong đó có tối đa 2 đáp án đúng.

DELIMITER $$
CREATE TRIGGER trig_sl_asw_each_ques
-- chưa làm đc
DELIMITER ;

-- Q8: Viết trigger không cho phép người dùng xóa bài thi mới tạo được 2 ngày:

drop trigger if exists trig_del_ex;
DELIMITER $$
CREATE TRIGGER trig_del_ex
before delete ON exam
FOR EACH ROW
BEGIN
IF day(old.creat_date) > day(now()) -2 THEN
signal SQLstate '45000' 
set message_text='không thể xóa bài thi mới tạo 2 ngày';
end if;
end$$
DELIMITER ;

-- Q10:  Viết trigger chỉ cho phép người dùng chỉ được update, delete các question khi question đó chưa nằm trong exam nào

drop trigger if exists trig_update_del_ques;
DELIMITER $$
CREATE TRIGGER trig_update_del_ques
before  update ON question
FOR EACH ROW
BEGIN
declare QuesID int;
set QuesID = 0;
SELECT count(exam_id) INTO QuesID FROM Examquestion
		WHERE Question_ID = NEW.Question_ID; 
if (QuesID != 0) THEN 
signal SQLstate '45000' 
set message_text='không thể update câu hỏi này';
end if;
end$$
DELIMITER ;

drop trigger if exists trig_del_ques;
DELIMITER $$
CREATE TRIGGER trig_del_ques
before  delete ON question
FOR EACH ROW
BEGIN
declare QuesID int;
set QuesID = 0;
SELECT count(exam_id) INTO QuesID FROM Examquestion
		WHERE Question_ID = old.Question_ID; 
if (QuesID != 0) THEN 
signal SQLstate '45000' 
set message_text='không thể delete câu hỏi này';
end if;
end$$
DELIMITER ;

-- Q12: Lấy ra thông tin exam trong đó:
		-- Duration <=30 thì sẽ đổi giá trị thành "short time"
        -- 30 < Duration <= 60 thì sẽ đổi thành giá trị "medium time"
        -- Duratin >60 thì đổi thành giá trị 'long time'
        
select exam_id, `code`, title, Category_id, case 
when duration <= 30 then 'short time'
when duration <= 60  then 'medium time'
when duration > 60 then 'long time time'
end AS Duration, Creator_ID , Creat_Date  

from exam;


-- Q13: Thống kê số account trong mỗi group và in ra thêm 1 column nữa có tên
-- là the_number_user_amount và mang giá trị được quy định như sau:
-- Nếu số lượng user trong group =< 5 thì sẽ có giá trị là few
-- Nếu số lượng user trong group <= 20 và > 5 thì sẽ có giá trị là normal
-- Nếu số lượng user trong group > 20 thì sẽ có giá trị là higher
SELECT 
    Group_ID,
    COUNT(account_id) AS sl_acc,
    CASE
        WHEN COUNT(account_id) <= 1 THEN 'few'
        WHEN COUNT(account_id) <= 2 THEN 'normal'
        ELSE 'higher'
    END AS the_number_user_amount
FROM
    Groupaccount
GROUP BY Group_ID;

-- Q14: Thống kê mỗi phòng ban có bao nhiêu user , nếu phòng ban nào k có user thì sẽ thay đổi giá trị 0 thành 'không có user'

select * from account;
select * from department;
SELECT 
    D.Department_id,
    CASE
        WHEN COUNT(A.Department_ID) = 0 THEN 'Không có User'
        ELSE COUNT(A.Department_ID)
    END AS sl_acc
FROM
    department D
        LEFT JOIN
    account A ON D.Department_id = A.Department_id
GROUP BY D.Department_id;
