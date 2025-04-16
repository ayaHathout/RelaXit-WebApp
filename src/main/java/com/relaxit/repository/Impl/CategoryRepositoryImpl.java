package com.relaxit.repository.Impl;

import com.relaxit.domain.models.Category;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.Interfaces.CategoryRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.util.List;

public class CategoryRepositoryImpl implements CategoryRepository {
    private final EntityManager entityManager;

    public CategoryRepositoryImpl() {
        entityManager = JPAUtil.getEntityManager();
    }

    @Override
    public List<Category> getAllCategories() {
        return entityManager.createQuery("SELECT c FROM Category c ORDER BY c.name", Category.class).getResultList();
    }

    @Override
    public Category findById(Long id) {
        return entityManager.find(Category.class, id);
    }

    @Override
    public Category save(Category category) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            if (category.getCategoryId() == null) {
                entityManager.persist(category);
            } else {
                category = entityManager.merge(category);
            }
            transaction.commit();
            return category;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }

    @Override
    public void delete(Long id) {
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Category category = entityManager.find(Category.class, id);
            if (category != null) {
                entityManager.remove(category);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw e;
        }
    }
    
    @Override
    public void close() {
        entityManager.close();
    }
}