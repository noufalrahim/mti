package com.tinysteps.tinysteps.service;

import com.tinysteps.tinysteps.model.*;
import com.tinysteps.tinysteps.repository.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import org.springframework.http.ResponseEntity;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class ChildResponseServiceTest {

    @Mock private ChildResponseRespository childResponseRepository;
    @Mock private ChildRepository childRepository;
    @Mock private QuestionRepository questionRepository;
    @Mock private CategoryRepository categoryRepository;

    @InjectMocks
    private ChildResponseService childResponseService;

    private ChildModel child;
    private QuestionModel question;
    private ChildResponseModel childResponse;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        child = new ChildModel();
        child.setId(1L);

        CategoryModel category = new CategoryModel();
        category.setId(10L);
        category.setName("Motor Skills");

        question = new QuestionModel();
        question.setId(100L);
        question.setCategory(category);

        childResponse = new ChildResponseModel();
        childResponse.setChild(child);
        childResponse.setQuestion(question);
        childResponse.setQuestionAnswered(true);
        childResponse.setAnsweredYes(true);
    }

    @Test
    void testGetAllChildResponse() {
        when(childResponseRepository.findAll()).thenReturn(List.of(childResponse));

        List<ChildResponseModel> result = childResponseService.getAllChildResponse();

        assertEquals(1, result.size());
        verify(childResponseRepository).findAll();
    }

    @Test
    void testAddChildResponse_Success() {
        when(childRepository.findById(1L)).thenReturn(Optional.of(child));
        when(questionRepository.findById(100L)).thenReturn(Optional.of(question));
        when(childResponseRepository.findByChildIdAndQuestionId(1L, 100L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = childResponseService.addChildResponse(childResponse);

        assertEquals(201, response.getStatusCodeValue());
        assertEquals("Child response created successfully", response.getBody().get("message"));
        verify(childResponseRepository).save(any(ChildResponseModel.class));
    }

    @Test
    void testAddChildResponse_ChildMissing() {
        ChildResponseModel model = new ChildResponseModel();
        model.setQuestion(question);

        ResponseEntity<Map<String, Object>> response = childResponseService.addChildResponse(model);

        assertEquals(400, response.getStatusCodeValue());
        assertEquals("Child information is missing or invalid", response.getBody().get("message"));
    }

    @Test
    void testAddChildResponse_ChildNotFound() {
        when(childRepository.findById(1L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = childResponseService.addChildResponse(childResponse);

        assertEquals(404, response.getStatusCodeValue());
        assertEquals("Child not found", response.getBody().get("message"));
    }

    @Test
    void testAddChildResponse_QuestionNotFound() {
        when(childRepository.findById(1L)).thenReturn(Optional.of(child));
        when(questionRepository.findById(100L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = childResponseService.addChildResponse(childResponse);

        assertEquals(404, response.getStatusCodeValue());
        assertEquals("Question not found", response.getBody().get("message"));
    }

    @Test
    void testAddChildResponse_UpdateIfExists() {
        ChildResponseModel existingResponse = new ChildResponseModel();
        existingResponse.setChild(child);
        existingResponse.setQuestion(question);
        existingResponse.setQuestionAnswered(false);
        existingResponse.setAnsweredYes(false);

        when(childRepository.findById(1L)).thenReturn(Optional.of(child));
        when(questionRepository.findById(100L)).thenReturn(Optional.of(question));
        when(childResponseRepository.findByChildIdAndQuestionId(1L, 100L)).thenReturn(Optional.of(existingResponse));

        ResponseEntity<Map<String, Object>> response = childResponseService.addChildResponse(childResponse);

        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Child response updated successfully", response.getBody().get("message"));
        verify(childResponseRepository).save(existingResponse);
    }

    @Test
    void testGetChildProgress_NoResponses() {
        CategoryModel category = new CategoryModel();
        category.setId(10L);
        category.setName("Motor Skills");

        when(categoryRepository.findAll()).thenReturn(List.of(category));
        when(childResponseRepository.findByChildId(1L)).thenReturn(Collections.emptyList());
        when(questionRepository.findByCategoryId(10L)).thenReturn(List.of(question));

        ResponseEntity<Map<String, Object>> response = childResponseService.getChildProgress(1L);

        assertEquals(200, response.getStatusCodeValue());
        assertEquals("No responses found for this child", response.getBody().get("message"));
    }

    @Test
    void testGetChildProgress_WithResponses() {
        CategoryModel category = new CategoryModel();
        category.setId(10L);
        category.setName("Motor Skills");
        question.setCategory(category);

        when(categoryRepository
