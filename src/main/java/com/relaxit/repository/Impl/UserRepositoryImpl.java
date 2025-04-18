package com.relaxit.repository.Impl;

import com.relaxit.domain.models.User;
import com.relaxit.repository.Interfaces.UserRepository;
import com.relaxit.utils.EntityManagerFactorySingleton;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.domain.utils.TransactionUtils; 
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;


import java.time.LocalDateTime;
import java.util.List;

public class UserRepositoryImpl implements UserRepository {

    private EntityManager entityManager;
    // private String sql;
    // private Query query;

    public UserRepositoryImpl() {
        entityManager = JPAUtil.getEntityManager();
    }

    @Override
    public void addUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null!");
        }
        TransactionUtils.executeInTransaction(em -> {
            if (existsByEmail(user.getEmail())) {
                throw new IllegalArgumentException("User with this email already exists!");
            }
            em.persist(user);
        });
    }

    @Override
    public void updateUser(User user) {
        if (user == null) {
            throw new IllegalArgumentException("User cannot be null!");
        }
        TransactionUtils.executeInTransaction(em -> {
            User existingUser = em.find(User.class, user.getUserId());
            if (existingUser == null) {
                throw new IllegalArgumentException("User not found!");
            }
            if (user.getEmail() != null && !user.getEmail().equals(existingUser.getEmail())) {
                throw new IllegalArgumentException("Email cannot be changed!");
            }
            if (user.getPassword() != null && !user.getPassword().equals(existingUser.getPassword())) {
                existingUser.setPassword(user.getPassword());
            }
            if (user.getFullName() != null && !user.getFullName().equals(existingUser.getFullName())) {
                existingUser.setFullName(user.getFullName());
            }
            if (user.getBirthdate() != null && !user.getBirthdate().equals(existingUser.getBirthdate())) {
                existingUser.setBirthdate(user.getBirthdate());
            }
            if (user.getJob() != null && !user.getJob().equals(existingUser.getJob())) {
                existingUser.setJob(user.getJob());
            }
            if (user.getAddress() != null && !user.getAddress().equals(existingUser.getAddress())) {
                existingUser.setAddress(user.getAddress());
            }
            if (user.getInterests() != null && !user.getInterests().equals(existingUser.getInterests())) {
                existingUser.setInterests(user.getInterests());
            }
            if (user.getProfileImage() != null && !user.getProfileImage().equals(existingUser.getProfileImage())) {
                existingUser.setProfileImage(user.getProfileImage());
            }
            if (user.getRole() != null && !user.getRole().equals(existingUser.getRole())) {
                existingUser.setRole(user.getRole());
            }
            if (user.getCreditLimit() != null && !user.getCreditLimit().equals(existingUser.getCreditLimit())) {
                existingUser.setCreditLimit(user.getCreditLimit());
            }
            // Update the updatedAt timestamp
            existingUser.setUpdatedAt(LocalDateTime.now());
            em.merge(existingUser);
        });
    }

    @Override
    public void deleteById(Long userId) {
        TransactionUtils.executeInTransaction(em -> {
            User user = em.find(User.class, userId);
            if (user == null) {
                throw new IllegalArgumentException("User with ID " + userId + " not found!");
            }
            em.remove(user);
        });
    }

    @Override
    public List<User> getAllUsers() {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u", User.class).getResultList();
        } finally {
            em.close();
        }
    }

    @Override
    public boolean existsByEmail(String email) {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            Long count = (Long) em.createQuery("SELECT COUNT(u) FROM User u WHERE u.email = :email")
                    .setParameter("email", email)
                    .getSingleResult();
            return count > 0;
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

    @Override
    public User findById(Long userId) {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            return em.find(User.class, userId);
        } finally {
            em.close();
        }
    }

    @Override
    public List<User> findByName(String name) {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            return em.createQuery("SELECT u FROM User u WHERE u.fullName LIKE :name", User.class)
                    .setParameter("name", "%" + name + "%")
                    .getResultList();
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