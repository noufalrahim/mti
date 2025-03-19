package com.tinysteps.tinysteps.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.AdminModel;
import com.tinysteps.tinysteps.service.AdminService;

@RestController
@RequestMapping("/api/admin")
public class AdminController {

    @Autowired
    private AdminService AdminService;

    @GetMapping("")
    public List<AdminModel> getAllAdmin() {
        return AdminService.getAllAdmin();
    }

    @PostMapping("/add")
    public String addAdmin(@RequestBody AdminModel adminModel) {
        return AdminService.addAdmin(adminModel.getName());
    }
}
