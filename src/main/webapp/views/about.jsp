<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <title>About Us - RelaXit</title>

		<!-- StyleSheet link CSS -->
		<link href="../assets/css/bootstrap.min.css" rel="stylesheet">
		<link href="../assets/css/responsive.css" rel="stylesheet" type="text/css">
		<link href="../assets/css/aos.css" rel="stylesheet">
		<link href="<c:url value='/assets/css/first.css'/>" rel="stylesheet">
		<link href="<c:url value='/assets/css/about-page.css'/>" rel="stylesheet">

		<!-- Bootstrap CSS -->
		<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
		<link href="<c:url value='/assets/css/tiny-slider.css'/>" rel="stylesheet">

		<!-- material-design-iconic-font css -->
        <link rel="stylesheet" href="<c:url value='/assets/css/material-design-iconic-font.css'/>">
        <!-- All common css of theme -->
        <link rel="stylesheet" href="<c:url value='/assets/css/default.css'/>">
		<style>
			/* About Page Styles - RelaXit */

/* Base variables for consistent theming */
:root {
  --primary-color: #378ac9;
  --primary-dark: #2c6fa3;
  --primary-light: #5aa3db;
  --accent-color: #f8f9fa;
  --text-dark: #333333;
  --text-light: #737373;
  --white: #ffffff;
  --section-padding: 5rem 0;
  --transition: all 0.3s ease;
}

/* Journey section styling */
.journey-con {
  background-color: var(--white);
  padding: var(--section-padding);
  overflow: hidden;
}

/* Image container styling */
.journey_wrapper {
  position: relative;
  border-radius: 8px;
  overflow: hidden;
  box-shadow: 0 15px 30px rgba(55, 138, 201, 0.1);
}

.journey_wrapper::before {
  content: "";
  position: absolute;
  left: -20px;
  top: -20px;
  width: 80px;
  height: 80px;
  border-radius: 50%;
  background-color: rgba(55, 138, 201, 0.15);
  z-index: -1;
}

.journey_wrapper::after {
  content: "";
  position: absolute;
  right: -30px;
  bottom: -30px;
  width: 120px;
  height: 120px;
  border-radius: 8px;
  background-color: rgba(55, 138, 201, 0.08);
  z-index: -1;
}

.journey-image {
  position: relative;
  overflow: hidden;
  border-radius: 8px;
  transition: var(--transition);
}

.journey-image img {
  width: 100%;
  height: auto;
  object-fit: cover;
  transition: var(--transition);
  transform: scale(1);
}

.journey-image:hover img {
  transform: scale(1.05);
}

/* Content styling */
.journey_content {
  padding: 1.5rem 0 1.5rem 2rem;
}

.journey_content h2 {
  font-size: 2.5rem;
  font-weight: 700;
  margin-bottom: 1.5rem;
  color: var(--text-dark);
  position: relative;
  padding-bottom: 15px;
}

.journey_content h2::after {
  content: '';
  position: absolute;
  left: 0;
  bottom: 0;
  width: 80px;
  height: 4px;
  background-color: var(--primary-color);
}

.text1 {
  font-size: 1.1rem;
  line-height: 1.8;
  color: var(--text-dark);
  margin-bottom: 1.5rem;
  white-space: pre-line;
}

.text2 {
  font-size: 1.2rem;
  font-weight: 500;
  line-height: 1.6;
  font-style: italic;
  color: var(--primary-dark);
  padding: 1.5rem;
  background-color: rgba(55, 138, 201, 0.05);
  border-left: 4px solid var(--primary-color);
  border-radius: 0 8px 8px 0;
}

/* Call-to-action section */
.cta-section {
  background-color: var(--primary-color);
  padding: 4rem 0;
  margin: 3rem 0;
  position: relative;
  overflow: hidden;
}

.cta-section::before {
  content: "";
  position: absolute;
  right: 0;
  top: 0;
  width: 30%;
  height: 100%;
  background-color: rgba(255, 255, 255, 0.05);
  clip-path: polygon(25% 0%, 100% 0%, 100% 100%, 0% 100%);
}

.cta-content {
  text-align: center;
  color: var(--white);
}

.cta-content h3 {
  font-size: 2.2rem;
  font-weight: 700;
  margin-bottom: 1.5rem;
}

.cta-content p {
  font-size: 1.1rem;
  max-width: 700px;
  margin: 0 auto 2rem;
}

.cta-btn {
  display: inline-block;
  padding: 12px 30px;
  background-color: var(--white);
  color: var(--primary-color);
  border-radius: 50px;
  font-weight: 600;
  text-decoration: none;
  transition: var(--transition);
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.cta-btn:hover {
  background-color: rgba(255, 255, 255, 0.9);
  transform: translateY(-3px);
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

/* Team section */
.team-section {
  padding: var(--section-padding);
  background-color: var(--accent-color);
}

.section-title {
  text-align: center;
  margin-bottom: 3rem;
}

.section-title h2 {
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--text-dark);
  margin-bottom: 1rem;
  position: relative;
  display: inline-block;
}

.section-title h2::after {
  content: '';
  position: absolute;
  left: 50%;
  bottom: -10px;
  width: 80px;
  height: 4px;
  background-color: var(--primary-color);
  transform: translateX(-50%);
}

.section-title p {
  font-size: 1.1rem;
  color: var(--text-light);
  max-width: 700px;
  margin: 0 auto;
}

/* Values section */
.values-section {
  padding: var(--section-padding);
}

.value-card {
  padding: 2rem;
  border-radius: 8px;
  background-color: var(--white);
  box-shadow: 0 8px 20px rgba(55, 138, 201, 0.08);
  height: 100%;
  transition: var(--transition);
}

.value-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 30px rgba(55, 138, 201, 0.15);
}

.value-icon {
  width: 70px;
  height: 70px;
  line-height: 70px;
  text-align: center;
  background-color: rgba(55, 138, 201, 0.1);
  border-radius: 50%;
  margin-bottom: 1.5rem;
  transition: var(--transition);
}

.value-card:hover .value-icon {
  background-color: var(--primary-color);
  color: var(--white);
}

.value-card h3 {
  font-size: 1.5rem;
  font-weight: 600;
  margin-bottom: 1rem;
  color: var(--text-dark);
}

.value-card p {
  font-size: 1rem;
  color: var(--text-light);
  line-height: 1.7;
}

/* Responsive adjustments */
@media (max-width: 991px) {
  .journey_content {
    padding: 2rem 0 0 0;
    margin-top: 2rem;
  }
  
  .journey_content h2 {
    font-size: 2rem;
  }
  
  .text1, .text2 {
    font-size: 1rem;
  }
}

@media (max-width: 767px) {
  :root {
    --section-padding: 3rem 0;
  }
  
  .journey-con {
    padding-top: 3rem;
    padding-bottom: 3rem;
  }
  
  .journey_wrapper {
    margin-bottom: 2rem;
  }
  
  .cta-section {
    padding: 3rem 0;
  }
  
  .cta-content h3 {
    font-size: 1.8rem;
  }
}

/* Animation enhancement */
[data-aos] {
  transition-duration: 800ms;
}

[data-aos="zoom-in"] {
  transform: scale(0.9);
  opacity: 0;
  transition-property: transform, opacity;
}

[data-aos="zoom-in"].aos-animate {
  transform: scale(1);
  opacity: 1;
}

[data-aos="fade-up"] {
  transform: translateY(30px);
  opacity: 0;
  transition-property: transform, opacity;
}

[data-aos="fade-up"].aos-animate {
  transform: translateY(0);
  opacity: 1;
}
		</style>
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
				<div class="row align-items-center">
					<div class="col-xl-5 col-lg-6 col-md-12 col-sm-12 col-12">
						<div class="journey_wrapper position-relative" data-aos="zoom-in">
							<figure class="journey-image mb-0">
								<img src="../assets/images/about2.png" alt="RelaXit's Journey" class="img-fluid">
							</figure>
						</div>
					</div>
					<div class="col-xl-7 col-lg-6 col-md-12 col-sm-12 col-12">
						<div class="journey_content" data-aos="fade-up">
                            <h2>Our Story</h2>
							<p class="text1">At RelaXit, we create ergonomic seats and pillows designed to support your spine and improve your posture because we believe comfort starts with proper sitting.

								Our vision is simple: to make spinal health a priority in every home, office, and space. We're not just selling products, we're offering a lifestyle change.
								
								What makes us different? Our products provide active support while you sit, work, or travel not just passive comfort. They're designed for real life, helping you maintain better posture naturally.
								
								We're here to do more than just cushion your seat. We're helping you sit right, feel better, and live healthier one ergonomic solution at a time.
								
								Try RelaXit today and experience the difference proper support can make.
								
								RelaXit, Where comfort meets spinal health.
							</p>
							<p class="text2">We take pride in offering a diverse range of options, including ergonomic solutions for every body type and need, so everyone can experience the perfect support.</p>
						</div>
					</div>
				</div>
			</div>
		</section>
		<!-- End of About us section -->
        
        <!-- Start of Values section -->
        <section class="values-section">
            <div class="container">
                <div class="section-title" data-aos="fade-up">
                    <h2>Our Values</h2>
                    <p>The principles that guide everything we do at RelaXit</p>
                </div>
                
                <div class="row mt-5">
                    <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="100">
                        <div class="value-card">
                            <div class="value-icon">
                                <i class="fas fa-heart fa-2x" style="color: #378ac9;"></i>
                            </div>
                            <h3>Comfort First</h3>
                            <p>We believe that true comfort comes from proper support. Every product we design prioritizes your physical wellbeing above all else.</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                        <div class="value-card">
                            <div class="value-icon">
                                <i class="fas fa-medal fa-2x" style="color: #378ac9;"></i>
                            </div>
                            <h3>Quality Craftsmanship</h3>
                            <p>We use only premium materials and meticulous manufacturing processes to ensure our products provide lasting support and durability.</p>
                        </div>
                    </div>
                    
                    <div class="col-lg-4 col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                        <div class="value-card">
                            <div class="value-icon">
                                <i class="fas fa-lightbulb fa-2x" style="color: #378ac9;"></i>
                            </div>
                            <h3>Innovation</h3>
                            <p>We continuously research and develop new ergonomic solutions that adapt to modern lifestyles and address evolving postural challenges.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- End of Values section -->
        
        <!-- Start of CTA section -->
        <section class="cta-section">
            <div class="container">
                <div class="cta-content" data-aos="zoom-in">
                    <h3>Experience Better Support Today</h3>
                    <p>Discover how our ergonomic products can transform the way you sit, work, and relax.</p>
                    <a href="<c:url value='/products'/>" class="cta-btn">Explore Our Products</a>
                </div>
            </div>
        </section>
        <!-- End of CTA section -->

		<!-- Include the footer -->
        <jsp:include page="footer.jsp" />

        <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>

		<!-- all js here -->
		<script src="<c:url value='/assets/js/bootstrap.bundle.min.js'/>"></script>
		<script src="<c:url value='/assets/js/tiny-slider.js'/>"></script>
		<script src="<c:url value='/assets/js/custom.js'/>"></script>

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