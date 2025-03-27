package com.tinysteps.tinysteps.service;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.repository.CategoryRepository;

@Service
public class CategoryService {

    private final CategoryRepository categoryRepository;

    @Autowired
    CategoryModel newCategory;

    public CategoryService(CategoryRepository categoryRepository) {
        this.categoryRepository = categoryRepository;
    }

    public List<CategoryModel> getAllCategory() {
        return categoryRepository.findAll();
    }

    public String addCategory(String name) {
        Optional<CategoryModel> existingCategory = categoryRepository.findByName(name);
        if (existingCategory.isPresent()) {
            return "Category already exists!";
        }

        newCategory.setName(name);
        categoryRepository.save(newCategory);

        return "Category added successfully!";
    }

    public String editCategory(CategoryModel categoryModel) {
        Long id = categoryModel.getId();
        Optional<CategoryModel> existingCategory = categoryRepository.findById(id);
        System.out.print(existingCategory);

        if (!existingCategory.isPresent()) {
            return "No category exists with the given ID!";
        }

        categoryRepository.save(categoryModel);

        return "Category updated successfully!";
    }

    public ResponseEntity<Map<String, Object>> deleteCategory(Long id) {
        Optional<CategoryModel> existingCategory = categoryRepository.findById(id);

        if (!existingCategory.isPresent()) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(Map.of("message", "Category is missing or invalid", "data", Collections.emptyMap()));
        
        }

        categoryRepository.deleteById(id);
        return ResponseEntity.status(HttpStatus.OK)
        .body(Map.of("message", "Category deleted s", "data", Collections.emptyMap()));


    }

}
