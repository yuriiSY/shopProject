package com.example.buysell.repositories;

import com.example.buysell.models.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByEmail(String email);
    @Query(value = "SELECT * FROM users u where u.active = true",nativeQuery = true)
    List<User> findUsersByActive();
    @Query(value = "SELECT * FROM users u where u.active = false",nativeQuery = true)
    List<User> findUsersByEnabled();

    @Query(value = "SELECT * FROM users u order by u.name asc",nativeQuery = true)
    List<User> sortAZ();
    @Query(value = "SELECT * FROM users u order by u.name desc",nativeQuery = true)
    List<User> sortZA();
}
