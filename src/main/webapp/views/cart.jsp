<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!doctype html>
<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

		<title>Cart Page</title>
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

<!-- Cart -->
<div class="cart-con position-relative">
    <div class="container">
        <div class="row">
            <div class="col-lg-8 col-12">
                <div class="product-detail-box" data-aos="fade-up">
                    <div class="heading">
                        <span>Shopping Cart</span>
                        <span>(<span id="cart-count">${cartItemCount}</span> Items)</span>
                    </div>
                    <div class="shopping-cart">
                        <div class="column-labels">
                            <label class="product-details">Product Details</label>
                            <label class="product-price">Price</label>
                            <label class="product-quantity">Quantity</label>
                            <label class="product-line-price">Total</label>
                            <label class="product-removal"></label>
                        </div>
                        <div class="shopping-cart-info" id="cart-items-container">
                            <c:choose>
                                <c:when test="${empty cartItems}">
                                    <div class="empty-cart-message text-center py-5">
                                        <i class="fas fa-shopping-cart fa-4x mb-3"></i>
                                        <h4>Your cart is empty</h4>
                                        <p class="text-muted">Looks like you haven't added any items to your cart yet.</p>
                                        <a href="<c:url value='/shop'/>" class="btn btn-primary mt-3">Continue Shopping</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="item" items="${cartItems}">
                                        <div class="product d-sm-flex d-block align-items-center" data-cart-id="${item.cartId}">
                                            <div class="product-details">
                                                <div class="product-image">
                                                    <figure class="mb-0">
                                                        <img src="<c:url value='${empty item.product.productImage ? "/relaxit/assets/images/products/holder.png" : item.product.productImage}'/>" alt="${item.product.name}" class="img-fluid">
                                                    </figure>
                                                </div>
                                                <div class="product-content">
                                                    <span class="product-title">${item.product.name}</span>
                                                </div>
                                            </div>
                                            <div class="product-price"><span>$${item.product.price}</span></div>
                                            <div class="product-quantity d-flex">
                                                <div class="product-qty-details">
                                                    <button class="value-button decrease-button" data-cart-id="${item.cartId}" title="Decrease quantity">-</button>
                                                    <div class="number">${item.quantity}</div>
                                                    <button class="value-button increase-button" data-cart-id="${item.cartId}" title="Increase quantity">+</button>
                                                </div>
                                            </div>
                                            <div class="product-line-price"><span>$${item.itemTotal}</span></div>
                                            <div class="product-removal">
                                                <button class="remove-product" data-cart-id="${item.cartId}" title="Remove item">
                                                    <i class="fas fa-times"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <div class="buttun-shopping">
                        <a href="<c:url value='views/shop'/>" class="text-decoration-none">
                            <i class="fa-solid fa-arrow-left"></i> Continue Shopping
                        </a>
                        <c:if test="${not empty cartItems}">
                            <button id="clear-cart" class="btn btn-outline-danger ms-3">Clear Cart</button>
                        </c:if>
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
                        <a href="#" class="text-decoration-none" id="apply-coupon">Apply</a>
                    </div>
                    <div class="detail">
                        <span class="heading">Product Details:</span>
                        <ul class="list-unstyled mb-0">
                            <li><span>Sub Total</span><span class="dollar" id="subtotal">$${cartTotal}</span></li>
                            <li><span>Shipping</span><span class="dollar" id="shipping">$${cartItemCount > 0 ? '20.00' : '0.00'}</span></li>
                        </ul>
                        <div class="all-total">
                            <div class="total">
                                <span class="text">Grand Total</span>
                                <span class="dollar" id="grand-total">$${grandTotal}</span>
                            </div>
                            <a href="<c:url value='/views/checkout.jsp'/>"
                               class="text-decoration-none all_button ${empty cartItems ? 'disabled' : ''}" 
                               id="checkout-button">
                                Proceed to checkout <i class="fa-solid fa-arrow-right"></i>
                            </a>
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

<script>
    // Initialize cart functionality when page loads
    document.addEventListener('DOMContentLoaded', function() {
        if (document.querySelector('.shopping-cart')) {
            initCartPage();
        }
    });
</script>


<!-- Include the footer -->
<jsp:include page="footer.jsp" />



<script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>


		<!-- Latest compiled JavaScript -->
		<script src="<c:url value='/assets/js/jquery-3.7.1.min.js'/>"></script>
		<script src="<c:url value='/assets/js/popper.min.js'/>"></script>
		<script src="<c:url value='/assets/js/search.js'/>"></script>
		<script src="<c:url value='/assets/js/aos.js'/>"></script>
		<script src="<c:url value='/assets/js/owl.carousel.js'/>"></script>
		<script src="<c:url value='/assets/js/carousel.js'/>"></script>
		<script src="<c:url value='/assets/js/animation.js'/>"></script>
		<script src="<c:url value='/assets/js/back-to-top-button.js'/>"></script>
		<script src="<c:url value='/assets/js/preloader.js'/>"></script>
		<script src="<c:url value='/assets/js/bootstrap.min.js'/>"></script>


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
