package com.codegym.project_module_5.controller.chat;

import com.codegym.project_module_5.model.dto.ChatRequest;
import com.codegym.project_module_5.service.chat_service.ChatService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/chat")
public class ChatController {
    private final ChatService chatService;

    public ChatController(ChatService chatService) {
        this.chatService = chatService;
    }

    @GetMapping("")
    public String chatPage(Model model) {
        model.addAttribute("chatRequest", new ChatRequest());
        return "chat/chat_message";
    }

    @PostMapping("/message")
    public String sendMessage(@ModelAttribute("chatRequest")ChatRequest chatRequest, Model model) {
//        String message = chatService.generate(chatRequest);
//        model.addAttribute("request", message);
//        return "chat/chat_message";

//        System.out.println("USER INPUT = " + chatRequest.getRequest());
        String response = chatService.generate(chatRequest);
//        System.out.println("BOT RESPONSE = " + response);
        model.addAttribute("response", response);
        return "chat/chat_message";
    }
}
