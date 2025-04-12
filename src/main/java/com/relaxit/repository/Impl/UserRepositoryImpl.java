package com.relaxit.repository.Impl;

import com.relaxit.domain.models.User;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.Interfaces.UserRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;

public class UserRepositoryImpl implements UserRepository {
    private final EntityManager entityManager;
    private String sql;
    private Query query;

    public UserRepositoryImpl () {
        entityManager = JPAUtil.getEntityManager();
        sql = null;
        query = null;
    }
    
     @Override
    public User findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateCreditLimit(Long userId, Double newCreditLimit) {
        System.out.println("In updateCreditLimit() in UserRepositoryImpl");

        System.out.println(userId + ": " + newCreditLimit);

        EntityTransaction entityTransaction = null;
        try {
            entityTransaction = entityManager.getTransaction();
            entityTransaction.begin();

            String sql = "UPDATE User SET creditLimit = :newCreditLimit WHERE userId = :userId";
            Query query = entityManager.createQuery(sql)
                    .setParameter("newCreditLimit", newCreditLimit)
                    .setParameter("userId", userId);

            int updateCount = query.executeUpdate();
            entityTransaction.commit();
            return updateCount > 0;
        } catch (Exception e) {
            if (entityTransaction != null && entityTransaction.isActive())
                entityTransaction.rollback();

            throw new RuntimeException("Failed to update credit limit", e);
        }
    }
}
