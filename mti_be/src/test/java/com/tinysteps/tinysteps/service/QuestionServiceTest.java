package com.tinysteps.tinysteps.service;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.assertj.core.api.Assertions.assertThat;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.times;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.tinysteps.tinysteps.model.AgeGroupModel;
import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.model.QuestionModel;
import com.tinysteps.tinysteps.repository.CategoryRepository;
import com.tinysteps.tinysteps.repository.QuestionRepository;

public class QuestionServiceTest {

    private QuestionRepository questionRepository;
    private CategoryRepository categoryRepository;
    private QuestionService questionService;

    @BeforeEach
    void setUp() {
        questionRepository = mock(QuestionRepository.class);
        categoryRepository = mock(CategoryRepository.class);
        questionService = new QuestionService(questionRepository, categoryRepository);
    }

    @Test
    void testAddQuestionSuccess() {
        QuestionModel question = new QuestionModel();
        question.setQuestionEnglish("New Q");

        CategoryModel category = new CategoryModel();
        category.setId(1L);
        question.setCategory(category);

        AgeGroupModel age = new AgeGroupModel();
        age.setId(1L);
        question.setAgeGroup(age);

        when(questionRepository.findByQuestionEnglish("New Q")).thenReturn(Optional.empty());
        when(questionRepository.findByCategoryId(1L)).thenReturn(List.of(new QuestionModel()));
        when(questionRepository.findByAgeGroupId(1L)).thenReturn(List.of(new QuestionModel()));

        ResponseEntity<String> result = questionService.addQuestion(question);

        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.CREATED);
        assertThat(result.getBody()).isEqualTo("Question added successfully!");
        verify(questionRepository, times(1)).save(question);
    }

    @Test
    void testAddQuestionConflict() {
        QuestionModel question = new QuestionModel();
        question.setQuestionEnglish("Duplicate");

        when(questionRepository.findByQuestionEnglish("Duplicate")).thenReturn(Optional.of(new QuestionModel()));

        ResponseEntity<String> result = questionService.addQuestion(question);

        assertThat(result.getStatusCode()).isEqualTo(HttpStatus.CONFLICT);
        assertThat(result.getBody()).isEqualTo("Question already exists");
        verify(questionRepository, never()).save(any());
    }

    @Test
    void testGetAllQuestions() {
        List<QuestionModel> list = List.of(new QuestionModel());
        when(questionRepository.findAll()).thenReturn(list);

        ResponseEntity<List<QuestionModel>> result = questionService.getAllQuestions();

        assertThat(result.getBody()).hasSize(1);
    }

    @Test
    void testDeleteQuestionNotFound() {
        when(questionRepository.findById(1L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = questionService.deleteQuestion(1L);
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody()).containsEntry("message", "No question found");
    }

    @Test
    void testDeleteQuestionSuccess() {
        QuestionModel q = new QuestionModel();
        q.setId(1L);
        when(questionRepository.findById(1L)).thenReturn(Optional.of(q));

        ResponseEntity<Map<String, Object>> response = questionService.deleteQuestion(1L);
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).containsEntry("message", "Question deleted succesfully");
    }

    @Test
    void testGetQuestionByCategoryFound() {
        CategoryModel cat = new CategoryModel();
        cat.setId(1L);
        when(categoryRepository.findById(1L)).thenReturn(Optional.of(cat));
        when(questionRepository.findByCategoryId(1L)).thenReturn(List.of(new QuestionModel()));

        ResponseEntity<Map<String, Object>> response = questionService.getQuestionByCategory(1L);
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.OK);
        assertThat(response.getBody()).containsEntry("message", "Question fetched succesfully");
    }

    @Test
    void testGetQuestionByCategoryNotFound() {
        when(categoryRepository.findById(99L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = questionService.getQuestionByCategory(99L);
        assertThat(response.getStatusCode()).isEqualTo(HttpStatus.NOT_FOUND);
        assertThat(response.getBody()).containsEntry("message", "No category found");
    }
}
