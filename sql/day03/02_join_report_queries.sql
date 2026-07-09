-- Day 3 - JOIN, GROUP BY, COUNT, SUM, AVG
-- Database: database_practice
-- Mục tiêu: luyện INNER JOIN, LEFT JOIN, GROUP BY và các hàm thống kê.

-- =====================================================
-- 1. Seed data: enrollments
-- =====================================================
-- enrollments là bảng trung gian nối students và courses.
-- Cần có dữ liệu trong bảng này thì mới JOIN students với courses được.

INSERT INTO enrollments (student_id, course_id, status)
VALUES
    (1, 1, 'active'),
    (2, 1, 'active'),
    (3, 1, 'active'),
    (4, 2, 'active'),
    (5, 2, 'active'),
    (6, 2, 'active'),
    (7, 3, 'active'),
    (8, 3, 'active'),
    (9, 3, 'active'),
    (10, 4, 'active'),
    (11, 4, 'active'),
    (12, 4, 'active'),
    (13, 5, 'active'),
    (14, 5, 'active'),
    (15, 5, 'active');

-- =====================================================
-- 2. INNER JOIN: danh sách sinh viên kèm khóa học
-- =====================================================
-- INNER JOIN chỉ lấy dữ liệu có khớp ở cả hai bên.
-- Ở đây chỉ những student đã có enrollment mới xuất hiện.

SELECT
    s.id AS student_id,
    s.full_name AS student_name,
    s.email,
    c.id AS course_id,
    c.course_name,
    e.enrolled_at,
    e.status
FROM enrollments e
INNER JOIN students s ON e.student_id = s.id
INNER JOIN courses c ON e.course_id = c.id
ORDER BY s.id ASC;

-- =====================================================
-- 3. GROUP BY + COUNT: số sinh viên theo từng khóa học
-- =====================================================
-- GROUP BY dùng để gom các dòng có cùng course lại thành 1 nhóm.
-- COUNT dùng để đếm số enrollment trong từng course.

SELECT
    c.id AS course_id,
    c.course_name,
    COUNT(e.student_id) AS total_students
FROM courses c
INNER JOIN enrollments e ON c.id = e.course_id
GROUP BY c.id, c.course_name
ORDER BY c.id ASC;

-- =====================================================
-- 4. LEFT JOIN: danh sách khóa học chưa có sinh viên
-- =====================================================
-- LEFT JOIN lấy tất cả dữ liệu ở bảng bên trái.
-- Nếu bên phải không có dữ liệu khớp thì các cột bên phải sẽ là NULL.

SELECT
    c.id AS course_id,
    c.course_name
FROM courses c
LEFT JOIN enrollments e ON c.id = e.course_id
WHERE e.id IS NULL
ORDER BY c.id ASC;

-- =====================================================
-- 5. Mini challenge: Orders, OrderDetails và tổng tiền đơn hàng
-- =====================================================
-- Mục tiêu: tạo dữ liệu đơn hàng và dùng SUM để tính tổng tiền mỗi đơn.

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;

CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    order_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_details (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    product_name VARCHAR(100) NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL,

    CONSTRAINT fk_order_details_order
        FOREIGN KEY (order_id)
        REFERENCES orders(id)
        ON DELETE CASCADE
);

INSERT INTO orders (customer_name)
VALUES
    ('Nguyen Van An'),
    ('Tran Thi Binh'),
    ('Le Minh Chau');

INSERT INTO order_details (order_id, product_name, quantity, unit_price)
VALUES
    (1, 'Keyboard', 1, 500000),
    (1, 'Mouse', 2, 250000),
    (2, 'Monitor', 1, 3000000),
    (2, 'HDMI Cable', 2, 150000),
    (3, 'Laptop Stand', 1, 700000),
    (3, 'USB Hub', 1, 450000);

SELECT
    o.id AS order_id,
    o.customer_name,
    SUM(od.quantity * od.unit_price) AS total_amount
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
GROUP BY o.id, o.customer_name
ORDER BY o.id ASC;
