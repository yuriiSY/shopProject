package com.example.buysell.services;

import com.example.buysell.models.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.security.Principal;

public interface ProductService {
    void addToUserCart(Long productId, Principal principal);

    @Transactional
    void delProductById(Long id);

    void deleteProduct(Principal principal, Long id);

    Product getProductById(Long id);

    Page<Product> listProducts(String title, Pageable pageable);

    void saveOrUpdateProduct(Principal principal, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException;

    void update(Product existProduct, Product product, MultipartFile file1, MultipartFile file2, MultipartFile file3) throws IOException;

    Page<Product> findByTitleSearch(String title, Pageable pageable);

}
