package com.codegym.project_module_5.service.nutrition_service;

import com.codegym.project_module_5.model.nutrition_model.DishNutrition;
import com.codegym.project_module_5.service.general_service.IGeneralService;

import java.util.List;

public interface IDishNutritionService extends IGeneralService<DishNutrition> {
    List<DishNutrition> findByDishIdWithNutrition(Long id);
}
