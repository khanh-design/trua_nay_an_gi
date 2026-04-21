package com.codegym.project_module_5.service.chat_service;

import com.codegym.project_module_5.model.dto.ChatRequest;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

@Service
public class ChatService {

    private final RestTemplate restTemplate;

    public ChatService() {
        this.restTemplate = new RestTemplate();
    }

    public String generate(ChatRequest chatRequest) {

        String url = "https://edric1417.app.n8n.cloud/webhook-test/chat-bot";

        // Body gửi sang n8n
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("message", chatRequest.getRequest());
        requestBody.put("goal", chatRequest.getGoal());
        requestBody.put("diseases", chatRequest.getDiseases());
        requestBody.put("userId", chatRequest.getUserId());

        // Header
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        try {
            ResponseEntity<Map> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    entity,
                    Map.class
            );
            System.out.println("RAW RESPONSE = " + response.getBody());

            if (response.getBody() != null) {
                Object res = response.getBody().get("response");

                if (res != null) {
                    return res.toString();
                }
            }

            return "Bot không trả lời 😢";
        } catch (Exception e) {
            e.printStackTrace();
        }
        return url;
    }
}