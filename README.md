# DatabasePractice

## Mục tiêu

Repo này dùng để luyện tập SQL, thiết kế database và tư duy dữ liệu trong tuần 3.

Day 1 tập trung vào các kiến thức nền tảng:

- Database, table, row, column.
- Primary key.
- Foreign key.
- Quan hệ one-to-many và many-to-many.
- ERD cơ bản.

Day 2 tập trung vào các câu lệnh SQL cơ bản:

- SELECT.
- INSERT.
- UPDATE.
- DELETE.
- WHERE.
- LIKE.
- ORDER BY.
- Transaction cơ bản với BEGIN và ROLLBACK.

## Công nghệ sử dụng

- PostgreSQL 17
- pgAdmin 4
- SQL
- Git/GitHub

## Cấu trúc thư mục

```text
DatabasePractice/
├── sql/
│   ├── day01/
│   │   └── 01_create_tables.sql
│   ├── day02/
│   │   └── 01_crud_queries.sql
│   └── day03/
│       └── 02_join_report_queries.sql
├── docs/
│   └── day01/
│       ├── erd.md
│       └── mini_challenge_category_product_supplier.md
├── .gitignore
└── README.md
```

## Day 1 - Database, table, primary key, foreign key và ERD

### Nội dung đã làm

- Tạo database local tên `database_practice` bằng pgAdmin.
- Viết file SQL tạo 3 bảng: `students`, `courses`, `enrollments`.
- Chạy SQL thành công trong pgAdmin Query Tool.
- Thiết kế ERD dạng Markdown cho quan hệ Student - Course - Enrollment.
- Phân tích mini challenge Category - Product - Supplier.

### File chính

- Script tạo bảng: `sql/day01/01_create_tables.sql`
- Markdown mô tả ERD: `docs/day01/erd.md`
- Mini challenge: `docs/day01/mini_challenge_category_product_supplier.md`

## Cách chạy SQL bằng pgAdmin

1. Mở pgAdmin 4.
2. Kết nối server PostgreSQL 17.
3. Mở database `database_practice`.
4. Right click database `database_practice` > Query Tool.
5. Copy nội dung file `sql/day01/01_create_tables.sql` vào Query Tool.
6. Bấm Execute hoặc nhấn F5.
7. Refresh `Schemas > public > Tables` để kiểm tra bảng.

## Kết quả mong đợi

Sau khi chạy SQL, trong database `database_practice` có 3 bảng:

- `students`
- `courses`
- `enrollments`

## ERD dạng Markdown

```text
students 1 ---- N enrollments N ---- 1 courses
```

Ý nghĩa:

- Một student có thể có nhiều enrollment.
- Một course có thể có nhiều enrollment.
- Một enrollment thuộc về đúng một student và đúng một course.
- Vì một student có thể học nhiều course, và một course có thể có nhiều student, nên quan hệ giữa `students` và `courses` là many-to-many.
- Để biểu diễn quan hệ many-to-many, cần bảng trung gian `enrollments`.

## Mô tả các bảng

### Bảng students

Bảng `students` lưu thông tin học viên.

| Cột | Ý nghĩa |
| --- | --- |
| `id` | Khóa chính của học viên |
| `full_name` | Họ tên học viên |
| `email` | Email học viên, không được trùng |
| `date_of_birth` | Ngày sinh |
| `created_at` | Thời điểm tạo dữ liệu |

### Bảng courses

Bảng `courses` lưu thông tin khóa học.

| Cột | Ý nghĩa |
| --- | --- |
| `id` | Khóa chính của khóa học |
| `course_name` | Tên khóa học |
| `description` | Mô tả khóa học |
| `created_at` | Thời điểm tạo dữ liệu |

### Bảng enrollments

Bảng `enrollments` lưu thông tin đăng ký khóa học của học viên.

| Cột | Ý nghĩa |
| --- | --- |
| `id` | Khóa chính của lượt đăng ký |
| `student_id` | Khóa ngoại trỏ tới `students.id` |
| `course_id` | Khóa ngoại trỏ tới `courses.id` |
| `enrolled_at` | Thời điểm đăng ký |
| `status` | Trạng thái đăng ký |

## Mini challenge - Category Product Supplier

Mini challenge được phân tích trong file `docs/day01/mini_challenge_category_product_supplier.md`.

Quan hệ tổng quát:

```text
categories 1 ---- N products N ---- 1 suppliers
```

Ý nghĩa:

- Một category có thể có nhiều product.
- Một supplier có thể cung cấp nhiều product.
- Mỗi product trong phiên bản đơn giản thuộc về một category chính và một supplier chính.
- Bảng `products` cần có `category_id` và `supplier_id` để liên kết dữ liệu.

## Vì sao cần khóa ngoại?

Khóa ngoại cần thiết vì nó giúp đảm bảo dữ liệu giữa các bảng luôn hợp lệ.

Ví dụ trong project này:

- `enrollments.student_id` trỏ tới `students.id`.
- `enrollments.course_id` trỏ tới `courses.id`.

Nếu không có foreign key, database có thể cho phép tạo một enrollment với `student_id` không tồn tại trong bảng `students`, hoặc `course_id` không tồn tại trong bảng `courses`. Khi đó dữ liệu bị sai logic vì có lượt đăng ký nhưng không biết học viên hoặc khóa học thật sự là ai.

Foreign key giúp:

- Ngăn dữ liệu mồ côi.
- Giữ quan hệ giữa các bảng rõ ràng.
- Giúp database tự kiểm tra tính đúng đắn của dữ liệu.
- Giúp người đọc database hiểu bảng nào liên kết với bảng nào.

## Day 2 - SELECT, INSERT, UPDATE, DELETE và WHERE

### Nội dung đã làm

- Seed dữ liệu mẫu gồm 5 courses và 20 students.
- Viết query INSERT để thêm sinh viên mới.
- Viết query UPDATE để sửa thông tin sinh viên.
- Viết query DELETE để xóa sinh viên theo điều kiện.
- Viết query SELECT để đọc danh sách sinh viên.
- Viết query tìm sinh viên theo email chính xác.
- Viết query tìm sinh viên theo tên bằng LIKE.
- Viết query tìm sinh viên theo một phần email bằng LIKE.
- Hoàn thành mini challenge DELETE an toàn theo Id và ROLLBACK transaction.

### File chính

- `sql/day02/01_crud_queries.sql`

### Cách chạy SQL Day 2 bằng pgAdmin

1. Mở pgAdmin 4.
2. Kết nối server PostgreSQL 17.
3. Mở database `database_practice`.
4. Right click database `database_practice` > Query Tool.
5. Copy từng nhóm query trong file `sql/day02/01_crud_queries.sql` vào Query Tool.
6. Bấm Execute hoặc nhấn F5.

Lưu ý: không nên chạy lại toàn bộ phần seed nhiều lần vì cột `email` của bảng `students` có ràng buộc UNIQUE, chạy lại có thể bị lỗi trùng email.

### Ghi chú học tập Day 2

- INSERT dùng để thêm dữ liệu mới.
- SELECT dùng để đọc dữ liệu.
- UPDATE dùng để sửa dữ liệu đã có.
- DELETE dùng để xóa dữ liệu.
- WHERE dùng để giới hạn dòng dữ liệu bị tác động.
- LIKE dùng để tìm kiếm gần đúng.
- ORDER BY dùng để sắp xếp kết quả.
- BEGIN mở transaction.
- ROLLBACK hủy thay đổi trong transaction.

## Day 3 - JOIN, GROUP BY, COUNT, SUM và AVG

### Nội dung đã làm

- Seed dữ liệu enrollments để liên kết students với courses.
- Viết query INNER JOIN để lấy danh sách sinh viên kèm khóa học.
- Viết query GROUP BY và COUNT để đếm số sinh viên theo từng khóa học.
- Viết query LEFT JOIN để tìm khóa học chưa có sinh viên đăng ký.
- Hoàn thành mini challenge Orders/OrderDetails.
- Dùng SUM để tính tổng tiền của từng đơn hàng.

### File chính

- `sql/day03/02_join_report_queries.sql`

### Cách chạy SQL Day 3 bằng pgAdmin

1. Mở pgAdmin 4.
2. Kết nối server PostgreSQL 17.
3. Mở database `database_practice`.
4. Right click database `database_practice` > Query Tool.
5. Copy từng nhóm query trong file `sql/day03/02_join_report_queries.sql` vào Query Tool.
6. Bấm Execute hoặc nhấn F5.

Lưu ý: nên chạy từng phần theo thứ tự từ trên xuống dưới. Với phần mini challenge Orders/OrderDetails, script có `DROP TABLE IF EXISTS` nên có thể chạy lại để reset dữ liệu bảng orders và order_details.

### Ghi chú học tập Day 3

- INNER JOIN chỉ lấy dữ liệu có khớp ở cả hai bảng.
- LEFT JOIN lấy toàn bộ dữ liệu bảng bên trái, kể cả khi bảng bên phải không có dữ liệu khớp.
- GROUP BY dùng để gom nhiều dòng thành từng nhóm.
- COUNT dùng để đếm số dòng trong từng nhóm.
- SUM dùng để tính tổng giá trị số.
- Bảng order_details là bảng con của orders thông qua khóa ngoại order_id.

## Ghi chú học tập

- Primary key là khóa chính, dùng để định danh duy nhất một dòng dữ liệu.
- Foreign key là khóa ngoại, dùng để liên kết dữ liệu giữa các bảng.
- Quan hệ many-to-many không nên lưu trực tiếp trong một bảng, mà nên dùng bảng trung gian.
- Trong bài này, `enrollments` là bảng trung gian giữa `students` và `courses`.
