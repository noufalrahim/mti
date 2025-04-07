package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.model.ChildResponseModel;
import com.tinysteps.tinysteps.model.QuestionModel;
import com.tinysteps.tinysteps.service.ChildResponseService;
import org.junit.jupiter.api.BeforeEach;
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

@WebMvcTest(ChildResponseController.class)
public class ChildResponseControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ChildResponseService childResponseService;

    @Autowired
    private ObjectMapper objectMapper;

    private ChildResponseModel sampleResponse;

    @BeforeEach
    void setUp() {
        ChildModel child = new ChildModel();
        child.setId(1L);

        QuestionModel question = new QuestionModel();
        question.setId(1L);

        sampleResponse = new ChildResponseModel();
        sampleResponse.setChild(child);
        sampleResponse.setQuestion(question);
        sampleResponse.setQuestionAnswered(true);
        sampleResponse.setAnsweredYes(true);
    }

    @Test
    void testGetAllChildResponse() throws Exception {
        when(childResponseService.getAllChildResponse()).thenReturn(List.of(sampleResponse));

        mockMvc.perform(get("/api/childresponses"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].questionAnswered").value(true));
    }

    @Test
    void testAddChildResponse() throws Exception {
        Map<String, Object> mockResponse = Map.of(
                "message", "Child response created successfully",
                "data", sampleResponse
        );

        when(childResponseService.addChildResponse(any())).thenReturn(ResponseEntity.ok(mockResponse));

        mockMvc.perform(post("/api/childresponses/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(sampleResponse)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Child response created successfully"));
    }

    @Test
    void testGetChildProgress() throws Exception {
        Map<String, Object> mockProgress = Map.of(
                "message", "Child progress retrieved successfully",
                "data", Collections.emptyList()
        );

        when(childResponseService.getChildProgress(1L)).thenReturn(ResponseEntity.ok(mockProgress));

        mockMvc.perform(get("/api/childresponses/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Child progress retrieved successfully"));
    }
}
