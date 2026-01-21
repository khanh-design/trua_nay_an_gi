package com.codegym.project_module_5.service.impl.nutrition_service_impl;

import com.codegym.project_module_5.model.nutrition_model.Nutrition;
import com.codegym.project_module_5.repository.nutrition_repository.NutritionRepository;
import com.codegym.project_module_5.service.nutrition_service.INutritionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class NutritionService implements INutritionService {
    @Autowired
    private NutritionRepository nutritionRepository;

    @Override
    public Iterable<Nutrition> findAll() {
        return nutritionRepository.findAll();
    }

    @Override
    public Optional<Nutrition> findById(Long id) {
        return nutritionRepository.findById(id);
    }

    @Override
    public void save(Nutrition nutrition) {
        nutritionRepository.save(nutrition);
    }

    @Override
    public void delete(Long id) {
        nutritionRepository.deleteById(id);
    }
}
