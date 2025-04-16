<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="sidebar bg-dark text-white">
    <div class="sidebar-sticky pt-3">
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link text-white statistics-link ${activePage == 'statistics' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/statistics">
                    <i class="fas fa-chart-bar me-2"></i> Statistics
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${activePage == 'users' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users me-2"></i> Users
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white ${activePage == 'products' ? 'active' : ''}" 
                   href="${pageContext.request.contextPath}/admin/products">
                    <i class="fas fa-box me-2"></i> Products
                </a>
            </li>
            <li class="nav-item mt-auto">
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </a>
            </li>
        </ul>
    </div>
</nav>