package com.codegym.project_module_5.service.chat_service;

import com.codegym.project_module_5.model.dto.ChatRequest;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ChatService {

    private final RestTemplate restTemplate;

    public ChatService() {
        this.restTemplate = new RestTemplate();
    }

    @SuppressWarnings("unchecked")
    public String generate(ChatRequest chatRequest) {

        String url = "https://dothuyen24.app.n8n.cloud/webhook/c8075e94-5b2c-4dd1-b75d-61ddf17d1c45";

        // Body gửi sang n8n
        Map<String, Object> requestBody = new HashMap<>();
        requestBody.put("message", chatRequest.getRequest());
        requestBody.put("goal", chatRequest.getGoal());
        requestBody.put("diseases", chatRequest.getDiseases());
        requestBody.put("userId", chatRequest.getUserId());

        // Header
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setBasicAuth("customer1", "123456");

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(requestBody, headers);

        try {
            // n8n trả về: [{ "results": [{ "output": "..." }] }]
            ResponseEntity<List> response = restTemplate.exchange(
                    url,
                    HttpMethod.POST,
                    entity,
                    List.class);

            System.out.println("RAW RESPONSE = " + response.getBody());

            if (response.getBody() != null && !response.getBody().isEmpty()) {
                // Lấy phần tử đầu tiên của array
                Map<String, Object> firstItem = (Map<String, Object>) response.getBody().get(0);

                // Lấy list "results"
                List<Map<String, Object>> results = (List<Map<String, Object>>) firstItem.get("results");

                if (results != null && !results.isEmpty()) {
                    // Lấy "output" từ results[0]
                    Object output = results.get(0).get("output");
                    if (output != null) {
                        return output.toString();
                    }
                }
            }

            return "Bot không trả lời";
        } catch (Exception e) {
            System.err.println("Lỗi khi gọi n8n: " + e.getMessage());
            e.printStackTrace();
            return "Đã xảy ra lỗi khi kết nối tới bot: " + e.getMessage();
        }
    }
}