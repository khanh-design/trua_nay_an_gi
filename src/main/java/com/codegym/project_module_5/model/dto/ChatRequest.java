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
}
