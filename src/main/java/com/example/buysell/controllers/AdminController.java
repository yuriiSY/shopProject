package com.example.buysell.controllers;

import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.services.OrderServiceImpl;
import com.example.buysell.services.UserServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

    Logger logger = LoggerFactory.getLogger(AdminController.class);

    @Autowired
    public AdminController(UserServiceImpl userService, OrderServiceImpl orderService) {
        this.userService = userService;
        this.orderService = orderService;
    }

    @GetMapping("/admin")
    public String admin(Model model) {
        model.addAttribute("users", userService.list());
        logger.info("admin page has been opened");
        return "admin";
    }

    @PostMapping("/admin/user/ban/{id}")
    public String userBan(@PathVariable("id") Long id) {
        userService.banUser(id);
        logger.info("admin baned user with ID:{}", id);
        return "redirect:/admin";
    }

    @PostMapping("/orders-info/admin/{user}/update-status/{id}")
    public String updateStatus(@PathVariable("user") User user,@PathVariable("id") Long id) {
        orderService.updateOrderStatus(id);
        logger.info("order status changed");
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
        logger.info("for user with id:{} changed role",user.getId());
        return "redirect:/admin";
    }

    @GetMapping("/admin-active")
    public String activeUsers(Model model) {
        model.addAttribute("users", userService.findActiveUsers());
        logger.info("active users were shown");
        return "admin";
    }

    @GetMapping("/admin-baned")
    public String banedUsers(Model model) {
        model.addAttribute("users", userService.findEnabledUsers());
        logger.info("baned users were shown");
        return "admin";
    }

    @GetMapping("/admin/sorted-a-z")
    public String sortedUsersAZ(Model model) {
        model.addAttribute("users", userService.getUsersSortAZ());
        logger.info("users sorted from a to z ");
        return "admin";
    }

    @GetMapping("/admin/sorted-z-a")
    public String sortedUsersZA(Model model) {
        model.addAttribute("users", userService.getUsersSortZA());
        logger.info("users sorted from z to a ");
        return "admin";
    }
}