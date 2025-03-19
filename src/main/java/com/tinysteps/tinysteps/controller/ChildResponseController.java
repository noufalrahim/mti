package com.tinysteps.tinysteps.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.ChildResponseModel;
//import com.tinysteps.tinysteps.model.ChildResponseModel;
//import com.tinysteps.tinysteps.service.ChildResponseService;
import com.tinysteps.tinysteps.service.ChildResponseService;

@RestController
@RequestMapping("/api/childresponse")
public class ChildResponseController {

    @Autowired
    private ChildResponseService ChildResponseService;

    @GetMapping("")
    public List<ChildResponseModel> getAllChildResponse() {
        return ChildResponseService.getAllChildResponse();
    }

    @PostMapping("/add")
    public String addChildResponse(@RequestBody ChildResponseModel childresponseModel) {
        return ChildResponseService.addChildResponse(childresponseModel.getName());
    }
}
