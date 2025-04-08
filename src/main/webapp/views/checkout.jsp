<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Checkout Page</title>
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
    <jsp:param name="activePage" value="checkout" />
    <jsp:param name="heroTitle" value="Checkout" />
</jsp:include>
		<!-- Checkout -->
		<div class="cart-con checkout-con position-relative">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-12">
						<div class="product-detail-box">
							<form id="contactpage" method="post" class="position-relative">
								<div class="upper-form" data-aos="fade-up">
									<span class="address">Billing Address:</span>
									<div class="form-group input1 float-left">
										<label for="fname">First name</label>
										<input type="text" class="form_style" name="fname" id="fname">
									</div>
									<div class="form-group float-left">
										<label for="lname">Last name</label>
										<input type="text" class="form_style" name="lname" id="lname">
									</div>
									<div class="form-group input1 float-left">
										<label for="email">Email address</label>
										<input type="email" class="form_style" name="email" id="email">
									</div>
									<div class="form-group float-left">
										<label>State</label>
										<select class="form-control" required="">
											<option value="" disabled="" selected="" hidden="">Select State</option>
											<option value="California">California</option>
											<option value="Texas">Texas</option>
											<option value="Florida">Florida</option>
										</select>
									</div>
									<div class="form-group input1 float-left">
										<label>City</label>
										<select class="form-control" required="">
											<option value="" disabled="" selected="" hidden="">Select City</option>
											<option value="Los Angeles">Los Angeles</option>
											<option value="San Francisco">San Francisco</option>
											<option value="San Diego">San Diego</option>
										</select>
									</div>
									<div class="form-group float-left">
										<label for="code">Zip/ postal code</label>
										<input type="text" class="form_style" name="code" id="code">
									</div>
								</div>
								<div class="lower-form" data-aos="fade-up">
									<span class="address">Payment Method:</span>
									<div class="form-group float-left checkbox">
										<input type="checkbox" id="card">
										<label for="card">Credit card</label>
										<img src="../assets/img/checkout-cardimage.png" alt="image" class="img-fluid card">
									</div>
									<div class="form-group input2">
										<label for="cnumber">Card number</label>
										<input type="number" class="form_style" name="cnumber" id="cnumber">
									</div>
									<div class="form-group dates input1 float-left">
										<label>Expiration date</label>
										<select class="form-control input3 float-left" required="">
											<option value="" disabled="" selected="" hidden="">Month</option>
											<option value="January">January</option>
											<option value="February">February</option>
											<option value="March">March</option>
											<option value="April">April</option>
											<option value="May">May</option>
											<option value="June">June</option>
											<option value="July">July</option>
											<option value="August">August</option>
											<option value="September">September</option>
											<option value="October">October</option>
											<option value="November">November</option>
											<option value="December">December</option>
										</select>
										<select class="form-control input4 float-left" required="">
											<option value="" disabled="" selected="" hidden="">Year</option>
											<option value="2013">2013</option>
											<option value="2014">2014</option>
											<option value="2015">2015</option>
											<option value="2016">2016</option>
											<option value="2017">2017</option>
											<option value="2018">2018</option>
											<option value="2019">2019</option>
											<option value="2020">2020</option>
											<option value="2021">2021</option>
											<option value="2022">2022</option>
											<option value="2023">2023</option>
											<option value="2024">2024</option>
										</select>
									</div>
									<div class="form-group float-left">
										<label for="scord">Security Code</label>
										<input type="text" class="form_style" name="scord" id="scord">
									</div>
									<div class="form-group float-left dates checkbox">
										<input type="checkbox" id="cash">
										<label for="cash">Cash on Delivery</label>
										<i class="fa-solid fa-money-bill-wave"></i>
									</div>
									<p class="text-center text-size-14">By clicking the button, you agree to the <a href="terms-of-conditions.html" class="text-decoration-none terms-btn">Terms and Conditions</a></p>
								</div>
								<a href="thankyou.jsp" data-aos="fade-up" type="submit" id="submit" class="submit_now text-decoration-none">Palce Order Now<i class="fa-solid fa-arrow-right"></i></a>
							</form>
						</div>
					</div>
					<div class="col-lg-4 col-12">
						<div class="cart-total-outer" id="checkout-con" data-aos="fade-up">
							<div class="top-heading">
								<span class="product-items">Items</span>
								<span class="product-prices">Price</span>
							</div>
							<div class="list-items" id="cart-summary-items">
								<!-- Content -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

<!-- Include the footer -->
<jsp:include page="footer.jsp" />



<script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>

<script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>"></script>
<script src="<c:url value='/assets/js/custom.js'/>"></script>

<script src="<c:url value='/assets/js/aos.js'/>"></script>
<script src="<c:url value='/assets/js/animation.js'/>"></script>

	<!-- jquery latest version -->
<script src="<c:url value='/assets/js/jquery-3.6.0.min.js'/>"></script>
<!-- jquery.meanmenu js -->
<script src="<c:url value='/assets/js/jquery.meanmenu.js'/>"></script>
<!-- slick.min js -->
<script src="<c:url value='/assets/js/slick.min.js'/>"></script>
<!-- jquery.treeview js -->
<script src="<c:url value='/assets/js/jquery.treeview.js'/>"></script>
<!-- jquery-ui js -->
<script src="<c:url value='/assets/js/jquery-ui.min.js'/>"></script>
<!-- jquery.nicescroll.min js -->
<script src="<c:url value='/assets/js/jquery.nicescroll.min.js'/>"></script>
<!-- wow js -->
<script src="<c:url value='/assets/js/wow.min.js'/>"></script>
<!-- plugins js -->
<script src="<c:url value='/assets/js/plugins.js'/>"></script>
<!-- main js -->
	</body>
</html>
