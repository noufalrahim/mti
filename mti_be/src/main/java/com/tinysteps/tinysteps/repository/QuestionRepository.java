package com.tinysteps.tinysteps.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tinysteps.tinysteps.model.QuestionModel;

@Repository
public interface QuestionRepository extends JpaRepository<QuestionModel, Long> {
    Optional<QuestionModel> findByQuestionEnglish(String questionEnglish);
    List<QuestionModel> findByCategoryId(Long categoryId);
    List<QuestionModel> findByAgeGroupId(Long ageGroupId);
}
