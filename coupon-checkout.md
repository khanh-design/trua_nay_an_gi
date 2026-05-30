# Kế hoạch triển khai: Áp dụng Mã Giảm Giá khi Đặt Hàng (Option C)

Dự án: **Trưa Nay Ăn Gì**

Kế hoạch này thực hiện việc hiển thị giao diện Modal lựa chọn các Voucher hiện có của nhà hàng ngay tại trang thanh toán giỏ hàng, đồng thời tích hợp logic tính toán giảm giá vào quy trình lưu đơn hàng cho cả COD và VNPay.

---

## 📋 Các phần cần triển khai

### 1. Backend: Cung cấp danh sách Coupon của nhà hàng cho trang Checkout
- Nơi sửa đổi: `CartController.java`
- Công việc:
  - Ở method `showCartDetail` (GET `/cart/detail`), lấy `restaurantId` của nhà hàng có món ăn trong giỏ hàng.
  - Lấy danh sách Coupon khả dụng của nhà hàng đó từ `restaurantService.getCouponsByRestaurantId(restaurantId)`.
  - Đưa danh sách này vào Thymeleaf model với thuộc tính `"coupons"`.
  - Validate mã coupon tại API `/cart/apply-coupon`: Trả về JSON thông báo lỗi nếu mã không hợp lệ, không tồn tại hoặc đơn hàng không đủ giá trị tối thiểu.

### 2. Giao diện: Xây dựng Modal chọn Voucher tại trang thanh toán
- Nơi sửa đổi: `cart_detail.html`
- Công việc:
  - Thêm một dòng hiển thị **Voucher của nhà hàng** ở phía trên phần tạm tính kèm nút **Chọn Voucher**.
  - Xây dựng Modal Bootstrap `couponModal` hiển thị:
    - Input nhập mã tay + nút Áp dụng.
    - Danh sách Coupon render bằng Thymeleaf.
    - Logic Thymeleaf phân loại:
      - Nếu `subtotal >= coupon.minOrder` -> Hiển thị dạng thẻ Voucher hoạt động, có nút "Áp dụng".
      - Nếu `subtotal < coupon.minOrder` -> Hiển thị dạng thẻ bị khóa (mờ đi), ghi rõ "Mua thêm X ₫ để sử dụng".
  - AJAX JavaScript:
    - Khi click chọn áp dụng một mã -> Gửi request POST lên `/cart/apply-coupon?couponCode=XXX`.
    - Nhận response thành công -> reload trang (`window.location.reload()`) để Thymeleaf tự động render lại toàn bộ giá trị hóa đơn.
    - Nhận response thất bại -> Hiển thị alert/toast báo lỗi.

### 3. Backend: Tính toán giảm giá và lưu thông tin Coupon vào Đơn hàng
- Nơi sửa đổi: `CartController.java` (COD flow) và `PaymentController.java` (VNPay flow)
- Công việc:
  - Lấy `appliedCoupon` từ session.
  - Kiểm tra tính hợp lệ và tính số tiền giảm giá `discount`.
  - Đơn hàng `Orders` sẽ được set `coupon` đã dùng: `order.setCoupon(coupon)`.
  - Tổng tiền lưu vào DB: `order.setTotalPrice(subtotal - discount + serviceFee)`.
  - **VNPay Flow:** Đổi số tiền gửi sang cổng thanh toán thành tổng tiền sau giảm giá: `grandTotal = subtotal - discount + serviceFee + shippingFee`.
  - Clear session coupon sau khi đặt hàng thành công.

### 4. Giao diện: Hiển thị giảm giá ở các trang Hóa đơn & Lịch sử
- Nơi sửa đổi: `order_detail.html` và `order_history.html`
- Công việc:
  - Hiển thị dòng giảm giá: `- X đ` và tên mã giảm giá đã áp dụng trong phần tóm tắt thanh toán nếu đơn hàng có liên kết Coupon.

---

## 📈 Kế hoạch kiểm thử & Xác nhận

### Kiểm thử tự động
- Chạy build dự án để đảm bảo không bị lỗi biên dịch:
  ```powershell
  .\gradlew.bat build -x test
  ```

### Kiểm thử thủ công
1. Kiểm tra hiển thị Modal: Truy cập trang thanh toán, bấm "Chọn Voucher" và kiểm tra xem danh sách Voucher có khớp với các Voucher của nhà hàng đó không. Các voucher có tự động bị khóa/mở khóa dựa trên giá trị tạm tính hay không.
2. Kiểm tra áp dụng voucher: Áp dụng thử voucher hợp lệ -> Xem giá trị giảm giá và tổng cộng có được cập nhật lại không.
3. Kiểm tra lưu đơn hàng COD: Đặt hàng thành công -> Kiểm tra Database xem bảng `orders` có lưu đúng `coupon_id` và cột `total_price` đã được giảm trừ chính xác chưa.
4. Kiểm tra đặt hàng VNPay: Áp dụng voucher -> Đi tới thanh toán VNPay -> Kiểm tra số tiền hiển thị trên VNPay Sandbox có khớp với tổng thanh toán sau giảm giá không -> Xác nhận giao dịch thành công -> Kiểm tra DB đơn hàng đã được lưu đúng coupon.
