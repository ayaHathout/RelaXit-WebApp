<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Shop Page</title>
	<!-- Bootstrap CSS -->
	<link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
	<link href="<c:url value='/assets/css/first.css'/>" rel="stylesheet">

	<link href="<c:url value='/assets/css/shop.css'/>" rel="stylesheet" type="text/css">
	<link href="<c:url value='/assets/css/style.css'/>" rel="stylesheet" type="text/css">
	<link href="<c:url value='/assets/css/aos.css'/>" rel="stylesheet">
	<!-- <link rel="stylesheet" href="/relaxit/assets/css/default.css"> -->

	<!-- material-design-iconic-font css -->
    <link href="<c:url value='/assets/css/material-design-iconic-font.css'/>" rel="stylesheet">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/material-design-iconic-font@2.2.0/dist/css/material-design-iconic-font.min.css">

	<link rel="stylesheet" href="<c:url value='/assets/css/default.css'/>">
	
	  
	</head>
<body>

<!-- Include the header with custom parameters -->
<jsp:include page="header.jsp">
    <jsp:param name="activePage" value="shop" />
    <jsp:param name="heroTitle" value="Shop" />
</jsp:include>


		<!-- Shop -->
		<section class="shop1-con classic-con position-relative">
			<div class="container">
				<div class="row">
					<div class="sidebar sticky-sidebar col-lg-3">
						<div class="theiaStickySidebar">
							<div class="widget widget-categories" data-aos="fade-up">
								<div class="widget-title font_weight_600">Categories</div>
								<ul class="list-unstyled mb-0">
									<!-- 1. Chairs by Type -->
									<li class="cat-item cat-parent">
										<a href="chairs-by-type.html">Chairs by Type</a>
										<ul class="children">
											<li class="cat-item">
												<a href="fixed-chairs.html">Fixed Chairs</a>
												<ul class="children">
													<li><a href="office-chairs.html">Office chairs</a></li>
													<li><a href="gaming-chairs.html">Gaming chairs</a></li>
													<li><a href="conference-chairs.html">Conference room chairs</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="adjustable-chairs.html">Adjustable Chairs</a>
												<ul class="children">
													<li><a href="recliners.html">Multi-position recliners</a></li>
													<li><a href="active-chairs.html">Active sitting chairs</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 2. Back Support -->
									<li class="cat-item cat-parent">
										<a href="back-support.html">Back Support</a>
										<ul class="children">
											<li class="cat-item">
												<a href="lumbar-support.html">Lumbar Support Products</a>
												<ul class="children">
													<li><a href="backrest-cushions.html">Attachable backrest cushions</a></li>
													<li><a href="memory-foam-pillows.html">Memory foam back pillows</a></li>
													<li><a href="mesh-supports.html">Mesh ventilated back supports</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="posture-correctors.html">Posture Correctors</a>
												<ul class="children">
													<li><a href="back-braces.html">Wearable back braces</a></li>
													<li><a href="posture-belts.html">Posture training belts</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 3. Seat Cushions -->
									<li class="cat-item cat-parent">
										<a href="seat-cushions.html">Seat Cushions</a>
										<ul class="children">
											<li class="cat-item">
												<a href="chair-pads.html">Chair Pads</a>
												<ul class="children">
													<li><a href="gel-cushions.html">Gel-infused seat cushions</a></li>
													<li><a href="foam-toppers.html">Memory foam seat toppers</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="specialty-cushions.html">Specialty Cushions</a>
												<ul class="children">
													<li><a href="coccyx-cushions.html">Coccyx cushions</a></li>
													<li><a href="hemorrhoid-cushions.html">Hemorrhoid relief cushions</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 4. Neck & Travel Comfort -->
									<li class="cat-item cat-parent">
										<a href="neck-travel.html">Neck and Travel Comfort</a>
										<ul class="children">
											<li class="cat-item">
												<a href="neck-pillows.html">Neck Pillows</a>
												<ul class="children">
													<li><a href="car-neck-supports.html">Car seat neck supports</a></li>
													<li><a href="travel-pillows.html">Airplane travel pillows</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="portable-solutions.html">Portable Solutions</a>
												<ul class="children">
													<li><a href="inflatable-cushions.html">Inflatable seat cushions</a></li>
													<li><a href="foldable-supports.html">Foldable posture supports</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 5. Workspace Accessories -->
									<li class="cat-item cat-parent">
										<a href="workspace-accessories.html">Workspace Accessories</a>
										<ul class="children">
											<li class="cat-item">
												<a href="desk-ergonomics.html">Desk Ergonomics</a>
												<ul class="children">
													<li><a href="footrests.html">Adjustable footrests</a></li>
													<li><a href="wrist-rests.html">Keyboard wrist rests</a></li>
													<li><a href="laptop-stands.html">Laptop stands</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="comfort-addons.html">Comfort Add-ons</a>
												<ul class="children">
													<li><a href="desk-hammocks.html">Under-desk hammocks</a></li>
													<li><a href="seat-storage.html">Seat-mounted storage</a></li>
												</ul>
											</li>
										</ul>
									</li>
								</ul>
							</div>
						</div>
					</div>
					<div class="col-lg-9">
						<div class="row shop-products-con" data-aos="fade-up">

						    <c:forEach items="${products}" var="curProduct" varStatus="status">
                                <div class="col-xl-4 col-lg-6 col-md-6 col-sm-6">
                                    <div class="classic-box">
                                        <div class="classic_image_box box${status.index + 1}">
                                            <figure class="mb-0">
                                                <img src="${pageContext.request.contextPath}/assets/img/classic-image1.png" alt="image" class="img-fluid">
                                            </figure>
                                        </div>
                                        <div class="classic_box_content">
                                            <div class="text_wrapper position-relative">
                                                <a href="views/product-detail.jsp"><h6>${curProduct.name}</h6></a>
                                            </div>
                                            <p class="text-size-16">${curProduct.description}</p>
                                            <div class="price_wrapper position-relative">
                                                <span class="dollar">$<span class="counter">${curProduct.price}</span></span>
												<button class="add-to-cart" data-product-id="${curProduct.productId}">
													<img src="/relaxit/assets/img/cart.png" alt="Add to cart" class="img-fluid">
												</button>
											
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>


							<ul class="pagination" data-aos="fade-up">
								<li class="page-item"><a class="page-link" href="one-column.html">1</a></li>
								<li class="page-item"><a class="page-link" href="two-column.html">2</a></li>
								<li class="page-item"><a class="page-link" href="three-column.html">3</a></li>
								<li class="page-item next">
									<a class="page-link" href="single-blog.html"><i class="fas fa-angle-right"></i></a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</section>


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
<script src="<c:url value='/assets/js/main.min.js'/>"></script>
	</body>
</html>
