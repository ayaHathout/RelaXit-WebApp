package com.relaxit.repository.impl;

import com.relaxit.domain.models.User;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.interfaces.*;
import jakarta.persistence.EntityManager;

public class UserRepositoryImpl implements UserRepository {
    
     @Override
    public User findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();

        }
    }
}
