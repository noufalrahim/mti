package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.service.ChildService;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.*;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import java.time.LocalDate;
import java.util.*;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import org.springframework.test.web.servlet.result.MockMvcResultHandlers;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.hamcrest.Matchers.*;

@WebMvcTest(ChildController.class)
public class ChildControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private ChildService childService;

    @Autowired
    private ObjectMapper objectMapper;

    private ChildModel child;
    private UserModel user;

    @BeforeEach
    void setup() {
        user = new UserModel();
        user.setId(1L);

        child = new ChildModel();
        child.setName("Tommy");
        child.setUser(user);
        child.setDateOfBirth(LocalDate.of(2020, 1, 1));
    }

    @Test
    void testGetAllChildren() throws Exception {
        List<ChildModel> children = List.of(child);
        when(childService.getAllChild()).thenReturn(ResponseEntity.ok(children));

        mockMvc.perform(MockMvcRequestBuilders.get("/api/child"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("Tommy"));
    }

    @Test
    void testGetAllChildrenOfUser_Success() throws Exception {
        Map<String, Object> responseMap = Map.of(
                "message", "Data fetched successfully",
                "data", List.of(child)
        );

        when(childService.getAllChildrenOfUser(1L))
                .thenReturn(ResponseEntity.ok(responseMap));

        mockMvc.perform(MockMvcRequestBuilders.get("/api/child/user/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Data fetched successfully"))
                .andExpect(jsonPath("$.data[0].name").value("Tommy"));
    }

    @Test
    void testAddChild_Success() throws Exception {
        Map<String, Object> response = Map.of(
                "message", "Created new child",
                "data", child
        );

        when(childService.addChild(any(ChildModel.class)))
                .thenReturn(ResponseEntity.status(HttpStatus.CREATED).body(response));

        mockMvc.perform(MockMvcRequestBuilders.post("/api/child/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(child)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.message").value("Created new child"))
                .andExpect(jsonPath("$.data.name").value("Tommy"));
    }

    @Test
    void testAddChild_BadRequest() throws Exception {
        // User is null in the child
        ChildModel badChild = new ChildModel();
        badChild.setName("Invalid");

        Map<String, Object> response = Map.of(
                "message", "User is required",
                "data", Collections.emptyList()
        );

        when(childService.addChild(any(ChildModel.class)))
                .thenReturn(ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response));

        mockMvc.perform(MockMvcRequestBuilders.post("/api/child/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(badChild)))
                .andExpect(status().isBadRequest())
                .andExpect(jsonPath("$.message").value("User is required"));
    }
}
