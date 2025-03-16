package com.tinysteps.tinysteps.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.service.ChildService;

@RestController
@RequestMapping("/api/child")
public class ChildController {

    @Autowired
    private ChildService childService;

    @GetMapping("")
    public ResponseEntity<List<ChildModel>> getAllChildren() {
        return childService.getAllChild();
    }

    @PostMapping("/add")
    public ResponseEntity<String> addChild(@RequestBody ChildModel child) {
        return childService.addChild(child);
    }
}
