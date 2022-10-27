package com.example.buysell.controllers;


import com.example.buysell.models.Order;
import com.example.buysell.models.User;

import com.example.buysell.services.OrderServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class OrderController {
    private final OrderServiceImpl orderService;

    @Autowired
    public OrderController(OrderServiceImpl orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/orders-info/{user}")
    public String aboutOrders(Model model, @PathVariable("user") User user) {
        List<Order> orders = orderService.getOrders(user);
        model.addAttribute("user",user);
        model.addAttribute( "orders", orders);
        return "orders";
    }

    @GetMapping("/orders-info/{user}/delete/{id}")
    public String delProductFromCart(@PathVariable("user") User user, @PathVariable("id") Long productId) {
        orderService.canselOrder(productId);
        return "redirect:/orders-info/"+user.getId();
    }

}
