package com.tinysteps.tinysteps.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.QuestionModel;
import com.tinysteps.tinysteps.repository.QuestionRepository;

@Service
public class QuestionService {

    private final QuestionRepository questionRepository;

    public QuestionService(QuestionRepository questionRepository) {
        this.questionRepository = questionRepository;
    }

    public ResponseEntity<String> addQuestion(QuestionModel question) {
        boolean questionExist = questionRepository.findByQuestionEnglish(question.getQuestionEnglish()).isPresent();
        boolean categoryExist = !questionRepository.findByCategoryId(question.getCategory().getId()).isEmpty();
        boolean ageGroupExist = !questionRepository.findByAgeGroupId(question.getAgeGroup().getId()).isEmpty();

        if (questionExist) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Question already exists");
        }
        if (!categoryExist) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid category");
        }
        if (!ageGroupExist) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Invalid age group");
        }

        questionRepository.save(question);
        return ResponseEntity.status(HttpStatus.CREATED).body("Question added successfully!");
    }

    public ResponseEntity<List<QuestionModel>> getAllQuestions() {
        List<QuestionModel> questions = questionRepository.findAll();
        return ResponseEntity.ok(questions);
    }
}
