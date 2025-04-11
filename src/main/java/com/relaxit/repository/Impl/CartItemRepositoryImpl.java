package com.relaxit.repository.Impl;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.Interfaces.CartItemRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.math.BigDecimal;
import java.util.List;

public class CartItemRepositoryImpl implements CartItemRepository {
    private final EntityManager em;

    public CartItemRepositoryImpl () {
        em = JPAUtil.getEntityManager();
    }

    @Override
    public CartItem findById(Long id) {
        return em.find(CartItem.class, id);
    }

    @Override
    public List<CartItem> findByUserId(Long userId) {
        TypedQuery<CartItem> query = em.createQuery(
                "SELECT ci FROM CartItem ci JOIN FETCH ci.product WHERE ci.user.userId = :userId",
                CartItem.class);
        query.setParameter("userId", userId);
        return query.getResultList();
    }

    @Override
    public List<CartItem> findByUserIdAndProductId(Long userId, Long productId) {
        TypedQuery<CartItem> query = em.createQuery(
                "SELECT ci FROM CartItem ci WHERE ci.user.userId = :userId AND ci.product.productId = :productId",
                CartItem.class);
        query.setParameter("userId", userId);
        query.setParameter("productId", productId);
        return query.getResultList();
    }

    @Override
    public void save(CartItem cartItem) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(cartItem);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public void update(CartItem cartItem) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(cartItem);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public void delete(CartItem cartItem) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            if (!em.contains(cartItem)) {
                cartItem = em.merge(cartItem);
            }
            em.remove(cartItem);
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public void deleteById(Long id) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            CartItem cartItem = em.find(CartItem.class, id);
            if (cartItem != null) {
                em.remove(cartItem);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public void deleteByUserIdAndProductId(Long userId, Long productId) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.createQuery(
                "DELETE FROM CartItem ci WHERE ci.user.userId = :userId AND ci.product.productId = :productId")
                .setParameter("userId", userId)
                .setParameter("productId", productId)
                .executeUpdate();
                trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public void deleteByUserId(Long userId) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.createQuery("DELETE FROM CartItem ci WHERE ci.user.userId = :userId")
                .setParameter("userId", userId)
                .executeUpdate();
                trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public Long countItemsByUserId(Long userId) {
        return em.createQuery(
                "SELECT SUM(ci.quantity) FROM CartItem ci WHERE ci.user.userId = :userId", Long.class)
                .setParameter("userId", userId)
                .getSingleResult();
    }

    @Override
    public BigDecimal calculateTotalByUserId(Long userId) {
        return em.createQuery(
                "SELECT SUM(p.price * ci.quantity) FROM CartItem ci JOIN ci.product p WHERE ci.user.userId = :userId",
                        BigDecimal.class)
                .setParameter("userId", userId)
                .getSingleResult();
    }

    @Override
    public void close() {
        em.close();
    }
}
