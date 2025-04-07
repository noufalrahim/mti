package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.AgeGroupModel;
import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.model.QuestionModel;
import com.tinysteps.tinysteps.service.QuestionService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(QuestionController.class)
public class QuestionControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private QuestionService questionService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testGetAllQuestions() throws Exception {
        QuestionModel question = new QuestionModel();
        question.setQuestionEnglish("Sample Q?");
        when(questionService.getAllQuestions()).thenReturn(ResponseEntity.ok(List.of(question)));

        mockMvc.perform(get("/api/questions"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].questionEnglish").value("Sample Q?"));
    }

    @Test
    void testAddQuestion() throws Exception {
        QuestionModel question = new QuestionModel();
        question.setQuestionEnglish("Sample?");
        question.setQuestionMalayalam("ഉദാഹരണം?");
        question.setSeverity(2);

        CategoryModel category = new CategoryModel();
        category.setId(1L);
        question.setCategory(category);

        AgeGroupModel ageGroup = new AgeGroupModel();
        ageGroup.setId(1L);
        question.setAgeGroup(ageGroup);

        when(questionService.addQuestion(any())).thenReturn(ResponseEntity.status(201).body("Question added successfully!"));

        mockMvc.perform(post("/api/questions/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(question)))
                .andExpect(status().isCreated())
                .andExpect(content().string("Question added successfully!"));
    }

    @Test
    void testDeleteQuestion() throws Exception {
        when(questionService.deleteQuestion(1L)).thenReturn(ResponseEntity.ok(Map.of("message", "Deleted", "data", Collections.emptyMap())));

        mockMvc.perform(delete("/api/questions/delete/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Deleted"));
    }

    @Test
    void testGetQuestionByCategory() throws Exception {
        when(questionService.getQuestionByCategory(1L)).thenReturn(ResponseEntity.ok(Map.of("message", "Fetched", "data", Collections.emptyList())));

        mockMvc.perform(get("/api/questions/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Fetched"));
    }
}
