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
