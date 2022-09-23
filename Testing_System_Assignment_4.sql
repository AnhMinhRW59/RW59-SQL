-- Q1: viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ
select * from account;
SELECT 
    A.Account_id, A.full_name, Department_name
FROM
    `account` AS A
        RIGHT JOIN
    department AS D ON A.Department_id = D.Department_id
GROUP BY A.Full_name;

-- Q2: Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010
SELECT 
    *
FROM
    account
WHERE
    Create_date > '2010-12-20';

-- Q3: Viết lệnh để lấy ra tất cả các dev

SELECT 
    A.*, C.ten_ChucVu
FROM
    account AS A
        LEFT JOIN
    chuc_vu AS C ON A.id_ChucVu = C.id_ChucVu
WHERE
    A.id_ChucVu = 4
;

-- Q4: Viết lệnh để lấy ra danh sách phòng ban có >3 nhân viên
select * from account;
SELECT 
    D.Department_name,
    COUNT(D.Department_id) AS 'tổng nhân viên trong phòng ban'
FROM
    department AS D
        LEFT JOIN
    account AS A ON A.Department_id = D.Department_id
GROUP BY D.Department_id
HAVING COUNT(D.Department_id) > 3;

-- Q5: 	viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất
SELECT 
    Q.Question_id, EQ.Exam_id, COUNT(Q.Question_id) as 'số lượng câu hỏi sử dụng trong đề thi'
FROM
    question AS Q
        RIGHT JOIN
    examquestion AS EQ ON EQ.Question_id = Q.Question_id
GROUP BY Q.Question_id
ORDER BY Q.Question_id
LIMIT 1;

-- Q6: Thống kế mỗi Category Question được sử dụng trong bao nhiêu question

SELECT 
   C.Category_id, Category_name, COUNT(Q.Category_id)
FROM
    question AS Q
    left JOIN
    categoryquestion AS C ON C.Category_id = Q.Category_id
GROUP BY Q.Category_id;


-- Q7: Thống kê mỗi Question được sử dụng trong bao nhiêu exam
SELECT 
    EQ.Question_id, Q.Content, COUNT(EQ.Exam_id)
FROM
    examquestion AS EQ
        LEFT JOIN
    question AS Q ON Q.Question_id = EQ.Question_id
GROUP BY EQ.Question_id;

-- Q8: Lấy ra question có nhiều câu trả lời nhất
SELECT 
    A.Question_id, COUNT(A.Question_id)
FROM
    answer AS A
        LEFT JOIN
    question AS Q ON A.Question_id = Q.Question_id
GROUP BY A.Question_id
order by count(A.Question_id) desc
limit 1;

-- Q9: Thống kê số lượng account trong mỗi group
SELECT 
    GA.Group_id, COUNT(GA.Account_id) AS 'số lượng thành viên'
FROM
    groupaccount AS GA
        LEFT JOIN
    account AS A ON GA.Account_id = A.Account_id
GROUP BY GA.Group_id
;

-- Q10: tìm chức vụ có ít người nhất
SELECT 
    A.Department_id,
    D.Department_name,
    COUNT(A.Department_id) AS 'số thành viên'
FROM
    account AS A
        LEFT JOIN
    department AS D ON A.Department_id = D.Department_id
GROUP BY A.Department_id
ORDER BY COUNT(A.Department_id)
LIMIT 1;

-- Q11: thống kê mỗi phòng ban có bao nhiêu dev, test, scrum Master, Pm
SELECT 
    D.Department_id,
    D.Department_name,
    CV.ten_ChucVu,
    COUNT(A.id_ChucVu) AS 'số lượng thành viên'
FROM
    account AS A
        LEFT JOIN
    chuc_vu AS CV ON A.id_ChucVu = CV.id_ChucVu
        LEFT JOIN
    department AS D ON A.Department_id = D.Department_id
GROUP BY D.Department_id , CV.id_ChucVu;


-- Q12: Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì,...
SELECT 
    Q.Question_id,
    Q.Content,
    Q.Type_id,
    Q.Creator_id,
    A.Answer_id,
    A.is_Correct
FROM
    question AS Q
        LEFT JOIN
    answer AS A ON Q.Question_id = A.Question_id;
    
    -- Q13: Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm
    SELECT 
    TQ.Type_name as 'Loại câu hỏi' , COUNT(Q.Type_id) as 'số lượng câu hỏi'
FROM
    question AS Q
        LEFT JOIN
    typequestion AS TQ ON Q.Type_id = TQ.Type_id
GROUP BY TQ.Type_name;

-- Q14: lấy ra group không có account nào
 -- do sửa nhiều dữ liệu nên xin phép bỏ qua câu hỏi này, câu 16 tương tự 

-- Q16 Lấy ra question không có anwser nào
SELECT 
    *
FROM
    answer AS A
        RIGHT JOIN
    question AS Q ON A.Question_id = Q.Question_id
WHERE
    A.Answer_id IS NULL;
    

-- Exercise 2:
-- Q17: 
SELECT * FROM testing_system_assignment_2.groupaccount;
SELECT 
    account_id, Group_id
FROM
    groupaccount
WHERE
    Group_id = 1 
    union
    
SELECT 
    account_id, Group_id
FROM
    groupaccount
WHERE
    Group_id = 2;
    
    -- Q18: 
    SELECT 
    Group_id, COUNT(Account_id) AS 'số lượng thành viên'
FROM
    groupaccount
GROUP BY Group_id
HAVING COUNT(Account_id) > 1 
UNION ALL SELECT 
    Group_id, COUNT(Account_id) AS 'số lượng thành viên'
FROM
    groupaccount
GROUP BY Group_id
HAVING COUNT(Account_id) < 3;



