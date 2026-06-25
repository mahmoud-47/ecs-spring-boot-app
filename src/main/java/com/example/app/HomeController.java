package com.example.app;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {

    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("studentName", "Mohamed Gaye V1.2");
        model.addAttribute("labName", "ECS CI/CD — Module 4");
        return "index";
    }
}
