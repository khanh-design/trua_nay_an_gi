package com.codegym.project_module_5.controller.error;

import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/error")
public class ErrorController {
    @GetMapping("/403")
    public String accessDenied(
            @RequestParam(required = false) String message,
            Model model) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        boolean isAuthenticated = authentication != null
                && authentication.isAuthenticated()
                && !(authentication instanceof AnonymousAuthenticationToken);

        model.addAttribute("isAuthenticated", isAuthenticated);

        if (message == null || message.isEmpty()) {
            if (isAuthenticated) {
                message = "Bạn không có quyền truy cập trang này. Vui lòng đăng nhập với tài khoản có quyền phù hợp.";
            } else {
                message = "Bạn cần đăng nhập để truy cập trang này.";
            }
        }

        model.addAttribute("errorMessage", message);
        return "error/403";
    }
}
