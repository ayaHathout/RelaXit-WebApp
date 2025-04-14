package com.relaxit.repository.Impl;

import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.Interfaces.StatisticsRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.Query;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Logger;

public class StatisticsRepositoryImpl implements StatisticsRepository {

    private static final Logger LOGGER = Logger.getLogger(StatisticsRepositoryImpl.class.getName());
    private final EntityManager entityManager;

    public StatisticsRepositoryImpl() {
        this.entityManager = JPAUtil.getEntityManager();
        LOGGER.info("StatisticsRepositoryImpl initialized.");
    }

    @Override
    public long getTotalUsers() {
        try {
            LOGGER.info("Executing getTotalUsers query...");
            Query query = entityManager.createQuery("SELECT COUNT(u) FROM User u");
            long result = (long) query.getSingleResult();
            LOGGER.info("getTotalUsers result: " + result);
            return result;
        } catch (Exception e) {
            LOGGER.severe("Error in getTotalUsers: " + e.getMessage());
            return 0L;
        }
    }

    @Override
    public long getTotalProducts() {
        try {
            LOGGER.info("Executing getTotalProducts query...");
            Query query = entityManager.createQuery("SELECT COUNT(p) FROM Product p");
            long result = (long) query.getSingleResult();
            LOGGER.info("getTotalProducts result: " + result);
            return result;
        } catch (Exception e) {
            LOGGER.severe("Error in getTotalProducts: " + e.getMessage());
            return 0L;
        }
    }

    @Override
    public double getAvgCreditLimit() {
        try {
            LOGGER.info("Executing getAvgCreditLimit query...");
            Query query = entityManager.createQuery("SELECT AVG(u.creditLimit) FROM User u");
            Double result = (Double) query.getSingleResult();
            double avg = result != null ? result : 0.0;
            LOGGER.info("getAvgCreditLimit result: " + avg);
            return avg;
        } catch (Exception e) {
            LOGGER.severe("Error in getAvgCreditLimit: " + e.getMessage());
            return 0.0;
        }
    }

    @Override
    public long getTotalStock() {
        try {
            LOGGER.info("Executing getTotalStock query...");
            Query query = entityManager.createQuery("SELECT SUM(p.quantity) FROM Product p");
            Long result = (Long) query.getSingleResult();
            long stock = result != null ? result : 0L;
            LOGGER.info("getTotalStock result: " + stock);
            return stock;
        } catch (Exception e) {
            LOGGER.severe("Error in getTotalStock: " + e.getMessage());
            return 0L;
        }
    }

    @Override
    public Map<String, Long> getUsersByMonth() {
        try {
            LOGGER.info("Executing getUsersByMonth query...");
            Query query = entityManager.createQuery(
                "SELECT FUNCTION('DATE_FORMAT', u.createdAt, '%Y-%m'), COUNT(u) " +
                "FROM User u GROUP BY FUNCTION('DATE_FORMAT', u.createdAt, '%Y-%m')"
            );
            List<Object[]> results = query.getResultList();

            Map<String, Long> usersByMonth = new TreeMap<>();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM yyyy");
            for (Object[] row : results) {
                String yearMonth = (String) row[0]; // e.g., "2025-04"
                Long count = (Long) row[1];
                try {
                    LocalDateTime date = LocalDateTime.parse(yearMonth + "-01T00:00:00");
                    String label = date.format(formatter);
                    usersByMonth.put(label, count);
                } catch (Exception e) {
                    LOGGER.warning("Error parsing date " + yearMonth + ": " + e.getMessage());
                }
            }
            LOGGER.info("getUsersByMonth result: " + usersByMonth);
            return usersByMonth;
        } catch (Exception e) {
            LOGGER.severe("Error in getUsersByMonth: " + e.getMessage());
            return new TreeMap<>();
        }
    }
}