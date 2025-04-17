<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="author" content="Untree.co">
  <link rel="shortcut icon" href="favicon.png">

  <meta name="description" content="" />
  <meta name="keywords" content="bootstrap, bootstrap4" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-design-iconic-font@2.2.0/dist/css/material-design-iconic-font.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

    <!-- Bootstrap CSS -->
    <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <link href="<c:url value='/assets/css/tiny-slider.css'/>" rel="stylesheet">
    <link href="<c:url value='/assets/css/home.css'/>" rel="stylesheet">
    <title>RelaXit - Perfect Posture Solutions</title>
</head>

<body>

    <!-- Start Header/Navigation -->
    <nav class="custom-navbar navbar navbar-expand-md navbar-dark" aria-label="Furni navigation bar">
        <div class="container">
          <div class="logo">
            <i class="fas fa-chair logo-icon"></i>
            Rela<span>X</span>it
          </div>
      
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarsFurni" aria-controls="navbarsFurni" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
      
          <div class="collapse navbar-collapse" id="navbarsFurni">
            <ul class="custom-navbar-nav navbar-nav ms-auto mb-2 mb-md-0">
              <li class="nav-item active">
                <a class="nav-link" href="<c:url value='home'/>">Home</a>
              </li>
              <li><a class="nav-link" href="<c:url value='/shop'/>">Shop</a></li>
              <li><a class="nav-link" href="<c:url value='/views/about.jsp'/>">About us</a></li>
              <li><a class="nav-link" href="<c:url value='/views/contact.jsp'/>">Contact us</a></li>
            </ul>
      
            <ul class="custom-navbar-cta navbar-nav mb-2 mb-md-0 ms-5">
              
      
              <!-- Login -->
              <li class="nav-item user-dropdown">
                <div class="user-icon">
                    <c:choose>
                        <c:when test="${not empty user}">
                            <c:choose>
                                <c:when test="${not empty user.profileImage}">
                                    <img src="${pageContext.request.contextPath}/images/${user.profileImage != null && !user.profileImage.isEmpty() ? user.profileImage : 'assets/img/default-avatar.png'}" alt="Profile Image" class="user-profile-img" />
                                </c:when>
                                <c:otherwise>
                                    <c:choose>
                                        <c:when test="${not empty user.fullName}">
                                            <div class="user-initials">${fn:substring(user.fullName, 0, 1)}</div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="user-initials">U</div> 
                                        </c:otherwise>
                                    </c:choose>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <i class="fas fa-user"></i>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="user-menu">
                    <c:choose>
                        <c:when test="${not empty user}">
                            <!-- Logged in user menu -->
                            <div class="user-menu-header">
                                <div class="user-info">
                                    <div class="user-name"><p>Welcome back, ${user.fullName}!</p></div>
                                    <div class="user-email">${user.email}</div>
                                </div>
                            </div>
                            <ul class="user-menu-links">
                                <li>
                                    <a href="<c:url value='/profile'/>">
                                        <i class="fas fa-user-circle"></i>
                                        <span>My Profile</span>
                                    </a>
                                </li>
                                <li class="divider"></li>
                                <li>
                                    <a href="<c:url value='/logoutClient'/>" class="logout-link">
                                        <i class="fas fa-sign-out-alt"></i>
                                        <span>Sign Out</span>
                                    </a>
                                </li>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <div class="guest-menu-header">
                                <h4>Welcome</h4>
                                <p>New Customer? <a href="<c:url value='/login'/>" class="start-here-link">Start Here</a></p>
                            </div>
                            <div class="auth-buttons">
                                <a href="<c:url value='/login'/>" class="btn btn-primary login-btn">Sign In</a>
                                <a href="<c:url value='/login'/>" class="btn btn-outline register-btn">Register</a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </li>
      
              <!-- Shopping Cart -->
              <li class="nav-item mini-cart">
                <div class="cart-icon">
                    <i class="zmdi zmdi-shopping-cart"></i>
                    <span class="cart-counter">${cartItemCount != null ? cartItemCount : '0'}</span>
                </div>
                <div class="mini-cart-brief">
                    <div class="cart-items">
                        <p>You have <span class="item-count">${cartItemCount != null ? cartItemCount : '0'}</span> items in your shopping bag</p>
                    </div>
                    <div class="all-cart-product">
                        <c:choose>
                            <c:when test="${empty cartItems}">
                                <div class="empty-cart-message">
                                    <p>Your cart is empty</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                               
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="cart-totals">
                        <h5>TOTAL <span class="cart-total">$${cartTotal != null ? cartTotal : '0.00'}</span></h5>
                    </div>
                    <div class="cart-bottom">
                        <a href="<c:url value='/cart/view'/>" class="btn btn-outline-secondary">VIEW CART</a>
                        <a href="<c:url value='/checkout'/>" class="btn btn-primary ${empty cartItems ? 'disabled' : ''}">CHECK OUT</a>
                    </div>
                </div>
            </li>
            </ul>
          </div>
        </div>
      </nav>
    
    <!-- End Header/Navigation -->


    <!-- Start Hero Section -->
                
    <section class="hero">
        <div class="particles-container">
            <!-- particle effect -->
            <%
            for (int i = 0; i < 35; i++) {
                double size = Math.random() * 15 + 8;
                double left = Math.random() * 100;
                double delay = Math.random() * 2; 
                double duration = Math.random() * 15 + 15; 
                
                out.println("<div class=\"particle\" style=\"" +
                    "width: " + size + "px;" +
                    "height: " + size + "px;" +
                    "left: " + left + "%;" +
                    "bottom: -" + size + "px;" +
                    "animation-delay: " + delay + "s;" +
                    "animation-duration: " + duration + "s;" +
                    "opacity: " + (Math.random() * 0.5 + 0.5) + ";" +
                    "transform: scale(" + (Math.random() * 0.7 + 1.3) + ");" +
                "\"></div>");
            }
            %>
        </div>
        
        <!--Spine visualization-->
        <div class="spine-container" id="spine-container">
            <div class="spine-curve" id="spine">
                <!-- Cervical curve (lordosis - inward curve) -->
                <div class="vertebra" style="left: 48%; top: 0%;"></div>
                <div class="disc" style="left: 48%; top: 2%;"></div>
                <div class="vertebra" style="left: 47%; top: 4%;"></div>
                <div class="disc" style="left: 46%; top: 6%;"></div>
                <div class="vertebra" style="left: 45%; top: 8%;"></div>
                <div class="disc" style="left: 44%; top: 10%;"></div>
                <div class="vertebra" style="left: 43%; top: 12%;"></div>
                <div class="disc" style="left: 43%; top: 14%;"></div>
                
                <!-- Thoracic curve (kyphosis - outward curve) -->
                <div class="vertebra" style="left: 44%; top: 16%;"></div>
                <div class="disc" style="left: 45%; top: 18%;"></div>
                <div class="vertebra" style="left: 46%; top: 20%;"></div>
                <div class="disc" style="left: 48%; top: 22%;"></div>
                <div class="vertebra" style="left: 50%; top: 24%;"></div>
                <div class="disc" style="left: 52%; top: 26%;"></div>
                <div class="vertebra" style="left: 54%; top: 28%;"></div>
                <div class="disc" style="left: 56%; top: 30%;"></div>
                <div class="vertebra" style="left: 58%; top: 32%;"></div>
                <div class="disc" style="left: 59%; top: 34%;"></div>
                <div class="vertebra" style="left: 60%; top: 36%;"></div>
                <div class="disc" style="left: 60%; top: 38%;"></div>
                <div class="vertebra" style="left: 59%; top: 40%;"></div>
                
                <!-- Lumbar curve (lordosis - inward curve) -->
                <div class="disc" style="left: 58%; top: 42%;"></div>
                <div class="vertebra" style="left: 56%; top: 44%;"></div>
                <div class="disc" style="left: 54%; top: 46%;"></div>
                <div class="vertebra" style="left: 52%; top: 48%;"></div>
                <div class="disc" style="left: 50%; top: 50%;"></div>
                <div class="vertebra" style="left: 48%; top: 52%;"></div>
                <div class="disc" style="left: 46%; top: 54%;"></div>
                <div class="vertebra" style="left: 44%; top: 56%;"></div>
                <div class="disc" style="left: 42%; top: 58%;"></div>
                <div class="vertebra" style="left: 40%; top: 60%;"></div>
                
                <!-- Sacral curve (kyphosis - outward curve) -->
                <div class="disc" style="left: 41%; top: 62%;"></div>
                <div class="vertebra" style="left: 42%; top: 64%;"></div>
                <div class="disc" style="left: 43%; top: 66%;"></div>
                <div class="vertebra" style="left: 44%; top: 68%;"></div>
                <div class="disc" style="left: 45%; top: 70%;"></div>
                <div class="vertebra" style="left: 46%; top: 72%;"></div>
                <div class="disc" style="left: 47%; top: 74%;"></div>
                <div class="vertebra" style="left: 48%; top: 76%;"></div>
                <div class="disc" style="left: 49%; top: 78%;"></div>
                <div class="vertebra" style="left: 50%; top: 80%;"></div>
                <div class="disc" style="left: 51%; top: 82%;"></div>
                <div class="vertebra" style="left: 52%; top: 84%;"></div>
                <div class="disc" style="left: 53%; top: 86%;"></div>
                <div class="vertebra" style="left: 54%; top: 88%;"></div>
            </div>
            <div class="status" id="status"></div>
        </div>
        
        <div class="hero-content">
            <h1>Perfect Posture. <span>Endless Comfort.</span></h1>
            <p class="hero-text">Experience revolutionary ergonomic designs that transform how you sit, rest, and live. Our scientifically crafted products align your spine for maximum comfort and long-term health benefits.</p>
            <div class="cta-buttons">
                <a href="<c:url value='/shop'/>" class="cta-primary">Discover Collection</a>
            </div>
        </div>
        
        <div class="hero-image">
            <div class="hero-image-container">
                <div class="glow"></div>
                <img class="product-image" src="<c:url value='/assets/images/pic.png'/>" alt="Ultra-modern ergonomic chair with perfect spine support" />
                <div class="badge">New Design</div>
            </div>
        </div>
        <div class="hero-bottom-wave">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320" preserveAspectRatio="none" style="width: 100%; height: 100%;">
                <path fill="#ffffff" fill-opacity="1" d="M0,160L48,144C96,128,192,96,288,90.7C384,85,480,107,576,133.3C672,160,768,192,864,186.7C960,181,1056,139,1152,133.3C1248,128,1344,160,1392,176L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
            </svg>
        </div>
    </section>

    <script>
        // Header scroll effect
        window.addEventListener('scroll', function() {
            const header = document.querySelector('.site-header');
            if (window.scrollY > 50) {
                header.style.background = 'rgba(255, 255, 255, 0.9)';
                header.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.1)';
                header.style.backdropFilter = 'blur(10px)';
            } else {
                header.style.background = 'transparent';
                header.style.boxShadow = 'none';
                header.style.backdropFilter = 'none';
            }
        });
    
        // Spine animation
       document.addEventListener('DOMContentLoaded', function() {
    const spine = document.getElementById('spine');
    const spineContainer = document.getElementById('spine-container');
    const status = document.getElementById('status');
    
    // Store original positions for the natural S-shape
    const originalPositions = [];
    const elements = spine.querySelectorAll('.vertebra, .disc');
    elements.forEach(element => {
        originalPositions.push({
            element: element,
            left: element.style.left
        });
    });
    
    // Poor posture - C-shape configuration
    function setPoorPosture() {
        elements.forEach(element => {
            element.style.transition = 'left 1s ease';
            element.style.left = "40%";
        });
        status.classList.add('highlight');
    }
    
    // Correct posture - natural S-shape
    function setCorrectPosture() {
        originalPositions.forEach(item => {
            item.element.style.transition = 'left 1s ease';
            item.element.style.left = item.left;
        });
        status.classList.remove('highlight');
    }
    
    // Animation sequence
    function runAnimation() {

        setCorrectPosture();
        setTimeout(() => {
            setPoorPosture();
            setTimeout(() => {
                setCorrectPosture();
            }, 2000);
        }, 3000);
    }
    
    runAnimation();
    setInterval(runAnimation, 6000); 
});
    </script>
	
		<!-- End Hero Section -->

		<!-- Start Product Section -->
		<div class="product-section">
			<div class="container">
				<div class="row">

					<!-- Start Column 1 -->
					<div class="col-md-12 col-lg-3 mb-5 mb-lg-0">
						<h2 class="mb-4 section-title">Engineered for Spinal Health</h2>
						<p class="mb-4">Every RelaXit product is scientifically designed to support your natural spinal curvature. Our orthopedic materials adapt to your body, reducing pressure points and promoting perfect posture.</p>
						<p><a href="<c:url value='/shop'/>" class="btn">Explore</a></p>
					</div> 
					<!-- End Column 1 -->

					<!-- Start Column 2 -->
					<c:forEach var="curProduct" items="${products}" varStatus="status">
                        <div class="col-12 col-md-4 col-lg-3 mb-5 mb-md-0">
                            <a class="product-item" href="<c:url value='/product/${curProduct.productId}'/>">
                                <div class="image">
                                    <img src="${curProduct.productImage != null && !curProduct.productImage.isEmpty() ? pageContext.request.contextPath.concat('/images').concat(curProduct.productImage).concat('?t=').concat(currentTimeMillis) : '/relaxit/assets/images/pic.png'}"
                                                          alt="${curProduct.name}" class="img-fluid">
                                </div>
                                <h3 class="product-title">${curProduct.name}</h3>
                                <strong class="product-price">$${curProduct.price}</strong>
                                <c:choose>
                                    <c:when test="${status.index + 1 eq 1}">
                                        <span class="product-badge">All-day comfort throne</span>
                                    </c:when>
                                     <c:when test="${status.index + 1 eq 2}">
                                        <span class="product-badge">Adaptive back support</span>
                                     </c:when>
                                      <c:otherwise>
                                        <span class="product-badge">Legs' best friend</span>
                                      </c:otherwise>
                                </c:choose>
                                <span class="icon-cross add-to-cart" data-product-id="${curProduct.productId}">
                                    <img src="<c:url value='/assets/images/cross.svg'/>" class="img-fluid">
                                </span>
                            </a>
                        </div>
					</c:forEach>
					<!-- End Column 2 -->
				</div>
			</div>
		</div>
		<!-- End Product Section -->

		<!-- Start Why Choose Us Section -->
		<div class="why-choose-section">
			<div class="container">
				<div class="row justify-content-between">
					<div class="col-lg-6">
						<h2 class="section-title">The RelaXit Difference</h2>
						<p>We combine orthopedic science with premium comfort to create products that don't just feel good - they're clinically proven to improve posture and reduce back pain.</p>

						<div class="row my-5">
							<div class="col-6 col-md-6">
								<div class="feature">
									<div class="icon">
										<img src="<c:url value='/assets/images/spine_105426.png'/>" alt="Spine Health" class="imf-fluid">
									</div>
									<h3>Orthopedic Design</h3>
									<p>Developed with spine specialists to support your natural curvature and reduce spinal stress.</p>
								</div>
							</div>

							<div class="col-6 col-md-6">
								<div class="feature">
									<div class="icon">
										<img src="<c:url value='/assets/images/hospital-sign_7664670.png'/>" alt="Premium Materials" class="imf-fluid">
									</div>
									<h3>Medical-Grade Materials</h3>
									<p>Breathable, hypoallergenic fabrics with memory foam that adapts to your body.</p>
								</div>
							</div>

							<div class="col-6 col-md-6">
								<div class="feature">
									<div class="icon">
										<img src="<c:url value='/assets/images/spa-relax_3023823.png'/>" alt="Posture Support" class="imf-fluid">
									</div>
									<h3>Posture Correction</h3>
									<p>Subtle design elements gently encourage proper alignment throughout the day.</p>
								</div>
							</div>

							<div class="col-6 col-md-6">
								<div class="feature">
									<div class="icon">
										<img src="<c:url value='/assets/images/insurance-premium_17384806.png'/>" alt="Clinically Tested" class="imf-fluid">
									</div>
									<h3>Clinically Tested</h3>
									<p>All products validated by orthopedic specialists for effectiveness.</p>
								</div>
							</div>

						</div>
					</div>

					<div class="col-lg-5">
						<div class="img-wrap">
							<img src="<c:url value='/assets/images/spine.jpg'/>" alt="Proper Spinal Alignment" class="img-fluid">
							<div class="img-caption">Our designs maintain natural S-curve of the spine</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- End Why Choose Us Section -->

		<!-- Start We Help Section -->
		<div class="we-help-section">
			<div class="container">
				<div class="row justify-content-between">
					<div class="col-lg-7 mb-5 mb-lg-0">
						<div class="imgs-grid">
							<div class="grid grid-1">
								<div class="grid-inner">
									<img src="<c:url value='/assets/images/good-poor-posture-sitting-1024x704.jpg'/>" alt="Proper office posture">
								</div>
							</div>
							<div class="grid grid-2">
								<div class="grid-inner">
									<img src="<c:url value='/assets/images/SLEEPING-posture.jpg'/>" alt="Healthy sleeping position">
								</div>
							</div>
							<div class="grid grid-3">
								<div class="grid-inner">
									<img src="<c:url value='/assets/images/back_sleeping_position.jpg'/>" alt="Comfortable relaxation">
								</div>
							</div>
						</div>
					</div>
					<div class="col-lg-5 ps-lg-5">
						<h2 class="section-title mb-4">Transform How You Sit, Work, and Rest</h2>
						<p>Chronic back pain often stems from poor posture and unsupportive furniture. Our ergonomic solutions actively correct alignment while providing unparalleled comfort for all activities.</p>

						<ul class="list-unstyled custom-list my-4">
							<li>Reduces pressure on spinal discs by up to 40%</li>
							<li>Promotes proper head-neck alignment</li>
							<li>Encourages active sitting to strengthen core muscles</li>
							<li>Adapts to your unique body shape and size</li>
						</ul>
						<p><a href="<c:url value='/technology.jsp'/>" class="btn">Learn About Our Technology</a></p>
					</div>
				</div>
			</div>
		</div>
		<!-- End We Help Section -->

		<!-- Start Popular Product -->
		<div class="popular-product">
			<div class="container">
				<div class="row">

					<div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
						<div class="product-item-sm d-flex">
							<div class="thumbnail">
								<img src="<c:url value='/assets/images/PostureCorrect Cushion.jpg'/>" alt="Posture Corrector" class="img-fluid">
							</div>
							<div class="pt-3">
								<h3>PostureCorrect Cushion</h3>
								<p>Gently trains your body to maintain proper alignment while seated</p>
								<p><a href="<c:url value='/clinical-results.jsp'/>">See Clinical Results</a></p>
							</div>
						</div>
					</div>

					<div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
						<div class="product-item-sm d-flex">
							<div class="thumbnail">
								<img src="<c:url value='/assets/images/ErgoKneel-Chair.jpg'/>" alt="Kneeling Chair" class="img-fluid">
							</div>
							<div class="pt-3">
								<h3>ErgoKneel Chair</h3>
								<p>Distributes weight evenly to reduce lower back pressure</p>
								<p><a href="<c:url value='/ergonomics.jsp'/>">Why Kneeling Helps</a></p>
							</div>
						</div>
					</div>

					<div class="col-12 col-md-6 col-lg-4 mb-4 mb-lg-0">
						<div class="product-item-sm d-flex">
							<div class="thumbnail">
								<img src="<c:url value='/assets/images/CervicalSupportPillow.jpg'/>" alt="Cervical Pillow" class="img-fluid">
							</div>
							<div class="pt-3">
								<h3>CervicalSupport Pillow</h3>
								<p>Maintains proper neck alignment during sleep</p>
								<p><a href="<c:url value='/sleep-guide.jsp'/>">Sleep Position Guide</a></p>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>
		<!-- End Popular Product -->

		<!-- Start Testimonial Slider -->
		<div class="testimonial-section">
			<div class="container">
				<div class="row">
					<div class="col-lg-7 mx-auto text-center">
						<h2 class="section-title">Real Relief, Real Results</h2>
					</div>
				</div>

				<div class="row justify-content-center">
					<div class="col-lg-12">
						<div class="testimonial-slider-wrap text-center">

							<div id="testimonial-nav">
								<span class="prev" data-controls="prev">
								  <span class="fa fa-chevron-left"></span>
								</span>
								<span class="next" data-controls="next">
								  <span class="fa fa-chevron-right"></span>
								</span>
							  </div>

							<div class="testimonial-slider">
								
								<c:if test="${empty testimonials}">
									<!-- Default testimonials if none loaded from server -->
									<div class="item">
										<div class="row justify-content-center">
											<div class="col-lg-8 mx-auto">
												<div class="testimonial-block text-center">
													<blockquote class="mb-5">
														<p>&ldquo;After 15 years of chronic back pain from office work, my PosturePerfect Chair has been life-changing. Within two weeks, my pain decreased by 80%. Now I can focus on my work instead of constantly adjusting my position.&rdquo;</p>
													</blockquote>
													<div class="author-info">
														<div class="author-pic">
															<img src="<c:url value='/assets/images/person_4.jpg'/>" alt="Dr. Sarah Chen" class="img-fluid">
														</div>
														<h3 class="font-weight-bold">Dr. Sarah Chen</h3>
														<span class="position d-block mb-3">Orthopedic Specialist</span>
													</div>
												</div>
											</div>
										</div>
									</div> 
									
									<div class="item">
                                        <div class="row justify-content-center">
                                            <div class="col-lg-8 mx-auto">
    
                                                <div class="testimonial-block text-center">
                                                    <blockquote class="mb-5">
                                                        <p>&ldquo;As a software developer, I sit for 10+ hours daily. The Lumbar Support Pillow eliminated my afternoon slouching and the associated back pain. It's now part of my essential work setup.&rdquo;</p>
                                                    </blockquote>
    
                                                    <div class="author-info">
                                                        <div class="author-pic">
                                                            <img src="<c:url value='/assets/images/person-1.jpg'/>" alt="Mark Richardson" class="img-fluid">
                                                        </div>
                                                        <h3 class="font-weight-bold">Mark Richardson</h3>
                                                        <span class="position d-block mb-3">Senior Developer, TechCo</span>
                                                    </div>
                                                </div>
    
                                            </div>
                                        </div>
                                    </div> 
                                    <!-- END item -->
    
                                    <div class="item">
                                        <div class="row justify-content-center">
                                            <div class="col-lg-8 mx-auto">
    
                                                <div class="testimonial-block text-center">
                                                    <blockquote class="mb-5">
                                                        <p>&ldquo;My CervicalSupport Pillow finally helped me wake up without neck stiffness. After trying countless pillows, this is the first one that actually supports my neck properly all night long.&rdquo;</p>
                                                    </blockquote>
    
                                                    <div class="author-info">
                                                        <div class="author-pic">
                                                            <img src="<c:url value='/assets/images/person_3.jpg'/>" alt="Emily Rodriguez" class="img-fluid">
                                                        </div>
                                                        <h3 class="font-weight-bold">Emily Rodriguez</h3>
                                                        <span class="position d-block mb-3">Elementary Teacher</span>
                                                    </div>
                                                </div>
    
                                            </div>
                                        </div>
                                    </div> 
                                    <!-- END item -->
                                </c:if>
                            </div>
                                
    
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Testimonial Slider -->
    
    
            <!-- Start Footer Section -->
    <footer class="site-footer">
        <div class="footer-main">
            <div class="container">
                <div class="row">
                    <!-- Contact Column -->
                    <div class="col-lg-4 col-md-6 mb-5 mb-lg-0">
                        <div class="footer-widget">
                            <div class="logo mb-3">
                                <i class="fas fa-chair logo-icon"></i>
                                Rela<span>X</span>it
                            </div>
                            <p class="footer-text">Revolutionizing spinal health through scientifically designed ergonomic solutions.</p>
                            <div class="footer-contact">
                                <div class="contact-item">
                                    <i class="fas fa-map-marker-alt contact-icon"></i>
                                    <span>New Cairo, Cairo, Egypt</span>
                                </div>
                                <div class="contact-item">
                                    <i class="fas fa-phone-alt contact-icon"></i>
                                    <span>(011)213-43747</span>
                                </div>
                                <div class="contact-item">
                                    <i class="fas fa-envelope contact-icon"></i>
                                    <span>support@relaxit.com</span>
                                </div>
                            </div>
                        </div>
                    </div>
    
                    <!-- Quick Links Column -->
                    <div class="col-lg-2 col-md-3 col-sm-6 mb-5 mb-md-0">
                        <h3 class="footer-heading">Products</h3>
                        <ul class="footer-links">
                            <li><a href="#">Ergonomic Chairs</a></li>
                            <li><a href="#">Lumbar Supports</a></li>
                            <li><a href="#">Posture Correctors</a></li>
                            <li><a href="#">Standing Desks</a></li>
                            <li><a href="#">Cervical Pillows</a></li>
                        </ul>
                    </div>
    
                    <!-- Resources Column -->
                    <div class="col-lg-2 col-md-3 col-sm-6 mb-5 mb-sm-0">
                        <h3 class="footer-heading">Resources</h3>
                        <ul class="footer-links">
                            <li><a href="#">Posture Guides</a></li>
                            <li><a href="#">Ergonomics Research</a></li>
                            <li><a href="#">Spine Health Blog</a></li>
                            <li><a href="#">Clinical Studies</a></li>
                            <li><a href="#">FAQ</a></li>
                        </ul>
                    </div>
    
                    <!-- Newsletter Column -->
                    <div class="col-lg-4 col-md-6">
                        <h3 class="footer-heading">Join Our Wellness Newsletter</h3>
                        <p class="footer-text">Get ergonomic tips and exclusive offers for spine health.</p>
                        <form class="newsletter-form">
                            <div class="input-group">
                                <input type="email" class="form-control" placeholder="Your email address" required>
                                <button class="btn btn-subscribe" type="submit">
                                    <i class="fas fa-paper-plane"></i>
                                </button>
                            </div>
                        </form>
                        <div class="social-links mt-4">
                            <a href="#" class="social-icon"><i class="fab fa-facebook-f"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-twitter"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-instagram"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-linkedin-in"></i></a>
                            <a href="#" class="social-icon"><i class="fab fa-youtube"></i></a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    
        <!-- Copyright Section -->
        <div class="footer-bottom">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-md-6 text-center text-md-start">
                        <p class="copyright-text mb-3 mb-md-0">&copy; 2025 RelaXit. All rights reserved. </p>
                    </div>
                    <div class="col-md-6 text-center text-md-end">
                        <div class="payment-methods">
                            <img src="<c:url value='/assets/images/payment/1.png'/>" alt="Visa">
                            <img src="<c:url value='/assets/images/payment/2.png'/>" alt="Mastercard">
                            <img src="<c:url value='/assets/images/payment/3.png'/>" alt="American Express">
                            <img src="<c:url value='/assets/images/payment/4.png'/>" alt="PayPal">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </footer>
    <!-- End Footer Section -->
    <script>
        const baseUrl = '${pageContext.request.contextPath}';
    </script>
    
            <script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>"></script>
            <script src="<c:url value='/assets/js/tiny-slider.js'/>"></script>
            <script src="<c:url value='/assets/js/custom.js'/>"></script>
            <script src="<c:url value='/assets/js/cart.js'/>"></script>
        </body>
</html>