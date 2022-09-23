SELECT * FROM trainee.trainee_manager;
-- Q3: Viết lệnh để lấy ra thực tập sinh có tên dài nhất, lấy ra các thông tin sau: tên, tuổi, các thông tin cơ bản (như đã được định nghĩa trong table)
SELECT 
    MAX(LENGTH(full_name)) AS 'độ dài Tên',
    full_name,
    Birth_date,
    Gender
FROM
    trainee_manager
GROUP BY full_name
ORDER BY MAX(LENGTH(full_name)) DESC;

-- Q4: Viết lệnh để lấy ra tất cả các thực tập sinh là ET, 1 ET thực tập sinh là những người đã vượt qua bài test đầu vào và thỏa mãn số điểm như sau:
--  ET_IQ + ET_Gmath>=20
--  ET_IQ>=8
--  ET_Gmath>=8
--  ET_English>=18

SELECT 
    Trainee_id,
    Et_iq,
    ET_gmath,
    Et_English,
    SUM(Et_iq + ET_gmath)
FROM
    trainee_manager
WHERE
    Et_iq >= 8 AND ET_gmath >= 8
        AND Et_English >= 18
GROUP BY Trainee_id
HAVING SUM(Et_iq + ET_gmath) >= 20;

-- Q5: xóa thực tập sinh có trainee id =3
DELETE FROM trainee_manager 
WHERE
    Trainee_id = 3;
    
    -- Q6: chuyển thực tập sinh ID =5 sang lớp SH125
    UPDATE trainee_manager 
SET 
    Training_class = 'SH125'
WHERE
    trainee_id = 5;
  

