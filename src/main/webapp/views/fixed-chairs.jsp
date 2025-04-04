<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Fixed Chairs Page</title>

		<!-- Bootstrap CSS -->
		<link href="/relaxit/assets/css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="/relaxit/assets/css/tiny-slider.css" rel="stylesheet">
		<link href="/relaxit/assets/css/style.css" rel="stylesheet">

	    <link href="/relaxit/assets/css/bootstrap.min2.css" rel="stylesheet">
		<link href="/relaxit/assets/css/shop.css" rel="stylesheet" type="text/css">
		<link href="/relaxit/assets/css/style.css" rel="stylesheet" type="text/css">
		<link href="/relaxit/assets/css/responsive.css" rel="stylesheet" type="text/css">
		<link href="/relaxit/assets/css/aos.css" rel="stylesheet">

        <!-- material-design-iconic-font css -->
		<link rel="stylesheet" href="/relaxit/assets/css/material-design-iconic-font.css">
		<!-- All common css of theme -->
		<link rel="stylesheet" href="/relaxit/assets/css/default.css">
	</head>

	<body>
		<!-- Start Header/Navigation -->
		<nav class="custom-navbar navbar navbar navbar-expand-md navbar-dark bg-dark" arial-label="Furni navigation bar">

			<div class="container">
				<a class="navbar-brand" href="index.html">Furni<span>.</span></a>

				<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>

				<div class="collapse navbar-collapse" id="navbarsFurni">
					<ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
						<li class="nav-item "><a class="nav-link" href="index.html">Home</a></li>
						<li class="active"><a class="nav-link" href="/views/shop.jsp">Shop</a></li>
						<li><a class="nav-link" href="/views/about.jsp">About us</a></li>
						<li><a class="nav-link" href="services.html">Services</a></li>
						<li><a class="nav-link" href="blog.html">Blog</a></li>
						<li><a class="nav-link" href="contact.html">Contact us</a></li>
					</ul>

					<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
						<li><a class="nav-link" href="#"><img src="/relaxit/assets/img/user.svg"></a></li>
						<li><a class="nav-link" href="views/cart.jsp"><img src="/relaxit/assets/img/cart.svg"></a></li>
					</ul>
				</div>
			</div>

		</nav>
		<!-- End Header/Navigation -->


		<!-- Start Hero Section -->
		<div class="hero">
			<div class="container">
				<div class="row justify-content-between">
					<div class="col-lg-5">
						<div class="intro-excerpt">
							<h1>Fixed Chairs</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Hero Section -->


		<!-- Fixed Chairs -->
		<section class="shop1-con classic-con position-relative">
			<div class="container">
				<div class="row">
					<div class="col-lg-9">
						<div class="row shop-products-con" data-aos="fade-up">

                            <c:forEach var="curProduct" items="${products}" varStatus="status">
                                    <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
                                        <div class="classic-box">
                                            <div class="classic_image_box box${status.index + 1}">
                                                <figure class="mb-0">
                                                    <img src="/relaxit/assets/img/classic-image1.png" alt="image" class="img-fluid">
                                                </figure>
                                            </div>
                                            <div class="classic_box_content">
                                                <div class="text_wrapper position-relative">
                                                    <h6>${curProduct.name}</h6>
                                                </div>
                                                <p class="text-size-16">${curProduct.description}</p>
                                                <div class="price_wrapper position-relative">
                                                    <span class="dollar">$<span class="counter">${curProduct.price}</span></span>
                                                    <a href="views/cart.jsp"><img src="/relaxit/assets/img/cart.png" alt="image" class="img-fluid"></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </c:forEach>

                            <!-- Pagination -->
                            <ul class="pagination" data-aos="fade-up">
                                <c:if test="${pageNumber > 1}">
                                    <li class="page-item next">
                                        <a class="page-link" href="fixed-chairs?page=${pageNumber - 1}"><i class="fas fa-angle-left"></i></a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == pageNumber ? 'active' : ''}">
                                        <a class="page-link" href="fixed-chairs?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                                <c:if test="${pageNumber < totalPages}">
                                    <li class="page-item next">
                                        <a class="page-link" href="shop?page=${pageNumber + 1}"><i class="fas fa-angle-right"></i></a>
                                    </li>
                                </c:if>
                            </ul>
						</div>
					</div>
				</div>
			</div>
		</section>


		<!-- Start Footer Section -->
		<footer class="footer-section">
			<div class="container relative">

				<div class="sofa-img">
					<img src="/relaxit/assets/img/sofa.png" alt="Image" class="img-fluid">
				</div>

				<div class="row">
					<div class="col-lg-8">
						<div class="subscription-form">
							<h3 class="d-flex align-items-center"><span class="me-1"><img src="/relaxit/assets/img/envelope-outline.svg" alt="Image" class="img-fluid"></span><span>Subscribe to Newsletter</span></h3>

							<form action="#" class="row g-3">
								<div class="col-auto">
									<input type="text" class="form-control" placeholder="Enter your name">
								</div>
								<div class="col-auto">
									<input type="email" class="form-control" placeholder="Enter your email">
								</div>
								<div class="col-auto">
									<button class="btn btn-primary">
										<span class="fa fa-paper-plane"></span>
									</button>
								</div>
							</form>

						</div>
					</div>
				</div>

				<div class="row g-5 mb-5">
					<div class="col-lg-4">
						<div class="mb-4 footer-logo-wrap"><a href="#" class="footer-logo">Furni<span>.</span></a></div>
						<p class="mb-4">Donec facilisis quam ut purus rutrum lobortis. Donec vitae odio quis nisl dapibus malesuada. Nullam ac aliquet velit. Aliquam vulputate velit imperdiet dolor tempor tristique. Pellentesque habitant</p>

						<ul class="list-unstyled custom-social">
							<li><a href="#"><span class="fa fa-brands fa-facebook-f"></span></a></li>
							<li><a href="#"><span class="fa fa-brands fa-twitter"></span></a></li>
							<li><a href="#"><span class="fa fa-brands fa-instagram"></span></a></li>
							<li><a href="#"><span class="fa fa-brands fa-linkedin"></span></a></li>
						</ul>
					</div>

					<div class="col-lg-8">
						<div class="row links-wrap">
							<div class="col-6 col-sm-6 col-md-3">
								<ul class="list-unstyled">
									<li><a href="#">About us</a></li>
									<li><a href="#">Services</a></li>
									<li><a href="#">Blog</a></li>
									<li><a href="#">Contact us</a></li>
								</ul>
							</div>

							<div class="col-6 col-sm-6 col-md-3">
								<ul class="list-unstyled">
									<li><a href="#">Support</a></li>
									<li><a href="#">Knowledge base</a></li>
									<li><a href="#">Live chat</a></li>
								</ul>
							</div>

							<div class="col-6 col-sm-6 col-md-3">
								<ul class="list-unstyled">
									<li><a href="#">Jobs</a></li>
									<li><a href="#">Our team</a></li>
									<li><a href="#">Leadership</a></li>
									<li><a href="#">Privacy Policy</a></li>
								</ul>
							</div>

							<div class="col-6 col-sm-6 col-md-3">
								<ul class="list-unstyled">
									<li><a href="#">Nordic Chair</a></li>
									<li><a href="#">Kruzo Aero</a></li>
									<li><a href="#">Ergonomic Chair</a></li>
								</ul>
							</div>
						</div>
					</div>

				</div>

				<div class="border-top copyright">
					<div class="row pt-4">
						<div class="col-lg-6">
							<p class="mb-2 text-center text-lg-start">Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved. &mdash; Designed with love by <a href="https://untree.co">Untree.co</a>  Distributed By <a href="https://themewagon.com">ThemeWagon</a> <!-- License information: https://untree.co/license/ -->
            </p>
						</div>

						<div class="col-lg-6 text-center text-lg-end">
							<ul class="list-unstyled d-inline-flex ms-auto">
								<li class="me-4"><a href="#">Terms &amp; Conditions</a></li>
								<li><a href="#">Privacy Policy</a></li>
							</ul>
						</div>

					</div>
				</div>

			</div>
		</footer>
		<!-- End Footer Section -->


		<script src="/relaxit/assets/js/bootstrap.bundle.min.js"></script>
		<script src="/relaxit/assets/js/tiny-slider.js"></script>
		<script src="/relaxit/assets/js/custom.js"></script>

		<script src="/relaxit/assets/js/aos.js"></script>
		<script src="/relaxit/assets/js/animation.js"></script>

        	<!-- jquery latest version -->
		<script src="/relaxit/assets/js/jquery-3.6.0.min.js"></script>
		<!-- jquery.meanmenu js -->
		<script src="/relaxit/assets/js/jquery.meanmenu.js"></script>
		<!-- slick.min js -->
		<script src="/relaxit/assets/js/slick.min.js"></script>
		<!-- jquery.treeview js -->
		<script src="/relaxit/assets/js/jquery.treeview.js"></script>
		<!-- jquery-ui js -->
		<script src="/relaxit/assets/js/jquery-ui.min.js"></script>
		<!-- jquery.nicescroll.min js -->
		<script src="/relaxit/assets/js/jquery.nicescroll.min.js"></script>
		<!-- wow js -->
		<script src="/relaxit/assets/js/wow.min.js"></script>
		<!-- plugins js -->
		<script src="/relaxit/assets/js/plugins.js"></script>
		<!-- main js -->
		<script src="/relaxit/assets/js/main.min.js"></script>
	</body>
</html>
