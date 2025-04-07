package com.tinysteps.tinysteps.service;

import java.util.List;
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
import org.springframework.http.ResponseEntity;

import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.model.UserModel;
import com.tinysteps.tinysteps.repository.ChildRepository;
import com.tinysteps.tinysteps.repository.UserRepository;

public class UserServiceTest {

    @Mock
    private UserRepository userRepository;

    @Mock
    private ChildRepository childRepository;

    @InjectMocks
    private UserService userService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    void addUser_NewUser_ReturnsCreated() {
        String phone = "1234567890";
        when(userRepository.findByPhone(phone)).thenReturn(Optional.empty());

        ResponseEntity<String> response = userService.addUser(phone);

        assertEquals(201, response.getStatusCodeValue());
        assertEquals("User added successfully!", response.getBody());
        verify(userRepository).save(any(UserModel.class));
    }

    @Test
    void addUser_ExistingUser_ReturnsConflict() {
        String phone = "1234567890";
        when(userRepository.findByPhone(phone)).thenReturn(Optional.of(new UserModel()));

        ResponseEntity<String> response = userService.addUser(phone);

        assertEquals(409, response.getStatusCodeValue());
        assertEquals("Phone number already exists!", response.getBody());
    }

    @Test
    void getAllUsers_ReturnsList() {
        List<UserModel> mockUsers = List.of(new UserModel(), new UserModel());
        when(userRepository.findAll()).thenReturn(mockUsers);

        ResponseEntity<List<UserModel>> response = userService.getAllUsers();

        assertEquals(200, response.getStatusCodeValue());
        assertEquals(2, response.getBody().size());
    }

    @Test
    void getDefaultChild_ValidUser_ReturnsChild() {
        Long userId = 1L;
        ChildModel child = new ChildModel();
        UserModel user = new UserModel();
        user.setDefaultChild(child);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));

        ResponseEntity<Map<String, Object>> response = userService.getDefaultChild(userId);

        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Successfully fetched default child", response.getBody().get("message"));
        assertEquals(child, response.getBody().get("data"));
    }

    @Test
    void editDefaultChild_Valid_ReturnsSuccess() {
        Long userId = 1L;
        Long childId = 2L;

        UserModel user = new UserModel();
        ChildModel child = new ChildModel();
        child.setUser(user);

        when(userRepository.findById(userId)).thenReturn(Optional.of(user));
        when(childRepository.findById(childId)).thenReturn(Optional.of(child));

        ResponseEntity<Map<String, Object>> response = userService.editDefaultChild(userId, childId);

        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Default child updated successfully", response.getBody().get("message"));
        assertEquals(child, response.getBody().get("data"));
    }
}
