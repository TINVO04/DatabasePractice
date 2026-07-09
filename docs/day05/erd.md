# Day 5 - Inventory Management ERD

## Mục tiêu

Tài liệu này mô tả ERD cho mini project Inventory Management trong Day 5.

## Quan hệ tổng quát

```text
categories 1 ---- N products N ---- 1 suppliers
users      1 ---- N stock_in  N ---- 1 products
users      1 ---- N stock_out N ---- 1 products
```

## Giải thích quan hệ

### categories và products

- Một category có thể có nhiều product.
- Một product thuộc về đúng một category.
- Khóa ngoại: `products.category_id` trỏ tới `categories.id`.

### suppliers và products

- Một supplier có thể cung cấp nhiều product.
- Một product thuộc về đúng một supplier chính trong phiên bản đơn giản này.
- Khóa ngoại: `products.supplier_id` trỏ tới `suppliers.id`.

### products và stock_in

- Một product có thể có nhiều lần nhập kho.
- Một dòng stock_in thuộc về đúng một product.
- Khóa ngoại: `stock_in.product_id` trỏ tới `products.id`.

### users và stock_in

- Một user có thể thực hiện nhiều lần nhập kho.
- Một dòng stock_in do đúng một user thực hiện.
- Khóa ngoại: `stock_in.user_id` trỏ tới `users.id`.

### products và stock_out

- Một product có thể có nhiều lần xuất kho.
- Một dòng stock_out thuộc về đúng một product.
- Khóa ngoại: `stock_out.product_id` trỏ tới `products.id`.

### users và stock_out

- Một user có thể thực hiện nhiều lần xuất kho.
- Một dòng stock_out do đúng một user thực hiện.
- Khóa ngoại: `stock_out.user_id` trỏ tới `users.id`.

## Vì sao cần bảng stock_in và stock_out?

Không nên chỉ lưu số lượng tồn kho trong bảng products rồi bỏ qua lịch sử nhập/xuất.

Bảng `products.stock_quantity` cho biết số lượng hiện tại, còn `stock_in` và `stock_out` lưu lịch sử thay đổi kho.

Nhờ có `stock_in` và `stock_out`, hệ thống có thể trả lời các câu hỏi như:

- Sản phẩm nào được nhập nhiều nhất?
- Sản phẩm nào được xuất nhiều nhất?
- Tổng tiền nhập kho là bao nhiêu?
- Tổng doanh thu xuất kho là bao nhiêu?
- User nào thực hiện xuất kho nhiều nhất?

## Ghi chú về soft delete và audit fields

Các bảng chính có:

- `created_at`: thời điểm tạo dữ liệu.
- `updated_at`: thời điểm cập nhật dữ liệu.
- `is_deleted`: đánh dấu dữ liệu đã bị xóa mềm.

Soft delete giúp dữ liệu không bị mất thật khỏi database, phù hợp với các hệ thống quản lý cần lưu lịch sử.