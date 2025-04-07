package com.relaxit.repository.interfaces;

import com.relaxit.domain.models.User;

public interface UserRepository {
    void save(User user);
    User findByEmail(String email);
}