package com.relaxit.repository.impl;

import com.relaxit.domain.models.User;
import com.relaxit.repository.interfaces.UserRepository;
import com.relaxit.utils.EntityManagerFactorySingleton;
import jakarta.persistence.EntityManager;
import jakarta.persistence.NoResultException;

public class UserRepositoryImpl implements UserRepository {

    @Override
    public void save(User user) {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            if (user.getUserId() == null) {
                em.persist(user);
            } else {
                em.merge(user);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    @Override
    public User findByEmail(String email) {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        } finally {
            em.close();
        }
    }
}