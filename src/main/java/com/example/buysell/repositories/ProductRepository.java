package com.example.buysell.repositories;

import com.example.buysell.models.Product;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;


public interface ProductRepository extends JpaRepository<Product, Long> {

    @Query(value = "SELECT * FROM products p where p.title like %:title%",nativeQuery = true)
    Page<Product> findByTitle(@Param("title") String title, Pageable pageable);

    Page<Product> findAll(Pageable pageable);

}
