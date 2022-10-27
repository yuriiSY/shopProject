package com.example.buysell.services;

import com.example.buysell.models.User;
import com.example.buysell.models.enums.Role;
import com.example.buysell.repositories.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Service
@Slf4j
public class UserServiceImpl implements UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public UserServiceImpl(UserRepository userRepository, PasswordEncoder passwordEncoder) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public boolean createUser(User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
        user.setActive(true);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.getRoles().add(Role.ROLE_ADMIN);
        log.info("Saving new User. ID: {}; Author email: {}", user.getId(), user.getEmail());
        userRepository.save(user);
        return true;
    }

    @Override
    public List<User> list() {
        return userRepository.findAll();
    }
    @Override
    public void banUser(Long id) {
        User user = userRepository.findById(id).orElse(null);
        if (user != null) {
            if (user.isActive()) {
                user.setActive(false);
            } else {
                user.setActive(true);
            }
        }
        log.info("Baned User with ID: {}; Author email: {}", user.getId(),user.getEmail());
        userRepository.save(user);
    }

    @Override
    public void changeUserRoles(User user, Map<String, String> form) {
        Set<String> roles = Arrays.stream(Role.values())
                .map(Role::name)
                .collect(Collectors.toSet());
        user.getRoles().clear();
        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoles().add(Role.valueOf(key));
            }
        }
        log.info("Changed role  for User id : {}; Author email: {}",user.getId(),user.getEmail());
        userRepository.save(user);
    }

    @Override
    public List<User> findActiveUsers() {
        return userRepository.findUsersByActive();
    }

    @Override
    public List<User> findEnabledUsers() {
        return userRepository.findUsersByEnabled();
    }

    @Override
    public List<User> getUsersSortAZ() {
        return userRepository.sortAZ();
    }
    @Override
    public List<User> getUsersSortZA() {return userRepository.sortZA();}
}
