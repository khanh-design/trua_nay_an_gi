package com.codegym.project_module_5.service.chat_service;

import com.codegym.project_module_5.model.dto.ChatRequest;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.ai.chat.messages.SystemMessage;
import org.springframework.ai.chat.messages.UserMessage;
import org.springframework.ai.chat.prompt.Prompt;
import org.springframework.stereotype.Service;

@Service
public class ChatService {
    private final ChatClient chatClient;

    public ChatService(ChatClient.Builder chatClient) {
        this.chatClient = chatClient.build();
    }

    public String generate(ChatRequest chatRequest) {
        Prompt prompt = new Prompt(
                new SystemMessage("Tôi là Deveria.AI" +
                        "Bạn nên trả lời bằng giọng điệu trang trọng."),
                new UserMessage(chatRequest.getRequest())
        );

        return chatClient
                .prompt(prompt)
                .call()
                .content();
    }
}
