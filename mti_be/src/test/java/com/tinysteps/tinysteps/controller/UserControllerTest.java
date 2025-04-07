package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.service.UserService;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.test.web.servlet.MockMvc;

import java.util.*;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(UserController.class)
public class UserControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private UserService userService;

    private ObjectMapper objectMapper;

    @BeforeEach
    void setup() {
        objectMapper = new ObjectMapper();
    }

    @Test
    void getAllUsers_ReturnsUsers() throws Exception {
        List<UserModel> users = List.of(new UserModel(), new UserModel());
        when(userService.getAllUsers()).thenReturn(ResponseEntity.ok(users));

        mockMvc.perform(get("/api/users"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.length()").value(2));
    }

    @Test
    void addUser_ReturnsCreated() throws Exception {
        UserModel user = new UserModel();
        user.setPhone("1234567890");

        when(userService.addUser(any())).thenReturn(ResponseEntity.status(201).body("User added successfully!"));

        mockMvc.perform(post("/api/users/add")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(user)))
                .andExpect(status().isCreated())
                .andExpect(content().string("User added successfully!"));
    }

    @Test
    void getDefaultChild_ReturnsChild() throws Exception {
        ChildModel child = new ChildModel();
        Map<String, Object> response = Map.of("message", "Successfully fetched default child", "data", child);

        when(userService.getDefaultChild(1L)).thenReturn(ResponseEntity.ok(response));

        mockMvc.perform(get("/api/users/default-child/1"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Successfully fetched default child"));
    }

    @Test
    void editDefaultChild_ReturnsUpdated() throws Exception {
        ChildModel child = new ChildModel();
        Map<String, Object> response = Map.of("message", "Default child updated successfully", "data", child);

        when(userService.editDefaultChild(1L, 2L)).thenReturn(ResponseEntity.ok(response));

        mockMvc.perform(put("/api/users/1/default-child/2"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Default child updated successfully"));
    }
}
