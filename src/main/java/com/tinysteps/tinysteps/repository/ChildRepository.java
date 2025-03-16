package com.tinysteps.tinysteps.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tinysteps.tinysteps.model.ChildModel;

@Repository
public interface ChildRepository extends JpaRepository<ChildModel, Long> {

    Optional<ChildModel> findByName(String name);

    Optional<ChildModel> findByUserPhone(String phone);

    Optional<ChildModel> findByNameAndUserId(String name, Long userId);

}
