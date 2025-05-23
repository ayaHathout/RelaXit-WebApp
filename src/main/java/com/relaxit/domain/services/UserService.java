package com.relaxit.domain.services;

import com.relaxit.domain.enums.UserRole;
import com.relaxit.domain.models.User;
import com.relaxit.repository.Impl.UserRepositoryImpl;
import com.relaxit.repository.Interfaces.UserRepository;
import org.mindrot.jbcrypt.BCrypt;

import java.util.List;

public class UserService {

    private final UserRepository userRepository;

    

    public UserService(UserRepository userRepository) {
        if (userRepository == null) {
            throw new IllegalArgumentException("UserRepository cannot be null!");
        }
        this.userRepository = userRepository;
    }

    public UserService () {
        userRepository = new UserRepositoryImpl();
    }

    public void registerUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null!");
        }
        if (user.getPassword() == null || user.getPassword().isEmpty()) {
            user.setPassword("");
        } else {
            user.setPassword(BCrypt.hashpw(user.getPassword(), BCrypt.gensalt()));
        }
        validateRequiredFields(user);
        if (user.getRole() == null) {
            user.setRole(UserRole.USER);
        }
        userRepository.addUser(user);
    }

    public User loginUser(String email, String password) {
        if (email == null || password == null) {
            throw new IllegalArgumentException("Email and password cannot be null!");
        }
        User user = userRepository.findByEmail(email);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            return user;
        }
        return null;
    }

    public User getUserById(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("User ID cannot be null!");
        }
        return userRepository.findById(userId);
    }

    public User getUserByEmail(String email) {
        if (email == null) {
            throw new IllegalArgumentException("Email cannot be null!");
        }
        return userRepository.findByEmail(email);
    }

    public void updateUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null!");
        }
        User existingUser = userRepository.findById(user.getUserId());
        if (existingUser == null) {
            throw new IllegalArgumentException("User not found!");
        }
        validateRequiredFields(user); // Apply the same validations as during registration
        userRepository.updateUser(user);
    }

   

    public Double getCreditLimitByUserId (Long id) {
        User curUser = userRepository.findById(id);
        return curUser.getCreditLimit();
    }

    public boolean updateCreditLimit (Long userId, Double creditLimit) {
        return userRepository.updateCreditLimit(userId, creditLimit);
    }
    

    public void deleteUser(Long userId) {
        if (userId == null) {
            throw new IllegalArgumentException("User ID cannot be null!");
        }

        User user = userRepository.findById(userId);
        if (user == null) {
            throw new IllegalArgumentException("User with ID " + userId + " not found to delete!");
        }
        userRepository.deleteById(userId);
    }

    public List<User> getAllUsers() {
        return userRepository.getAllUsers();
    }

    public List<User> searchUsersByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return getAllUsers();
        }
        return userRepository.findByName(name);
    }

    public boolean emailExists(String email) {
        if (email == null) {
            throw new IllegalArgumentException("Email cannot be null!");
        }
        return userRepository.existsByEmail(email);
    }

    private void validateRequiredFields(User user) {
        if (user.getEmail() == null || user.getEmail().isEmpty()) {
            throw new IllegalArgumentException("Email is required!");
        }
        if (!user.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            throw new IllegalArgumentException("Invalid email format!");
        }
       
        if (user.getFullName() == null || user.getFullName().isEmpty()) {
            throw new IllegalArgumentException("Full name is required!");
        }
        if (user.getBirthdate() == null) {
            throw new IllegalArgumentException("Birthdate is required!");
        }
        if (user.getJob() == null || user.getJob().isEmpty()) {
            throw new IllegalArgumentException("Job is required!");
        }
        if (user.getAddress() == null || user.getAddress().isEmpty()) {
            throw new IllegalArgumentException("Address is required!");
        }
        if (user.getCreditLimit() == null) {
            throw new IllegalArgumentException("Credit Limit is required!");
        }
        if (user.getCreditLimit() > 100000) {
            throw new IllegalArgumentException("Credit Limit cannot exceed $100,000!");
        }
    }
}