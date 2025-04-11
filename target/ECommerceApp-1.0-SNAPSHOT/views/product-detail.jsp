<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>${product.name} - RelaxIt</title>
    <!-- Include your CSS files here -->
    <!-- ... -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Include your header here -->
    <!-- ... -->

    <!-- Product Detail Section -->
    <div class="product-detail-section">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <div class="product-image">
                        <img src="<c:url value='${product.imageUrl}'/>" alt="${product.name}" class="img-fluid">
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="product-info">
                        <h1>${product.name}</h1>
                        <div class="price-box">
                            <span class="price">$${product.price}</span>
                            <c:if test="${product.oldPrice != null}">
                                <span class="old-price">$${product.oldPrice}</span>
                            </c:if>
                        </div>
                        <div class="product-description">
                            <p>${product.description}</p>
                        </div>
                        
                        <div class="quantity-cart-box d-flex align-items-center">
                            <div class="quantity-box">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <button class="btn quantity-left-minus" type="button" data-type="minus">
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                    <input type="text" class="form-control" id="product-quantity" value="1" min="1">
                                    <div class="input-group-append">
                                        <button class="btn quantity-right-plus" type="button" data-type="plus">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                            <div class="cart-box ml-3">
                                <button id="add-to-cart-btn" class="btn btn-primary" data-product-id="${product.productId}">
                                    <i class="fa fa-shopping-cart"></i> Add to Cart
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- End Product Detail Section -->

    <!-- Include your footer here -->
    <!-- ... -->
    
    <!-- Include JavaScript dependencies -->
    <script src="<c:url value='/js/cart.js'/>"></script>
    <script src="<c:url value='/js/product-detail.js'/>"></script>
</body>
</html>