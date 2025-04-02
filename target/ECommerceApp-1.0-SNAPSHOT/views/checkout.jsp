<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Checkout Page</title>

		<!-- Bootstrap CSS -->
		<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="../assets/css/tiny-slider.css" rel="stylesheet">
		<link href="../assets/css/style.css" rel="stylesheet">

		<!-- Latest compiled and minified CSS -->
		<link href="../assets/css/bootstrap.min2.css" rel="stylesheet">
		<!-- StyleSheet link CSS -->
		<link href="../assets/css/shop.css" rel="stylesheet" type="text/css">
		<link href="../assets/css/style.css" rel="stylesheet" type="text/css">
		<link href="../assets/css/aos.css" rel="stylesheet">
		<link href="../assets/css/magnific-popup.css" rel="stylesheet" type="text/css">

		<!-- material-design-iconic-font css -->
		<link rel="stylesheet" href="../assets/css/material-design-iconic-font.css">
		<!-- All common css of theme -->
		<link rel="stylesheet" href="../assets/css/default.css">
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
						<li class="nav-item ">
							<a class="nav-link" href="index.html">Home</a>
						</li>
						<li><a class="nav-link" href="shop.jsp">Shop</a></li>
						<li><a class="nav-link" href="about.jsp">About us</a></li>
						<li><a class="nav-link" href="services.html">Services</a></li>
						<li><a class="nav-link" href="blog.html">Blog</a></li>
						<li><a class="nav-link" href="contact.html">Contact us</a></li>
					</ul>

					<ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
						<li><a class="nav-link" href="#"><img src="../assets/img/user.svg"></a></li>
						<li><a class="nav-link" href="cart.jsp"><img src="../assets/img/cart.svg"></a></li>
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
							<h1>Checkout</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Hero Section -->


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
						<div class="cart-total-outer" data-aos="fade-up">
							<div class="top-heading">
								<span class="product-items">Items</span>
								<span class="product-prices">Price</span>
							</div>
							<div class="list-items">
								<div class="each-item">
									<div class="product-items">
										<span class="heading">3 x Classic Vanilla</span>
										<p class="text-size-14 mb-0">Creamy vanilla ice cream topped with cherry.</p>
									</div>
									<div class="product-prices">
										<span class="dollar">$13.00</span>
									</div>
								</div>
								<div class="each-item">
									<div class="product-items">
										<span class="heading">6 x Chocolate Brownie</span>
										<p class="text-size-14 mb-0">Rich chocolate ice cream with chunks of brownie.</p>
									</div>
									<div class="product-prices">
										<span class="dollar">$23.00</span>
									</div>
								</div>
								<div class="each-item">
									<div class="product-items">
										<span class="heading">4 x Stawberry Cake</span>
										<p class="text-size-14 mb-0">Strawberry ice cream layered with shortcake</p>
									</div>
									<div class="product-prices">
										<span class="dollar">$22.00</span>
									</div>
								</div>
								<div class="each-item">
									<div class="product-items">
										<span class="heading">2 x Mint Chocolate</span>
										<p class="text-size-14 mb-0">Refreshing mint ice cream with chocolate chips.</p>
									</div>
									<div class="product-prices">
										<span class="dollar">$07.00</span>
									</div>
								</div>
								<div class="each-item">
									<div class="product-items">
										<span class="heading">Grand Total</span>
									</div>
									<div class="product-prices">
										<span class="dollar total-price">$83.99</span>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- Start Footer Section -->
		<footer class="footer-section">
			<div class="container relative">
				<div class="sofa-img">
					<img src="../assets/img/sofa.png" alt="Image" class="img-fluid">
				</div>

				<div class="row">
					<div class="col-lg-8">
						<div class="subscription-form">
							<h3 class="d-flex align-items-center"><span class="me-1"><img src="../assets/img/envelope-outline.svg" alt="Image" class="img-fluid"></span><span>Subscribe to Newsletter</span></h3>

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
							<p class="mb-2 text-center text-lg-start">Copyright &copy;<script>document.write(new Date().getFullYear());</script>. All Rights Reserved. &mdash; Designed with love by <a href="https://untree.co">Untree.co</a> Distributed By <a hreff="https://themewagon.com">ThemeWagon</a>  <!-- License information: https://untree.co/license/ -->
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


		<script src="../assets/js/bootstrap.bundle.min.js"></script>
		<script src="../assets/js/tiny-slider.js"></script>
		<script src="../assets/js/custom.js"></script>

		<!-- Latest compiled JavaScript -->
		<script src="../assets/js/jquery-3.7.1.min.js"></script>
		<script src="../assets/js/popper.min.js"></script>
		<script src="../assets/js/bootstrap.min.js"></script>
		<script src="../assets/js/aos.js"></script>
		<script src="../assets/js/owl.carousel.js"></script>
		<script src="../assets/js/carousel.js"></script>
		<script src="../assets/js/animation.js"></script>
		<script src="../assets/js/back-to-top-button.js"></script>
		<script src="../assets/js/preloader.js"></script>
		<script src="../assets/js/search.js"></script>
		<script src="../assets/js/remove-product.js"></script>
		<script src="../assets/js/quantity.js"></script>

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
	</body>
</html>
