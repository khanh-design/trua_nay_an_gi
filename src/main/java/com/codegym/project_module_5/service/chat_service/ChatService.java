package com.codegym.project_module_5.service.chat_service;

import com.codegym.project_module_5.model.dto.ChatRequest;
import com.codegym.project_module_5.model.user_model.UserHealthProfile;
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
    public String generate(ChatRequest chatRequest, UserHealthProfile healthProfile) {

        String url = "https://phong23.app.n8n.cloud/webhook/c8075e94-5b2c-4dd1-b75d-61ddf17d1c45";

        // Body gửi sang n8n
        Map<String, Object> requestBody = new HashMap<>();

        // === Xây dựng enriched message với context sức khỏe ===
        // Ưu tiên: healthProfile (session) > chatRequest fields (frontend gửi kèm)
        Double  bmi           = healthProfile != null ? healthProfile.getBmi()           : chatRequest.getBmi();
        Double  bmr           = healthProfile != null ? healthProfile.getBmr()           : chatRequest.getBmr();
        Double  tdee          = healthProfile != null ? healthProfile.getTdee()          : chatRequest.getTdee();
        Double  targetCal     = healthProfile != null ? healthProfile.getTargetCalories(): chatRequest.getTargetCalories();
        String  bmiCategory   = healthProfile != null ? healthProfile.getBmiCategory()  : chatRequest.getBmiCategory();
        String  goal          = healthProfile != null && healthProfile.getGoal() != null
                                    ? healthProfile.getGoal()
                                    : (chatRequest.getGoal() != null ? chatRequest.getGoal() : "maintain");
        Double  weight        = healthProfile != null ? healthProfile.getWeight()        : chatRequest.getWeight();
        Double  height        = healthProfile != null ? healthProfile.getHeight()        : chatRequest.getHeight();
        Integer age           = healthProfile != null ? healthProfile.getAge()           : chatRequest.getAge();
        String  gender        = healthProfile != null ? healthProfile.getGender()        : chatRequest.getGender();

        String enrichedMessage = chatRequest.getRequest();
        // Chỉ nhúng context nếu có ít nhất chỉ số quan trọng (BMI hoặc TDEE)
        if (bmi != null || tdee != null) {
            StringBuilder ctx = new StringBuilder("[Thông tin sức khỏe người dùng:");
            if (weight  != null) ctx.append(" Cân nặng=").append(String.format("%.1f", weight)).append("kg,");
            if (height  != null) ctx.append(" Chiều cao=").append(String.format("%.0f", height)).append("cm,");
            if (age     != null) ctx.append(" Tuổi=").append(age).append(",");
            if (gender  != null) ctx.append(" Giới tính=").append("male".equals(gender) ? "Nam" : "Nữ").append(",");
            if (bmi     != null) ctx.append(" BMI=").append(String.format("%.1f", bmi));
            if (bmiCategory != null) ctx.append(" (").append(bmiCategory).append(")");
            ctx.append(",");
            if (bmr     != null) ctx.append(" BMR=").append(Math.round(bmr)).append(" kcal,");
            if (tdee    != null) ctx.append(" TDEE=").append(Math.round(tdee)).append(" kcal,");
            if (targetCal != null) ctx.append(" Mục tiêu calo=").append(Math.round(targetCal)).append(" kcal/ngày,");
            ctx.append(" Mục tiêu=").append(goal).append("]");
            enrichedMessage = ctx.toString() + "\n\n" + chatRequest.getRequest();
        }

        // === DEBUG: log để kiểm tra dữ liệu ===
        System.out.println("=== CHAT DEBUG ===");
        System.out.println("healthProfile from session: " + (healthProfile != null ? "FOUND" : "NULL"));
        System.out.println("chatRequest.getBmi(): " + chatRequest.getBmi());
        System.out.println("chatRequest.getTdee(): " + chatRequest.getTdee());
        System.out.println("chatRequest.getGoal(): " + chatRequest.getGoal());
        System.out.println("bmi resolved: " + bmi);
        System.out.println("tdee resolved: " + tdee);
        System.out.println("enrichedMessage:\n" + enrichedMessage);
        System.out.println("==================");

        requestBody.put("message", enrichedMessage);
        requestBody.put("goal", goal);
        requestBody.put("diseases", chatRequest.getDiseases());
        requestBody.put("userId", chatRequest.getUserId());

        // Gửi health metrics nếu có
        if (healthProfile != null) {
            Map<String, Object> health = new HashMap<>();
            health.put("weight", healthProfile.getWeight());
            health.put("height", healthProfile.getHeight());
            health.put("age", healthProfile.getAge());
            health.put("gender", healthProfile.getGender());
            health.put("activityLevel", healthProfile.getActivityLevel());
            health.put("bmi", healthProfile.getBmi());
            health.put("bmr", healthProfile.getBmr());
            health.put("tdee", healthProfile.getTdee());
            health.put("targetCalories", healthProfile.getTargetCalories());
            health.put("bmiCategory", healthProfile.getBmiCategory());
            health.put("goal", healthProfile.getGoal());
            requestBody.put("healthProfile", health);
        }

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