package com.tinysteps.tinysteps.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.service.UserService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

@RestController
@RequestMapping("/api/users")
@Tag(name = "User API", description = "Endpoints for managing users")
public class UserController {

    @Autowired
    private UserService userService;

    @Operation(summary = "Get all users")
    @GetMapping("")
    public ResponseEntity<List<UserModel>> getAllUsers() {
        return userService.getAllUsers();
    }

    @Operation(summary = "Create a new user")
    @PostMapping("/add")
    public ResponseEntity<String> addUser(@RequestBody UserModel user) {
        return userService.addUser(user.getPhone());
    }
}
