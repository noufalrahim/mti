package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.AdminModel;
import com.tinysteps.tinysteps.service.AdminService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import java.util.*;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

import static org.mockito.Mockito.*;

@WebMvcTest(AdminController.class)
public class AdminControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private AdminService adminService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testGetAllAdmin() throws Exception {
        AdminModel admin = new AdminModel();
        admin.setName("Noufal");

        when(adminService.getAllAdmin()).thenReturn(Collections.singletonList(admin));

        mockMvc.perform(get("/api/admins"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("Noufal"));
    }

    @Test
    void testAddAdmin() throws Exception {
        AdminModel admin = new AdminModel();
        admin.setName("Noufal");

        when(adminService.addAdmin("Noufal")).thenReturn("Admin added successfully!");

        mockMvc.perform(post("/api/admins/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(admin)))
                .andExpect(status().isOk())
                .andExpect(content().string("Admin added successfully!"));
    }
}
