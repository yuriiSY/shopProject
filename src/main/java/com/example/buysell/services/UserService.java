package com.example.buysell.services;

import com.example.buysell.models.User;

import java.util.List;
import java.util.Map;

public interface UserService {

    boolean createUser(User user);
    List<User> list();
    void banUser(Long id);
    void changeUserRoles(User user, Map<String, String> form);
    List<User> findActiveUsers();
    List<User> findEnabledUsers();

    List<User> getUsersSortAZ();

    List<User> getUsersSortZA();
}
