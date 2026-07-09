# Mini Challenge - Category Product Supplier

## Mục tiêu

Phân tích quan hệ giữa 3 bảng: categories, products, suppliers.

## Quan hệ tổng quát

categories 1 ---- N products N ---- 1 suppliers

## Giải thích quan hệ Category - Product

Một category có thể có nhiều product.
Ví dụ category Laptop có thể có MacBook Air, Dell XPS, ThinkPad.
Mỗi product thuộc về một category chính.

Vì vậy, bảng products cần có category_id làm foreign key trỏ tới categories.id.

## Giải thích quan hệ Supplier - Product

Một supplier có thể cung cấp nhiều product.
Ví dụ supplier Apple có thể cung cấp MacBook Air, MacBook Pro, iMac.
Mỗi product trong phiên bản đơn giản có một supplier chính.

Vì vậy, bảng products cần có supplier_id làm foreign key trỏ tới suppliers.id.

## Các bảng đề xuất

### categories

- id: khóa chính của danh mục.
- category_name: tên danh mục.

### suppliers

- id: khóa chính của nhà cung cấp.
- supplier_name: tên nhà cung cấp.
- phone: số điện thoại.
- email: email nhà cung cấp.

### products

- id: khóa chính của sản phẩm.
- product_name: tên sản phẩm.
- price: giá sản phẩm.
- category_id: khóa ngoại trỏ tới categories.id.
- supplier_id: khóa ngoại trỏ tới suppliers.id.

## Vì sao cần foreign key trong mini challenge?

Foreign key giúp đảm bảo product không trỏ tới category hoặc supplier không tồn tại.

Ví dụ nếu product có category_id = 10, thì trong bảng categories phải tồn tại category có id = 10.
Nếu không có foreign key, dữ liệu sản phẩm có thể bị sai vì thuộc về một danh mục không tồn tại.
