package com.codegym.project_module_5.model.nutrition_model;

import com.codegym.project_module_5.model.restaurant_model.Dish;
import jakarta.persistence.*;
import lombok.Data;

import java.util.Set;

@Entity
@Data
public class Nutrition {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String unit;

}
