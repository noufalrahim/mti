package com.tinysteps.tinysteps.service;

import com.tinysteps.tinysteps.model.AdminModel;
import com.tinysteps.tinysteps.repository.AdminRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class AdminServiceTest {

    @Mock
    private AdminRepository adminRepository;

    @InjectMocks
    private AdminService adminService;

    @Captor
    ArgumentCaptor<AdminModel> adminCaptor;

    private AdminModel adminModel;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);
        adminModel = new AdminModel();
        adminModel.setName("Noufal");
        adminService = new AdminService(adminRepository);
        adminService.newAdmin = new AdminModel(); // inject manually
    }

    @Test
    void testGetAllAdmin() {
        List<AdminModel> adminList = Arrays.asList(adminModel);
        when(adminRepository.findAll()).thenReturn(adminList);

        List<AdminModel> result = adminService.getAllAdmin();

        assertEquals(1, result.size());
        assertEquals("Noufal", result.get(0).getName());
        verify(adminRepository, times(1)).findAll();
    }

    @Test
    void testAddAdmin_WhenNotExists() {
        when(adminRepository.findByName("Noufal")).thenReturn(Optional.empty());

        String result = adminService.addAdmin("Noufal");

        assertEquals("Admin added successfully!", result);
        verify(adminRepository, times(1)).save(any(AdminModel.class));
    }

    @Test
    void testAddAdmin_WhenAlreadyExists() {
        when(adminRepository.findByName("Noufal")).thenReturn(Optional.of(adminModel));

        String result = adminService.addAdmin("Noufal");

        assertEquals("Admin already exists!", result);
        verify(adminRepository, never()).save(any());
    }
}
