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

INSERT IGNORE INTO user_address (user_id, full_address, default_address) VALUES
(4, '123 Đường ABC, Quận 1, TP.HCM', 0),
(4, '456 Đường XYZ, Quận 3, TP.HCM', 0),
(1, '123 Nguyễn Trãi, Hà Nội', 1),
(2, '56 Lê Lợi, Hà Nội', 0);

-- ============================================================
-- THÊM MÓN MỚI (id 25–34)
-- ============================================================

-- ── Dishes ──────────────────────────────────────────────────
INSERT IGNORE INTO dish (name, restaurant_id, price, description, picture_url, tag_id, baner, is_available, category_id) VALUES
-- Nhà hàng 1 - Hải Sản Biển Đông
('Nghêu hấp sả', 1, 95000, 'Nghêu tươi hấp sả gừng, mở miệng thơm lừng, nước dùng ngọt tự nhiên', 'eat_food/ngheu_hap_sa.jpg', 1, false, true, 4),
('Cá lóc nướng trui', 1, 165000, 'Cá lóc đồng nướng trui theo kiểu miền Nam, ăn kèm bánh tráng và rau sống', 'eat_food/ca_loc_nuong_trui.jpg', 7, false, true, 4),
('Lẩu hải sản thập cẩm', 1, 380000, 'Lẩu hải sản đặc biệt với tôm, cua, mực, cá và nấm, nước dùng đậm đà (2-3 người)', 'eat_food/lau_hai_san.jpg', 3, false, true, 4),
-- Nhà hàng 2 - Cơm Tấm Sài Gòn
('Cơm tấm bì sườn trứng', 2, 65000, 'Combo cơm tấm đầy đủ: sườn nướng, bì, chả, trứng ốp la', 'eat_food/com_tam_bi_suon_trung.jpg', 5, false, true, 1),
('Bún bò Huế', 2, 75000, 'Bún bò Huế đúng vị: nước dùng cay nồng, thịt bò mềm, chả cua thơm', 'eat_food/bun_bo_hue.jpg', 1, false, true, 3),
('Mì Quảng gà', 2, 70000, 'Mì Quảng sợi vàng, nhân gà và tôm, chan xăm xắp nước dùng sệt', 'eat_food/mi_quang_ga.jpg', 3, false, true, 3),
('Bánh canh cua', 2, 80000, 'Sợi bánh canh to tròn, cua đồng béo ngậy, nước lèo sánh đỏ', 'eat_food/banh_canh_cua.jpg', 1, false, true, 3),
-- Nhà hàng 3 - Milktea House
('Trà Sữa Taro', 3, 43000, 'Khoai môn tím thơm béo, hòa quyện cùng sữa tươi, phủ trân châu trắng', 'drinks/tra_sua_taro.jpg', 10, false, true, 7),
('Trà Đào Cam Sả', 3, 35000, 'Trà đào mát lạnh kết hợp cam tươi và sả thơm, thanh mát ngày hè', 'drinks/tra_dao_cam_sa.jpg', 11, false, true, 8),
('Sinh Tố Bơ Sữa', 3, 48000, 'Bơ hass chín mượt, xay cùng sữa đặc và đá bào, béo ngậy mịn màng', 'drinks/sinh_to_bo_sua.jpg', 9, false, true, 7);

-- ── Nutrition data cho 10 món mới ───────────────────────────
INSERT IGNORE INTO dish_nutrition (dish_id, nutrition_id, amount) VALUES
-- Nghêu hấp sả (25)
(25,1,180),(25,2,22),(25,3,8),(25,4,5),(25,5,1),(25,6,520),(25,7,2),
-- Cá lóc nướng trui (26)
(26,1,340),(26,2,38),(26,3,5),(26,4,18),(26,5,1),(26,6,680),(26,7,1),
-- Lẩu hải sản thập cẩm (27)
(27,1,620),(27,2,55),(27,3,25),(27,4,30),(27,5,4),(27,6,1200),(27,7,5),
-- Cơm tấm bì sườn trứng (28)
(28,1,720),(28,2,38),(28,3,85),(28,4,32),(28,5,2),(28,6,1050),(28,7,6),
-- Bún bò Huế (29)
(29,1,540),(29,2,36),(29,3,68),(29,4,18),(29,5,3),(29,6,1100),(29,7,4),
-- Mì Quảng gà (30)
(30,1,510),(30,2,30),(30,3,70),(30,4,16),(30,5,3),(30,6,920),(30,7,4),
-- Bánh canh cua (31)
(31,1,490),(31,2,28),(31,3,72),(31,4,14),(31,5,2),(31,6,880),(31,7,3),
-- Trà Sữa Taro (32)
(32,1,430),(32,2,8),(32,3,58),(32,4,17),(32,5,2),(32,6,165),(32,7,36),
-- Trà Đào Cam Sả (33)
(33,1,155),(33,2,1),(33,3,35),(33,4,0),(33,5,1),(33,6,30),(33,7,29),
-- Sinh Tố Bơ Sữa (34)
(34,1,480),(34,2,6),(34,3,32),(34,4,38),(34,5,7),(34,6,90),(34,7,18);

-- ── Dish options cho các món mới ────────────────────────────
INSERT IGNORE INTO dish_option (name, dish_id, price, description, is_available) VALUES
-- Nghêu hấp sả (25)
('Thêm sả', 25, 10000, 'Thêm sả thơm', true),
('Thêm ớt', 25, 5000, 'Tăng độ cay', true),
-- Lẩu hải sản (27)
('Thêm tôm', 27, 60000, 'Thêm 3 con tôm sú', true),
('Thêm mực', 27, 40000, 'Thêm mực tươi', true),
('Thêm nấm', 27, 20000, 'Mix nấm đông cô & kim châm', true),
-- Cơm tấm bì sườn trứng (28)
('Thêm sườn', 28, 25000, 'Thêm 1 miếng sườn nướng', true),
('Thêm trứng', 28, 8000, 'Thêm trứng ốp la', true),
-- Bún bò Huế (29)
('Thêm giò heo', 29, 30000, 'Thêm 1/2 giò heo ninh mềm', true),
('Thêm chả cua', 29, 15000, 'Thêm chả cua đặc biệt', true),
('Ít cay', 29, 0, 'Giảm bột ớt', true),
-- Trà Sữa Taro (32)
('Thêm Trân Châu Đen', 32, 5000, 'Trân châu đường đen dẻo', true),
('Ít Đường', 32, 0, 'Ngọt 50%', true),
('Size L', 32, 8000, 'Tăng cỡ ly lên 700ml', true),
-- Trà Đào Cam Sả (33)
('Thêm đào', 33, 10000, 'Thêm miếng đào giòn', true),
('Ít Đá', 33, 0, 'Ít đá để vị đậm hơn', true),
-- Sinh Tố Bơ Sữa (34)
('Thêm sữa đặc', 34, 5000, 'Ngọt đậm hơn', true),
('Không đường', 34, 0, 'Uống thuần bơ', true);

-- ============================================================
-- THÊM MÓN MỚI (id 35–50): Topping · Rau củ · Healthy & Gym
-- ============================================================

-- ── Thêm 2 category mới ─────────────────────────────────────
INSERT IGNORE INTO category (name) VALUES
('Nước Ép'),
('Healthy & Gym');

-- ── Dishes ──────────────────────────────────────────────────
INSERT IGNORE INTO dish (name, restaurant_id, price, description, picture_url, tag_id, baner, is_available, category_id) VALUES
-- TOPPING (id 35–39, restaurant 3)
('Trân Châu Đường Đen', 3, 10000, 'Trân châu tự nấu, dẻo dai thơm ngọt, rim đường đen mật mía', 'toppings/tran_chau_duong_den.jpg', 10, false, true, 9),
('Thạch Dừa', 3, 8000, 'Thạch dừa thanh mát, giòn giòn, thích hợp thêm vào mọi đồ uống', 'toppings/thach_dua.jpg', 9, false, true, 9),
('Pudding Trứng', 3, 12000, 'Pudding trứng mịn màng béo ngậy kiểu Nhật, tan trong miệng', 'toppings/pudding_trung.jpg', 10, false, true, 9),
('Kem Cheese Tươi', 3, 15000, 'Kem cheese làm từ cream cheese tươi, mặn ngọt hài hòa', 'toppings/kem_cheese.jpg', 11, false, true, 9),
('Thạch Trà Xanh', 3, 10000, 'Thạch matcha dịu ngọt, màu xanh đẹp mắt, bổ sung vào trà sữa', 'toppings/thach_tra_xanh.jpg', 9, false, true, 9),
-- RAU CỦ (id 40–44, restaurant 2)
('Rau muống xào tỏi', 2, 35000, 'Rau muống non tươi xào tỏi phi vàng, xanh giòn đậm đà', 'vegetables/rau_muong_xao_toi.jpg', 5, false, true, 6),
('Đậu hũ sốt cà chua', 2, 40000, 'Đậu hũ non hấp thụ nước sốt cà chua ngọt chua, ăn kèm cơm rất ngon', 'vegetables/dau_hu_sot_ca_chua.jpg', 6, false, true, 6),
('Canh khổ qua nhồi thịt', 2, 45000, 'Khổ qua nhồi thịt heo xay, nước canh ngọt, thanh lọc cơ thể', 'vegetables/canh_kho_qua.jpg', 1, false, true, 6),
('Gỏi cuốn tươi (4 cuốn)', 2, 35000, 'Gỏi cuốn tươi với tôm, thịt, bún, rau sống, chấm nước tương', 'vegetables/goi_cuon_tuoi.jpg', 5, false, true, 6),
('Salad cà chua dưa leo', 2, 30000, 'Salad rau củ tươi mát, trộn giấm olive, hạt tiêu, thảo mộc', 'vegetables/salad_ca_chua.jpg', 6, false, true, 6),
-- NƯỚC ÉP (id 45–47, restaurant 3)
('Nước ép dưa hấu', 3, 40000, 'Dưa hấu đỏ tươi ép lạnh, ngọt mát giải nhiệt tức thì', 'juice/nuoc_ep_dua_hau.jpg', 11, false, true, 10),
('Nước ép cà rốt cam gừng', 3, 45000, 'Cà rốt + cam tươi + gừng ép lạnh, tốt cho mắt và miễn dịch', 'juice/nuoc_ep_ca_rot_cam.jpg', 9, false, true, 10),
('Nước ép cần tây táo', 3, 48000, 'Cần tây + táo xanh + chanh ép lạnh, detox nhẹ mỗi sáng', 'juice/nuoc_ep_can_tay_tao.jpg', 9, false, true, 10),
-- HEALTHY & GYM (id 48–50, restaurant 3)
('Protein Shake Chuối Socola', 3, 68000, 'Whey protein + chuối + cacao nguyên chất + sữa hạnh nhân, nạp năng lượng sau tập', 'healthy/protein_shake_chuoi.jpg', 11, false, true, 11),
('Green Detox Smoothie', 3, 58000, 'Cải bó xôi + dứa + táo + gừng + chanh xay nhuyễn, detox toàn thân', 'healthy/green_detox.jpg', 9, false, true, 11),
('Smoothie Yến Mạch Bơ', 3, 62000, 'Bơ hass + yến mạch rolled + chuối + mật ong + sữa hạnh nhân, bữa sáng lý tưởng cho gym thủ', 'healthy/smoothie_yen_mach_bo.jpg', 10, false, true, 11);

-- ── Nutrition data (16 món mới) ─────────────────────────────
INSERT IGNORE INTO dish_nutrition (dish_id, nutrition_id, amount) VALUES
(35,1,120),(35,2,0),(35,3,30),(35,4,0),(35,5,0),(35,6,15),(35,7,20),
(36,1,60),(36,2,0),(36,3,15),(36,4,0),(36,5,0),(36,6,10),(36,7,10),
(37,1,180),(37,2,5),(37,3,22),(37,4,8),(37,5,0),(37,6,80),(37,7,18),
(38,1,210),(38,2,4),(38,3,12),(38,4,18),(38,5,0),(38,6,120),(38,7,10),
(39,1,70),(39,2,1),(39,3,16),(39,4,0),(39,5,0),(39,6,20),(39,7,12),
(40,1,120),(40,2,4),(40,3,10),(40,4,7),(40,5,3),(40,6,320),(40,7,2),
(41,1,180),(41,2,12),(41,3,14),(41,4,9),(41,5,2),(41,6,380),(41,7,5),
(42,1,210),(42,2,18),(42,3,12),(42,4,10),(42,5,4),(42,6,450),(42,7,3),
(43,1,190),(43,2,14),(43,3,25),(43,4,4),(43,5,3),(43,6,280),(43,7,2),
(44,1,90),(44,2,3),(44,3,12),(44,4,4),(44,5,3),(44,6,180),(44,7,6),
(45,1,120),(45,2,2),(45,3,28),(45,4,0),(45,5,1),(45,6,15),(45,7,22),
(46,1,140),(46,2,2),(46,3,32),(46,4,0),(46,5,2),(46,6,80),(46,7,24),
(47,1,110),(47,2,1),(47,3,26),(47,4,0),(47,5,2),(47,6,90),(47,7,20),
(48,1,420),(48,2,36),(48,3,45),(48,4,8),(48,5,4),(48,6,220),(48,7,18),
(49,1,160),(49,2,4),(49,3,35),(49,4,1),(49,5,5),(49,6,95),(49,7,22),
(50,1,480),(50,2,12),(50,3,52),(50,4,28),(50,5,8),(50,6,130),(50,7,14);

-- ── Dish options ─────────────────────────────────────────────
INSERT IGNORE INTO dish_option (name, dish_id, price, description, is_available) VALUES
('Thêm vào trà sữa bất kỳ', 35, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 36, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 37, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 38, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 39, 0, 'Combo topping + đồ uống', true),
('Thêm tỏi phi', 40, 5000, 'Tỏi phi vàng giòn rắc thêm', true),
('Thêm ớt', 40, 0, 'Tăng độ cay', true),
('Thêm 2 cuốn', 43, 18000, 'Tổng 6 cuốn', true),
('Thêm nước tương đậu phộng', 43, 5000, 'Sốt đậu phộng đặc biệt', true),
('Thêm dressing Caesar', 44, 10000, 'Sốt Caesar béo ngậy', true),
('Không dầu olive', 44, 0, 'Ăn ít béo', true),
('Thêm đá', 45, 0, 'Thêm đá lạnh', true),
('Không đường', 46, 0, 'Uống thuần rau củ', true),
('Thêm gừng', 47, 5000, 'Tăng hương vị detox', true),
('Thêm 1 scoop protein', 48, 25000, 'Tăng 25g protein thêm', true),
('Không đường', 48, 0, 'Dành cho chế độ keto', true),
('Thêm chia seeds', 49, 8000, 'Bổ sung omega-3 và fiber', true),
('Thêm mật ong', 49, 5000, 'Tự nhiên ngọt hơn', true),
('Thêm 1 scoop protein', 50, 25000, 'Tăng protein cho buổi sáng', true),
('Không mật ong', 50, 0, 'Ăn kiêng đường', true);


