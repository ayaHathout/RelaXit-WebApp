<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RelaXit Admin Dashboard</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        /* Ensure main content fits correctly */
        main {
            flex-grow: 1;
            padding: 20px;
          /*  background-color: #f8f9fa;
             overflow: hidden;  */
           /* min-height: 100vh;  Full viewport height */
        }
        .debug-section {
            border: 2px solid #ffc107;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #fff3cd;
        }
        body {
       /*     overflow: hidden;  Prevent body scrollbars */
        }
    </style>
</head>
<body>
    <div class="d-flex flex-column min-vh-100">
        <!-- Header -->
        <jsp:include page="partials/header.jsp"/>
        <div class="d-flex flex-grow-1">
            <!-- Sidebar -->
            <jsp:include page="partials/sidebar.jsp"/>
            <!-- Main Content -->
            <main>
                <!-- Debug -->
                <%-- <div class="debug-section">
                    <p><strong>layout.jsp Debug:</strong> contentPage = <c:out value="${requestScope.contentPage}" default="null" /></p>
                    <p><strong>layout.jsp Debug:</strong> activePage = <c:out value="${requestScope.activePage}" default="null" /></p>
                    <p><strong>layout.jsp Debug:</strong> param.contentPage = <c:out value="${param.contentPage}" default="null" /></p>
                </div> --%>
                <!-- Content -->
                <c:choose>
                    <c:when test="${not empty requestScope.contentPage}">
                        <jsp:include page="${requestScope.contentPage}"/>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning text-center">
                            No content page specified.
                        </div>
                    </c:otherwise>
                </c:choose>
            </main>
        </div>
        <!-- Footer -->
        <jsp:include page="partials/footer.jsp"/>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/assets/js/admin.js"></script>
</body>
</html>