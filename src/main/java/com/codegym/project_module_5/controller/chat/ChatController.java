package com.codegym.project_module_5.controller.chat;

import com.codegym.project_module_5.model.dto.ChatRequest;
import com.codegym.project_module_5.service.chat_service.ChatService;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@Controller
@RequestMapping("/chat")
public class ChatController {

    private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    // Hiển thị trang chat
    @GetMapping("")
    public String chatPage(Model model) {
        model.addAttribute("chatRequest", new ChatRequest());
        return "chat/chat_message";
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

            String response = chatService.generate(chatRequest);

            return ResponseEntity.ok(Map.of("response", response));
        } catch (Exception e) {
            System.err.println("Lỗi trong ChatController: " + e.getMessage());
            return ResponseEntity
                    .internalServerError()
                    .body(Map.of("error", "Không thể xử lý yêu cầu: " + e.getMessage()));
        }
    }
}