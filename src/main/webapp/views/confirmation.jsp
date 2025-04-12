<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
    <head>
        <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    </head>
    <body>
        <c:choose>
            <c:when test="${message == 'Successful purchasing!'}">
                <div class="alert alert-success" role="alert">${message}</div>
                <jsp:include page="thankyou.jsp"/>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger" role="alert">${message}</div>
                <jsp:include page="cart.jsp"/>
            </c:otherwise>
        </c:choose>
    </body>
</html>