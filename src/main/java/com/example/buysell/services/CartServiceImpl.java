package com.example.buysell.services;

import com.example.buysell.dto.CartDTO;
import com.example.buysell.dto.CartDetailDTO;
import com.example.buysell.models.*;
import com.example.buysell.repositories.CartRepository;
import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
@Slf4j
public class CartServiceImpl implements CartService {
    private final CartRepository cartRepository;
    private final ProductRepository productRepository;
    private final UserRepository userRepository;

    @Autowired
    public CartServiceImpl(CartRepository cartRepository, ProductRepository productRepository, UserRepository userRepository) {
        this.cartRepository = cartRepository;
        this.productRepository = productRepository;
        this.userRepository = userRepository;
    }

    @Override
    @Transactional
    public Cart createCart(User user, List<Long> productsIds) {
        Cart cart = new Cart();
        cart.setUser(user);
        List<Product> productList = getCollectProductsById(productsIds);
        cart.setProducts(productList);
        log.info("Cart with ID: {} created for user {} ", cart.getId() ,user.getId());
        return cartRepository.save(cart);
    }

    private List<Product> getCollectProductsById(List<Long> productsIds) {
        return productsIds.stream()
                .map(productRepository::getOne)
                .collect(Collectors.toList());
    }

    @Override
    public void addProduct(Cart cart, List<Long> productIds) {
        List<Product> products = cart.getProducts();
        List<Product> newProductList = products == null ? new ArrayList<>() : new ArrayList<>(products);
        newProductList.addAll(getCollectProductsById(productIds));
        cart.setProducts(newProductList);
        cartRepository.save(cart);
    }
    @Override
    public void deleteProduct(Long id,String name) {
        Cart cart = getCart(name);
        cart.getProducts().remove(productRepository.getOne(id));
        if (cart.getProducts().isEmpty()) {
            clearCart(name);
        }
        log.info("Product with ID: {} was deleted from Cart: {} ", id , cart.getId());
        cartRepository.save(cart);
    }
    private Cart getCart(String name) {
        User user = userRepository.findByEmail(name);
        return user.getCart();
    }

    @Override
    public CartDTO getCartByUser(String name) {
        User user = userRepository.findByEmail(name);
        if (user == null || user.getCart()==null) {
            return new CartDTO();
        }
        CartDTO cartDTO = new CartDTO();
        Map<Long , CartDetailDTO> mapProductId = new HashMap<>();
        List<Product> products = user.getCart().getProducts();
        for (Product product : products) {
            CartDetailDTO detail = mapProductId.get(product.getId());
            if (detail == null) {
                mapProductId.put(product.getId(),new CartDetailDTO(product));
            } else {
                detail.setAmount(detail.getAmount()+1);
                detail.setSum(detail.getSum() + product.getPrice());
            }
        }
        cartDTO.setCartDetails(new ArrayList<>(mapProductId.values()));
        cartDTO.aggregate();
        return cartDTO;
    }

    @Override
    public void clearCart(String name) {
        Cart cart = getCart(name);
        User user = cart.getUser();
        user.setCart(null);
        log.info("Cart with ID: {} was cleaned", cart.getId());
        cartRepository.delete(cart);
    }
}
