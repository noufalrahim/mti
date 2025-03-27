package com.tinysteps.tinysteps.service;

import java.util.Collections;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.repository.UserRepository;

@Service
public class AuthService {

    private final UserRepository userRepository;

    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public ResponseEntity<Map<String, Object>> authentication(String phone) {

        if (phone == null || phone.length() != 10) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("message", "Invalid mobile number", "data", Collections.emptyMap()));
        }

        Optional<UserModel> existingUser = userRepository.findByPhone(phone); // No need for Optional.ofNullable()

        if (existingUser.isPresent()) {
            return ResponseEntity.status(HttpStatus.OK)
                    .body(Map.of("message", "Successfully logged in", "data", existingUser.get()));
        }

        UserModel newUser = new UserModel();
        newUser.setPhone(phone);
        userRepository.save(newUser);

        return ResponseEntity.status(HttpStatus.CREATED)
                .body(Map.of("message", "Account created successfully", "data", newUser));
    }
}
