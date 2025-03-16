package com.tinysteps.tinysteps.service;

import java.util.List;

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

}
