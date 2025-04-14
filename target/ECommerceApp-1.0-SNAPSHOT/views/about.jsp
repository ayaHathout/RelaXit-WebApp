<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>About Us Page</title>

		<!-- StyleSheet link CSS -->
		<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
		<link href="../assets/css/responsive.css" rel="stylesheet" type="text/css">
		<link href="../assets/css/aos.css" rel="stylesheet">
		<link href="<c:url value='/assets/css/first.css'/>" rel="stylesheet">

		<!-- Bootstrap CSS -->
		<link href="<c:url value='/assets/css/bootstrap.min2.css'/>" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="<c:url value='/assets/css/tiny-slider.css'/>" rel="stylesheet">
		<link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet">

		<!-- material-design-iconic-font css -->
        <link rel="stylesheet" href="<c:url value='/assets/css/material-design-iconic-font.css'/>">
        <!-- All common css of theme -->
        <link rel="stylesheet" href="<c:url value='/assets/css/default.css'/>">
	</head>

	<body>
	    <!-- Include the header with custom parameters -->
	        <jsp:include page="header.jsp">
            <jsp:param name="activePage" value="about" />
            <jsp:param name="heroTitle" value="About Us" />
        </jsp:include>
		
		<!-- Start of About us section -->
		<section class="journey-con position-relative">
			<div class="container">
				<div class="row">
					<div class="col-xl-5 col-lg-6 col-md-12 col-sm-12 col-12">
						<div class="journey_wrapper position-relative" data-aos="zoom-in">
							<figure class="journey-image mb-0">
								<img src="../assets/img/kelly-sikkema.jpg" alt="image" class="img-fluid">
							</figure>
						</div>
					</div>
					<div class="col-xl-7 col-lg-6 col-md-12 col-sm-12 col-12">
						<div class="journey_content" data-aos="fade-up">
							<p class="text1">At RelaXit, we create ergonomic seats and pillows designed to support your spine and improve your posture because we believe comfort starts with proper sitting.

								Our vision is simple: to make spinal health a priority in every home, office, and space. We're not just selling products, we're offering a lifestyle change.
								
								What makes us different? Our products provide active support while you sit, work, or travel not just passive comfort. They're designed for real life, helping you maintain better posture naturally.
								
								We're here to do more than just cushion your seat. We're helping you sit right, feel better, and live healthier one ergonomic solution at a time.
								
								Try RelaXit today and experience the difference proper support can make.
								
								RelaXit, Where comfort meets spinal health.
							</p>
							<p class="text2">We take pride in offering a diverse range of options, including dairy-free, vegan, and gluten-free choices, so everyone can find their perfect scoop.</p>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End of About us section -->
		<br> <br> <br> <br>

		<!-- Include the footer -->
        <jsp:include page="footer.jsp" />


		<!-- Latest compiled JavaScript -->
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
		<script src="<c:url value='/assets/js/main.min.js'/>"></script>
	</body>
</html>
