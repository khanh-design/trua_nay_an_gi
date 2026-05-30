package com.codegym.project_module_5.service.evaluate_serivce;

import com.codegym.project_module_5.model.evaluate_model.Evaluate;
import com.codegym.project_module_5.service.general_service.IGeneralService;

import java.util.List;

public interface IEvaluateService extends IGeneralService<Evaluate> {
    List<Evaluate> findByRestaurantId(Long restaurantId);
}
