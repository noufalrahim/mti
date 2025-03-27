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

import com.tinysteps.tinysteps.model.AdminModel;
import com.tinysteps.tinysteps.service.AdminService;

@RestController
@RequestMapping("/api/admins")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @GetMapping("")
    public List<AdminModel> getAllAdmin() {
        return adminService.getAllAdmin();
    }

    @PostMapping("/add")
    public String addAdmin(@RequestBody AdminModel adminModel) {
        return adminService.addAdmin(adminModel.getName());
    }
    @DeleteMapping("delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteAdmin(@PathVariable String id) {
        Long adminId = Long.valueOf(id);
        return adminService.deleteAdmin(adminId);
    }
    @PutMapping("edit/{id}")
    public String editAdmin(@RequestBody AdminModel adminModel) {
        return adminService.editAdmin(adminModel);
    }
}
