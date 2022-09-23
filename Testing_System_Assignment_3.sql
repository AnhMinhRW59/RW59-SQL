	
    -- Q2: lấy ra tất cả các phòng ban
SELECT 
    *
FROM
    department;
	
    -- Q4: lấy ra thông tin account có full name dài nhất
select max(length(full_name)) from `account`;
SELECT 
    full_name
FROM
    `account`
WHERE
    LENGTH(full_name) = 16;

	-- Q5: lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id =3
    SELECT 
    MAX(LENGTH(full_name))
FROM
    account
WHERE
    Department_id = 3;

SELECT 
   *
FROM
    `account`
WHERE
    Department_id = 3
        AND LENGTH(full_name) = 16;
	
    -- Q6: Lấy ra tên group đã tham gia trước ngày 20/12/2019
SELECT 
    create_date
FROM
    `group`
WHERE
    create_date < '2019-12-20';
	
    -- Q7: Lấy ra Id của Question có >=4 câu trả lời 
SELECT 
    COUNT(Question_id), Question_id
FROM
    answer
GROUP BY Question_id
HAVING COUNT(Question_id) >= 4;
	
    -- Q8: Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trc ngày 20/12/2019
SELECT 
    exam_id AS MaDeThi,
    Duration AS ThoiGianLamBai,
    Creat_date AS NgayTaoBaiThi
FROM
    exam
WHERE
    Duration >= 60
        AND Creat_date < '2019-12-20';
	
    -- Q9: Lấy ra 5 group đc tạo gần đây nhất
SELECT 
    *
FROM
    `group`
ORDER BY create_date DESC
LIMIT 3;
	
    -- Q10: Đếm số nhân viên thuộc department có id =2
SELECT 
    COUNT(Department_id)
FROM
    account
WHERE
    Department_id = 2;
	
    -- Q11: Lấy ra nhân viên có tên bắt đầu bằng chứ "D" và kết thúc bằng chữ "o"
SELECT 
    *
FROM
    Account
WHERE
    full_name LIKE 'D%'
        AND full_name LIKE '%o';
	-- Q12: Xóa tất cả các exam được tạo trước ngày 20/12/2019
DELETE FROM exam 
WHERE
    Creat_date < '2019-12-20';

-- Q13: Xóa tất cả các question có nội dung bắt đầu bằng từ câu hỏi
DELETE content FROM Question 
WHERE
    content LIKE 'câu hỏi%';

-- Q14: update thông tin của account có id =5 thành tên "Nguyễn Bá Lộc" và email thành "loc.nguyenba@vti.com.vn"
SELECT * FROM testing_system_assignment_2.account;
UPDATE account 
SET 
    account_id = 5,
    email = 'loc.nguyenba@vti.com.vn',
    user_name = 'Loc Nguyen',
    full_name = 'Nguyễn Bá Lộc';

-- Q15: update account có id =5 sẽ thuộc group có id =4
select * from groupaccount;
UPDATE groupaccount 
SET 
    account_id = 5
WHERE
    group_id = 4;

