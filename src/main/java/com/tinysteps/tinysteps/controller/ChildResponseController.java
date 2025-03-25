package com.tinysteps.tinysteps.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.ChildResponseModel;
import com.tinysteps.tinysteps.service.ChildResponseService;



@RestController
@RequestMapping("/api/childresponses")
public class ChildResponseController {

    @Autowired
    private ChildResponseService childresponseService;

    @GetMapping("")
    public List<ChildResponseModel> getAllChildResponse() {
        return childresponseService.getAllChildResponse();
    }

    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addChildResponse(@RequestBody ChildResponseModel childResponseModel) {
        return childresponseService.addChildResponse(childResponseModel);
    }

    @GetMapping("/{childId}")
    public ResponseEntity<Map<String, Object>> getChildProgress(@PathVariable Long childId) {
        return childresponseService.getChildProgress(childId);
    }
    
    
}
