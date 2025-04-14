package com.relaxit.repository.Interfaces;

import java.util.Map;

public interface StatisticsRepository {
    long getTotalUsers();
    long getTotalProducts();
    double getAvgCreditLimit();
    long getTotalStock();
    Map<String, Long> getUsersByMonth();
}