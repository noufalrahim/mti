package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.AgeGroupModel;
import com.tinysteps.tinysteps.service.AgeGroupService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.*;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(AgeGroupController.class)
public class AgeGroupControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AgeGroupService ageGroupService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testGetAllAgeGroups() throws Exception {
        AgeGroupModel ageGroup = new AgeGroupModel();
        ageGroup.setStartAge(2);
        ageGroup.setEndAge(5);

        when(ageGroupService.getAllAgeGroup()).thenReturn(List.of(ageGroup));

        mockMvc.perform(get("/api/agegroup"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].startAge").value(2))
                .andExpect(jsonPath("$[0].endAge").value(5));
    }

    @Test
    void testAddAgeGroup() throws Exception {
        AgeGroupModel ageGroup = new AgeGroupModel();
        ageGroup.setStartAge(2);
        ageGroup.setEndAge(5);

        when(ageGroupService.addAgeGroup(any(AgeGroupModel.class)))
                .thenReturn("Age group added successfully!");

        mockMvc.perform(post("/api/agegroup/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(ageGroup)))
                .andExpect(status().isOk())
                .andExpect(content().string("Age group added successfully!"));
    }
}
