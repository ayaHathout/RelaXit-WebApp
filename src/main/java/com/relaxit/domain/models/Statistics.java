package com.relaxit.domain.models;

import com.fasterxml.jackson.annotation.JsonGetter;
import java.util.List;

public class Statistics {
    private long totalUsers;
    private long totalProducts;
    private double avgCreditLimit;
    private long totalStock;
    private List<String> chartLabels;
    private List<Long> chartData;

    // Default constructor
    public Statistics() {
    }

    public Statistics(long totalUsers, long totalProducts, double avgCreditLimit, long totalStock,
            List<String> chartLabels, List<Long> chartData) {
        this.totalUsers = totalUsers;
        this.totalProducts = totalProducts;
        this.avgCreditLimit = avgCreditLimit;
        this.totalStock = totalStock;
        this.chartLabels = chartLabels;
        this.chartData = chartData;
    }

    // Getters and Setters
    public long getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(long totalUsers) {
        this.totalUsers = totalUsers;
    }

    public long getTotalProducts() {
        return totalProducts;
    }

    public void setTotalProducts(long totalProducts) {
        this.totalProducts = totalProducts;
    }

    public double getAvgCreditLimit() {
        return avgCreditLimit;
    }

    public void setAvgCreditLimit(double avgCreditLimit) {
        this.avgCreditLimit = avgCreditLimit;
    }

    public long getTotalStock() {
        return totalStock;
    }

    public void setTotalStock(long totalStock) {
        this.totalStock = totalStock;
    }

    public List<String> getChartLabels() {
        return chartLabels;
    }

    public void setChartLabels(List<String> chartLabels) {
        this.chartLabels = chartLabels;
    }

    public List<Long> getChartData() {
        return chartData;
    }

    public void setChartData(List<Long> chartData) {
        this.chartData = chartData;
    }

    // For JSP JSON rendering (used in statistics.jsp)
    @JsonGetter("chartLabelsJson")
    public String getChartLabelsJson() {
        return new com.google.gson.Gson().toJson(chartLabels);
    }

    @JsonGetter("chartDataJson")
    public String getChartDataJson() {
        return new com.google.gson.Gson().toJson(chartData);
    }
}