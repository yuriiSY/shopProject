package com.example.buysell.services;

import com.example.buysell.dto.CartDTO;
import com.example.buysell.models.Cart;
import com.example.buysell.models.User;

import java.util.List;

public interface CartService {
    Cart createCart(User user, List<Long> productsIds);
    void addProduct(Cart cart, List<Long> productIds);

    void deleteProduct(Long id,String user);
    CartDTO getCartByUser(String name);

    void clearCart(String name);
}
