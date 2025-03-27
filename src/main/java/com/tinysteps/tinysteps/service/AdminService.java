package com.tinysteps.tinysteps.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.AdminModel;
import com.tinysteps.tinysteps.repository.AdminRepository;

@Service
public class AdminService {

    private final AdminRepository adminRepository;

    @Autowired
    AdminModel newAdmin;

    public AdminService(AdminRepository adminRepository) {
        this.adminRepository = adminRepository;
    }

    public List<AdminModel> getAllAdmin() {
        return adminRepository.findAll();
    }

    public String addAdmin(String name) {
        Optional<AdminModel> existingAdmin = adminRepository.findByName(name);
        if (existingAdmin.isPresent()) {
            return "Admin already exists!";
        }

        newAdmin.setName(name);
        adminRepository.save(newAdmin);

        return "Admin added successfully!";
    }
    public ResponseEntity<Map<String, Object>> deleteAdmin(Long id) {
        Optional<AdminModel> existingAdmin = adminRepository.findById(id);

        if (!existingAdmin.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Admin is missing or invalid", "data", Collections.emptyMap()));

        }

        adminRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.OK)
                .body(Map.of("message", "Admin deleted successfully", "data", Collections.emptyMap()));

    }
    public String editAdmin(AdminModel adminModel) {
        Long id = adminModel.getId();
        Optional<AdminModel> existingAdmin = adminRepository.findById(id);
        System.out.print(existingAdmin);

        if (!existingAdmin.isPresent()) {
            return "No admin exists with the given ID!";
        }

        adminRepository.save(adminModel);

        return "Admin updated successfully!";
    }
}
