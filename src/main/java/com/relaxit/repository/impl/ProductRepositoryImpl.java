package com.relaxit.repository.impl;

import com.relaxit.domain.models.Product;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.interfaces.ProductRepository;

import jakarta.persistence.EntityManager;

public class ProductRepositoryImpl implements ProductRepository{
    
     @Override
    public Product findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

}
