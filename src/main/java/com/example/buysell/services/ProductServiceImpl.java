package com.example.buysell.services;

import com.example.buysell.models.Cart;
import com.example.buysell.models.Image;
import com.example.buysell.models.Product;
import com.example.buysell.models.User;
import com.example.buysell.repositories.ProductRepository;
import com.example.buysell.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;


import java.io.IOException;
import java.security.Principal;
import java.util.Collections;

@Service
@Slf4j
public class ProductServiceImpl implements ProductService {
    private final ProductRepository productRepository;
    private final UserRepository userRepository;
    private final CartService cartService;

    @Autowired
    public ProductServiceImpl(ProductRepository productRepository, UserRepository userRepository, CartService cartService) {
        this.productRepository = productRepository;
        this.userRepository = userRepository;
        this.cartService = cartService;
    }

    @Override
    public Page<Product> listProducts(String title, Pageable pageable) {
        if (title != null && !title.isEmpty()) {
            return productRepository.findByTitle(title,pageable);

        }else {
            return productRepository.findAll(pageable);
        }
    }

    @Override
    @Transactional
    public void saveOrUpdateProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        product.setUser(getUserByPrincipal(principal));
        addImageToProduct(product,file1,file2,file3);
        log.info("Saving new Product. Title: {}; Author email: {}", product.getTitle(), product.getUser().getEmail());
        Product productFromDb = productRepository.save(product);
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        productRepository.save(product);
    }

    private void addImageToProduct(Product product,MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        Image image1;
        Image image2;
        Image image3;
        if (file1.getSize() != 0) {
            image1 = toImageEntity(file1);
            if (product.getPreviewImageId() == null) {
                image1.setPreviewImage(true);
            }
            product.addImageToProduct(image1);
        }
        if (file2.getSize() != 0) {
            image2 = toImageEntity(file2);
            product.addImageToProduct(image2);
        }
        if (file3.getSize() != 0) {
            image3 = toImageEntity(file3);
            product.addImageToProduct(image3);
        }
    }
    @Override
    public void update(Product existProduct, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException {
        existProduct.setTitle(product.getTitle());
        existProduct.setPrice(product.getPrice());
        existProduct.setCity(product.getCity());
        existProduct.setDescription(product.getDescription());
        addImageToProduct(existProduct,file1,file2,file3);
        Product productFromDb = productRepository.save(existProduct);//image id
        productFromDb.setPreviewImageId(productFromDb.getImages().get(0).getId());
        log.info("Updated Product. Title: {};", product.getId());
        productRepository.save(existProduct);
    }

    @Override
    public Page<Product> findByTitleSearch(String title,Pageable pageable) {
       return productRepository.findByTitle(title,pageable);
    }

    private Image toImageEntity(MultipartFile file) throws IOException {
        Image image = new Image();
        image.setName(file.getName());
        image.setOriginalFileName(file.getOriginalFilename());
        image.setContentType(file.getContentType());
        image.setSize(file.getSize());
        image.setBytes(file.getBytes());
        return image;
    }
    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }
    @Transactional
    @Override
    public void delProductById(Long id) {
        log.info("Deleted Product with ID: {};", id);
        productRepository.deleteById(id);
    }

    @Transactional
    @Override
    public void deleteProduct(Principal principal, Long id) {
        User user = getUserByPrincipal(principal);
        Product product = productRepository.findById(id).orElse(null);
        if (product.getUser().getId().equals(user.getId())) {
                productRepository.deleteById(id);
        }
    }
    @Override
    public Product getProductById(Long id) {
        return productRepository.findById(id).orElse(null);
    }
    @Override
    public void addToUserCart(Long productId, Principal principal) {
        User user = getUserByPrincipal(principal);
        if (user == null) {
            throw new RuntimeException("User not found " + principal.getName());
        }
        Cart cart = user.getCart();
        if (cart == null) {
            Cart newCart = cartService.createCart(user, Collections.singletonList(productId));
            user.setCart(newCart);
            userRepository.save(user);
        } else {
            cartService.addProduct(cart,Collections.singletonList(productId));
        }
        log.info(" Product with ID: {} was added to Cart", productId);
    }
}
