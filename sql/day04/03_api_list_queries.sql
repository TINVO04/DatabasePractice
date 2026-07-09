-- 1. Setup data: categories và products
-- =====================================================
-- categories lưu danh mục sản phẩm.
-- products lưu sản phẩm và có category_id liên kết tới categories.
-- Các cột created_at, updated_at, is_deleted dùng để chuẩn bị cho API CRUD.

DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    price NUMERIC(12, 2) NOT NULL,
    stock_quantity INTEGER NOT NULL DEFAULT 0,
    category_id INTEGER NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(id)
        ON DELETE RESTRICT
);

INSERT INTO categories (category_name)
VALUES
    ('Keyboard'),
    ('Mouse'),
    ('Monitor'),
    ('Laptop Accessory'),
    ('Cable');

INSERT INTO products (product_name, price, stock_quantity, category_id)
VALUES
    ('Mechanical Keyboard K1', 1200000, 15, 1),
    ('Wireless Keyboard K2', 850000, 20, 1),
    ('Office Keyboard K3', 350000, 50, 1),
    ('Gaming Mouse M1', 650000, 25, 2),
    ('Wireless Mouse M2', 420000, 40, 2),
    ('Office Mouse M3', 180000, 60, 2),
    ('Monitor 24 inch Full HD', 2800000, 12, 3),
    ('Monitor 27 inch 2K', 5200000, 8, 3),
    ('Monitor 32 inch 4K', 9500000, 5, 3),
    ('Laptop Stand Aluminum', 700000, 30, 4),
    ('USB Hub 4 Ports', 450000, 35, 4),
    ('Cooling Pad Pro', 550000, 18, 4),
    ('HDMI Cable 1.5m', 150000, 100, 5),
    ('USB-C Cable 2m', 220000, 90, 5),
    ('DisplayPort Cable', 300000, 45, 5);

-- =====================================================
-- 2. Pagination: danh sách sản phẩm theo page/pageSize
-- =====================================================
-- Ví dụ: page = 1, pageSize = 5
-- Công thức: OFFSET = (page - 1) * pageSize = (1 - 1) * 5 = 0

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name,
    p.created_at
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
ORDER BY p.id ASC
LIMIT 5 OFFSET 0;

-- Ví dụ: page = 2, pageSize = 5
-- Công thức: OFFSET = (2 - 1) * 5 = 5

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name,
    p.created_at
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
ORDER BY p.id ASC
LIMIT 5 OFFSET 5;

-- =====================================================
-- 3. Search: tìm sản phẩm theo tên
-- =====================================================
-- ILIKE dùng để tìm kiếm gần đúng và không phân biệt chữ hoa/chữ thường.
-- Ví dụ keyword = 'keyboard'

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
  AND p.product_name ILIKE '%keyboard%'
ORDER BY p.product_name ASC;

-- Ví dụ keyword = 'monitor'

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
  AND p.product_name ILIKE '%monitor%'
ORDER BY p.product_name ASC;

-- =====================================================
-- 4. Sort: sắp xếp sản phẩm theo price/name
-- =====================================================
-- Sort giúp API trả danh sách theo thứ tự người dùng chọn.

-- Sort theo giá tăng dần: rẻ đến đắt

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
ORDER BY p.price ASC;

-- Sort theo giá giảm dần: đắt đến rẻ

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
ORDER BY p.price DESC;

-- Sort theo tên A-Z

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
ORDER BY p.product_name ASC;

-- Sort theo tên Z-A

SELECT
    p.id,
    p.product_name,
    p.price,
    p.stock_quantity,
    c.category_name
FROM products p
INNER JOIN categories c ON p.category_id = c.id
WHERE p.is_deleted = FALSE
ORDER BY p.product_name DESC;
