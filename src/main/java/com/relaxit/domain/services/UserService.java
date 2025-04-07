package com.relaxit.domain.services;

import com.relaxit.domain.enums.UserRole;
import com.relaxit.domain.models.User;
import com.relaxit.repository.impl.UserRepositoryImpl;
import com.relaxit.repository.interfaces.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

import java.time.LocalDateTime;

public class UserService {

    private final UserRepository userRepository;

    public UserService() {
        this.userRepository = new UserRepositoryImpl();
    }

    public void registerUser(User user) {
        String plainPassword = user.getPassword();
        String hashedPassword = BCrypt.hashpw(plainPassword, BCrypt.gensalt());
        System.out.println("Before hash: " + plainPassword + " | After hash: " + hashedPassword);
        user.setPassword(hashedPassword);
        user.setRole(UserRole.USER);
        user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        userRepository.save(user);
    }

    public User loginUser(String email, String password) {
        User user = userRepository.findByEmail(email);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }
}