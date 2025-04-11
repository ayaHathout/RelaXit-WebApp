package com.relaxit.domain.utils;

import jakarta.persistence.EntityManager;
import com.relaxit.utils.EntityManagerFactorySingleton;

import java.util.function.Consumer;

public class TransactionUtils {

    public static void executeInTransaction(Consumer<EntityManager> action) {
        EntityManager em = EntityManagerFactorySingleton.getEntityManagerFactory().createEntityManager();
        try {
            em.getTransaction().begin();
            action.accept(em);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
}