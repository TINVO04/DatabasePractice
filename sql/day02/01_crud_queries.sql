-- Day 2 - CRUD queries
-- Database: database_practice
-- Mục tiêu: luyện SELECT, INSERT, UPDATE, DELETE và WHERE.

-- =====================================================
-- 1. Seed data: courses
-- =====================================================
-- INSERT dùng để thêm dữ liệu mới vào bảng.
-- Ở đây mình thêm 5 khóa học mẫu.

INSERT INTO courses (course_name, description)
VALUES
    ('SQL Basic', 'Learn basic SQL syntax'),
    ('CSharp OOP', 'Learn object-oriented programming in C#'),
    ('ASP.NET Core API', 'Build REST API with ASP.NET Core'),
    ('Entity Framework Core', 'Work with database using EF Core'),
    ('Git and GitHub', 'Learn source control and collaboration');

-- =====================================================
-- 2. Seed data: students
-- =====================================================
-- Thêm ít nhất 20 học viên mẫu.
-- Email cần khác nhau vì cột email có UNIQUE trong bảng students.

INSERT INTO students (full_name, email, date_of_birth)
VALUES
    ('Nguyen Van An', 'an.nguyen@example.com', '2001-01-15'),
    ('Tran Thi Binh', 'binh.tran@example.com', '2000-03-22'),
    ('Le Minh Chau', 'chau.le@example.com', '2002-07-10'),
    ('Pham Quoc Dung', 'dung.pham@example.com', '1999-11-05'),
    ('Hoang Thi Em', 'em.hoang@example.com', '2001-09-18'),
    ('Vo Thanh Giang', 'giang.vo@example.com', '2003-02-25'),
    ('Dang Ngoc Ha', 'ha.dang@example.com', '2000-12-30'),
    ('Bui Van Hieu', 'hieu.bui@example.com', '2002-04-14'),
    ('Do Thi Khanh', 'khanh.do@example.com', '2001-06-09'),
    ('Ngo Minh Long', 'long.ngo@example.com', '1998-08-21'),
    ('Duong Bao Nam', 'nam.duong@example.com', '2003-10-11'),
    ('Ly Thanh Oanh', 'oanh.ly@example.com', '2000-05-19'),
    ('Mai Quang Phuc', 'phuc.mai@example.com', '2002-01-07'),
    ('Truong Nhu Quynh', 'quynh.truong@example.com', '2001-03-03'),
    ('Huynh Van Son', 'son.huynh@example.com', '1999-07-27'),
    ('Phan Minh Tam', 'tam.phan@example.com', '2002-09-13'),
    ('Lam Thu Uyen', 'uyen.lam@example.com', '2001-12-01'),
    ('Cao Duc Viet', 'viet.cao@example.com', '2000-02-17'),
    ('Ta Hoai Xuan', 'xuan.ta@example.com', '2003-04-29'),
    ('Vu Ngoc Yen', 'yen.vu@example.com', '2002-06-06');

-- =====================================================
-- 3. INSERT: thêm một sinh viên mới
-- =====================================================
-- INSERT thêm một dòng dữ liệu mới vào bảng students.
-- Email phải là email chưa tồn tại vì cột email có UNIQUE.

INSERT INTO students (full_name, email, date_of_birth)
VALUES ('Test Student', 'test.student@example.com', '2004-01-01');

-- Kiểm tra sinh viên vừa thêm.
SELECT id, full_name, email, date_of_birth, created_at
FROM students
WHERE email = 'test.student@example.com';

-- =====================================================
-- 4. UPDATE: sửa thông tin sinh viên
-- =====================================================
-- UPDATE dùng để sửa dữ liệu đã có.
-- WHERE giúp chỉ sửa đúng sinh viên cần sửa.

UPDATE students
SET
    full_name = 'Test Student Updated',
    date_of_birth = '2004-02-02'
WHERE email = 'test.student@example.com';

-- Kiểm tra dữ liệu sau khi update.
SELECT id, full_name, email, date_of_birth, created_at
FROM students
WHERE email = 'test.student@example.com';

-- =====================================================
-- 5. DELETE: xóa sinh viên theo điều kiện
-- =====================================================
-- DELETE dùng để xóa dữ liệu.
-- Luôn kiểm tra bằng SELECT trước khi DELETE để tránh xóa nhầm.

SELECT id, full_name, email
FROM students
WHERE email = 'test.student@example.com';

DELETE FROM students
WHERE email = 'test.student@example.com';

-- Kiểm tra lại, nếu không còn dòng nào nghĩa là đã xóa thành công.
SELECT id, full_name, email
FROM students
WHERE email = 'test.student@example.com';

-- =====================================================
-- 6. SELECT: lấy danh sách sinh viên
-- =====================================================
-- SELECT dùng để đọc dữ liệu từ bảng.
-- ORDER BY dùng để sắp xếp kết quả.

SELECT id, full_name, email, date_of_birth, created_at
FROM students
ORDER BY id ASC;

-- =====================================================
-- 7. SELECT + WHERE: tìm sinh viên theo email chính xác
-- =====================================================
-- Dấu = dùng khi cần tìm đúng một giá trị cụ thể.

SELECT id, full_name, email, date_of_birth
FROM students
WHERE email = 'an.nguyen@example.com';

-- =====================================================
-- 8. SELECT + LIKE: tìm sinh viên theo tên
-- =====================================================
-- LIKE dùng để tìm gần đúng.
-- %An% nghĩa là tên có chứa chữ An ở bất kỳ vị trí nào.

SELECT id, full_name, email, date_of_birth
FROM students
WHERE full_name LIKE '%An%'
ORDER BY full_name ASC;

-- =====================================================
-- 9. SELECT + LIKE: tìm sinh viên theo một phần email
-- =====================================================
-- %@example.com nghĩa là email kết thúc bằng @example.com.

SELECT id, full_name, email, date_of_birth
FROM students
WHERE email LIKE '%@example.com'
ORDER BY email ASC;
