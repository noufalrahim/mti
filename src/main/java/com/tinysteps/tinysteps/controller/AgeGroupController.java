package com.tinysteps.tinysteps.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
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
}
