package com.tinysteps.tinysteps.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tinysteps.tinysteps.model.AdminModel;

@Repository
public interface AdminRepository extends JpaRepository<AdminModel, Long> {

    Optional<AdminModel> findByName(String name);

}
