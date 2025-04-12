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
										<a href="/relaxit/views/chairs-by-type.jsp">Chairs by Type</a>
										<ul class="children">
											<li class="cat-item">
												<a href="category?category-id=1">Fixed Chairs</a>
												<ul class="children">
													<li><a href="/relaxit/views/office-chairs.jsp">Office chairs</a></li>
													<li><a href="/relaxit/views/gaming-chairs.jsp">Gaming chairs</a></li>
													<li><a href="/relaxit/views/conference-chairs.jsp">Conference room chairs</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="category?category-id=2">Adjustable Chairs</a>
												<ul class="children">
													<li><a href="/relaxit/views/recliners.jsp">Multi-position recliners</a></li>
													<li><a href="/relaxit/views/active-chairs.jsp">Active sitting chairs</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 2. Back Support -->
									<li class="cat-item cat-parent">
										<a href="/relaxit/views/back-support.jsp">Back Support</a>
										<ul class="children">
											<li class="cat-item">
												<a href="category?category-id=3">Lumbar Support Products</a>
												<ul class="children">
													<li><a href="/relaxit/views/backrest-cushions.jsp">Attachable backrest cushions</a></li>
													<li><a href="/relaxit/views/memory-foam-pillows.jsp">Memory foam back pillows</a></li>
													<li><a href="/relaxit/views/mesh-supports.jsp">Mesh ventilated back supports</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="category?category-id=4">Posture Correctors</a>
												<ul class="children">
													<li><a href="/relaxit/views/back-braces.jsp">Wearable back braces</a></li>
													<li><a href="/relaxit/views/posture-belts.jsp">Posture training belts</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 3. Seat Cushions -->
									<li class="cat-item cat-parent">
										<a href="/relaxit/views/seat-cushions.jsp">Seat Cushions</a>
										<ul class="children">
											<li class="cat-item">
												<a href="category?category-id=5">Chair Pads</a>
												<ul class="children">
													<li><a href="/relaxit/views/gel-cushions.jsp">Gel-infused seat cushions</a></li>
													<li><a href="/relaxit/views/foam-toppers.jsp">Memory foam seat toppers</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="category?category-id=6">Specialty Cushions</a>
												<ul class="children">
													<li><a href="/relaxit/views/coccyx-cushions.jsp">Coccyx cushions</a></li>
													<li><a href="/relaxit/views/hemorrhoid-cushions.jsp">Hemorrhoid relief cushions</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 4. Neck & Travel Comfort -->
									<li class="cat-item cat-parent">
										<a href="category?category-id=7">Neck and Travel Comfort</a>
										<ul class="children">
											<li class="cat-item">
												<a href="category?category-id=7">Neck Pillows</a>
												<ul class="children">
													<li><a href="/relaxit/views/car-neck-supports.jsp">Car seat neck supports</a></li>
													<li><a href="/relaxit/views/travel-pillows.jsp">Airplane travel pillows</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="category?category-id=8">Portable Solutions</a>
												<ul class="children">
													<li><a href="/relaxit/views/inflatable-cushions.jsp">Inflatable seat cushions</a></li>
													<li><a href="/relaxit/views/foldable-supports.jsp">Foldable posture supports</a></li>
												</ul>
											</li>
										</ul>
									</li>

									<!-- 5. Workspace Accessories -->
									<li class="cat-item cat-parent">
										<a href="/relaxit/views/workspace-accessories.jsp">Workspace Accessories</a>
										<ul class="children">
											<li class="cat-item">
												<a href="category?category-id=9">Desk Ergonomics</a>
												<ul class="children">
													<li><a href="/relaxit/views/footrests.jsp">Adjustable footrests</a></li>
													<li><a href="/relaxit/views/wrist-rests.jsp">Keyboard wrist rests</a></li>
													<li><a href="/relaxit/views/laptop-stands.jsp">Laptop stands</a></li>
												</ul>
											</li>
											<li class="cat-item">
												<a href="category?category-id=10">Comfort Add-ons</a>
												<ul class="children">
													<li><a href="/relaxit/views/desk-hammocks.jsp">Under-desk hammocks</a></li>
													<li><a href="/relaxit/views/seat-storage.jsp">Seat-mounted storage</a></li>
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
                                                    <a href="views/cart.jsp" class="add-to-cart" data-product-id="${curProduct.productId}"><img src="/relaxit/assets/img/cart.png" alt="image" class="img-fluid"></a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                            </c:forEach>

                            <!-- Pagination -->
                            <ul class="pagination" data-aos="fade-up">
                                <c:if test="${pageNumber > 1}">
                                    <li class="page-item next">
                                        <a class="page-link" href="shop?page=${pageNumber - 1}"><i class="fas fa-angle-left"></i></a>
                                    </li>
                                </c:if>

                                <c:forEach begin="1" end="${totalPages}" var="i">
                                    <li class="page-item ${i == pageNumber ? 'active' : ''}">
                                        <a class="page-link" href="shop?page=${i}">${i}</a>
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
