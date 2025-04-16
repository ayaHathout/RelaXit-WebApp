package com.relaxit.repository.Interfaces;

import com.relaxit.domain.models.User;
import java.util.List;

public interface UserRepository {
    void addUser(User user); 
    void updateUser(User user);

    User findByEmail(String email);

    User findById(Long userId);
    void deleteById(Long userId);
    List<User> getAllUsers();
    boolean existsByEmail(String email);
   
    List<User> findByName(String name);
   
    boolean updateCreditLimit(Long userId, Double creditLimit);
}