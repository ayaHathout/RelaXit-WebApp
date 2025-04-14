<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="container-fluid">
    <h2 class="mb-4">Dashboard Statistics</h2>

    <!-- Debug -->
    <p class="text-muted">Debug: stats = ${stats}</p>
    <p class="text-muted">Debug: totalUsers = ${stats.totalUsers}, totalProducts = ${stats.totalProducts}, chartLabels = ${stats.chartLabels}</p>

    <!-- Always show cards, even if stats is empty -->
    <div class="row">
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Total Users</h5>
                    <p class="card-text display-4">
                        <c:out value="${stats.totalUsers != null ? stats.totalUsers : '0'}" />
                    </p>
                    <c:if test="${stats == null || stats.totalUsers == 0}">
                        <p class="zero-data">No users yet.</p>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Total Products</h5>
                    <p class="card-text display-4">
                        <c:out value="${stats.totalProducts != null ? stats.totalProducts : '0'}" />
                    </p>
                    <c:if test="${stats == null || stats.totalProducts == 0}">
                        <p class="zero-data">No products yet.</p>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Avg Credit Limit</h5>
                    <p class="card-text display-4">
                        <c:choose>
                            <c:when test="${stats != null && stats.avgCreditLimit != null && stats.avgCreditLimit > 0}">
                                <fmt:formatNumber value="${stats.avgCreditLimit}" type="currency" currencySymbol="$" />
                            </c:when>
                            <c:otherwise>$0.00</c:otherwise>
                        </c:choose>
                    </p>
                    <c:if test="${stats == null || stats.avgCreditLimit == 0}">
                        <p class="zero-data">No credit limits set.</p>
                    </c:if>
                </div>
            </div>
        </div>
        <div class="col-lg-3 col-md-6 col-sm-12 mb-4">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Total Stock</h5>
                    <p class="card-text display-4">
                        <c:out value="${stats.totalStock != null ? stats.totalStock : '0'}" />
                    </p>
                    <c:if test="${stats == null || stats.totalStock == 0}">
                        <p class="zero-data">No stock available.</p>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-12">
            <div class="card stats-card">
                <div class="card-body">
                    <h5 class="card-title">Users by Registration Month</h5>
                    <c:if test="${stats == null || empty stats.chartLabels}">
                        <p class="text-center text-muted">No user registration data available.</p>
                    </c:if>
                    <c:if test="${stats != null && not empty stats.chartLabels}">
                        <canvas id="usersChart"></canvas>
                    </c:if>
                </div>
            </div>
        </div>
    </div>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/statistics.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
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