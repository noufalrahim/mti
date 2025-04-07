package com.tinysteps.tinysteps.service;

import com.tinysteps.tinysteps.model.AgeGroupModel;
import com.tinysteps.tinysteps.repository.AgeGroupRepository;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.*;

import java.util.*;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class AgeGroupServiceTest {

    @Mock
    private AgeGroupRepository ageGroupRepository;

    @InjectMocks
    private AgeGroupService ageGroupService;

    private AgeGroupModel ageGroup;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.openMocks(this);

        ageGroup = new AgeGroupModel();
        ageGroup.setStartAge(2);
        ageGroup.setEndAge(5);

        ageGroupService = new AgeGroupService(ageGroupRepository);
    }

    @Test
    void testGetAllAgeGroup() {
        List<AgeGroupModel> expectedList = List.of(ageGroup);
        when(ageGroupRepository.findAll()).thenReturn(expectedList);

        List<AgeGroupModel> result = ageGroupService.getAllAgeGroup();

        assertEquals(1, result.size());
        verify(ageGroupRepository, times(1)).findAll();
    }

    @Test
    void testAddAgeGroup_WhenNotExists() {
        when(ageGroupRepository.existsByStartAgeLessThanAndEndAgeGreaterThan(5, 2)).thenReturn(false);

        String result = ageGroupService.addAgeGroup(ageGroup);

        assertEquals("Age group added successfully!", result);
        verify(ageGroupRepository).save(ageGroup);
    }

    @Test
    void testAddAgeGroup_WhenExists() {
        when(ageGroupRepository.existsByStartAgeLessThanAndEndAgeGreaterThan(5, 2)).thenReturn(true);

        String result = ageGroupService.addAgeGroup(ageGroup);

        assertEquals("Age group already exists!", result);
        verify(ageGroupRepository, never()).save(any());
    }
}
