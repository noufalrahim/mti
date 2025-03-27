package com.tinysteps.tinysteps.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.model.UserModel;

@Repository
public interface ChildRepository extends JpaRepository<ChildModel, Long> {

    Optional<ChildModel> findByName(String name);

    List<ChildModel> findByUser(UserModel user);

    Optional<ChildModel> findByUserId(Long id);

    Optional<ChildModel> findByNameAndUserId(String name, Long userId);


}
