# Day 1 - ERD Student Course Enrollment

## Mục tiêu

Thiết kế quan hệ giữa 3 bảng: students, courses, enrollments.

## Quan hệ tổng quát

students 1 ---- N enrollments N ---- 1 courses

## Giải thích quan hệ

Một student có thể đăng ký nhiều course.
Một course có thể có nhiều student.
Vì student và course là quan hệ nhiều-nhiều, cần bảng trung gian enrollments.

## Bảng students

- id: khóa chính của học viên.
- full_name: họ tên học viên.
- email: email học viên, không được trùng.
- date_of_birth: ngày sinh.
- created_at: thời điểm tạo dữ liệu.

## Bảng courses

- id: khóa chính của khóa học.
- course_name: tên khóa học.
- description: mô tả khóa học.
- created_at: thời điểm tạo dữ liệu.

## Bảng enrollments

- id: khóa chính của lượt đăng ký.
- student_id: khóa ngoại trỏ tới students.id.
- course_id: khóa ngoại trỏ tới courses.id.
- enrolled_at: thời điểm đăng ký.
- status: trạng thái đăng ký.

## Vì sao cần foreign key?

Foreign key giúp đảm bảo enrollment không trỏ tới student hoặc course không tồn tại.
