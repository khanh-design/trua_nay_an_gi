package com.codegym.project_module_5.repository.nutrition_repository;

import com.codegym.project_module_5.model.nutrition_model.Nutrition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface NutritionRepository extends JpaRepository<Nutrition, Long> {
}
