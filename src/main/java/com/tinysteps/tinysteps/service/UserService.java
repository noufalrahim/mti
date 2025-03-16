package com.tinysteps.tinysteps.service;

import java.util.List;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.repository.UserRepository;

@Service
public class UserService {

    private final UserRepository userRepository;

    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public ResponseEntity<String> addUser(String phone) {
        Optional<UserModel> existingUser = userRepository.findByPhone(phone);
        if (existingUser.isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Phone number already exists!");
        }

        UserModel newUser = new UserModel();
        newUser.setPhone(phone);
        userRepository.save(newUser);

        return ResponseEntity.status(HttpStatus.CREATED).body("User added successfully!");
    }

    public ResponseEntity<List<UserModel>> getAllUsers() {
        List<UserModel> users = userRepository.findAll();
        return ResponseEntity.ok(users);
    }
}
