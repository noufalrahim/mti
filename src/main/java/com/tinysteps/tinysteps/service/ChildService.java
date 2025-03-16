package com.tinysteps.tinysteps.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.repository.ChildRepository;

@Service
public class ChildService {

    private final ChildRepository childRepository;

    public ChildService(ChildRepository childRepository) {
        this.childRepository = childRepository;
    }

    public ResponseEntity<String> addChild(ChildModel child) {

        boolean childExists = childRepository.findByNameAndUserId(child.getName(), child.getUser().getId()).isPresent();

        if (childExists) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Child already exists!");
        }
        childRepository.save(child);
        return ResponseEntity.status(HttpStatus.CREATED).body("Child added successfully!");
    }

    public ResponseEntity<List<ChildModel>> getAllChild() {
        List<ChildModel> children = childRepository.findAll();
        return ResponseEntity.ok(children);
    }
}
