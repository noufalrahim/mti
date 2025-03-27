package com.tinysteps.tinysteps.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.AgeGroupModel;
import com.tinysteps.tinysteps.service.AgeGroupService;

@RestController
@RequestMapping("/api/agegroup")
public class AgeGroupController {

    @Autowired
    private AgeGroupService ageGroupService;

    @GetMapping("")
    public List<AgeGroupModel> getAllAgeGroups() {
        return ageGroupService.getAllAgeGroup();
    }
    
    @PostMapping("/add")
    public String addAgeGroup(@RequestBody AgeGroupModel ageGroup) {        
        return ageGroupService.addAgeGroup(ageGroup);
    }
    @DeleteMapping("delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteAgeGroup(@PathVariable Long id) {
        return ageGroupService.deleteAgeGroup(id);
    }
    @PutMapping("edit/{id}")
    public String editAgeGroup(@RequestBody AgeGroupModel ageGroupModel) {
        return ageGroupService.editAgeGroup(ageGroupModel);
    }
}
