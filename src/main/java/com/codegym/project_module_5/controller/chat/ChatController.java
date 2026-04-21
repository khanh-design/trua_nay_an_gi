package com.codegym.project_module_5.controller.chat;

import com.codegym.project_module_5.model.dto.ChatRequest;
import com.codegym.project_module_5.service.chat_service.ChatService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@RequestMapping("/chat")
public class ChatController {

    private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    // Load trang chat
    @GetMapping("")
    public String chatPage(Model model) {

        model.addAttribute("chatRequest", new ChatRequest());

        return "chat/chat_message";
    }

    // xử lý khi user gửi message
    @PostMapping("/message")
    public String sendMessage(
            @ModelAttribute("chatRequest") ChatRequest chatRequest,
            Model model,
            HttpSession session
    ) {

        // 🔥 tạo userId nếu chưa có
        String userId = (String) session.getAttribute("userId");

        if (userId == null) {
            userId = UUID.randomUUID().toString();
            session.setAttribute("userId", userId);
        }

        chatRequest.setUserId(userId);

        String response = chatService.generate(chatRequest);

        model.addAttribute("response", response);
        model.addAttribute("chatRequest", chatRequest);

        return "chat/chat_message";
    }
}