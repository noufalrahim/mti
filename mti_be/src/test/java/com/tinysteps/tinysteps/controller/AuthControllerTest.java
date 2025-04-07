package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.service.AuthService;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.*;
import org.springframework.test.web.servlet.MockMvc;

import java.util.*;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(AuthController.class)
public class AuthControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AuthService authService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testAuthenticationEndpoint() throws Exception {
        UserModel user = new UserModel();
        user.setPhone("9876543210");

        Map<String, Object> mockResponse = Map.of(
                "message", "Successfully logged in",
                "data", user
        );

        when(authService.authentication("9876543210"))
                .thenReturn(ResponseEntity.ok(mockResponse));

        mockMvc.perform(post("/api/auth")
                .contentType(MediaType.APPLICATION_JSON)
                .content(objectMapper.writeValueAsString(user)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message").value("Successfully logged in"))
                .andExpect(jsonPath("$.data.phone").value("9876543210"));
    }
}
