package com.example.buysell.controllers;


import com.example.buysell.models.Order;
import com.example.buysell.models.User;

import com.example.buysell.services.OrderServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class OrderController {
    private final OrderServiceImpl orderService;
    Logger logger = LoggerFactory.getLogger(OrderController.class);

    @Autowired
    public OrderController(OrderServiceImpl orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/orders-info/{user}")
    public String aboutOrders(Model model, @PathVariable("user") User user) {
        List<Order> orders = orderService.getOrders(user);
        model.addAttribute("user",user);
        model.addAttribute( "orders", orders);
        logger.info("the orders page has been opened");
        return "orders";
    }

    @GetMapping("/orders-info/{user}/delete/{id}")
    public String delProductFromCart(@PathVariable("user") User user, @PathVariable("id") Long productId) {
        orderService.canselOrder(productId);
        logger.info("order cancelled");
        return "redirect:/orders-info/"+user.getId();
    }

}
