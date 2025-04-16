package com.relaxit.repository.Impl;

import com.relaxit.domain.utils.TransactionUtils;
import com.relaxit.repository.Interfaces.StatisticsRepository;
import com.relaxit.utils.EntityManagerFactorySingleton;
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

    public StatisticsRepositoryImpl() {
        LOGGER.info("StatisticsRepositoryImpl initialized.");
    }

    @Override
    public long getTotalUsers() {
        long[] result = new long[1];
        TransactionUtils.executeInTransaction(em -> {
            try {
                LOGGER.info("Executing getTotalUsers query...");
                Query query = em.createQuery("SELECT COUNT(u) FROM User u");
                result[0] = (long) query.getSingleResult();
                LOGGER.info("getTotalUsers result: " + result[0]);
            } catch (Exception e) {
                LOGGER.severe("Error in getTotalUsers: " + e.getMessage());
                result[0] = 0L;
                throw e;
            }
        });
        return result[0];
    }

    @Override
    public long getTotalProducts() {
        long[] result = new long[1];
        TransactionUtils.executeInTransaction(em -> {
            try {
                LOGGER.info("Executing getTotalProducts query...");
                Query query = em.createQuery("SELECT COUNT(p) FROM Product p");
                result[0] = (long) query.getSingleResult();
                LOGGER.info("getTotalProducts result: " + result[0]);
            } catch (Exception e) {
                LOGGER.severe("Error in getTotalProducts: " + e.getMessage());
                result[0] = 0L;
                throw e;
            }
        });
        return result[0];
    }

    @Override
    public double getAvgCreditLimit() {
        double[] result = new double[1];
        TransactionUtils.executeInTransaction(em -> {
            try {
                LOGGER.info("Executing getAvgCreditLimit query...");
                Query query = em.createQuery("SELECT AVG(u.creditLimit) FROM User u");
                Double avg = (Double) query.getSingleResult();
                result[0] = avg != null ? avg : 0.0;
                LOGGER.info("getAvgCreditLimit result: " + result[0]);
            } catch (Exception e) {
                LOGGER.severe("Error in getAvgCreditLimit: " + e.getMessage());
                result[0] = 0.0;
                throw e;
            }
        });
        return result[0];
    }

    @Override
    public long getTotalStock() {
        long[] result = new long[1];
        TransactionUtils.executeInTransaction(em -> {
            try {
                LOGGER.info("Executing getTotalStock query...");
                Query query = em.createQuery("SELECT SUM(p.quantity) FROM Product p");
                Long stock = (Long) query.getSingleResult();
                result[0] = stock != null ? stock : 0L;
                LOGGER.info("getTotalStock result: " + result[0]);
            } catch (Exception e) {
                LOGGER.severe("Error in getTotalStock: " + e.getMessage());
                result[0] = 0L;
                throw e;
            }
        });
        return result[0];
    }

    @Override
    public Map<String, Long> getUsersByMonth() {
        Map<String, Long>[] result = new Map[]{new TreeMap<>()};
        TransactionUtils.executeInTransaction(em -> {
            try {
                LOGGER.info("Executing getUsersByMonth query...");
                Query query = em.createQuery(
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
                result[0] = usersByMonth;
                LOGGER.info("getUsersByMonth result: " + usersByMonth);
            } catch (Exception e) {
                LOGGER.severe("Error in getUsersByMonth: " + e.getMessage());
                result[0] = new TreeMap<>();
                throw e;
            }
        });
        return result[0];
    }
}