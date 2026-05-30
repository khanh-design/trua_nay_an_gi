-- Script thêm dữ liệu mẫu cho database casestudy
-- Chạy script này để có dữ liệu test trang chi tiết món ăn
create database `casestudy`;
USE casestudy;

-- 1. Thêm dữ liệu cho bảng roles
INSERT INTO roles (name) VALUES 
('ADMIN'),
('OWNER'), 
('CUSTOMER');

-- 2. Thêm dữ liệu cho bảng users
INSERT INTO user (username, password, email, phone, full_name, avatar_url) VALUES
('admin', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'admin@codegym.vn', '0987654321', 'Admin System', NULL),
('owner1', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'owner1@restaurant.com', '0123456789', 'Chủ nhà hàng 1', NULL),
('owner2', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'owner2@restaurant.com', '0123456790', 'Chủ nhà hàng 2', NULL),
('customer1', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'customer1@gmail.com', '0123456791', 'Khách hàng 1', NULL);

-- 3. Thêm dữ liệu cho bảng user_roles
INSERT INTO user_roles (user_id, role_id) VALUES
(1, 1), -- admin có role ADMIN
(2, 2), -- owner1 có role OWNER
(3, 2), -- owner2 có role OWNER
(4, 3); -- customer1 có role CUSTOMER

-- 4. Thêm dữ liệu cho bảng restaurants
INSERT INTO restaurant (name, user_id, address, phone, logo_url, description, is_long_term_partner, is_open, is_locked, is_approved) VALUES
('Nhà hàng Hải Sản Biển Đông', 2, '123 Đường Trần Hưng Đạo, Quận 1, TP.HCM', '0901234567', '/images/logo.jpg', 'Chuyên về các món hải sản tươi ngon, được chế biến theo công thức truyền thống', true, true, false, true),
('Quán Cơm Tấm Sài Gòn', 3, '456 Đường Lê Lợi, Quận 3, TP.HCM', '0901234568', '/images/logo.jpg', 'Quán cơm tấm nổi tiếng với hương vị đặc trưng của Sài Gòn', true, true, false, true),
('Trà Sữa Milktea House', 1, '123 Nguyễn Trãi, Hà Nội', '0988123456', 'https://example.com/logo_milktea.png', 'Chuỗi cửa hàng chuyên trà sữa, trà chanh và đồ uống giới trẻ', TRUE, TRUE, FALSE, TRUE);

-- 5. Thêm dữ liệu cho bảng categories
INSERT INTO category (name) VALUES
('Cơm'),
('Phở'),
('Bún'),
('Hải sản'),
('Gà'),
('Rau củ'),
('Trà Sữa'), 
('Trà Chanh'),
('Topping');

-- 6. Thêm dữ liệu cho bảng tags
INSERT INTO tag (name, restaurant_id) VALUES
('Ngon', 1),
('Rẻ', 2),
('Đặc biệt', 1),
('Mới', 1),
('Bán chạy', 2),
('Khuyến mãi', 2),
('Truyền thống', 1),
('Hiện đại', 2),
('Ngọt nhẹ', 3),
('Best seller', 3),
('Giới trẻ yêu thích', 3);

-- 7. Thêm dữ liệu cho bảng dishes
INSERT INTO dish (name, restaurant_id, price, description, picture_url, tag_id, is_available, category_id) VALUES
-- Nhà hàng Hải Sản Biển Đông
('Cua rang me', 1, 250000, 'Cua biển tươi rang với me chua ngọt, thịt cua săn chắc, nước sốt đậm đà', '/images/logo.jpg', 1, true, 4),
('Tôm hùm nướng muối ớt', 1, 450000, 'Tôm hùm tươi nướng với muối ớt, thịt ngọt béo, hương vị đặc trưng', '/images/logo.jpg', 3, true, 4),
('Cá hồi nướng lá chuối', 1, 180000, 'Cá hồi tươi nướng trong lá chuối, giữ nguyên hương vị tự nhiên', '/images/logo.jpg', 1, true, 4),
('Mực xào chua ngọt', 1, 120000, 'Mực tươi xào với nước sốt chua ngọt, giòn sần sật', '/images/logo.jpg', 2, true, 4),
('Súp hải sản', 1, 80000, 'Súp nóng với tôm, mực, cá và rau củ, nước dùng đậm đà', '/images/logo.jpg', 1, true, 4),
('Gỏi cá trích', 1, 95000, 'Gỏi cá trích tươi với rau sống, nước mắm chua ngọt', '/images/logo.jpg', 2, true, 4),

-- Quán Cơm Tấm Sài Gòn
('Cơm tấm sườn nướng', 2, 55000, 'Cơm tấm với sườn heo nướng thơm lừng, bì chả, chả trứng', '/images/logo.jpg', 1, true, 1),
('Cơm tấm gà nướng', 2, 50000, 'Cơm tấm với gà nướng da giòn, thịt mềm, nước mắm đặc biệt', '/images/logo.jpg', 2, true, 1),
('Cơm tấm chả cá', 2, 60000, 'Cơm tấm với chả cá thơm ngon, bì chả, chả trứng', '/images/logo.jpg', 3, true, 1),
('Phở bò tái', 2, 65000, 'Phở bò với nước dùng đậm đà, bò tái mềm, bánh phở dai', '/images/logo.jpg', 1, true, 2),
('Bún chả cá', 2, 70000, 'Bún với chả cá tươi, nước dùng ngọt, rau sống tươi', '/images/logo.jpg', 2, true, 3),
('Gà nướng lá chanh', 2, 180000, 'Gà ta nướng với lá chanh, thịt mềm, da giòn', '/images/logo.jpg', 3, true, 5),
('Trà Sữa Trân Châu Đường Đen', 3, 39000, 'Trà sữa đậm vị, trân châu đường đen dẻo thơm', 'https://example.com/trasua_duongden.jpg', 10, TRUE, 7),
('Trà Sữa Matcha', 3, 42000, 'Matcha Nhật Bản, vị ngọt dịu', 'https://example.com/trasua_matcha.jpg', 9, TRUE, 7),
('Trà Sữa Oolong Kem Cheese', 3, 45000, 'Trà oolong thơm nhẹ, phủ kem cheese mặn mà', 'https://example.com/oolong_cheese.jpg', 10, TRUE, 7),
('Trà Sữa Thái Xanh', 3, 35000, 'Trà Thái xanh đặc trưng, béo thơm', 'https://example.com/tra_thai_xanh.jpg', 11, TRUE, 7),
('Trà Sữa Socola', 3, 37000, 'Kết hợp giữa vị cacao và sữa', 'https://example.com/tra_socola.jpg', 9, TRUE, 7),
('Trà Sữa Hồng Trà', 3, 36000, 'Hồng trà đậm đà, kết hợp sữa ngọt nhẹ', 'https://example.com/tra_hong.jpg', 10, TRUE, 7),

('Trà Chanh Sả Tắc', 3, 25000, 'Trà chanh thanh mát kết hợp sả và tắc', 'https://example.com/trachanh_sata.jpg', 11, TRUE, 8),
('Trà Chanh Cam Quế', 3, 28000, 'Trà chanh kèm cam tươi và hương quế', 'https://example.com/trachanh_camque.jpg', 9, TRUE, 8),
('Trà Chanh Đào', 3, 30000, 'Trà chanh kết hợp miếng đào giòn ngọt', 'https://example.com/trachanh_dao.jpg', 10, TRUE, 8),
('Trà Chanh Bạc Hà', 3, 27000, 'Trà chanh thanh mát với bạc hà', 'https://example.com/trachanh_bac_ha.jpg', 11, TRUE, 8),
('Trà Chanh Gừng Mật Ong', 3, 32000, 'Tốt cho sức khỏe, ấm nóng vị gừng', 'https://example.com/trachanh_gung.jpg', 9, TRUE, 8),
('Trà Chanh Kiwi', 3, 34000, 'Trà chanh pha kiwi chua ngọt lạ miệng', 'https://example.com/trachanh_kiwi.jpg', 10, TRUE, 8);

-- DỮ LIỆU BẢNG nutrition (LOẠI CHẤT DINH DƯỠNG)
INSERT INTO nutrition (id, name, unit) VALUES
(1, 'Calories', 'kcal'),
(2, 'Protein', 'g'),
(3, 'Carbohydrate', 'g'),
(4, 'Fat', 'g'),
(5, 'Fiber', 'g'),
(6, 'Sodium', 'mg'),
(7, 'Sugar', 'g');

-- dish_nutrition
-- (dish_id, nutrition_id, amount)

INSERT INTO dish_nutrition (dish_id, nutrition_id, amount) VALUES
-- Cua rang me (1)
(1,1,520),(1,2,42),(1,3,12),(1,4,38),(1,5,1),(1,6,950),(1,7,6),

-- Tôm hùm nướng muối ớt (2)
(2,1,680),(2,2,60),(2,3,5),(2,4,45),(2,5,0),(2,6,1100),(2,7,2),

-- Cá hồi nướng lá chuối (3)
(3,1,420),(3,2,35),(3,3,8),(3,4,28),(3,5,1),(3,6,700),(3,7,1),

-- Mực xào chua ngọt (4)
(4,1,360),(4,2,28),(4,3,18),(4,4,16),(4,5,2),(4,6,820),(4,7,9),

-- Súp hải sản (5)
(5,1,250),(5,2,18),(5,3,20),(5,4,6),(5,5,2),(5,6,600),(5,7,4),

-- Cơm tấm sườn nướng (7)
(7,1,650),(7,2,32),(7,3,78),(7,4,28),(7,5,2),(7,6,980),(7,7,5),

-- Cơm tấm gà nướng (8)
(8,1,620),(8,2,30),(8,3,75),(8,4,24),(8,5,2),(8,6,900),(8,7,4),

-- Cơm tấm chả cá (9)
(9,1,700),(9,2,34),(9,3,80),(9,4,30),(9,5,2),(9,6,1020),(9,7,5),

-- Phở bò tái (10)
(10,1,520),(10,2,35),(10,3,65),(10,4,15),(10,5,2),(10,6,850),(10,7,3),

-- Bún chả cá (11)
(11,1,480),(11,2,28),(11,3,60),(11,4,12),(11,5,3),(11,6,780),(11,7,3),

-- Gà nướng lá chanh (12)
(12,1,560),(12,2,45),(12,3,10),(12,4,35),(12,5,1),(12,6,900),(12,7,1),

-- Trà sữa trân châu đường đen (13)
(13,1,420),(13,2,8),(13,3,55),(13,4,18),(13,5,1),(13,6,160),(13,7,38),

-- Trà sữa matcha (14)
(14,1,390),(14,2,7),(14,3,50),(14,4,15),(14,5,1),(14,6,150),(14,7,32),

-- Trà sữa oolong kem cheese (15)
(15,1,450),(15,2,8),(15,3,52),(15,4,20),(15,5,1),(15,6,170),(15,7,35),

-- Trà sữa Thái xanh (16)
(16,1,410),(16,2,7),(16,3,54),(16,4,16),(16,5,1),(16,6,155),(16,7,34),

-- Trà sữa socola (17)
(17,1,400),(17,2,7),(17,3,53),(17,4,15),(17,5,1),(17,6,150),(17,7,36),

-- Trà sữa hồng trà (18)
(18,1,380),(18,2,6),(18,3,50),(18,4,14),(18,5,1),(18,6,145),(18,7,30),

-- Trà chanh sả tắc (19)
(19,1,120),(19,2,1),(19,3,28),(19,4,0),(19,5,1),(19,6,25),(19,7,22),

-- Trà chanh cam quế (20)
(20,1,140),(20,2,1),(20,3,30),(20,4,0),(20,5,1),(20,6,30),(20,7,24),

-- Trà chanh đào (21)
(21,1,160),(21,2,1),(21,3,34),(21,4,0),(21,5,2),(21,6,35),(21,7,28),

-- Trà chanh bạc hà (22)
(22,1,130),(22,2,1),(22,3,29),(22,4,0),(22,5,1),(22,6,28),(22,7,23),

-- Trà chanh gừng mật ong (23)
(23,1,150),(23,2,1),(23,3,32),(23,4,0),(23,5,1),(23,6,40),(23,7,26),

-- Trà chanh kiwi (24)
(24,1,170),(24,2,1),(24,3,36),(24,4,0),(24,5,2),(24,6,45),(24,7,30);

SELECT n.name, dn.amount, n.unit
FROM dish_nutrition dn
JOIN nutrition n ON dn.nutrition_id = n.id
WHERE dn.dish_id = 1;

-- 8. Thêm dữ liệu cho bảng coupons
INSERT INTO coupon (name, restaurant_id, fixed_discount, percent_discount, min_order, max_discount, description, is_available) VALUES
-- Coupon cho Nhà hàng Hải Sản Biển Đông
('Giảm 50K cho đơn từ 500K', 1, 50000, NULL, 500000, NULL, 'Áp dụng cho tất cả món ăn', true),
('Giảm 15% cho đơn từ 1 triệu', 1, NULL, 15, 1000000, 200000, 'Giảm tối đa 200K', true),
('Giảm 100K cho đơn từ 800K', 1, 100000, NULL, 800000, NULL, 'Chỉ áp dụng vào thứ 2-4', true),

-- Coupon cho Quán Cơm Tấm Sài Gòn
('Giảm 20K cho đơn từ 100K', 2, 20000, NULL, 100000, NULL, 'Áp dụng cho tất cả món ăn', true),
('Giảm 10% cho đơn từ 200K', 2, NULL, 10, 200000, 50000, 'Giảm tối đa 50K', true),
('Miễn phí ship cho đơn từ 150K', 2, NULL, NULL, 150000, NULL, 'Áp dụng trong phạm vi 5km', true),
('Giảm 20%', 3, NULL, 20, 100000, 30000, 'Giảm 20% cho đơn từ 100k, tối đa 30k', TRUE),
('Freeship 15k', 3, 15000, NULL, 80000, NULL, 'Miễn phí ship 15k cho đơn từ 80k', TRUE);

-- 9. Thêm dữ liệu cho bảng dish_options
INSERT INTO dish_option (name, dish_id, price, description, is_available) VALUES
-- Options cho món Cua rang me
('Tăng size', 1, 50000, 'Tăng kích thước cua', true),
('Thêm me', 1, 15000, 'Thêm me chua', true),

-- Options cho món Tôm hùm nướng muối ớt
('Tăng size', 2, 100000, 'Tăng kích thước tôm hùm', true),
('Thêm muối ớt', 2, 20000, 'Thêm muối ớt', true),

-- Options cho món Cơm tấm sườn nướng
('Thêm sườn', 7, 25000, 'Thêm 1 miếng sườn', true),
('Thêm bì chả', 7, 15000, 'Thêm bì chả', true),
('Thêm chả trứng', 7, 10000, 'Thêm chả trứng', true),

('Thêm Trân Châu', 13, 5000, 'Trân châu truyền thống', TRUE),
('Thêm Thạch Phô Mai', 13, 7000, 'Thạch phô mai béo ngậy', TRUE),
('Thêm Kem Cheese', 15, 8000, 'Kem cheese mặn mà', TRUE),
('Ít Đá', 19, 0, 'Giữ hương vị đậm đà hơn', TRUE),
('Không Đường', 20, 0, 'Uống healthy hơn', TRUE),
('Đường 70%', 14, 0, 'Ngọt vừa phải', TRUE);

-- 10. Thêm dữ liệu cho bảng order_status
INSERT INTO order_status (name) VALUES
('Chờ xác nhận'),
('Đã xác nhận'),
('Đang chế biến'),
('Đang giao hàng'),
('Đã giao hàng'),
('Đã hủy');

-- 11. Thêm dữ liệu cho bảng shippers
INSERT INTO shipper (name, phone, deliver_minute, price, is_available) VALUES
('Nguyễn Văn A', '0901234569', 30, 50000, true),
('Trần Thị B', '0901234570', 25, 45000, true),
('Lê Văn C', '0901234571', 20, 40000, true);

-- 12. Thêm dữ liệu cho bảng orders (để test)
INSERT INTO orders (user_id, restaurant_id, shipper_id, order_status_id, coupon_id, customer_note) VALUES
(4, 1, 1, 5, 1, 'Giao hàng cẩn thận'),
(4, 2, 2, 5, 4, 'Không cay'),
(4, 1, 3, 4, 2, 'Giao nhanh'),
(1, 3, 1, 1, NULL, 'Ít đá, ngọt vừa'),
(2, 3, 2, 2, 1, 'Giao nhanh giúp mình nha'),
(1, 3, 3, 3, 2, 'Thêm nhiều trân châu');

-- 13. Thêm dữ liệu cho bảng order_details
INSERT INTO order_detail (order_id, dish_id, quantity) VALUES
(1, 1, 1),
(1, 3, 1),
(2, 7, 2),
(3, 2, 1),
(4, 13, 2), -- Đơn 4: 2 ly Trà Sữa Trân Châu Đường Đen
(4, 19, 1), -- Đơn 4: 1 ly Trà Chanh Sả Tắc
(5, 15, 1), -- Đơn 5: 1 ly Trà Sữa Oolong Kem Cheese
(5, 21, 2), -- Đơn 5: 2 ly Trà Chanh Đào
(6, 14, 1), -- Đơn 6: 1 ly Trà Sữa Matcha
(6, 20, 1); -- Đơn 6: 1 ly Trà Chanh Cam Quế

-- 14. Thêm dữ liệu cho bảng order_option_details
INSERT INTO oder_option_detail (order_detail_id, dish_option_id) VALUES
(1, 1),
(1, 2),
(3, 5),
(5, 1),  -- Trà Sữa Đường Đen thêm trân châu
(5, 2),  -- Trà Sữa Đường Đen thêm thạch phô mai
(7, 3),  -- Trà Oolong thêm Kem Cheese
(9, 6);  -- Trà Sữa Matcha mức ngọt 70%

INSERT INTO user_address (user_id, full_address, default_address) VALUES
(4, '123 Đường ABC, Quận 1, TP.HCM', 0),
(4, '456 Đường XYZ, Quận 3, TP.HCM', 0),
(1, '123 Nguyễn Trãi, Hà Nội', 1),
(2, '56 Lê Lợi, Hà Nội', 0);

UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/cua_rang_me.jpg' WHERE (`id` = '1');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/tom_hung_nuong.jpg' WHERE (`id` = '2');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/ca_hoi_nuong_la_chuoi.jpg' WHERE (`id` = '3');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/muc_sao_chua_ngot.jpg' WHERE (`id` = '4');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/sup_hai_san.jpg' WHERE (`id` = '5');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/com_tam.jpg' WHERE (`id` = '7');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/com_tam_ga_nuong.jpg' WHERE (`id` = '8');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/com-tam-cha-ca.jpg' WHERE (`id` = '9');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/pho-bo-tai.jpg' WHERE (`id` = '10');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/bun-cha-ca.jpg' WHERE (`id` = '11');
UPDATE `casestudy`.`dish` SET `picture_url` = 'eat_food/ga-nuong-la-tranh.jpg' WHERE (`id` = '12');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-sua-chan-trau-duong-den.jpg' WHERE (`id` = '13');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-sua-matcha.jpg' WHERE (`id` = '14');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-oolong-kem-cheese.jpg' WHERE (`id` = '15');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra_thai_xanh.jpg' WHERE (`id` = '16');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra_sua_socola.jpg' WHERE (`id` = '17');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/hong-tra-sua-tran-chau-trang.jpg' WHERE (`id` = '18');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-tac.jpg' WHERE (`id` = '19');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-cam-que.jpg' WHERE (`id` = '20');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-chanh-dao.jpg' WHERE (`id` = '21');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-chanh-bac-ha.jpg' WHERE (`id` = '22');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/tra-gung-mat-ong.jpg' WHERE (`id` = '23');
UPDATE `casestudy`.`dish` SET `picture_url` = 'drinks/meo-khi-pha-che-tra-kiwi.jpg' WHERE (`id` = '24');


UPDATE `casestudy`.`category` SET `picture_url` = 'com.jpg' WHERE (`id` = '1');
UPDATE `casestudy`.`category` SET `picture_url` = 'pho.jpg' WHERE (`id` = '2');
UPDATE `casestudy`.`category` SET `picture_url` = 'bun.jpg' WHERE (`id` = '3');
UPDATE `casestudy`.`category` SET `picture_url` = 'hai-san.jpg' WHERE (`id` = '4');
UPDATE `casestudy`.`category` SET `picture_url` = 'ga.jpg' WHERE (`id` = '5');
UPDATE `casestudy`.`category` SET `picture_url` = 'rau.jpg' WHERE (`id` = '6');
UPDATE `casestudy`.`category` SET `picture_url` = 'tra-sua.jpg' WHERE (`id` = '7');
UPDATE `casestudy`.`category` SET `picture_url` = 'tra-chanh.jpg' WHERE (`id` = '8');
UPDATE `casestudy`.`category` SET `picture_url` = 'trai-cay.jpg ' WHERE (`id` = '9');

-- ============================================================
-- THÊM MÓN MỚI (id 25–34)
-- ============================================================

-- Nhà hàng 1 - Hải Sản Biển Đông (restaurant_id = 1)
-- Nhà hàng 2 - Cơm Tấm Sài Gòn     (restaurant_id = 2)
-- Nhà hàng 3 - Milktea House        (restaurant_id = 3)

-- ── Dishes ──────────────────────────────────────────────────
INSERT INTO dish (name, restaurant_id, price, description, picture_url, tag_id, baner, is_available, category_id) VALUES
-- Nhà hàng 1 (Hải sản)
('Nghêu hấp sả', 1, 95000, 'Nghêu tươi hấp sả gừng, mở miệng thơm lừng, nước dùng ngọt tự nhiên', 'eat_food/ngheu_hap_sa.jpg', 1, false, true, 4),
('Cá lóc nướng trui', 1, 165000, 'Cá lóc đồng nướng trui theo kiểu miền Nam, ăn kèm bánh tráng và rau sống', 'eat_food/ca_loc_nuong_trui.jpg', 7, false, true, 4),
('Lẩu hải sản thập cẩm', 1, 380000, 'Lẩu hải sản đặc biệt với tôm, cua, mực, cá và nấm, nước dùng đậm đà (2-3 người)', 'eat_food/lau_hai_san.jpg', 3, false, true, 4),

-- Nhà hàng 2 (Cơm Tấm Sài Gòn)
('Cơm tấm bì sườn trứng', 2, 65000, 'Combo cơm tấm đầy đủ: sườn nướng, bì, chả, trứng ốp la', 'eat_food/com_tam_bi_suon_trung.jpg', 5, false, true, 1),
('Bún bò Huế', 2, 75000, 'Bún bò Huế đúng vị: nước dùng cay nồng, thịt bò mềm, chả cua thơm', 'eat_food/bun_bo_hue.jpg', 1, false, true, 3),
('Mì Quảng gà', 2, 70000, 'Mì Quảng sợi vàng, nhân gà và tôm, chan xăm xắp nước dùng sệt', 'eat_food/mi_quang_ga.jpg', 3, false, true, 3),
('Bánh canh cua', 2, 80000, 'Sợi bánh canh to tròn, cua đồng béo ngậy, nước lèo sánh đỏ', 'eat_food/banh_canh_cua.jpg', 1, false, true, 3),

-- Nhà hàng 3 (Milktea House)
('Trà Sữa Taro', 3, 43000, 'Khoai môn tím thơm béo, hòa quyện cùng sữa tươi, phủ trân châu trắng', 'drinks/tra_sua_taro.jpg', 10, false, true, 7),
('Trà Đào Cam Sả', 3, 35000, 'Trà đào mát lạnh kết hợp cam tươi và sả thơm, thanh mát ngày hè', 'drinks/tra_dao_cam_sa.jpg', 11, false, true, 8),
('Sinh Tố Bơ Sữa', 3, 48000, 'Bơ hass chín mượt, xay cùng sữa đặc và đá bào, béo ngậy mịn màng', 'drinks/sinh_to_bo_sua.jpg', 9, false, true, 7);

-- ── Cập nhật picture_url cho các món mới ────────────────────
-- (đã nhúng trực tiếp trong INSERT ở trên, không cần UPDATE thêm)

-- ── Nutrition data cho 10 món mới ───────────────────────────
INSERT INTO dish_nutrition (dish_id, nutrition_id, amount) VALUES
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
INSERT INTO dish_option (name, dish_id, price, description, is_available) VALUES
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
INSERT INTO category (name) VALUES
('Nước Ép'),       -- id 10
('Healthy & Gym'); -- id 11

UPDATE `casestudy`.`category` SET `picture_url` = 'category/nuoc-ep.jpg'      WHERE (`id` = '10');
UPDATE `casestudy`.`category` SET `picture_url` = 'category/healthy-gym.jpg'  WHERE (`id` = '11');

-- ── Dishes ──────────────────────────────────────────────────
-- Topping (restaurant 3 - Milktea House, category_id = 9)
-- Rau củ  (restaurant 2 - Cơm Tấm Sài Gòn, category_id = 6)
-- Nước ép (restaurant 3 - Milktea House, category_id = 10)
-- Healthy (restaurant 3 - Milktea House, category_id = 11)

INSERT INTO dish (name, restaurant_id, price, description, picture_url, tag_id, baner, is_available, category_id) VALUES

-- ── TOPPING (id 35–39) ───────────────────────────────────────
('Trân Châu Đường Đen', 3, 10000, 'Trân châu tự nấu, dẻo dai thơm ngọt, rim đường đen mật mía', 'toppings/tran_chau_duong_den.jpg', 10, false, true, 9),
('Thạch Dừa', 3, 8000, 'Thạch dừa thanh mát, giòn giòn, thích hợp thêm vào mọi đồ uống', 'toppings/thach_dua.jpg', 9, false, true, 9),
('Pudding Trứng', 3, 12000, 'Pudding trứng mịn màng béo ngậy kiểu Nhật, tan trong miệng', 'toppings/pudding_trung.jpg', 10, false, true, 9),
('Kem Cheese Tươi', 3, 15000, 'Kem cheese làm từ cream cheese tươi, mặn ngọt hài hòa', 'toppings/kem_cheese.jpg', 11, false, true, 9),
('Thạch Trà Xanh', 3, 10000, 'Thạch matcha dịu ngọt, màu xanh đẹp mắt, bổ sung vào trà sữa', 'toppings/thach_tra_xanh.jpg', 9, false, true, 9),

-- ── RAU CỦ (id 40–44) ──────────────────────────────────────
('Rau muống xào tỏi', 2, 35000, 'Rau muống non tươi xào tỏi phi vàng, xanh giòn đậm đà', 'vegetables/rau_muong_xao_toi.jpg', 5, false, true, 6),
('Đậu hũ sốt cà chua', 2, 40000, 'Đậu hũ non hấp thụ nước sốt cà chua ngọt chua, ăn kèm cơm rất ngon', 'vegetables/dau_hu_sot_ca_chua.jpg', 6, false, true, 6),
('Canh khổ qua nhồi thịt', 2, 45000, 'Khổ qua nhồi thịt heo xay, nước canh ngọt, thanh lọc cơ thể', 'vegetables/canh_kho_qua.jpg', 1, false, true, 6),
('Gỏi cuốn tươi (4 cuốn)', 2, 35000, 'Gỏi cuốn tươi với tôm, thịt, bún, rau sống, chấm nước tương', 'vegetables/goi_cuon_tuoi.jpg', 5, false, true, 6),
('Salad cà chua dưa leo', 2, 30000, 'Salad rau củ tươi mát, trộn giấm olive, hạt tiêu, thảo mộc', 'vegetables/salad_ca_chua.jpg', 6, false, true, 6),

-- ── NƯỚC ÉP (id 45–47) ─────────────────────────────────────
('Nước ép dưa hấu', 3, 40000, 'Dưa hấu đỏ tươi ép lạnh, ngọt mát giải nhiệt tức thì', 'juice/nuoc_ep_dua_hau.jpg', 11, false, true, 10),
('Nước ép cà rốt cam gừng', 3, 45000, 'Cà rốt + cam tươi + gừng ép lạnh, tốt cho mắt và miễn dịch', 'juice/nuoc_ep_ca_rot_cam.jpg', 9, false, true, 10),
('Nước ép cần tây táo', 3, 48000, 'Cần tây + táo xanh + chanh ép lạnh, detox nhẹ mỗi sáng', 'juice/nuoc_ep_can_tay_tao.jpg', 9, false, true, 10),

-- ── HEALTHY & GYM (id 48–50) ────────────────────────────────
('Protein Shake Chuối Socola', 3, 68000, 'Whey protein + chuối + cacao nguyên chất + sữa hạnh nhân, nạp năng lượng sau tập', 'healthy/protein_shake_chuoi.jpg', 11, false, true, 11),
('Green Detox Smoothie', 3, 58000, 'Cải bó xôi + dứa + táo + gừng + chanh xay nhuyễn, detox toàn thân', 'healthy/green_detox.jpg', 9, false, true, 11),
('Smoothie Yến Mạch Bơ', 3, 62000, 'Bơ hass + yến mạch rolled + chuối + mật ong + sữa hạnh nhân, bữa sáng lý tưởng cho gym thủ', 'healthy/smoothie_yen_mach_bo.jpg', 10, false, true, 11);

-- ── Nutrition data (16 món mới) ─────────────────────────────
INSERT INTO dish_nutrition (dish_id, nutrition_id, amount) VALUES
-- Trân Châu Đường Đen (35)
(35,1,120),(35,2,0),(35,3,30),(35,4,0),(35,5,0),(35,6,15),(35,7,20),
-- Thạch Dừa (36)
(36,1,60),(36,2,0),(36,3,15),(36,4,0),(36,5,0),(36,6,10),(36,7,10),
-- Pudding Trứng (37)
(37,1,180),(37,2,5),(37,3,22),(37,4,8),(37,5,0),(37,6,80),(37,7,18),
-- Kem Cheese Tươi (38)
(38,1,210),(38,2,4),(38,3,12),(38,4,18),(38,5,0),(38,6,120),(38,7,10),
-- Thạch Trà Xanh (39)
(39,1,70),(39,2,1),(39,3,16),(39,4,0),(39,5,0),(39,6,20),(39,7,12),
-- Rau muống xào tỏi (40)
(40,1,120),(40,2,4),(40,3,10),(40,4,7),(40,5,3),(40,6,320),(40,7,2),
-- Đậu hũ sốt cà chua (41)
(41,1,180),(41,2,12),(41,3,14),(41,4,9),(41,5,2),(41,6,380),(41,7,5),
-- Canh khổ qua nhồi thịt (42)
(42,1,210),(42,2,18),(42,3,12),(42,4,10),(42,5,4),(42,6,450),(42,7,3),
-- Gỏi cuốn tươi (43)
(43,1,190),(43,2,14),(43,3,25),(43,4,4),(43,5,3),(43,6,280),(43,7,2),
-- Salad cà chua dưa leo (44)
(44,1,90),(44,2,3),(44,3,12),(44,4,4),(44,5,3),(44,6,180),(44,7,6),
-- Nước ép dưa hấu (45)
(45,1,120),(45,2,2),(45,3,28),(45,4,0),(45,5,1),(45,6,15),(45,7,22),
-- Nước ép cà rốt cam gừng (46)
(46,1,140),(46,2,2),(46,3,32),(46,4,0),(46,5,2),(46,6,80),(46,7,24),
-- Nước ép cần tây táo (47)
(47,1,110),(47,2,1),(47,3,26),(47,4,0),(47,5,2),(47,6,90),(47,7,20),
-- Protein Shake Chuối Socola (48)
(48,1,420),(48,2,36),(48,3,45),(48,4,8),(48,5,4),(48,6,220),(48,7,18),
-- Green Detox Smoothie (49)
(49,1,160),(49,2,4),(49,3,35),(49,4,1),(49,5,5),(49,6,95),(49,7,22),
-- Smoothie Yến Mạch Bơ (50)
(50,1,480),(50,2,12),(50,3,52),(50,4,28),(50,5,8),(50,6,130),(50,7,14);

-- ── Dish options ─────────────────────────────────────────────
INSERT INTO dish_option (name, dish_id, price, description, is_available) VALUES
-- Topping (thêm vào trà sữa)
('Thêm vào trà sữa bất kỳ', 35, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 36, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 37, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 38, 0, 'Combo topping + đồ uống', true),
('Thêm vào trà sữa bất kỳ', 39, 0, 'Combo topping + đồ uống', true),
-- Rau muống xào tỏi
('Thêm tỏi phi', 40, 5000, 'Tỏi phi vàng giòn rắc thêm', true),
('Thêm ớt', 40, 0, 'Tăng độ cay', true),
-- Gỏi cuốn
('Thêm 2 cuốn', 43, 18000, 'Tổng 6 cuốn', true),
('Thêm nước tương đậu phộng', 43, 5000, 'Sốt đậu phộng đặc biệt', true),
-- Salad
('Thêm dressing Caesar', 44, 10000, 'Sốt Caesar béo ngậy', true),
('Không dầu olive', 44, 0, 'Ăn ít béo', true),
-- Nước ép
('Thêm đá', 45, 0, 'Thêm đá lạnh', true),
('Không đường', 46, 0, 'Uống thuần rau củ', true),
('Thêm gừng', 47, 5000, 'Tăng hương vị detox', true),
-- Protein shake / Healthy
('Thêm 1 scoop protein', 48, 25000, 'Tăng 25g protein thêm', true),
('Không đường', 48, 0, 'Dành cho chế độ keto', true),
('Thêm chia seeds', 49, 8000, 'Bổ sung omega-3 và fiber', true),
('Thêm mật ong', 49, 5000, 'Tự nhiên ngọt hơn', true),
('Thêm 1 scoop protein', 50, 25000, 'Tăng protein cho buổi sáng', true),
('Không mật ong', 50, 0, 'Ăn kiêng đường', true);

-- ============================================================
-- CHUẨN HÓA picture_url: tất cả relative tới /images/
-- Template mới dùng: th:src="@{'/images/' + ${dish.pictureUrl}}"
-- Cấu trúc: /images/{category-folder}/{filename}
-- ============================================================

-- ── Dishes cũ (1–24): ảnh nằm trong /images/dish/eat_food/ hoặc /images/dish/drinks/
-- Thêm prefix "dish/" để trỏ đúng vào thư mục hiện có
UPDATE `casestudy`.`dish` SET `picture_url` = CONCAT('dish/', picture_url)
WHERE id BETWEEN 1 AND 24
  AND picture_url NOT LIKE 'dish/%';

-- ── Dishes nhóm 2 (25–34): cùng eat_food / drinks
UPDATE `casestudy`.`dish` SET `picture_url` = CONCAT('dish/', picture_url)
WHERE id BETWEEN 25 AND 34
  AND picture_url NOT LIKE 'dish/%';

-- ── TOPPING (35–39): /images/toppings/
UPDATE `casestudy`.`dish` SET `picture_url` = 'toppings/tran_chau_duong_den.jpg' WHERE id = 35;
UPDATE `casestudy`.`dish` SET `picture_url` = 'toppings/thach_dua.jpg'            WHERE id = 36;
UPDATE `casestudy`.`dish` SET `picture_url` = 'toppings/pudding_trung.jpg'         WHERE id = 37;
UPDATE `casestudy`.`dish` SET `picture_url` = 'toppings/kem_cheese.jpg'            WHERE id = 38;
UPDATE `casestudy`.`dish` SET `picture_url` = 'toppings/thach_tra_xanh.jpg'        WHERE id = 39;

-- ── RAU CỦ (40–44): /images/vegetables/
UPDATE `casestudy`.`dish` SET `picture_url` = 'vegetables/rau_muong_xao_toi.jpg'  WHERE id = 40;
UPDATE `casestudy`.`dish` SET `picture_url` = 'vegetables/dau_hu_sot_ca_chua.jpg' WHERE id = 41;
UPDATE `casestudy`.`dish` SET `picture_url` = 'vegetables/canh_kho_qua.jpg'        WHERE id = 42;
UPDATE `casestudy`.`dish` SET `picture_url` = 'vegetables/goi_cuon_tuoi.jpg'       WHERE id = 43;
UPDATE `casestudy`.`dish` SET `picture_url` = 'vegetables/salad_ca_chua.jpg'       WHERE id = 44;

-- ── NƯỚC ÉP (45–47): /images/juice/
UPDATE `casestudy`.`dish` SET `picture_url` = 'juice/nuoc_ep_dua_hau.jpg'         WHERE id = 45;
UPDATE `casestudy`.`dish` SET `picture_url` = 'juice/nuoc_ep_ca_rot_cam.jpg'      WHERE id = 46;
UPDATE `casestudy`.`dish` SET `picture_url` = 'juice/nuoc_ep_can_tay_tao.jpg'     WHERE id = 47;

-- ── HEALTHY & GYM (48–50): /images/healthy/
UPDATE `casestudy`.`dish` SET `picture_url` = 'healthy/protein_shake_chuoi.jpg'   WHERE id = 48;
UPDATE `casestudy`.`dish` SET `picture_url` = 'healthy/green_detox.jpg'           WHERE id = 49;
UPDATE `casestudy`.`dish` SET `picture_url` = 'healthy/smoothie_yen_mach_bo.jpg'  WHERE id = 50;


-- ============================================================
-- DỮ LIỆU MẪU: ĐÁNH GIÁ NHÀ HÀNG (evaluate)
-- ============================================================

-- Nhà hàng 1 - Hải Sản Biển Đông
INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id) VALUES
('Hải sản cực tươi, cua rang me ăn đậm đà lắm, chắc chắn sẽ quay lại!', 5, 'cao', 'nhanh', NOW(), 'Hải sản tươi sống', 'Xuất sắc', 4, 1),
('Tôm hùm nướng muối ớt rất ngon, phục vụ nhiệt tình, giá hơi cao nhưng xứng đáng.', 4, 'trung bình', 'nhanh', NOW(), 'Phục vụ tốt', 'Tốt', 1, 1),
('Không gian sạch sẽ, món ăn chất lượng, mực xào chua ngọt giòn và đậm vị.', 5, 'cao', 'nhanh', NOW(), 'Không gian đẹp', 'Xuất sắc', 2, 1),
('Gỏi cá trích tươi ngon, nước mắm chua ngọt pha đúng vị, nhân viên thân thiện.', 4, 'cao', 'trung bình', NOW(), 'Thân thiện', 'Tốt', 3, 1),
('Lẩu hải sản thập cẩm đáng tiền, nguyên liệu tươi, nước dùng ngọt tự nhiên.', 5, 'cao', 'nhanh', NOW(), 'Lẩu đặc biệt', 'Xuất sắc', 4, 1);

-- Nhà hàng 2 - Cơm Tấm Sài Gòn
INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id) VALUES
('Cơm tấm sườn nướng thơm lừng, đúng vị Sài Gòn, giá bình dân dễ ăn.', 5, 'cao', 'nhanh', NOW(), 'Đúng vị truyền thống', 'Xuất sắc', 4, 2),
('Phở bò tái nước dùng trong, bò mềm ngon, sẽ ghé lại thường xuyên.', 4, 'cao', 'nhanh', NOW(), 'Nước dùng đậm đà', 'Tốt', 1, 2),
('Bún bò Huế cay vừa miệng, chả cua thơm, phục vụ nhanh thoáng.', 5, 'trung bình', 'nhanh', NOW(), 'Cay đúng vị', 'Xuất sắc', 3, 2),
('Cơm tấm gà nướng da giòn, thịt mềm, nước mắm pha rất ngon.', 4, 'cao', 'trung bình', NOW(), 'Gà nướng giòn', 'Tốt', 4, 2),
('Mì Quảng gà sợi dai, nhân đầy đặn, nước dùng sệt đặc trưng.', 5, 'cao', 'nhanh', NOW(), 'Đặc sản miền Trung', 'Xuất sắc', 2, 2);

-- Nhà hàng 3 - Milktea House
INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id) VALUES
('Trà sữa trân châu đường đen dẻo thơm, vị trà đậm vừa phải, rất thích!', 5, 'cao', 'nhanh', NOW(), 'Trân châu dẻo thơm', 'Xuất sắc', 4, 3),
('Trà sữa matcha thơm, không quá ngọt, nhân viên vui vẻ nhiệt tình.', 4, 'cao', 'nhanh', NOW(), 'Matcha chuẩn vị', 'Tốt', 1, 3),
('Sinh tố bơ sữa béo ngậy mịn màng, size lớn, giá hợp lý.', 5, 'trung bình', 'nhanh', NOW(), 'Bơ hảo hạng', 'Xuất sắc', 3, 3),
('Trà đào cam sả mát lạnh rất giải nhiệt, hương thơm tự nhiên dễ chịu.', 4, 'cao', 'nhanh', NOW(), 'Thanh mát', 'Tốt', 2, 3);

-- ============================================================
-- 2 NHÀ HÀNG MỚI: PHỞ BẮC THÀNH + BBQ GARDEN
-- ============================================================

INSERT INTO user (username, password, email, phone, full_name, avatar_url) VALUES
('owner3', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'owner3@restaurant.com', '0123456792', 'Chủ nhà hàng 3', NULL),
('owner4', '$2a$12$/NmbZs9tWCi7dPaF46ynseIsAaR6STGCA87SYHV3Ln.TdKJ/DZlVC', 'owner4@restaurant.com', '0123456793', 'Chủ nhà hàng 4', NULL);

INSERT INTO user_roles (user_id, role_id) SELECT id, 2 FROM user WHERE username IN ('owner3','owner4');

-- Nhà hàng 4: Phở Bắc Thành
INSERT INTO restaurant (name, user_id, address, phone, logo_url, description, is_long_term_partner, is_open, is_locked, is_approved)
SELECT 'Phở Bắc Thành', id, '88 Đinh Tiên Hoàng, Quận Bình Thạnh, TP.HCM', '0901234569',
       'logo/logo.jpg', 'Phở truyền thống Hà Nội chính gốc, nước dùng hầm xương bò 12 giờ, phục vụ từ 6h sáng đến 22h',
       true, true, false, true FROM user WHERE username = 'owner3';

-- Nhà hàng 5: BBQ Garden
INSERT INTO restaurant (name, user_id, address, phone, logo_url, description, is_long_term_partner, is_open, is_locked, is_approved)
SELECT 'BBQ Garden', id, '15 Nguyễn Huệ, Quận 1, TP.HCM', '0901234570',
       'logo/logo.jpg', 'Nhà hàng nướng lẩu phong cách Hàn Quốc, không gian rộng rãi, phù hợp nhóm bạn và gia đình',
       true, true, false, true FROM user WHERE username = 'owner4';

-- Tags
INSERT INTO tag (name, restaurant_id) VALUES
('Truyền thống', 4), ('Nước dùng đặc biệt', 4), ('Bán chạy', 4),
('Nướng Hàn Quốc', 5), ('All-you-can-eat', 5), ('Nhóm bạn', 5);

-- Món ăn nhà hàng 4 (Phở)
INSERT INTO dish (name, restaurant_id, price, description, picture_url, tag_id, baner, is_available, category_id) VALUES
('Phở bò tái chín', 4, 70000, 'Phở bò truyền thống với tái và chín, nước dùng trong vắt hầm xương bò 12h', 'eat_food/pho-bo-tai.jpg', 12, false, true, 2),
('Phở gà ta', 4, 65000, 'Phở gà nấu từ gà ta thả vườn, nước dùng ngọt nhẹ và thơm', 'eat_food/pho-bo-tai.jpg', 13, false, true, 2),
('Phở đặc biệt (tái, nạm, gầu, gân)', 4, 90000, 'Phở bò đặc biệt đầy đủ các loại thịt, thích hợp cho người ăn nhiều', 'eat_food/pho-bo-tai.jpg', 14, false, true, 2),
('Quẩy giòn', 4, 15000, 'Quẩy chiên vàng giòn ăn kèm phở', 'eat_food/sup_hai_san.jpg', 12, false, true, 2),
('Nước xương hầm', 4, 20000, 'Nước xương bò hầm nguyên chất, bổ dưỡng', 'eat_food/sup_hai_san.jpg', 13, false, true, 2);

-- Món ăn nhà hàng 5 (BBQ)
INSERT INTO dish (name, restaurant_id, price, description, picture_url, tag_id, baner, is_available, category_id) VALUES
('Thịt ba chỉ nướng Hàn Quốc', 5, 199000, 'Thịt ba chỉ heo tươi ngon nướng trực tiếp trên bếp than, ăn kèm rau sống và sốt đặc biệt', 'eat_food/ca_hoi_nuong_la_chuoi.jpg', 15, false, true, 5),
('Bò Wagyu nướng', 5, 350000, 'Bò Wagyu thượng hạng, thịt mềm tan trong miệng', 'eat_food/tom_hung_nuong.jpg', 16, false, true, 4),
('Combo lẩu Hàn Quốc (2 người)', 5, 450000, 'Lẩu kim chi cay nồng với bò mỹ, hải sản, nấm và rau củ', 'eat_food/lau_hai_san.jpg', 17, false, true, 4),
('Gà nướng sốt teriyaki', 5, 165000, 'Gà nướng sốt teriyaki ngọt thơm, da giòn thịt mềm', 'eat_food/ga-nuong-la-tranh.jpg', 15, false, true, 5),
('Mì lạnh Hàn Quốc (Naengmyeon)', 5, 95000, 'Mì lạnh kiều mạch truyền thống, nước dùng lạnh chua ngọt', 'eat_food/bun-cha-ca.jpg', 16, false, true, 3);

-- Đánh giá nhà hàng 4 (Phở Bắc Thành)
INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id)
SELECT 'Phở nước dùng trong ngọt tự nhiên, không bột ngọt, ăn xong không khát nước.', 5, 'cao', 'nhanh', NOW(), 'Nước dùng sạch', 'Xuất sắc', 4, id 
FROM restaurant WHERE name = 'Phở Bắc Thành' LIMIT 1;

INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id)
SELECT 'Phở đặc biệt đủ loại thịt, bò mềm, quẩy giòn rất ngon.', 4, 'cao', 'nhanh', NOW(), 'Đủ topping', 'Tốt', 1, id 
FROM restaurant WHERE name = 'Phở Bắc Thành' LIMIT 1;

INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id)
SELECT 'Giá hợp lý, phục vụ nhanh, không gian sạch sẽ thoáng mát.', 5, 'trung bình', 'nhanh', NOW(), 'Vệ sinh tốt', 'Xuất sắc', 3, id 
FROM restaurant WHERE name = 'Phở Bắc Thành' LIMIT 1;

-- Đánh giá nhà hàng 5 (BBQ Garden)
INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id)
SELECT 'Thịt ba chỉ nướng rất thơm, không bị khô, sốt chấm đặc biệt ngon tuyệt.', 5, 'cao', 'nhanh', NOW(), 'Thịt tươi ngon', 'Xuất sắc', 4, id 
FROM restaurant WHERE name = 'BBQ Garden' LIMIT 1;

INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id)
SELECT 'Bò Wagyu tan trong miệng, trải nghiệm ăn uống sang trọng, đáng đồng tiền.', 5, 'cao', 'nhanh', NOW(), 'Thịt Wagyu cao cấp', 'Xuất sắc', 2, id 
FROM restaurant WHERE name = 'BBQ Garden' LIMIT 1;

INSERT INTO evaluate (comment, star, response_rate, response_time, followers, outstanding_features, product_quality, user_id, restaurant_id)
SELECT 'Không gian rộng rãi, nhân viên nhiệt tình, combo lẩu Hàn rất đáng thử.', 4, 'cao', 'trung bình', NOW(), 'Không gian sang', 'Tốt', 3, id 
FROM restaurant WHERE name = 'BBQ Garden' LIMIT 1;

