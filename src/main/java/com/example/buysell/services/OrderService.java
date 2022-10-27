package com.example.buysell.services;

import com.example.buysell.models.Order;
import com.example.buysell.models.User;

import java.security.Principal;
import java.util.List;

public interface OrderService {
    void createOrderFromCart(Principal principal);

    List<Order> getOrders(User user);

    void updateOrderStatus(Long id);

    void canselOrder(Long id);
}
