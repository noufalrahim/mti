package com.tinysteps.tinysteps.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.tinysteps.tinysteps.model.ChildResponseModel;
import com.tinysteps.tinysteps.model.QuestionModel;

@Repository
public interface ChildResponseRespository extends JpaRepository<ChildResponseModel, Long> {
    Optional<ChildResponseModel> findByQuestion(QuestionModel question);
    Optional<ChildResponseModel> findByChildIdAndQuestionId(Long childId, Long questionId);
    List<ChildResponseModel> findByChildId(Long childId);
}
