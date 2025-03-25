package com.tinysteps.tinysteps.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.QuestionModel;
import com.tinysteps.tinysteps.service.QuestionService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.parameters.RequestBody;
import io.swagger.v3.oas.annotations.tags.Tag;


@RestController
@RequestMapping("/api/questions")
@Tag(name = "Question API", description = "Endpoints for managing questions")
public class QuestionController {

    @Autowired
    private QuestionService questionService;

    @Operation(summary = "Get all questions")
    @GetMapping("")
    public ResponseEntity<List<QuestionModel>> getAllQuestions() {
        return questionService.getAllQuestions();
    }

    @Operation(summary = "Create a new question")
    @PostMapping("/add")
    public ResponseEntity<String> addQuestion(
            //***FOR API DOCUMENTATION***
            @RequestBody(
                    description = "JSON request body to add a question",
                    required = true,
                    content = @Content(
                            mediaType = "application/json",
                            examples = @ExampleObject(value = """
                            {
                                "questionEnglish": "How do plants make their food?",
                                "questionMalayalam": "സസ്യങ്ങൾ അവരുടെ ആഹാരം എങ്ങനെ നിർമ്മിക്കുന്നു?",
                                "severity": 3,
                                "category": { "id": 2 },
                                "ageGroup": { "id": 1 }
                            }
                            """)
                    )
            )
            //***FOR API DOCUMENTATION***
            @org.springframework.web.bind.annotation.RequestBody QuestionModel question) {
        return questionService.addQuestion(question);
    }

    @DeleteMapping("delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteQuestion(@PathVariable Long id) {
        return questionService.deleteQuestion(id);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Map<String, Object>> getQuestionByCategory(@PathVariable Long id) {
        return questionService.getQuestionByCategory(id);
    }

}
