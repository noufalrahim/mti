package com.tinysteps.tinysteps.controller;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequestMapping("/api")
public class HomeController {

    @GetMapping("/")
    public String welocome() {
        return "Welcome to Tiny Steps Server";
    }
      

}
