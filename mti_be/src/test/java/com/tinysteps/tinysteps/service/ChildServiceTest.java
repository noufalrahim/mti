package com.tinysteps.tinysteps.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.assertEquals;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
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

class ChildServiceTest {

    @InjectMocks
    private ChildService childService;

    @Mock
    private ChildRepository childRepository;

    @Mock
    private UserRepository userRepository;

    private ChildModel child;
    private UserModel user;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        user = new UserModel();
        user.setId(1L);

        child = new ChildModel();
        child.setName("Tommy");
        child.setUser(user);
        child.setDateOfBirth(LocalDate.of(2020, 1, 1));
    }

    @Test
    void testAddChild_Success() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(childRepository.findByNameAndUserId("Tommy", 1L)).thenReturn(Optional.empty());
        when(childRepository.findByUser(user)).thenReturn(List.of(child));

        ResponseEntity<Map<String, Object>> response = childService.addChild(child);

        assertEquals(201, response.getStatusCodeValue());
        assertEquals("Created new child", response.getBody().get("message"));
        verify(childRepository).save(child);
    }

    @Test
    void testAddChild_UserIsNull() {
        ChildModel invalidChild = new ChildModel();
        invalidChild.setName("Invalid");

        ResponseEntity<Map<String, Object>> response = childService.addChild(invalidChild);

        assertEquals(400, response.getStatusCodeValue());
        assertEquals("User is required", response.getBody().get("message"));
    }

    @Test
    void testAddChild_UserNotFound() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = childService.addChild(child);

        assertEquals(404, response.getStatusCodeValue());
        assertEquals("User not found", response.getBody().get("message"));
    }

    @Test
    void testAddChild_AlreadyExists() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(childRepository.findByNameAndUserId("Tommy", 1L)).thenReturn(Optional.of(child));

        ResponseEntity<Map<String, Object>> response = childService.addChild(child);

        assertEquals(409, response.getStatusCodeValue());
        assertEquals("Child already exists", response.getBody().get("message"));
    }

    @Test
    void testGetAllChild() {
        when(childRepository.findAll()).thenReturn(List.of(child));

        ResponseEntity<List<ChildModel>> response = childService.getAllChild();

        assertEquals(200, response.getStatusCodeValue());
        assertEquals(1, response.getBody().size());
    }

    @Test
    void testGetAllChildrenOfUser_Success() {
        when(userRepository.findById(1L)).thenReturn(Optional.of(user));
        when(childRepository.findByUser(user)).thenReturn(List.of(child));

        ResponseEntity<Map<String, Object>> response = childService.getAllChildrenOfUser(1L);

        assertEquals(200, response.getStatusCodeValue());
        assertEquals("Data fetched successfully", response.getBody().get("message"));
    }

    @Test
    void testGetAllChildrenOfUser_UserNotFound() {
        when(userRepository.findById(1L)).thenReturn(Optional.empty());

        ResponseEntity<Map<String, Object>> response = childService.getAllChildrenOfUser(1L);

        assertEquals(404, response.getStatusCodeValue());
        assertEquals("User not found", response.getBody().get("message"));
    }
}
