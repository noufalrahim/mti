package com.tinysteps.tinysteps.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.model.QuestionModel;
import com.tinysteps.tinysteps.repository.CategoryRepository;
import com.tinysteps.tinysteps.repository.QuestionRepository;

@Service
public class QuestionService {

    private final QuestionRepository questionRepository;
    private final CategoryRepository categoryRepository;

    public QuestionService(QuestionRepository questionRepository, CategoryRepository categoryRepository) {
        this.questionRepository = questionRepository;
        this.categoryRepository = categoryRepository;
    }

    public ResponseEntity<String> addQuestion(QuestionModel question) {
        boolean questionExist = questionRepository.findByQuestionEnglish(question.getQuestionEnglish()).isPresent();
        boolean categoryExist = !questionRepository.findByCategoryId(question.getCategory().getId()).isEmpty();
        boolean ageGroupExist = !questionRepository.findByAgeGroupId(question.getAgeGroup().getId()).isEmpty();

        if (questionExist) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Question already exists");
        }
        // if (!categoryExist) {
        //     return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid category");
        // }
        // if (!ageGroupExist) {
        //     return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid age group");
        // }

        questionRepository.save(question);
        return ResponseEntity.status(HttpStatus.CREATED).body("Question added successfully!");
    }

    public ResponseEntity<List<QuestionModel>> getAllQuestions() {
        List<QuestionModel> questions = questionRepository.findAll();
        return ResponseEntity.ok(questions);
    }

    public ResponseEntity<Map<String, Object>> deleteQuestion(Long id) {
        Optional<QuestionModel> existingQuestion = questionRepository.findById(id);
        if (!existingQuestion.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "No question found", "data", Collections.emptyMap()));

        }

        questionRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.OK)
                    .body(Map.of("message", "Question deleted succesfully", "data", Collections.emptyMap()));
    }

    public ResponseEntity<Map<String, Object>> getQuestionByCategory(Long categoryId) {
        Optional<CategoryModel> existingCategory = categoryRepository.findById(categoryId);

        if (!existingCategory.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "No category found", "data", Collections.emptyMap()));

        }

        List<QuestionModel> questions = questionRepository.findByCategoryId(categoryId);
        return ResponseEntity.status(HttpStatus.OK)
                    .body(Map.of("message", "Question fetched succesfully", "data", questions));
    }
}
