<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Thanks Page</title>

		 <!-- Bootstrap CSS -->
		 <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
		 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		 <link href="<c:url value='/assets/css/first.css'/>" rel="stylesheet">
 
		 <link href="<c:url value='/assets/css/shop.css'/>" rel="stylesheet" type="text/css">
		 <link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet" type="text/css">
		 <link href="<c:url value='/assets/css/aos.css'/>" rel="stylesheet">
 
		 <!-- material-design-iconic-font css -->
		 <link href="<c:url value='/assets/css/material-design-iconic-font.css'/>" rel="stylesheet">
		 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-design-iconic-font@2.2.0/dist/css/material-design-iconic-font.min.css">
		 <link rel="stylesheet" href="<c:url value='/assets/css/default.css'/>">
	</head>

	<body>
<!-- Include the header with custom parameters -->
<jsp:include page="header.jsp">
    <jsp:param name="activePage" value="cart" />
    <jsp:param name="heroTitle" value="Cart" />
</jsp:include>

<div class="untree_co-section">
	<div class="container">
		<div class="row">
			<div class="col-md-12 text-center pt-5">
				<span class="display-3 thankyou-icon text-primary">
					<svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-cart-check mb-5" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
						<path fill-rule="evenodd" d="M11.354 5.646a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L8 8.293l2.646-2.647a.5.5 0 0 1 .708 0z"/>
						<path fill-rule="evenodd" d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .491.592l-1.5 8A.5.5 0 0 1 13 12H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l1.313 7h8.17l1.313-7H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 0 0 2 1 1 0 0 0 0-2zm7 0a1 1 0 1 0 0 2 1 1 0 0 0 0-2z"/>
					</svg>
				</span>
				<h2 class="display-3 text-black">Thank you!</h2>
				<p class="lead mb-5">
					<c:choose>
						<c:when test="${not empty sessionScope.confirmationMessage}">
							${sessionScope.confirmationMessage}
						</c:when>
						<c:otherwise>
							Your order was successfully completed.
						</c:otherwise>
					</c:choose>
				</p>
				<p><a href="/relaxit/shop" class="btn btn-sm btn-outline-black">Back to shop</a></p>
			</div>
		</div>
	</div>
</div>



<!-- Include the footer -->
<jsp:include page="footer.jsp" />



		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/tiny-slider.js"></script>
		<script src="../assets/js/custom.js"></script>

        <!-- jquery latest version -->
		<script src="../assets/js/jquery-3.6.0.min.js"></script>
		<!-- jquery.meanmenu js -->
		<script src="../assets/js/jquery.meanmenu.js"></script>
		<!-- slick.min js -->
		<script src="../assets/js/slick.min.js"></script>
		<!-- jquery.treeview js -->
		<script src="../assets/js/jquery.treeview.js"></script>
		<!-- jquery-ui js -->
		<script src="../assets/js/jquery-ui.min.js"></script>
		<!-- jquery.nicescroll.min js -->
		<script src="../assets/js/jquery.nicescroll.min.js"></script>
		<!-- wow js -->
		<script src="../assets/js/wow.min.js"></script>
		<!-- plugins js -->
		<script src="../assets/js/plugins.js"></script>
		<!-- main js -->
		<script src="../assets/js/main.min.js"></script>
		<script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
	</body>
</html>
