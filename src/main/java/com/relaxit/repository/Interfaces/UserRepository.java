package com.relaxit.repository.Interfaces;

import com.relaxit.domain.models.User;

public interface UserRepository {

    User findById(Long id);

    boolean updateCreditLimit(Long userId, Double creditLimit);
}
