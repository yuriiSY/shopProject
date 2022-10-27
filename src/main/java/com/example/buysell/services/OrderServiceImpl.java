package com.example.buysell.services;

import com.example.buysell.dto.CartDTO;
import com.example.buysell.models.Cart;
import com.example.buysell.models.Order;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.OrderRepository;
import com.example.buysell.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;


@Service
@Slf4j
public class OrderServiceImpl implements OrderService {
    private final UserRepository userRepository;
    private final OrderRepository orderRepository;
    private final CartServiceImpl cartService;
    @Autowired
    public OrderServiceImpl(UserRepository userRepository, OrderRepository orderRepository,CartServiceImpl cartService) {
        this.userRepository = userRepository;
        this.orderRepository = orderRepository;
        this.cartService=cartService;
    }
    @Override
    public void createOrderFromCart(Principal principal) {
        Order order = new Order();
        User user = userRepository.findByEmail(principal.getName());
        Cart cart = user.getCart();
        CartDTO cartDTO = cartService.getCartByUser(principal.getName());
        List<Product> products = new ArrayList<>(cart.getProducts());
        order.setTotalPrice(cartDTO.getSum());
        order.setProducts(products);
        order.setUser(user);
        cartService.clearCart(principal.getName());
        log.info("Created Order id: {} for User id: {}", order.getId(),user.getId());
        orderRepository.save(order);
    }

    @Override
    public List<Order> getOrders(User user) {
        return user.getOrders();
    }

    @Override
    public void updateOrderStatus(Long id) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order != null) {
            if (order.isStatus()) {
                order.setStatus(false);
            } else {
                order.setStatus(true);
            }
        }
        orderRepository.save(order);
    }
    @Override
    public void canselOrder(Long id) {
        Order order = orderRepository.getById(id);
        if (!order.isStatus()) {
            log.info("Order id: {} deleted",order.getId());
            orderRepository.delete(order);
        }
    }
}
