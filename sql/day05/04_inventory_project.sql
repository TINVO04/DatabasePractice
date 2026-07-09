-- 1. Create tables: users, categories, suppliers, products, stock_in, stock_out
-- =====================================================
-- Inventory Management là hệ thống quản lý kho đơn giản.
-- products là bảng trung tâm.
-- stock_in lưu lịch sử nhập kho.
-- stock_out lưu lịch sử xuất kho.

DROP TABLE IF EXISTS stock_out;
DROP TABLE IF EXISTS stock_in;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    role VARCHAR(50) NOT NULL DEFAULT 'staff',
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE suppliers (
    id SERIAL PRIMARY KEY,
    supplier_name VARCHAR(150) NOT NULL,
    phone VARCHAR(30),
    email VARCHAR(150),
    address TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    sku VARCHAR(50) NOT NULL UNIQUE,
    price NUMERIC(12, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER NOT NULL,
    supplier_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(id)
        ON DELETE RESTRICT
);

CREATE TABLE stock_in (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_cost NUMERIC(12, 2) NOT NULL,
    note TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_stock_in_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_stock_in_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
);

CREATE TABLE stock_out (
    id SERIAL PRIMARY KEY,
    product_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    unit_price NUMERIC(12, 2) NOT NULL,
    note TEXT,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_stock_out_product
        FOREIGN KEY (product_id)
        REFERENCES products(id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_stock_out_user
        FOREIGN KEY (user_id)
        REFERENCES users(id)
        ON DELETE RESTRICT
);

-- =====================================================
-- 2. Seed data: users, categories, suppliers, products, stock_in, stock_out
-- =====================================================
-- Dữ liệu mẫu dùng để luyện CRUD, JOIN, GROUP BY, pagination và report.

INSERT INTO users (full_name, email, role)
VALUES
    ('Nguyen Van Admin', 'admin.inventory@example.com', 'admin'),
    ('Tran Thi Staff', 'staff.inventory@example.com', 'staff'),
    ('Le Minh Manager', 'manager.inventory@example.com', 'manager');

INSERT INTO categories (category_name, description)
VALUES
    ('Keyboard', 'Keyboard products'),
    ('Mouse', 'Mouse products'),
    ('Monitor', 'Monitor products'),
    ('Laptop Accessory', 'Accessories for laptops'),
    ('Cable', 'Connection cables');

INSERT INTO suppliers (supplier_name, phone, email, address)
VALUES
    ('Tech Supply Co', '0901000001', 'contact@techsupply.example.com', 'Ho Chi Minh City'),
    ('Computer World', '0901000002', 'sales@computerworld.example.com', 'Ha Noi'),
    ('Office Gear Ltd', '0901000003', 'hello@officegear.example.com', 'Da Nang'),
    ('Digital Hub', '0901000004', 'support@digitalhub.example.com', 'Can Tho'),
    ('Accessory Pro', '0901000005', 'info@accessorypro.example.com', 'Hue');

INSERT INTO products (product_name, sku, price, stock_quantity, category_id, supplier_id)
VALUES
    ('Mechanical Keyboard K1', 'KB-K1', 1200000, 15, 1, 1),
    ('Wireless Keyboard K2', 'KB-K2', 850000, 20, 1, 2),
    ('Office Keyboard K3', 'KB-K3', 350000, 50, 1, 3),
    ('Gaming Mouse M1', 'MS-M1', 650000, 25, 2, 1),
    ('Wireless Mouse M2', 'MS-M2', 420000, 40, 2, 2),
    ('Office Mouse M3', 'MS-M3', 180000, 60, 2, 3),
    ('Monitor 24 inch Full HD', 'MN-24FHD', 2800000, 12, 3, 2),
    ('Monitor 27 inch 2K', 'MN-27-2K', 5200000, 8, 3, 4),
    ('Monitor 32 inch 4K', 'MN-32-4K', 9500000, 5, 3, 4),
    ('Laptop Stand Aluminum', 'LA-STAND', 700000, 30, 4, 5),
    ('USB Hub 4 Ports', 'LA-HUB4', 450000, 35, 4, 5),
    ('Cooling Pad Pro', 'LA-COOL', 550000, 18, 4, 5),
    ('HDMI Cable 1.5m', 'CB-HDMI15', 150000, 100, 5, 3),
    ('USB-C Cable 2m', 'CB-USBC2', 220000, 90, 5, 5),
    ('DisplayPort Cable', 'CB-DP', 300000, 45, 5, 4);

INSERT INTO stock_in (product_id, user_id, quantity, unit_cost, note)
VALUES
    (1, 1, 10, 900000, 'Initial stock'),
    (2, 1, 15, 650000, 'Initial stock'),
    (3, 2, 30, 250000, 'Initial stock'),
    (4, 2, 20, 480000, 'Initial stock'),
    (5, 3, 25, 300000, 'Initial stock'),
    (7, 1, 8, 2200000, 'Initial stock'),
    (8, 3, 5, 4300000, 'Initial stock'),
    (10, 2, 20, 500000, 'Initial stock'),
    (13, 2, 50, 90000, 'Initial stock'),
    (14, 3, 40, 150000, 'Initial stock');

INSERT INTO stock_out (product_id, user_id, quantity, unit_price, note)
VALUES
    (1, 2, 2, 1200000, 'Customer order'),
    (2, 2, 3, 850000, 'Customer order'),
    (4, 3, 4, 650000, 'Customer order'),
    (5, 2, 5, 420000, 'Customer order'),
    (7, 3, 2, 2800000, 'Customer order'),
    (10, 1, 3, 700000, 'Customer order'),
    (13, 2, 10, 150000, 'Customer order'),
    (14, 3, 8, 220000, 'Customer order');

-- =====================================================
-- 3. Required queries group A: CRUD và đọc dữ liệu cơ bản
-- =====================================================

-- Query 1: Lấy danh sách tất cả sản phẩm chưa bị xóa
SELECT
    id,
    product_name,
    sku,
    price,
    stock_quantity
FROM products
WHERE is_deleted = FALSE
ORDER BY id ASC;

-- Query 2: Lấy chi tiết một sản phẩm theo SKU
SELECT
    id,
    product_name,
    sku,
    price,
    stock_quantity
FROM products
WHERE sku = 'KB-K1'
  AND is_deleted = FALSE;

-- Query 3: Thêm một supplier mới
INSERT INTO suppliers (supplier_name, phone, email, address)
VALUES ('New Supplier Demo', '0901999999', 'new.supplier@example.com', 'Demo Address');

-- Query 4: Cập nhật giá một sản phẩm theo SKU
UPDATE products
SET
    price = 1250000,
    updated_at = CURRENT_TIMESTAMP
WHERE sku = 'KB-K1';

-- Query 5: Soft delete một supplier demo
UPDATE suppliers
SET
    is_deleted = TRUE,
    updated_at = CURRENT_TIMESTAMP
WHERE email = 'new.supplier@example.com';

-- =====================================================
-- 4. Required queries group B: JOIN report
-- =====================================================

-- Query 6: Danh sách sản phẩm kèm category và supplier
SELECT
    p.id,
    p.product_name,
    p.sku,
    p.price,
    p.stock_quantity,
    c.category_name,
    s.supplier_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
INNER JOIN suppliers s ON p.supplier_id = s.id
WHERE p.is_deleted = FALSE
ORDER BY p.id ASC;

-- Query 7: Danh sách nhập kho kèm tên sản phẩm và người thực hiện
SELECT
    si.id AS stock_in_id,
    p.product_name,
    u.full_name AS created_by,
    si.quantity,
    si.unit_cost,
    si.quantity * si.unit_cost AS total_cost,
    si.created_at
FROM stock_in si
INNER JOIN products p ON si.product_id = p.id
INNER JOIN users u ON si.user_id = u.id
ORDER BY si.id ASC;

-- Query 8: Danh sách xuất kho kèm tên sản phẩm và người thực hiện
SELECT
    so.id AS stock_out_id,
    p.product_name,
    u.full_name AS created_by,
    so.quantity,
    so.unit_price,
    so.quantity * so.unit_price AS total_amount,
    so.created_at
FROM stock_out so
INNER JOIN products p ON so.product_id = p.id
INNER JOIN users u ON so.user_id = u.id
ORDER BY so.id ASC;

-- Query 9: Danh sách sản phẩm có tồn kho thấp hơn 10
SELECT
    p.id,
    p.product_name,
    p.sku,
    p.stock_quantity,
    c.category_name,
    s.supplier_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
INNER JOIN suppliers s ON p.supplier_id = s.id
WHERE p.stock_quantity < 10
  AND p.is_deleted = FALSE
ORDER BY p.stock_quantity ASC;

-- Query 10: Danh sách sản phẩm chưa từng được xuất kho
SELECT
    p.id,
    p.product_name,
    p.sku,
    p.stock_quantity
FROM products p
LEFT JOIN stock_out so ON p.id = so.product_id
WHERE so.id IS NULL
  AND p.is_deleted = FALSE
ORDER BY p.id ASC;

-- =====================================================
-- 5. Required queries group C: GROUP BY thống kê
-- =====================================================

-- Query 11: Đếm số sản phẩm theo từng category
SELECT
    c.id AS category_id,
    c.category_name,
    COUNT(p.id) AS total_products
FROM categories c
LEFT JOIN products p ON c.id = p.category_id AND p.is_deleted = FALSE
WHERE c.is_deleted = FALSE
GROUP BY c.id, c.category_name
ORDER BY c.id ASC;

-- Query 12: Tổng số lượng tồn kho theo từng category
SELECT
    c.id AS category_id,
    c.category_name,
    SUM(p.stock_quantity) AS total_stock_quantity
FROM categories c
INNER JOIN products p ON c.id = p.category_id
WHERE c.is_deleted = FALSE
  AND p.is_deleted = FALSE
GROUP BY c.id, c.category_name
ORDER BY total_stock_quantity DESC;

-- Query 13: Tổng tiền nhập kho theo từng sản phẩm
SELECT
    p.id AS product_id,
    p.product_name,
    SUM(si.quantity) AS total_in_quantity,
    SUM(si.quantity * si.unit_cost) AS total_in_cost
FROM products p
INNER JOIN stock_in si ON p.id = si.product_id
WHERE p.is_deleted = FALSE
GROUP BY p.id, p.product_name
ORDER BY total_in_cost DESC;

-- Query 14: Tổng tiền xuất kho theo từng sản phẩm
SELECT
    p.id AS product_id,
    p.product_name,
    SUM(so.quantity) AS total_out_quantity,
    SUM(so.quantity * so.unit_price) AS total_out_amount
FROM products p
INNER JOIN stock_out so ON p.id = so.product_id
WHERE p.is_deleted = FALSE
GROUP BY p.id, p.product_name
ORDER BY total_out_amount DESC;

-- Query 15: Tổng doanh thu xuất kho theo từng user
SELECT
    u.id AS user_id,
    u.full_name,
    SUM(so.quantity * so.unit_price) AS total_sales_amount
FROM users u
INNER JOIN stock_out so ON u.id = so.user_id
WHERE u.is_deleted = FALSE
GROUP BY u.id, u.full_name
ORDER BY total_sales_amount DESC;
