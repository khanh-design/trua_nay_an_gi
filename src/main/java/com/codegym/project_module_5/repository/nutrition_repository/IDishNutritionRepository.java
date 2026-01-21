package com.codegym.project_module_5.repository.nutrition_repository;

import com.codegym.project_module_5.model.nutrition_model.DishNutrition;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface IDishNutritionRepository extends JpaRepository<DishNutrition, Long> {
    @Query("""
    SELECT dn
    FROM DishNutrition dn
    JOIN FETCH dn.nutrition
    WHERE dn.dish.id = :dishId""")
    List<DishNutrition> findByDishIdWithNutrition(@Param("dishId") Long dishId);
}
