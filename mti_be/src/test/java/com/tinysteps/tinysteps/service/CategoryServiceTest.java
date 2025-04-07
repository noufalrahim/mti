package com.tinysteps.tinysteps.service;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.mockito.ArgumentMatchers.any;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import static org.mockito.Mockito.never;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;

import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.repository.CategoryRepository;

public class CategoryServiceTest {

    @Mock
    private CategoryRepository categoryRepository;

    @InjectMocks
    private CategoryService categoryService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        // manually set the prototype-scoped bean since we mocked everything
        categoryService.newCategory = new CategoryModel();
    }

    @Test
    void testAddCategory_NewCategory() {
        when(categoryRepository.findByName("Toys")).thenReturn(Optional.empty());

        String result = categoryService.addCategory("Toys");

        assertEquals("Category added successfully!", result);
        verify(categoryRepository).save(any(CategoryModel.class));
    }

    @Test
    void testAddCategory_ExistingCategory() {
        when(categoryRepository.findByName("Toys")).thenReturn(Optional.of(new CategoryModel()));

        String result = categoryService.addCategory("Toys");

        assertEquals("Category already exists!", result);
        verify(categoryRepository, never()).save(any());
    }

    @Test
    void testEditCategory_Success() {
        CategoryModel existing = new CategoryModel();
        existing.setId(1L);
        existing.setName("Old");

        when(categoryRepository.findById(1L)).thenReturn(Optional.of(existing));

        String result = categoryService.editCategory(existing);

        assertEquals("Category updated successfully!", result);
        verify(categoryRepository).save(existing);
    }

    @Test
    void testEditCategory_NotFound() {
        CategoryModel nonExistent = new CategoryModel();
        nonExistent.setId(99L);

        when(categoryRepository.findById(99L)).thenReturn(Optional.empty());

        String result = categoryService.editCategory(nonExistent);

        assertEquals("No category exists with the given ID!", result);
    }

    @Test
    void testDeleteCategory_Success() {
        CategoryModel existing = new CategoryModel();
        existing.setId(2L);

        when(categoryRepository.findById(2L)).thenReturn(Optional.of(existing));

        String result = categoryService.deleteCategory(2L);

        assertEquals("Category deleted successfully!", result);
        verify(categoryRepository).deleteById(2L);
    }

    @Test
    void testDeleteCategory_NotFound() {
        when(categoryRepository.findById(3L)).thenReturn(Optional.empty());

        String result = categoryService.deleteCategory(3L);

        assertEquals("No category exists with the given ID!", result);
    }
}
