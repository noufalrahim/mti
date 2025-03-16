package com.tinysteps.tinysteps.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.tinysteps.tinysteps.model.AgeGroupModel;

public interface AgeGroupRepository extends JpaRepository<AgeGroupModel, Long> {
    boolean existsByStartAgeLessThanAndEndAgeGreaterThan(Integer endAge, Integer startAge);
}
