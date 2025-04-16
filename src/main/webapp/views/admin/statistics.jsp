<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container-fluid">
    <h2 class="mb-4">Dashboard Statistics</h2>

    <!-- Loading Indicator -->
    <div id="stats-loading" class="alert alert-info text-center d-none">
        Loading statistics...
    </div>

    <!-- Always show cards, even if stats is empty -->
    <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <p class="card-text display-4" id="total-users">
                        <c:out value="${stats.totalUsers != null ? stats.totalUsers : '0'}" />
                    </p>
                    <p class="zero-data" id="total-users-zero" <c:if test="${stats != null && stats.totalUsers > 0}">style="display: none;"</c:if>>No users yet.</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Total Products</h5>
                    <p class="card-text display-4" id="total-products">
                        <c:out value="${stats.totalProducts != null ? stats.totalProducts : '0'}" />
                    </p>
                    <p class="zero-data" id="total-products-zero" <c:if test="${stats != null && stats.totalProducts > 0}">style="display: none;"</c:if>>No products yet.</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Avg Credit Limit</h5>
                    <p class="card-text display-4" id="avg-credit-limit">
                        <c:choose>
                            <c:when test="${stats != null && stats.avgCreditLimit != null && stats.avgCreditLimit > 0}">
                                <fmt:formatNumber value="${stats.avgCreditLimit}" type="currency" currencySymbol="$" />
                            </c:when>
                            <c:otherwise>$0.00</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="zero-data" id="avg-credit-limit-zero" <c:if test="${stats != null && stats.avgCreditLimit > 0}">style="display: none;"</c:if>>No credit limits set.</p>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Total Stock</h5>
                    <p class="card-text display-4" id="total-stock">
                        <c:out value="${stats.totalStock != null ? stats.totalStock : '0'}" />
                    </p>
                    <p class="zero-data" id="total-stock-zero" <c:if test="${stats != null && stats.totalStock > 0}">style="display: none;"</c:if>>No stock available.</p>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Users by Registration Month</h5>
                    <div id="chart-container">
                        <canvas id="usersChart" <c:if test="${stats == null || empty stats.chartLabels}">style="display: none;"</c:if>></canvas>
                        <p class="text-center text-muted" id="no-chart-data" <c:if test="${stats != null && not empty stats.chartLabels}">style="display: none;"</c:if>>No user registration data available.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/statistics.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Initial chart data
        <c:if test="${stats != null && not empty stats.chartLabels}">
            const chartLabels = ${stats.chartLabelsJson};
            const chartData = ${stats.chartDataJson};
        </c:if>
        <c:if test="${stats == null || empty stats.chartLabels}">
            const chartLabels = [];
            const chartData = [];
        </c:if>
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/statistics.js"></script>
</div>