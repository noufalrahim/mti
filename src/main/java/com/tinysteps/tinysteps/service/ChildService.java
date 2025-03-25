package com.tinysteps.tinysteps.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.repository.ChildRepository;
import com.tinysteps.tinysteps.repository.UserRepository;

@Service
public class ChildService {

    private final ChildRepository childRepository;
    private final UserRepository userRepository;

    public ChildService(ChildRepository childRepository, UserRepository userRepository) {
        this.childRepository = childRepository;
        this.userRepository = userRepository;
    }

    public ResponseEntity<Map<String, Object>> addChild(ChildModel child) {
        if (child.getUser() == null || child.getUser().getId() == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(Map.of("message", "User is required", "data", Collections.emptyList()));
        }
    
        Optional<UserModel> userOpt = userRepository.findById(child.getUser().getId());
        if (userOpt.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "User not found", "data", Collections.emptyList()));
        }
    
        UserModel user = userOpt.get();
        child.setUser(user);
    
        Optional<ChildModel> childExists = childRepository.findByNameAndUserId(child.getName(), user.getId());
    
        if (childExists.isPresent()) {
            return ResponseEntity.status(HttpStatus.CONFLICT)
                    .body(Map.of("message", "Child already exists", "data", Collections.emptyList()));
        }
    
        childRepository.save(child);
    
        List<ChildModel> children = childRepository.findByUser(user);
        if (children.size() == 1) {
            user.setDefaultChild(child);
            userRepository.save(user);
        }
    
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(Map.of("message", "Created new child", "data", child));
    }
    
    

    public ResponseEntity<List<ChildModel>> getAllChild() {
        List<ChildModel> children = childRepository.findAll();
        return ResponseEntity.ok(children);
    }

    public ResponseEntity<Map<String, Object>> getAllChildrenOfUser(Long id) {
        Optional<UserModel> user = userRepository.findById(id);

        if (user.isEmpty()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "User not found", "data", Collections.emptyList()));
        }

        List<ChildModel> children = childRepository.findByUser(user.get());

        return ResponseEntity.status(HttpStatus.OK)
                .body(Map.of("message", "Data fetched successfully", "data", children));
    }
}
