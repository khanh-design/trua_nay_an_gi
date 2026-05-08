-- ============================================
-- Docker Init Script - Trưa Nay Ăn Gì
-- File này được tự động chạy khi MySQL container khởi tạo lần đầu
-- ============================================

CREATE DATABASE IF NOT EXISTS `casestudy` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE casestudy;

-- 1. Roles
INSERT IGNORE INTO roles (name) VALUES 
('ADMIN'),
('OWNER'), 
('CUSTOMER');

-- 2. Users (password = 123456 hashed với BCrypt strength 12)
INSERT IGNORE INTO user (username, password, email, phone, full_name, avatar_url) VALUES
('admin', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'admin@codegym.vn', '0987654321', 'Admin System', NULL),
('owner1', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'owner1@restaurant.com', '0123456789', 'Chủ nhà hàng 1', NULL),
('owner2', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'owner2@restaurant.com', '0123456790', 'Chủ nhà hàng 2', NULL),
('customer1', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'customer1@gmail.com', '0123456791', 'Khách hàng 1', NULL);

-- 3. User roles
INSERT IGNORE INTO user_roles (user_id, role_id) VALUES
(1, 1),
(2, 2),
(3, 2),
(4, 3);

-- 4. Restaurants
INSERT IGNORE INTO restaurant (name, user_id, address, phone, logo_url, description, is_long_term_partner, is_open, is_locked, is_approved) VALUES
('Nhà hàng Hải Sản Biển Đông', 2, '123 Đường Trần Hưng Đạo, Quận 1, TP.HCM', '0901234567', '/images/logo.jpg', 'Chuyên về các món hải sản tươi ngon', true, true, false, true),
('Quán Cơm Tấm Sài Gòn', 3, '456 Đường Lê Lợi, Quận 3, TP.HCM', '0901234568', '/images/logo.jpg', 'Quán cơm tấm nổi tiếng Sài Gòn', true, true, false, true),
('Trà Sữa Milktea House', 1, '123 Nguyễn Trãi, Hà Nội', '0988123456', '/images/logo.jpg', 'Chuỗi cửa hàng trà sữa, trà chanh', TRUE, TRUE, FALSE, TRUE);

-- 5. Categories
INSERT IGNORE INTO category (name) VALUES
('Cơm'), ('Phở'), ('Bún'), ('Hải sản'), ('Gà'), ('Rau củ'), ('Trà Sữa'), ('Trà Chanh'), ('Topping');

-- 6. Tags
INSERT IGNORE INTO tag (name, restaurant_id) VALUES
('Ngon', 1), ('Rẻ', 2), ('Đặc biệt', 1), ('Mới', 1), ('Bán chạy', 2),
('Khuyến mãi', 2), ('Truyền thống', 1), ('Hiện đại', 2),
('Ngọt nhẹ', 3), ('Best seller', 3), ('Giới trẻ yêu thích', 3);

-- 7. Dishes
INSERT IGNORE INTO dish (name, restaurant_id, price, description, picture_url, tag_id, is_available, category_id) VALUES
('Cua rang me', 1, 250000, 'Cua biển tươi rang với me chua ngọt', 'eat_food/cua_rang_me.jpg', 1, true, 4),
('Tôm hùm nướng muối ớt', 1, 450000, 'Tôm hùm tươi nướng với muối ớt', 'eat_food/tom_hung_nuong.jpg', 3, true, 4),
('Cá hồi nướng lá chuối', 1, 180000, 'Cá hồi tươi nướng trong lá chuối', 'eat_food/ca_hoi_nuong_la_chuoi.jpg', 1, true, 4),
('Mực xào chua ngọt', 1, 120000, 'Mực tươi xào với nước sốt chua ngọt', 'eat_food/muc_sao_chua_ngot.jpg', 2, true, 4),
('Súp hải sản', 1, 80000, 'Súp nóng với tôm, mực, cá và rau củ', 'eat_food/sup_hai_san.jpg', 1, true, 4),
('Gỏi cá trích', 1, 95000, 'Gỏi cá trích tươi với rau sống', '/images/logo.jpg', 2, true, 4),
('Cơm tấm sườn nướng', 2, 55000, 'Cơm tấm với sườn heo nướng thơm lừng', 'eat_food/com_tam.jpg', 1, true, 1),
('Cơm tấm gà nướng', 2, 50000, 'Cơm tấm với gà nướng da giòn', 'eat_food/com_tam_ga_nuong.jpg', 2, true, 1),
('Cơm tấm chả cá', 2, 60000, 'Cơm tấm với chả cá thơm ngon', 'eat_food/com-tam-cha-ca.jpg', 3, true, 1),
('Phở bò tái', 2, 65000, 'Phở bò với nước dùng đậm đà', 'eat_food/pho-bo-tai.jpg', 1, true, 2),
('Bún chả cá', 2, 70000, 'Bún với chả cá tươi', 'eat_food/bun-cha-ca.jpg', 2, true, 3),
('Gà nướng lá chanh', 2, 180000, 'Gà ta nướng với lá chanh', 'eat_food/ga-nuong-la-tranh.jpg', 3, true, 5),
('Trà Sữa Trân Châu Đường Đen', 3, 39000, 'Trà sữa đậm vị, trân châu đường đen dẻo thơm', 'drinks/tra-sua-chan-trau-duong-den.jpg', 10, TRUE, 7),
('Trà Sữa Matcha', 3, 42000, 'Matcha Nhật Bản, vị ngọt dịu', 'drinks/tra-sua-matcha.jpg', 9, TRUE, 7),
('Trà Sữa Oolong Kem Cheese', 3, 45000, 'Trà oolong thơm nhẹ, phủ kem cheese', 'drinks/tra-oolong-kem-cheese.jpg', 10, TRUE, 7),
('Trà Sữa Thái Xanh', 3, 35000, 'Trà Thái xanh đặc trưng, béo thơm', 'drinks/tra_thai_xanh.jpg', 11, TRUE, 7),
('Trà Sữa Socola', 3, 37000, 'Kết hợp giữa vị cacao và sữa', 'drinks/tra_sua_socola.jpg', 9, TRUE, 7),
('Trà Sữa Hồng Trà', 3, 36000, 'Hồng trà đậm đà, sữa ngọt nhẹ', 'drinks/hong-tra-sua-tran-chau-trang.jpg', 10, TRUE, 7),
('Trà Chanh Sả Tắc', 3, 25000, 'Trà chanh thanh mát kết hợp sả và tắc', 'drinks/tra-tac.jpg', 11, TRUE, 8),
('Trà Chanh Cam Quế', 3, 28000, 'Trà chanh kèm cam tươi và hương quế', 'drinks/tra-cam-que.jpg', 9, TRUE, 8),
('Trà Chanh Đào', 3, 30000, 'Trà chanh kết hợp miếng đào giòn ngọt', 'drinks/tra-chanh-dao.jpg', 10, TRUE, 8),
('Trà Chanh Bạc Hà', 3, 27000, 'Trà chanh thanh mát với bạc hà', 'drinks/tra-chanh-bac-ha.jpg', 11, TRUE, 8),
('Trà Chanh Gừng Mật Ong', 3, 32000, 'Tốt cho sức khỏe, ấm nóng vị gừng', 'drinks/tra-gung-mat-ong.jpg', 9, TRUE, 8),
('Trà Chanh Kiwi', 3, 34000, 'Trà chanh pha kiwi chua ngọt lạ miệng', 'drinks/meo-khi-pha-che-tra-kiwi.jpg', 10, TRUE, 8);

-- 8. Nutrition
INSERT IGNORE INTO nutrition (id, name, unit) VALUES
(1, 'Calories', 'kcal'), (2, 'Protein', 'g'), (3, 'Carbohydrate', 'g'),
(4, 'Fat', 'g'), (5, 'Fiber', 'g'), (6, 'Sodium', 'mg'), (7, 'Sugar', 'g');

-- 9. Dish nutrition
INSERT IGNORE INTO dish_nutrition (dish_id, nutrition_id, amount) VALUES
(1,1,520),(1,2,42),(1,3,12),(1,4,38),(1,5,1),(1,6,950),(1,7,6),
(2,1,680),(2,2,60),(2,3,5),(2,4,45),(2,5,0),(2,6,1100),(2,7,2),
(3,1,420),(3,2,35),(3,3,8),(3,4,28),(3,5,1),(3,6,700),(3,7,1),
(4,1,360),(4,2,28),(4,3,18),(4,4,16),(4,5,2),(4,6,820),(4,7,9),
(5,1,250),(5,2,18),(5,3,20),(5,4,6),(5,5,2),(5,6,600),(5,7,4),
(7,1,650),(7,2,32),(7,3,78),(7,4,28),(7,5,2),(7,6,980),(7,7,5),
(8,1,620),(8,2,30),(8,3,75),(8,4,24),(8,5,2),(8,6,900),(8,7,4),
(9,1,700),(9,2,34),(9,3,80),(9,4,30),(9,5,2),(9,6,1020),(9,7,5),
(10,1,520),(10,2,35),(10,3,65),(10,4,15),(10,5,2),(10,6,850),(10,7,3),
(11,1,480),(11,2,28),(11,3,60),(11,4,12),(11,5,3),(11,6,780),(11,7,3),
(12,1,560),(12,2,45),(12,3,10),(12,4,35),(12,5,1),(12,6,900),(12,7,1),
(13,1,420),(13,2,8),(13,3,55),(13,4,18),(13,5,1),(13,6,160),(13,7,38),
(14,1,390),(14,2,7),(14,3,50),(14,4,15),(14,5,1),(14,6,150),(14,7,32),
(15,1,450),(15,2,8),(15,3,52),(15,4,20),(15,5,1),(15,6,170),(15,7,35),
(16,1,410),(16,2,7),(16,3,54),(16,4,16),(16,5,1),(16,6,155),(16,7,34),
(17,1,400),(17,2,7),(17,3,53),(17,4,15),(17,5,1),(17,6,150),(17,7,36),
(18,1,380),(18,2,6),(18,3,50),(18,4,14),(18,5,1),(18,6,145),(18,7,30),
(19,1,120),(19,2,1),(19,3,28),(19,4,0),(19,5,1),(19,6,25),(19,7,22),
(20,1,140),(20,2,1),(20,3,30),(20,4,0),(20,5,1),(20,6,30),(20,7,24),
(21,1,160),(21,2,1),(21,3,34),(21,4,0),(21,5,2),(21,6,35),(21,7,28),
(22,1,130),(22,2,1),(22,3,29),(22,4,0),(22,5,1),(22,6,28),(22,7,23),
(23,1,150),(23,2,1),(23,3,32),(23,4,0),(23,5,1),(23,6,40),(23,7,26),
(24,1,170),(24,2,1),(24,3,36),(24,4,0),(24,5,2),(24,6,45),(24,7,30);

-- 10. Coupons
INSERT IGNORE INTO coupon (name, restaurant_id, fixed_discount, percent_discount, min_order, max_discount, description, is_available) VALUES
('Giảm 50K cho đơn từ 500K', 1, 50000, NULL, 500000, NULL, 'Áp dụng cho tất cả món ăn', true),
('Giảm 15% cho đơn từ 1 triệu', 1, NULL, 15, 1000000, 200000, 'Giảm tối đa 200K', true),
('Giảm 100K cho đơn từ 800K', 1, 100000, NULL, 800000, NULL, 'Chỉ áp dụng vào thứ 2-4', true),
('Giảm 20K cho đơn từ 100K', 2, 20000, NULL, 100000, NULL, 'Áp dụng cho tất cả món ăn', true),
('Giảm 10% cho đơn từ 200K', 2, NULL, 10, 200000, 50000, 'Giảm tối đa 50K', true),
('Miễn phí ship cho đơn từ 150K', 2, NULL, NULL, 150000, NULL, 'Áp dụng trong phạm vi 5km', true),
('Giảm 20%', 3, NULL, 20, 100000, 30000, 'Giảm 20% cho đơn từ 100k, tối đa 30k', TRUE),
('Freeship 15k', 3, 15000, NULL, 80000, NULL, 'Miễn phí ship 15k cho đơn từ 80k', TRUE);

-- 11. Dish options
INSERT IGNORE INTO dish_option (name, dish_id, price, description, is_available) VALUES
('Tăng size', 1, 50000, 'Tăng kích thước cua', true),
('Thêm me', 1, 15000, 'Thêm me chua', true),
('Tăng size', 2, 100000, 'Tăng kích thước tôm hùm', true),
('Thêm muối ớt', 2, 20000, 'Thêm muối ớt', true),
('Thêm sườn', 7, 25000, 'Thêm 1 miếng sườn', true),
('Thêm bì chả', 7, 15000, 'Thêm bì chả', true),
('Thêm chả trứng', 7, 10000, 'Thêm chả trứng', true),
('Thêm Trân Châu', 13, 5000, 'Trân châu truyền thống', TRUE),
('Thêm Thạch Phô Mai', 13, 7000, 'Thạch phô mai béo ngậy', TRUE),
('Thêm Kem Cheese', 15, 8000, 'Kem cheese mặn mà', TRUE),
('Ít Đá', 19, 0, 'Giữ hương vị đậm đà hơn', TRUE),
('Không Đường', 20, 0, 'Uống healthy hơn', TRUE),
('Đường 70%', 14, 0, 'Ngọt vừa phải', TRUE);

-- 12. Order statuses
INSERT IGNORE INTO order_status (name) VALUES
('Chờ xác nhận'), ('Đã xác nhận'), ('Đang chế biến'),
('Đang giao hàng'), ('Đã giao hàng'), ('Đã hủy');

-- 13. Shippers
INSERT IGNORE INTO shipper (name, phone, deliver_minute, price, is_available) VALUES
('Nguyễn Văn A', '0901234569', 30, 50000, true),
('Trần Thị B', '0901234570', 25, 45000, true),
('Lê Văn C', '0901234571', 20, 40000, true);

-- 14. Orders (sample data)
INSERT IGNORE INTO orders (user_id, restaurant_id, shipper_id, order_status_id, coupon_id, customer_note, address, total_price) VALUES
(4, 1, 1, 5, 1, 'Giao hàng cẩn thận', '123 Đường ABC, Quận 1, TP.HCM', 430000),
(4, 2, 2, 5, 4, 'Không cay', '456 Đường XYZ, Quận 3, TP.HCM', 110000),
(4, 1, 3, 4, 2, 'Giao nhanh', '123 Đường ABC, Quận 1, TP.HCM', 450000),
(1, 3, 1, 1, NULL, 'Ít đá, ngọt vừa', '123 Nguyễn Trãi, Hà Nội', 103000),
(2, 3, 2, 2, 1, 'Giao nhanh giúp mình nha', '56 Lê Lợi, Hà Nội', 105000),
(1, 3, 3, 3, 2, 'Thêm nhiều trân châu', '123 Nguyễn Trãi, Hà Nội', 70000);

-- 15. Order details
INSERT IGNORE INTO order_detail (order_id, dish_id, quantity, price) VALUES
(1, 1, 1, 250000),
(1, 3, 1, 180000),
(2, 7, 2, 55000),
(3, 2, 1, 450000),
(4, 13, 2, 39000),
(4, 19, 1, 25000),
(5, 15, 1, 45000),
(5, 21, 2, 30000),
(6, 14, 1, 42000),
(6, 20, 1, 28000);

-- 16. User addresses
INSERT IGNORE INTO user_address (user_id, full_address, default_address) VALUES
(4, '123 Đường ABC, Quận 1, TP.HCM', 0),
(4, '456 Đường XYZ, Quận 3, TP.HCM', 0),
(1, '123 Nguyễn Trãi, Hà Nội', 1),
(2, '56 Lê Lợi, Hà Nội', 0);
