<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container-fluid">
    <h2 class="mb-4">Users Management</h2>
    <div class="card p-4 mb-4 shadow-sm">
        <!-- Search Form -->
       <form id="searchForm" class="mb-4">
    <div class="input-group">
        <input type="text" name="search" id="searchInput" class="form-control" placeholder="Search by name" value="${param.search}">
        <button type="button" id="clearButton" class="btn btn-outline-secondary" disabled><i class="bi bi-x-lg"></i></button>
        <button type="submit" class="btn btn-primary"><i class="bi bi-search"></i></button>
    </div>
</form>
        <!-- Feedback Area -->
        <div id="feedback" class="alert alert-info text-center d-none" role="alert">
            Loading...
        </div>
        <!-- Users Table -->
        <div class="table-responsive">
            <table class="table table-hover table-bordered">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Job</th>
                        <th>Birthdate</th>
                        <th>Credit Limit</th>
                        <th>Address</th>
                    </tr>
                </thead>
                <tbody id="usersTableBody">
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>${user.job}</td>
                            <td>${user.birthdate}</td>
                            <td>${user.creditLimit}</td>
                            <td>${user.address}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="8" class="text-center">No users found.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>