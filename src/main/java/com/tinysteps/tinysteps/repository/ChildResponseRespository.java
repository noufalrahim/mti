package com.tinysteps.tinysteps.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tinysteps.tinysteps.model.ChildResponseModel;

@Repository
public interface ChildResponseRespository extends JpaRepository<ChildResponseModel, Long> {

}
