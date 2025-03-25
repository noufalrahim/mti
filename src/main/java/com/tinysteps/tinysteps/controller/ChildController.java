package com.tinysteps.tinysteps.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.tinysteps.tinysteps.model.ChildModel;
import com.tinysteps.tinysteps.service.ChildService;

@RestController
@RequestMapping("/api/child")
public class ChildController {

    // private static final Logger logger = LoggerFactory.getLogger(ChildController.class);
    @Autowired
    private ChildService childService;

    @GetMapping("")
    public ResponseEntity<List<ChildModel>> getAllChildren() {
        return childService.getAllChild();
    }

    @GetMapping("/user/{id}")
    public ResponseEntity<Map<String, Object>> getMethodName(@PathVariable Long id) {
        return childService.getAllChildrenOfUser(id);
    }

    @PostMapping("/add")
    public ResponseEntity<Map<String, Object>> addChild(@RequestBody ChildModel child) {
        // logger.info("Child received: {}", child);
        return childService.addChild(child);
    }
}
