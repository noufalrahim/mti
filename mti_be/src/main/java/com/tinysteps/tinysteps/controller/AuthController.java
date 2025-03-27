package com.tinysteps.tinysteps.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.service.AuthService;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;


@RestController
@RequestMapping("/api/auth")
@Tag(name = "Auth API", description = "Endpoints for managing authentication")
public class AuthController {
    
    @Autowired
    private AuthService authService;

    @Operation(summary="authentication")
    @PostMapping("")
    public ResponseEntity<Map<String, Object>> authentication(@RequestBody UserModel user) {
        return authService.authentication(user.getPhone());
    }
}
