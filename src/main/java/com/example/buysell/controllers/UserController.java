package com.example.buysell.controllers;

import com.example.buysell.models.User;
import com.example.buysell.services.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.util.Map;

@Controller
public class UserController {
    private final UserServiceImpl userService;

    @Autowired
    public UserController(UserServiceImpl userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }


    @PostMapping("/registration")
    public String createUser(@Valid User user, BindingResult bindingResult,
                             Model model) {
        Map<String,String> errorsMap = ControllersUtils.getErrors(bindingResult);
        model.addAttribute("user", user);

        if (user.getName().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "registration";
        }
        if (user.getEmail().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "registration";
        }
        if (user.getPassword().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "registration";
        }
        if (user.getPhoneNumber().isBlank()) {
            model.mergeAttributes(errorsMap);
            return "registration";
        }

        if (!userService.createUser(user)) {
            model.addAttribute("errorMessage", "EMAIL: " + user.getEmail() + " already exist.");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/user/{user}")
    public String userInfo(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("products", user.getProducts());
        return "user-info";
    }
}
