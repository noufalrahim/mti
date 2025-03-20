package com.tinysteps.tinysteps.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tinysteps.tinysteps.model.ChildResponseModel;
import com.tinysteps.tinysteps.repository.ChildResponseRespository;

@Service
public class ChildResponseService {

    private final ChildResponseRespository childresponseRepository;

    @Autowired
    ChildResponseModel newChildResponse;

    public ChildResponseService(ChildResponseRespository childresponseRepository) {
        this.childresponseRepository = childresponseRepository;
    }

    public List<ChildResponseModel> getAllChildResponse() {
        return childresponseRepository.findAll();
    }

    // public String addChildResponse(String name) {
    //     Optional<ChildResponseModel> existinChildResponse = childresponseRepository.findByName(name);
    //     if (existinChildResponse.isPresent()) {
    //         return "ChildResponse already exists!";
    //     }

    //     newChildResponse.setName(name);
    //     childresponseRepository.save(newChildResponse);

    //     return "childresponse added successfully!";
    // }

    public String addChildResponse(ChildResponseModel childResponseModel) {
        childresponseRepository.save(childResponseModel);
        return "Child Response added successfully";
    }
}
