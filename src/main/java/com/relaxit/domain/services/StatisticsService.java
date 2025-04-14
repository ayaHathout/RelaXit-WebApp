package com.relaxit.domain.services;

import com.relaxit.domain.models.Statistics;
import com.relaxit.repository.Interfaces.StatisticsRepository;
import com.relaxit.repository.Impl.StatisticsRepositoryImpl;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

public class StatisticsService {

    private static final Logger LOGGER = Logger.getLogger(StatisticsService.class.getName());
    private final StatisticsRepository statisticsRepository;

    public StatisticsService() {
        this.statisticsRepository = new StatisticsRepositoryImpl();
        LOGGER.info("StatisticsService initialized.");
    }
    public StatisticsService(StatisticsRepository statisticsRepository) {
        this.statisticsRepository = statisticsRepository;
        LOGGER.info("StatisticsService initialized with custom repository.");
    }

    public Statistics getStatistics() {
        try {
            LOGGER.info("Fetching statistics...");
            long totalUsers = statisticsRepository.getTotalUsers();
            long totalProducts = statisticsRepository.getTotalProducts();
            double avgCreditLimit = statisticsRepository.getAvgCreditLimit();
            long totalStock = statisticsRepository.getTotalStock();
            Map<String, Long> usersByMonth = statisticsRepository.getUsersByMonth();

            List<String> chartLabels = new ArrayList<>(usersByMonth.keySet());
            List<Long> chartData = new ArrayList<>(usersByMonth.values());

            Statistics stats = new Statistics(totalUsers, totalProducts, avgCreditLimit, totalStock, chartLabels, chartData);
            LOGGER.info("Statistics fetched: totalUsers=" + totalUsers +
                        ", totalProducts=" + totalProducts +
                        ", avgCreditLimit=" + avgCreditLimit +
                        ", totalStock=" + totalStock +
                        ", chartLabels=" + chartLabels +
                        ", chartData=" + chartData);
            return stats;
        } catch (Exception e) {
            LOGGER.severe("Error fetching statistics: " + e.getMessage());
            return new Statistics(0L, 0L, 0.0, 0L, new ArrayList<>(), new ArrayList<>());
        }
    }
}