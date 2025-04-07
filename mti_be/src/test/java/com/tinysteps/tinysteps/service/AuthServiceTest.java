package com.tinysteps.tinysteps.service;

import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.mockito.ArgumentMatchers.any;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import org.mockito.MockitoAnnotations;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.repository.UserRepository;

public class AuthServiceTest {

    @Mock
    private UserRepository userRepository;

    @InjectMocks
    private AuthService authService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void testAuthentication_InvalidPhone() {
        ResponseEntity<Map<String, Object>> response = authService.authentication("123");

        assertEquals(HttpStatus.BAD_REQUEST, response.getStatusCode());
        assertEquals("Invalid mobile number", response.getBody().get("message"));
    }

    @Test
    void testAuthentication_ExistingUser() {
        String phone = "9876543210";
        UserModel user = new UserModel();
        user.setPhone(phone);

        when(userRepository.findByPhone(phone)).thenReturn(Optional.of(user));

        ResponseEntity<Map<String, Object>> response = authService.authentication(phone);

        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals("Successfully logged in", response.getBody().get("message"));
    }

    @Test
    void testAuthentication_NewUser() {
        String phone = "9876543210";

        when(userRepository.findByPhone(phone)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = authService.authentication(phone);

        assertEquals(HttpStatus.CREATED, response.getStatusCode());
        assertEquals("Account created successfully", response.getBody().get("message"));

        verify(userRepository).save(any(UserModel.class));
    }
}
