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
                                <form action="/relaxit2/thanks" id="contactpage" method="post" class="position-relative">
                                    <div class="upper-form" data-aos="fade-up">
                                        <span class="address">Billing Address:</span>
                                            <div class="form-group input1 float-left">
                                                <label for="fname">First name</label>
                                                <input type="text" class="form_style" name="fname" id="fname" placeholder="Enter your first name" required>
                                            </div>
                                            <div class="form-group float-left">
                                                <label for="lname">Last name</label>
                                                <input type="text" class="form_style" name="lname" id="lname" placeholder="Enter your last name" required>
                                            </div>
                                            <div class="form-group input1 float-left">
                                                <label for="email">Email address</label>
                                                <input type="email" class="form_style" name="email" id="email" placeholder="Enter a valid email address" required>
                                            </div>
                                            <div class="form-group float-left">
                                                <label>State</label>
                                                <select class="form-control" required>
                                                    <option value="" name="state" disabled selected hidden>Select State</option>
                                                    <option value="Cairo">Cairo</option>
                                                    <option value="Giza">Giza</option>
                                                    <option value="Alexandria">Alexandria</option>
                                                    <option value="Qalyubia">Qalyubia</option>
                                                    <option value="Port Said">Port Said</option>
                                                    <option value="Suez">Suez</option>
                                                    <option value="Dakahlia">Dakahlia</option>
                                                    <option value="Sharqia">Sharqia</option>
                                                    <option value="Gharbia">Gharbia</option>
                                                    <option value="Monufia">Monufia</option>
                                                    <option value="Beheira">Beheira</option>
                                                    <option value="Kafr El Sheikh">Kafr El Sheikh</option>
                                                    <option value="Damietta">Damietta</option>
                                                    <option value="Ismailia">Ismailia</option>
                                                    <option value="Fayoum">Fayoum</option>
                                                    <option value="Beni Suef">Beni Suef</option>
                                                    <option value="Minya">Minya</option>
                                                    <option value="Asyut">Asyut</option>
                                                    <option value="Sohag">Sohag</option>
                                                    <option value="Qena">Qena</option>
                                                    <option value="Luxor">Luxor</option>
                                                    <option value="Aswan">Aswan</option>
                                                    <option value="Red Sea">Red Sea</option>
                                                    <option value="New Valley">New Valley</option>
                                                    <option value="Matrouh">Matrouh</option>
                                                    <option value="North Sinai">North Sinai</option>
                                                    <option value="South Sinai">South Sinai</option>
                                                </select>
                                            </div>
                                            <div class="form-group input1 float-left">
                                                <label>City</label>
                                                <select class="form-control" required>
                                                    <option value="" name="city" disabled selected hidden>Select City</option>
                                                    <option value="Nasr City">Nasr City</option>
                                                    <option value="Heliopolis">Heliopolis</option>
                                                    <option value="6th of October">6th of October</option>
                                                    <option value="New Cairo">New Cairo</option>
                                                    <option value="Maadi">Maadi</option>
                                                    <option value="Shubra">Shubra</option>
                                                    <option value="Tanta">Tanta</option>
                                                    <option value="Mansoura">Mansoura</option>
                                                    <option value="Zagazig">Zagazig</option>
                                                    <option value="Ismailia City">Ismailia City</option>
                                                    <option value="Banha">Banha</option>
                                                    <option value="Fayoum City">Fayoum City</option>
                                                    <option value="Aswan City">Aswan City</option>
                                                    <option value="Qena City">Qena City</option>
                                                    <option value="Hurghada">Hurghada</option>
                                                    <option value="Sharm El-Sheikh">Sharm El-Sheikh</option>
                                                    <option value="Luxor City">Luxor City</option>
                                                    <option value="Port Said City">Port Said City</option>
                                                    <option value="Suez City">Suez City</option>
                                                    <option value="Arish">Arish</option>
                                                </select>
                                            </div>
                                            <div class="form-group float-left">
                                                <label for="code">Zip/ postal code</label>
                                                <input type="text" class="form_style" name="code" id="code" placeholder="Enter your area postal code" required>
                                            </div>
                                        </div>
                                        <div class="lower-form" data-aos="fade-up">
                                            <span class="address">Payment Method:</span>
                                        <div class="form-group float-left checkbox">
                                            <input type="radio" name="paymentMethod" value="wallet" id="card" required>
                                            <label for="card">Wallet</label>
                                        </div>

                                        <div class="form-group float-left checkbox">
                                            <input type="radio" name="paymentMethod" value="cash" id="cash">
                                            <label for="cash">Cash on Delivery</label>
                                        </div>

                                        <p class="text-center text-size-14">By clicking the button, you agree to the <a href="terms-of-conditions.html" class="text-decoration-none terms-btn">Terms and Conditions</a></p>
                                    </div>
                                    <button type="submit" class="submit_now text-decoration-none">
                                        Place Order Now <i class="fa-solid fa-arrow-right"></i>
                                    </button>

                                   <!-- <a href="/relaxit2/thanks" data-aos="fade-up" type="submit" id="submit" class="submit_now text-decoration-none">Palce Order Now<i class="fa-solid fa-arrow-right"></i></a> -->
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
