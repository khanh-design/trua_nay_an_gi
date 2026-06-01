package com.codegym.project_module_5.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Setter
@Getter
@Data
public class ChatRequest {
    private String request;
    private String goal;
    private List<String> diseases;
    private String userId;

    // Health profile fields (input)
    private Double weight;         // kg
    private Double height;         // cm
    private Integer age;
    private String gender;         // "male" / "female"
    private String activityLevel;  // sedentary, light, moderate, active, very_active

    // Computed health metrics (sent from frontend sessionStorage)
    private Double bmi;
    private Double bmr;
    private Double tdee;
    private Double targetCalories;
    private String bmiCategory;
}

