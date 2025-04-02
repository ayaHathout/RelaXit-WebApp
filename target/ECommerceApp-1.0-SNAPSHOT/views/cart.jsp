<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Cart Page</title>

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
					<li><a class="nav-link" href="cart.html"><img src="../assets/img/cart.svg"></a></li>
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
							<h1>Cart</h1>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Hero Section -->


		<!-- Cart -->
		<div class="cart-con position-relative">
			<div class="container">
				<div class="row">
					<div class="col-lg-8 col-12">
						<div class="product-detail-box" data-aos="fade-up">
							<div class="heading">
								<span>Shopping Cart</span>
								<span>(04 Items)</span>
							</div>
							<div class="shopping-cart">
								<div class="column-labels">
									<label class="product-details">Product Details</label>
									<label class="product-price">Price</label>
									<label class="product-quantity">Quantity</label>
									<label class="product-line-price">Total</label>
									<label class="product-removal"></label>
								</div>
								<div class="shopping-cart-info">
									<div class="product d-sm-flex d-block align-items-center">
										<div class="product-details">
											<div class="product-image box1">
												<figure class="mb-0">
													<img src="../assets/img/cart-image1.png" alt="image" class="img-fluid">
												</figure>
											</div>
											<div class="product-content">
												<span class="product-title">Classic Vanilla</span>
											</div>
										</div>
										<div class="product-price"><span>4.99$</span></div>
										<div class="product-quantity d-flex">
											<div class="product-qty-details">
												<button class="value-button decrease-button" onclick="decreaseValue(this)" title="">-</button>
												<div class="number">3</div><button class="value-button increase-button" onclick="increaseValue(this)" title="">+</button>
											</div>
										</div>
										<div class="product-line-price"><span>13.00</span></div>
										<div class="product-removal">
											<button class="remove-product"><i class="fas fa-times"></i></button>
										</div>
									</div>
									<div class="product d-sm-flex d-block align-items-center">
										<div class="product-details">
											<div class="product-image box2">
												<figure class="mb-0">
													<img src="../assets/img/cart-image2.png" alt="image" class="img-fluid">
												</figure>
											</div>
											<div class="product-content">
												<span class="product-title">Chocolate Brownie</span>
											</div>
										</div>
										<div class="product-price"><span>5.49$</span></div>
										<div class="product-quantity d-flex">
											<div class="product-qty-details">
												<button class="value-button decrease-button" onclick="decreaseValue(this)" title="">-</button>
												<div class="number">6</div><button class="value-button increase-button" onclick="increaseValue(this)" title="">+</button>
											</div>
										</div>
										<div class="product-line-price"><span>23.00</span></div>
										<div class="product-removal">
											<button class="remove-product"><i class="fas fa-times"></i></button>
										</div>
									</div>
									<div class="product d-sm-flex d-block align-items-center">
										<div class="product-details">
											<div class="product-image box3">
												<figure class="mb-0">
													<img src="../assets/img/cart-image3.png" alt="image" class="img-fluid">
												</figure>
											</div>
											<div class="product-content">
												<span class="product-title">Stawberry Cake</span>
											</div>
										</div>
										<div class="product-price"><span>5.29$</span></div>
										<div class="product-quantity d-flex">
											<div class="product-qty-details">
												<button class="value-button decrease-button" onclick="decreaseValue(this)" title="">-</button>
												<div class="number">4</div><button class="value-button increase-button" onclick="increaseValue(this)" title="">+</button>
											</div>
										</div>
										<div class="product-line-price"><span>22.00</span></div>
										<div class="product-removal">
											<button class="remove-product"><i class="fas fa-times"></i></button>
										</div>
									</div>
									<div class="product d-sm-flex d-block align-items-center">
										<div class="product-details">
											<div class="product-image box4">
												<figure class="mb-0">
													<img src="../assets/img/cart-image4.png" alt="image" class="img-fluid">
												</figure>
											</div>
											<div class="product-content">
												<span class="product-title">Mint Chocolate</span>
											</div>
										</div>
										<div class="product-price"><span>3.99$</span></div>
										<div class="product-quantity d-flex">
											<div class="product-qty-details">
												<button class="value-button decrease-button" onclick="decreaseValue(this)" title="">-</button>
												<div class="number">2</div><button class="value-button increase-button" onclick="increaseValue(this)" title="">+</button>
											</div>
										</div>
										<div class="product-line-price"><span>7.00</span></div>
										<div class="product-removal">
											<button class="remove-product"><i class="fas fa-times"></i></button>
										</div>
									</div>
								</div>
							</div>
							<div class="buttun-shopping">
								<a href="shop.html" class="text-decoration-none"><i class="fa-solid fa-arrow-left"></i>Continue Shopping</a>
							</div>
						</div>
					</div>
					<div class="col-lg-4 col-12">
						<div class="cart-total-outer" data-aos="fade-up">
							<h4 class="mb-0">Order Summary</h4>
							<div class="coupon">
								<div class="ticket">
									<i class="fa-solid fa-ticket"></i>
									<span class="heading">Apply Coupons</span>
								</div>
								<a href="cart.html" class="text-decoration-none">Apply</a>
							</div>
							<div class="detail">
								<span class="heading">Product Details:</span>
								<ul class="list-unstyled mb-0">
									<li><span>Sub Total</span><span class="dollar">$63.99</span></li>
									<li><span>Shipping</span><span class="dollar">$20.00</span></li>
								</ul>
								<div class="all-total">
									<div class="total">
										<span class="text">Grand Total</span><span class="dollar">$89.99</span>
									</div>
									<a href="checkout.jsp" class="text-decoration-none all_button">Proceed to checkout<i class="fa-solid fa-arrow-right"></i></a>
								</div>
								<div class="note">
									<i class="fa-solid fa-shield-halved"></i>
									<span class="note-text">Safe and Secure Payments, Easy Returns. 100% Authentic Products</span>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Cart-->


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
