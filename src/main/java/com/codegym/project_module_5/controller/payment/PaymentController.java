package com.codegym.project_module_5.controller.payment;

import com.codegym.project_module_5.model.cart_model.CartItem;
import com.codegym.project_module_5.model.order_model.*;
import com.codegym.project_module_5.model.shipper_model.Shipper;
import com.codegym.project_module_5.model.user_model.User;
import com.codegym.project_module_5.repository.order_repository.IOrderStatusRepository;
import com.codegym.project_module_5.service.cart_service.ICartService;
import com.codegym.project_module_5.service.order_service.IOrderDetailService;
import com.codegym.project_module_5.service.order_service.IOrderService;
import com.codegym.project_module_5.service.payment.VNPayService;
import com.codegym.project_module_5.service.restaurant_service.IRestaurantService;
import com.codegym.project_module_5.service.shipper_service.IShipperService;
import com.codegym.project_module_5.service.user_service.IUserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/payment")
public class PaymentController {

    @Autowired
    private VNPayService vnPayService;

    @Autowired
    private IOrderService orderService;

    @Autowired
    private IOrderDetailService orderDetailService;

    @Autowired
    private ICartService cartService;

    @Autowired
    private IUserService userService;

    @Autowired
    private IRestaurantService restaurantService;

    @Autowired
    private IShipperService shipperService;

    @Autowired
    private IOrderStatusRepository orderStatusRepository;

    @GetMapping("/vnpay-return")
    public String vnpayReturn(@RequestParam Map<String, String> params,
                              HttpSession session,
                              Model model,
                              RedirectAttributes redirectAttributes) {

        boolean isValid = vnPayService.validateReturn(params);
        boolean isSuccess = isValid && vnPayService.isPaymentSuccess(params);

        model.addAttribute("isAuthenticated", true);
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !(authentication instanceof AnonymousAuthenticationToken)) {
            String username = authentication.getName();
            User currentUser = userService.findByUsername(username).orElse(null);
            model.addAttribute("currentUser", currentUser);
        }

        if (isSuccess) {
            // Retrieve pending order data from session
            @SuppressWarnings("unchecked")
            List<Long> selectedItemIds = (List<Long>) session.getAttribute("vnpay_selectedItems");
            String address = (String) session.getAttribute("vnpay_address");
            Long shipperId = (Long) session.getAttribute("vnpay_shipperId");
            String note = (String) session.getAttribute("vnpay_note");

            if (selectedItemIds == null || address == null || shipperId == null) {
                model.addAttribute("success", false);
                model.addAttribute("message", "Phiên thanh toán đã hết hạn. Vui lòng thử lại.");
                return "payment/vnpay-result";
            }

            Authentication auth = SecurityContextHolder.getContext().getAuthentication();
            if (auth == null || !auth.isAuthenticated() || auth instanceof AnonymousAuthenticationToken) {
                return "redirect:/account/login";
            }

            String username = auth.getName();
            User currentUser = userService.findByUsername(username).orElse(null);
            if (currentUser == null) {
                return "redirect:/account/login";
            }

            // Create order
            List<CartItem> allCartItems = cartService.getCartItems(currentUser);
            List<CartItem> itemsToOrder = allCartItems.stream()
                    .filter(item -> selectedItemIds.contains(item.getId()))
                    .collect(Collectors.toList());

            if (itemsToOrder.isEmpty()) {
                model.addAttribute("success", false);
                model.addAttribute("message", "Không tìm thấy sản phẩm trong giỏ hàng.");
                return "payment/vnpay-result";
            }

            Optional<Shipper> shipperOpt = shipperService.findById(shipperId);
            if (shipperOpt.isEmpty()) {
                model.addAttribute("success", false);
                model.addAttribute("message", "Đơn vị vận chuyển không hợp lệ.");
                return "payment/vnpay-result";
            }

            Long restaurantId = itemsToOrder.get(0).getDish().getRestaurant().getId();
            var restaurantOpt = restaurantService.findById(restaurantId);
            if (restaurantOpt.isEmpty()) {
                model.addAttribute("success", false);
                model.addAttribute("message", "Nhà hàng không tồn tại.");
                return "payment/vnpay-result";
            }

            OrderStatus status = orderStatusRepository.findByName("Chờ xác nhận")
                    .orElseGet(() -> {
                        OrderStatus s = new OrderStatus();
                        s.setName("Chờ xác nhận");
                        return orderStatusRepository.save(s);
                    });

            double totalPrice = 0;
            for (CartItem item : itemsToOrder) {
                totalPrice += item.getDish().getPrice() * item.getQuantity();
            }

            // --- Tính toán mã giảm giá (Coupon) từ session VNPay ---
            String appliedCoupon = (String) session.getAttribute("vnpay_appliedCoupon");
            com.codegym.project_module_5.model.restaurant_model.Coupon coupon = null;
            double discount = 0;
            if (appliedCoupon != null && !appliedCoupon.isBlank()) {
                try {
                    var coupons = restaurantService.getCouponsByRestaurantId(restaurantId);
                    var matched = coupons.stream()
                            .filter(c -> Boolean.TRUE.equals(c.getIsAvailable()))
                            .filter(c -> c.getName() != null && c.getName().equalsIgnoreCase(appliedCoupon.trim()))
                            .findFirst();
                    if (matched.isPresent()) {
                        coupon = matched.get();
                        boolean minOk = coupon.getMinOrder() == null || totalPrice >= coupon.getMinOrder();
                        if (minOk) {
                            double d = 0;
                            if (coupon.getFixedDiscount() != null) d += coupon.getFixedDiscount();
                            if (coupon.getPercentDiscount() != null) d += totalPrice * (coupon.getPercentDiscount() / 100.0);
                            if (coupon.getMaxDiscount() != null) d = Math.min(d, coupon.getMaxDiscount());
                            discount = Math.max(0, Math.min(d, totalPrice));
                        }
                    }
                } catch (Exception e) {
                    // Bỏ qua lỗi
                }
            }

            double serviceFee = Math.round(totalPrice * 0.05);

            Orders order = new Orders();
            order.setUser(currentUser);
            order.setRestaurant(restaurantOpt.get());
            order.setOrderStatus(status);
            order.setCoupon(coupon); // Gán coupon cho order
            order.setTotalPrice(Math.max(0, totalPrice - discount) + serviceFee); // totalPrice = subtotal - discount + serviceFee
            order.setAddress(address);
            order.setShipper(shipperOpt.get());
            order.setCustomerNote(note);
            order.setPaymentMethod(PaymentMethod.VNPAY);
            order.setPaymentStatus(PaymentStatus.PAID);
            order.setVnpTransactionNo(params.get("vnp_TransactionNo"));
            orderService.save(order);

            for (CartItem ci : itemsToOrder) {
                OrderDetail od = new OrderDetail();
                od.setOrder(order);
                od.setDish(ci.getDish());
                od.setQuantity((long) ci.getQuantity());
                od.setPrice(ci.getDish().getPrice());
                orderDetailService.save(od);
            }

            for (CartItem item : itemsToOrder) {
                cartService.removeCartItem(item.getId());
            }

            // Clear VNPay session data
            clearVnpaySession(session);

            model.addAttribute("success", true);
            model.addAttribute("order", order);
            model.addAttribute("transactionNo", params.get("vnp_TransactionNo"));
            model.addAttribute("message", "Thanh toán thành công!");
        } else {
            // Payment failed — don't create order
            clearVnpaySession(session);

            String responseCode = params.getOrDefault("vnp_ResponseCode", "99");
            model.addAttribute("success", false);
            model.addAttribute("message", getErrorMessage(responseCode));
        }

        return "payment/vnpay-result";
    }

    @PostMapping("/vnpay-ipn")
    @ResponseBody
    public Map<String, String> vnpayIpn(@RequestParam Map<String, String> params) {
        Map<String, String> result = new HashMap<>();

        boolean isValid = vnPayService.validateReturn(params);
        if (!isValid) {
            result.put("RspCode", "97");
            result.put("Message", "Invalid Checksum");
            return result;
        }

        // IPN chỉ xác nhận — order đã được tạo trong vnpay-return
        result.put("RspCode", "00");
        result.put("Message", "Confirm Success");
        return result;
    }

    private void clearVnpaySession(HttpSession session) {
        session.removeAttribute("vnpay_selectedItems");
        session.removeAttribute("vnpay_address");
        session.removeAttribute("vnpay_shipperId");
        session.removeAttribute("vnpay_note");
        session.removeAttribute("vnpay_appliedCoupon");
        session.removeAttribute("vnpay_txnRef");
        session.removeAttribute("paymentMethod");
        session.removeAttribute("orderNote");
        session.removeAttribute("appliedCoupon");
        session.removeAttribute("selectedShipperId");
    }

    private String getErrorMessage(String responseCode) {
        return switch (responseCode) {
            case "07" -> "Trừ tiền thành công nhưng giao dịch bị nghi ngờ (liên quan tới lừa đảo, giao dịch bất thường).";
            case "09" -> "Thẻ/Tài khoản chưa đăng ký dịch vụ InternetBanking tại ngân hàng.";
            case "10" -> "Xác thực thông tin thẻ/tài khoản không đúng quá 3 lần.";
            case "11" -> "Đã hết hạn chờ thanh toán. Vui lòng thực hiện lại giao dịch.";
            case "12" -> "Thẻ/Tài khoản bị khóa.";
            case "13" -> "Mật khẩu xác thực giao dịch (OTP) không đúng.";
            case "24" -> "Bạn đã hủy giao dịch thanh toán.";
            case "51" -> "Tài khoản không đủ số dư để thực hiện giao dịch.";
            case "65" -> "Tài khoản đã vượt quá hạn mức giao dịch trong ngày.";
            case "75" -> "Ngân hàng thanh toán đang bảo trì.";
            case "79" -> "Nhập sai mật khẩu thanh toán quá số lần quy định.";
            default -> "Giao dịch không thành công. Mã lỗi: " + responseCode;
        };
    }
}
