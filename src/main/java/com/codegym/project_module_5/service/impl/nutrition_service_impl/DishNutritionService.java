package com.codegym.project_module_5.service.impl.nutrition_service_impl;

import com.codegym.project_module_5.model.nutrition_model.DishNutrition;
import com.codegym.project_module_5.repository.nutrition_repository.IDishNutritionRepository;
import com.codegym.project_module_5.service.nutrition_service.IDishNutritionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DishNutritionService implements IDishNutritionService {
    @Autowired
    private IDishNutritionRepository dishNutritionRepository;

    @Override
    public Iterable<DishNutrition> findAll() {
        return dishNutritionRepository.findAll();
    }

    @Override
    public Optional<DishNutrition> findById(Long id) {
        return dishNutritionRepository.findById(id);
    }

    @Override
    public void save(DishNutrition dishNutrition) {
        dishNutritionRepository.save(dishNutrition);
    }

    @Override
    public void delete(Long id) {
        dishNutritionRepository.deleteById(id);
    }

    @Override
    public List<DishNutrition> findByDishIdWithNutrition(Long id) {
        return dishNutritionRepository.findByDishIdWithNutrition(id);
    }
}
