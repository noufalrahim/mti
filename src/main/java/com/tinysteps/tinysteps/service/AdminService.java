package com.tinysteps.tinysteps.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
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
}
