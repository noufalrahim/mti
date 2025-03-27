package com.tinysteps.tinysteps.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.CategoryModel;
import com.tinysteps.tinysteps.service.CategoryService;

@RestController
@RequestMapping("/api/category")
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

    @GetMapping("")
    public List<CategoryModel> getAllCategory() {
        return categoryService.getAllCategory();
    }

    @PostMapping("/add")
    public String addCategory(@RequestBody CategoryModel categoryModel) {
        return categoryService.addCategory(categoryModel.getName());
    }

    @PutMapping("edit/{id}")
    public String editCategory(@RequestBody CategoryModel categoryModel) {
        return categoryService.editCategory(categoryModel);
    }

    @DeleteMapping("delete/{id}")
    public ResponseEntity<Map<String, Object>> deleteCategory(@PathVariable String id) {
        Long categoryId = Long.valueOf(id);
        return categoryService.deleteCategory(categoryId);
    }
}
