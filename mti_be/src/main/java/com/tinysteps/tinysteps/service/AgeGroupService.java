package com.tinysteps.tinysteps.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.AgeGroupModel;
import com.tinysteps.tinysteps.repository.AgeGroupRepository;


@Service
public class AgeGroupService {
    public final AgeGroupRepository ageGroupRepository;

    public AgeGroupService(AgeGroupRepository ageGroupRepository) {
        this.ageGroupRepository = ageGroupRepository;
    }

    public List<AgeGroupModel> getAllAgeGroup() {
        return ageGroupRepository.findAll();
    }

    public String addAgeGroup(AgeGroupModel ageGroup) {
        if (ageGroupRepository.existsByStartAgeLessThanAndEndAgeGreaterThan(ageGroup.getEndAge(), ageGroup.getStartAge())) {
            return "Age group already exists!";
        }

        ageGroupRepository.save(ageGroup);

        return "Age group added successfully!";
    }
    public ResponseEntity<Map<String, Object>> deleteAgeGroup(Long id) {
        Optional<AgeGroupModel> existingAgeGroup = ageGroupRepository.findById(id);

        if (!existingAgeGroup.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "AgeGroup is missing or invalid", "data", Collections.emptyMap()));

        }

        ageGroupRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.OK)
                .body(Map.of("message", "AgeGroup deleted successfully", "data", Collections.emptyMap()));

    }
    public String editAgeGroup(AgeGroupModel ageGroupModel) {
        Long id = ageGroupModel.getId();
        Optional<AgeGroupModel> existingAgeGroup = ageGroupRepository.findById(id);
        System.out.print(existingAgeGroup);

        if (!existingAgeGroup.isPresent()) {
            return "No ageGroup exists with the given ID!";
        }

        ageGroupRepository.save(ageGroupModel);

        return "AgeGroup updated successfully!";
    }

}
