package com.codegym.project_module_5.model.nutrition_model;

import com.codegym.project_module_5.model.restaurant_model.Dish;
import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class DishNutrition {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private Double amount;

    @ManyToOne
    private Dish dish;

    @ManyToOne
    private Nutrition nutrition;
}
