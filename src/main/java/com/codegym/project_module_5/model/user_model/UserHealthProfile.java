package com.codegym.project_module_5.model.user_model;

import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDateTime;

@Entity
@Table(name = "user_health_profile")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserHealthProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    private Double weight;         // kg
    private Double height;         // cm
    private Integer age;
    private String gender;         // "male" / "female"
    private String activityLevel;  // sedentary, light, moderate, active, very_active
    private String goal;           // lose_weight, maintain, gain_muscle

    private Double bmi;
    private Double bmr;
    private Double tdee;
    private Double targetCalories;
    private String bmiCategory;

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @Column(name = "updated_at")
    private LocalDateTime updatedAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    /**
     * Tính toán tất cả chỉ số sức khỏe từ input thể trạng
     */
    public void calculateHealthMetrics() {
        if (weight == null || height == null || age == null || gender == null) return;

        double heightM = height / 100.0;
        this.bmi = Math.round(weight / (heightM * heightM) * 10.0) / 10.0;

        if (bmi < 18.5) bmiCategory = "Thiếu cân";
        else if (bmi < 25) bmiCategory = "Bình thường";
        else if (bmi < 30) bmiCategory = "Thừa cân";
        else bmiCategory = "Béo phì";

        // Mifflin-St Jeor
        if ("male".equalsIgnoreCase(gender)) {
            this.bmr = (double) Math.round(10 * weight + 6.25 * height - 5 * age + 5);
        } else {
            this.bmr = (double) Math.round(10 * weight + 6.25 * height - 5 * age - 161);
        }

        double multiplier = switch (activityLevel != null ? activityLevel : "sedentary") {
            case "light" -> 1.375;
            case "moderate" -> 1.55;
            case "active" -> 1.725;
            case "very_active" -> 1.9;
            default -> 1.2;
        };
        this.tdee = (double) Math.round(bmr * multiplier);

        this.targetCalories = switch (goal != null ? goal : "maintain") {
            case "lose_weight" -> tdee - 500;
            case "gain_muscle" -> tdee + 400;
            default -> tdee;
        };
    }
}
