package com.relaxit.domain.services;

import com.relaxit.domain.models.User;
import com.relaxit.repository.Impl.UserRepositoryImpl;
import com.relaxit.repository.Interfaces.UserRepository;

public class UserService {
    private UserRepository userRepository;

    public UserService () {
        userRepository = new UserRepositoryImpl();
    }

    public Double getCreditLimitByUserId (Long id) {
        User curUser = userRepository.findById(id);
        return curUser.getCreditLimit();
    }

    public boolean updateCreditLimit (Long userId, Double creditLimit) {
        return userRepository.updateCreditLimit(userId, creditLimit);
    }
}
