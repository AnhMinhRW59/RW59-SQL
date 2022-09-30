-- Q1: tạp view có chứa danh sách nhân viên thuộc phòng giáo viên

CREATE VIEW Thanh_vien_phong_giao_vien AS
    SELECT 
        account_id
    FROM
        account
    WHERE
        Department_id = 3;
        
-- Q2: Tạo view có chứa thông tin các account tham gia vào nhiều group nhất
CREATE VIEW acc_in_group AS
SELECT 
    A.*, COUNT(GA.Group_id) AS CountGA
FROM
    groupaccount GA
        JOIN
    account A ON GA.Account_id = A.Account_id
GROUP BY A.Account_id
HAVING COUNT(ga.group_id) = (SELECT 
        MAX(c)
    FROM
        (SELECT 
            COUNT(ga.group_id) AS c
        FROM
            groupaccount AS ga
        GROUP BY ga.account_id) B);
    
-- Q3: Tạo view có chứa câu hỏi có những content quá dài (content quá 300 từ được coi là quá dài) và xóa nó đi
		create view  content_too_much_word as 
      SELECT 
    *
FROM
    question
WHERE
    LENGTH(content) > 8;
DELETE FROM question 
WHERE
    LENGTH(content) > 8;
    
    -- Q4: tạo view có chứa danh sách các phòng ban có nhiều nhân viên nhất 
    create view dep_hav_most_emp as
    SELECT 
    D.*, COUNT(A.Department_id) as 'số lượng nhân viên'
FROM
    department D
        LEFT JOIN
    account A ON D.Department_id = A.Department_id
GROUP BY D.Department_name
ORDER BY COUNT(A.Department_id) DESC;

	-- Q5: Tạo view có tất cả những câu hỏi do ueser họ Nguyễn tạo ra
 CREATE VIEW Ques_by_Nguyen AS
    SELECT 
        Q.*
    FROM
        question Q
            LEFT JOIN
        account A ON Q.Creator_id = A.Account_id
    WHERE
        A.Full_name LIKE 'Nguyen%';
        