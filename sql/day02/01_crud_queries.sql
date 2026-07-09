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


