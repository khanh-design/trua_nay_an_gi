package com.codegym.project_module_5.controller.chat;

import com.codegym.project_module_5.model.dto.ChatRequest;
import com.codegym.project_module_5.model.user_model.User;
import com.codegym.project_module_5.model.user_model.UserHealthProfile;
import com.codegym.project_module_5.repository.user_repository.IUserHealthProfileRepository;
import com.codegym.project_module_5.repository.user_repository.IUserRepository;
import com.codegym.project_module_5.service.chat_service.ChatService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/chat")
public class ChatController {

    private final ChatService chatService;
    private final IUserHealthProfileRepository healthProfileRepo;
    private final IUserRepository userRepo;

    public ChatController(ChatService chatService,
                          IUserHealthProfileRepository healthProfileRepo,
                          IUserRepository userRepo) {
        this.chatService = chatService;
        this.healthProfileRepo = healthProfileRepo;
        this.userRepo = userRepo;
    }

    // Hiển thị trang chat
    @GetMapping("")
    public String chatPage(Model model) {
        model.addAttribute("chatRequest", new ChatRequest());
        return "chat/chat_message";
    }

    // Lưu health profile
    @PostMapping("/health-profile")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> saveHealthProfile(
            @RequestBody ChatRequest chatRequest,
            Principal principal,
            HttpSession session
    ) {
        try {
            UserHealthProfile profile = new UserHealthProfile();
            profile.setWeight(chatRequest.getWeight());
            profile.setHeight(chatRequest.getHeight());
            profile.setAge(chatRequest.getAge());
            profile.setGender(chatRequest.getGender());
            profile.setActivityLevel(chatRequest.getActivityLevel());
            profile.setGoal(chatRequest.getGoal());

            // Tính BMI/BMR/TDEE
            profile.calculateHealthMetrics();

            // Lưu vào DB nếu user đã đăng nhập
            if (principal != null) {
                userRepo.findByUsername(principal.getName()).ifPresent(user -> {
                    profile.setUser(user);
                    healthProfileRepo.save(profile);
                });
            }

            // Lưu vào session để dùng cho chat
            session.setAttribute("healthProfile", profile);

            return ResponseEntity.ok(Map.of(
                    "success", true,
                    "bmi", profile.getBmi(),
                    "bmr", profile.getBmr(),
                    "tdee", profile.getTdee(),
                    "targetCalories", profile.getTargetCalories(),
                    "bmiCategory", profile.getBmiCategory()
            ));
        } catch (Exception e) {
            return ResponseEntity.internalServerError()
                    .body(Map.of("success", false, "error", e.getMessage()));
        }
    }

    // Endpoint JSON cho fetch từ JS
    @PostMapping("/message")
    @ResponseBody
    public ResponseEntity<Map<String, String>> sendMessage(
            @RequestBody ChatRequest chatRequest,
            HttpSession session
    ) {
        try {
            String userId = (String) session.getAttribute("userId");
            if (userId == null) {
                userId = UUID.randomUUID().toString();
                session.setAttribute("userId", userId);
            }

            chatRequest.setUserId(userId);

            // Lấy health profile từ session
            UserHealthProfile healthProfile =
                    (UserHealthProfile) session.getAttribute("healthProfile");

            String response = chatService.generate(chatRequest, healthProfile);

            return ResponseEntity.ok(Map.of("response", response));
        } catch (Exception e) {
            System.err.println("Lỗi trong ChatController: " + e.getMessage());
            return ResponseEntity
                    .internalServerError()
                    .body(Map.of("error", "Không thể xử lý yêu cầu: " + e.getMessage()));
        }
    }
}