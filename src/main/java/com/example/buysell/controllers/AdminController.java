package com.example.buysell.controllers;

import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.services.OrderServiceImpl;
import com.example.buysell.services.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Map;

@Controller
@PreAuthorize("hasAuthority('ROLE_ADMIN')")
public class AdminController {
    private final UserServiceImpl userService;
    private final OrderServiceImpl orderService;

    @Autowired
    public AdminController(UserServiceImpl userService, OrderServiceImpl orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/admin")
    public String admin(Model model) {
        model.addAttribute("users", userService.list());
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        return "redirect:/admin";
    }

    @PostMapping("/orders-info/admin/{user}/update-status/{id}")
    public String updateStatus(@PathVariable("user") User user,@PathVariable("id") Long id) {
        orderService.updateOrderStatus(id);
        return "redirect:/orders-info/"+user.getId();
    }

    @GetMapping("/admin/user/edit/{user}")
    public String userEdit(@PathVariable("user") User user, Model model) {
        model.addAttribute("user", user);
        model.addAttribute("roles", Role.values());
        return "user-edit";
    }

    @PostMapping("/admin/user/edit")
    public String userEdit(@RequestParam("userId") User user, @RequestParam Map<String, String> form) {
        userService.changeUserRoles(user, form);
        return "redirect:/admin";
    }

    @GetMapping("/admin-active")
    public String activeUsers(Model model) {
        model.addAttribute("users", userService.findActiveUsers());
        return "admin";
    }

    @GetMapping("/admin-baned")
    public String banedUsers(Model model) {
        model.addAttribute("users", userService.findEnabledUsers());
        return "admin";
    }

    @GetMapping("/admin/sorted-a-z")
    public String sortedUsersAZ(Model model) {
        model.addAttribute("users", userService.getUsersSortAZ());
        return "admin";
    }

    @GetMapping("/admin/sorted-z-a")
    public String sortedUsersZA(Model model) {
        model.addAttribute("users", userService.getUsersSortZA());
        return "admin";
    }
}