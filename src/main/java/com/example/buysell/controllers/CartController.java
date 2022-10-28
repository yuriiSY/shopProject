package com.example.buysell.controllers;

import com.example.buysell.dto.CartDTO;
import com.example.buysell.services.CartServiceImpl;
import com.example.buysell.services.OrderServiceImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;

@Controller
public class CartController {
    private final CartServiceImpl cartService;
    private final OrderServiceImpl orderService;

    Logger logger = LoggerFactory.getLogger(CartController.class);
    @Autowired
    public CartController(CartServiceImpl cartService, OrderServiceImpl orderService) {
        this.cartService = cartService;
        this.orderService = orderService;
    }

    @GetMapping("/cart")
    public String aboutBucket(Model model, Principal principal) {
        if (principal==null) {
            model.addAttribute("cart", new CartDTO());
        } else {
            CartDTO cartDTO = cartService.getCartByUser(principal.getName());
            model.addAttribute( "cart",cartDTO);
        }
        logger.info("cart page has been opened");
        return "cart";
    }

    @GetMapping("/cart/order")
    public String addProductToOrder(Principal principal,Model model) {
        if(principal==null) {
            return "redirect:/";
        }
        orderService.createOrderFromCart(principal);
        logger.info("new order created");
        return "redirect:/";
    }

    @GetMapping("/cart/delete/{id}")
    public String delProductFromCart(@PathVariable("id") Long productId,Principal principal) {
        cartService.deleteProduct(productId,principal.getName());
        logger.info("the product has been removed from the cart");
        return "redirect:/cart";
    }

    @PostMapping("/cart/clear")
    public String clearCart(Principal principal) {
        cartService.clearCart(principal.getName());
        logger.info("shopping cart empty");
        return "redirect:/";
    }


}
