package com.tinysteps.tinysteps.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.service.CategoryService;
import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;

import org.springframework.test.web.servlet.MockMvc;

import java.util.List;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(CategoryController.class)
public class CategoryControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private CategoryService categoryService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    void testGetAllCategory() throws Exception {
        CategoryModel category = new CategoryModel();
        category.setName("Toys");

        when(categoryService.getAllCategory()).thenReturn(List.of(category));

        mockMvc.perform(get("/api/category"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$[0].name").value("Toys"));
    }

    @Test
    void testAddCategory() throws Exception {
        CategoryModel category = new CategoryModel();
        category.setName("Books");

        when(categoryService.addCategory("Books")).thenReturn("Category added successfully!");

        mockMvc.perform(post("/api/category/add")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(category)))
                .andExpect(status().isOk())
                .andExpect(content().string("Category added successfully!"));
    }

    @Test
    void testEditCategory() throws Exception {
        CategoryModel category = new CategoryModel();
        category.setId(1L);
        category.setName("Updated");

        when(categoryService.editCategory(any(CategoryModel.class))).thenReturn("Category updated successfully!");

        mockMvc.perform(put("/api/category/edit/1")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(category)))
                .andExpect(status().isOk())
                .andExpect(content().string("Category updated successfully!"));
    }

    @Test
    void testDeleteCategory() throws Exception {
        when(categoryService.deleteCategory(1L)).thenReturn("Category deleted successfully!");

        mockMvc.perform(delete("/api/category/delete/1"))
                .andExpect(status().isOk())
                .andExpect(content().string("Category deleted successfully!"));
    }
}
