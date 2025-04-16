<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <title>${product.name} - RelaxIt</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link href="<c:url value='/assets/css/bootstrap.min.css'/>" rel="stylesheet">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css"
                rel="stylesheet">
            <link href="<c:url value='/assets/css/first.css'/>" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet"
                href="https://cdn.jsdelivr.net/npm/material-design-iconic-font@2.2.0/dist/css/material-design-iconic-font.min.css">
            <!-- <link rel="stylesheet" href="<c:url value='/assets/css/default.css'/>"> -->

            <style>
                :root {
                    --primary-color: #4399ee;
                    --secondary-color: #3765c9;
                    --accent-color: #f72585;
                    --light-gray: #f8f9fa;
                    --dark-gray: #6c757d;
                    --border-radius: 8px;
                    --box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    --transition: all 0.3s ease;
                }

                .product-detail-section {
                    padding: 3rem 0;
                    background-color: white;
                }

                .product-image-container {
                  position: relative;
                  border-radius: var(--border-radius);
                  overflow: hidden;
                  box-shadow: var(--box-shadow);
                  margin-bottom: 1.5rem;
                  height: 500px; 
                  display: flex;
                  justify-content: center;
                  align-items: center;
                  background-color: #f8f9fa; 
                }

               .product-image {
                  width: 100%;
                  max-height: 100%;
                  object-fit: contain; 
                  border-radius: var(--border-radius);
                  display: block;
                }

               @media (max-width: 768px) {
                 .product-image-container {
                     height: 300px; 
                    }
                }
                .product-info {
                    padding: 2rem;
                }

                .product-title {
                    font-size: 2rem;
                    font-weight: 700;
                    margin-bottom: 1rem;
                    color: #212529;
                }

                .price-box {
                    margin: 1.5rem 0;
                }

                .current-price {
                    font-size: 1.8rem;
                    font-weight: 700;
                    color: #0369a1;
                }

                .product-description {
                    margin: 2rem 0;
                    line-height: 1.6;
                    color: #495057;
                }

                .product-meta {
                    margin: 1.5rem 0;
                    padding: 1rem 0;
                    border-top: 1px solid #e9ecef;
                    border-bottom: 1px solid #e9ecef;
                }

                .meta-item {
                    display: flex;
                    align-items: center;
                    margin: 0.5rem 0;
                }

                .meta-label {
                    font-weight: 600;
                    min-width: 120px;
                    color: #343a40;
                }

                .quantity-cart-box {
                    display: flex;
                    align-items: center;
                    margin: 2rem 0;
                }

                .quantity-box {
                    margin-right: 1.5rem;
                }

                .quantity-input-group {
                    display: flex;
                    align-items: center;
                    border: 1px solid #e1e1e1;
                    border-radius: 50px;
                    overflow: hidden;
                    width: 120px;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
                    background-color: #ffffff;
                }

                .quantity-btn {
                    background: transparent;
                    border: none;
                    width: 36px;
                    height: 36px;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    cursor: pointer;
                    transition: all 0.2s ease;
                    color: var(--primary-color);
                    padding: 0;
                }

                .quantity-btn:hover {
                    background-color: #f5f7ff;
                }

                .quantity-btn:active {
                    transform: scale(0.95);
                }

                .quantity-btn:disabled {
                    opacity: 0.5;
                    cursor: not-allowed;
                    color: #adb5bd;
                }

                .quantity-btn i {
                    font-size: 14px;
                }

                .quantity-input {
                    width: 50px;
                    height: 36px;
                    text-align: center;
                    border: none;
                    font-weight: 600;
                    font-size: 15px;
                    color: #212529;
                    background-color: transparent;
                    padding: 0;
                }

                .quantity-input:focus {
                    outline: none;
                }

                .quantity-input::-webkit-outer-spin-button,
                .quantity-input::-webkit-inner-spin-button {
                    -webkit-appearance: none;
                    margin: 0;
                }

                /* Add to cart button improvements */
                .add-to-cart {
                    background: linear-gradient(135deg, #3765c9, #4399ee);
                    color: white;
                    border: none;
                    padding: 0.75rem 2rem;
                    border-radius: 50px;
                    font-weight: 600;
                    display: flex;
                    align-items: center;
                    transition: all 0.3s ease;
                    box-shadow: 0 4px 10px rgba(67, 97, 238, 0.3);
                    height: 40px;
                }

                .add-to-cart:hover {
                    background: linear-gradient(135deg, #378ac9, #3053b3);
                    transform: translateY(-2px);
                    box-shadow: 0 6px 12px rgba(67, 97, 238, 0.4);
                }

                .add-to-cart:active {
                    transform: translateY(1px);
                    box-shadow: 0 2px 8px rgba(67, 97, 238, 0.3);
                }

                .add-to-cart:disabled {
                    background: linear-gradient(135deg, #a3b1f3, #a8a4e0);
                    opacity: 0.8;
                    cursor: not-allowed;
                    transform: none;
                    box-shadow: 0 2px 6px rgba(67, 97, 238, 0.2);
                }

                .add-to-cart i {
                    margin-right: 8px;
                    font-size: 16px;
                }

                /* Improve the spacing between buttons */
                .quantity-box {
                    margin-right: 1.5rem;
                }

                @media (max-width: 768px) {
                    .quantity-cart-box {
                        flex-direction: column;
                        align-items: flex-start;
                    }

                    .quantity-box {
                        margin-bottom: 1rem;
                        margin-right: 0;
                    }

                    .add-to-cart {
                        width: 100%;
                        justify-content: center;
                    }
                }

                .product-features {
                    margin-top: 3rem;
                    padding: 2rem;
                    background: var(--light-gray);
                    border-radius: var(--border-radius);
                }

                .features-title {
                    font-size: 1.5rem;
                    margin-bottom: 1.5rem;
                    color: #212529;
                }

                .feature-list {
                    list-style-type: none;
                    padding: 0;
                }

                .feature-list li {
                    padding: 0.5rem 0;
                    display: flex;
                    align-items: center;
                }

                .feature-list li i {
                    color: var(--primary-color);
                    margin-right: 0.75rem;
                }

                @media (max-width: 768px) {
                    .product-title {
                        font-size: 1.5rem;
                    }

                    .quantity-cart-box {
                        flex-direction: column;
                        align-items: flex-start;
                    }

                    .quantity-box {
                        margin-bottom: 1rem;
                        margin-right: 0;
                    }
                }

                .stock-warning {
                    color: #ff7800;
                    font-size: 0.9em;
                    margin-left: 5px;
                }

                .stock-warning-box {
                    margin-top: 15px;
                    transition: all 0.3s ease;
                }

                .quantity-btn:disabled {
                    opacity: 0.5;
                    cursor: not-allowed;
                }

                .add-to-cart:disabled {
                    opacity: 0.7;
                    cursor: not-allowed;
                }
            </style>
        </head>

        <body>
            <!-- Include the header -->
            <jsp:include page="header.jsp">
                <jsp:param name="activePage" value="shop" />
                <jsp:param name="heroTitle" value="Shop" />
            </jsp:include>

            <!-- Product Detail Section -->
            <c:choose>
                <c:when test="${empty product}">
                    <div class="alert alert-warning text-center">
                        <h3>Product not found!</h3>
                        <p>The requested product could not be found. <a href="<c:url value='/home'/>">Return to home</a>
                        </p>
                    </div>
                </c:when>
                <c:otherwise>
                    <section class="product-detail-section">
                        <div class="container">
                            <div class="row">
                                <!-- Product Image -->
                                <div class="col-lg-6">
                                    <div class="product-image-container">
                                        <img src="${product.productImage != null && !product.productImage.isEmpty() ? pageContext.request.contextPath.concat('/images').concat(product.productImage).concat('?t=').concat(currentTimeMillis) : '/relaxit/assets/images/pic.png'}"
                                                     alt="${product.name}" class="product-image">
                                    </div>
                                </div>

                                <!-- Product Info -->
                                <div class="col-lg-6">
                                    <div class="product-info">
                                        <h1 class="product-title">${product.name}</h1>

                                        <div class="price-box">
                                            <span class="current-price">$${product.price}</span>
                                        </div>

                                        <div class="product-description">
                                            <p>${product.description}</p>
                                        </div>

                                        <div class="product-meta">
                                            <div class="meta-item">
                                                <span class="meta-label">Availability:</span>
                                                <span class="${product.quantity > 0 ? 'text-success' : 'text-danger'}">
                                                    ${product.quantity > 0 ? 'In Stock' : 'Out of Stock'}
                                                </span>
                                                <c:if test="${product.quantity > 0 && product.quantity <= 5}">
                                                    <span class="stock-warning">(Only ${product.quantity} left)</span>
                                                </c:if>
                                            </div>
                                            <div class="meta-item">
                                                <span class="meta-label">SKU:</span>
                                                <span>${product.productId}</span>
                                            </div>
                                            <div class="meta-item">
                                                <span class="meta-label">Category:</span>
                                                <span>${product.getCategory().description}</span>
                                            </div>
                                        </div>

                                        <div class="quantity-cart-box">
                                            <div class="quantity-box">
                                                <div class="quantity-input-group">
                                                    <button class="quantity-btn quantity-left-minus" type="button"
                                                        data-type="minus" ${product.quantity <=0 ? 'disabled' : '' }>
                                                        <i class="fas fa-minus"></i>
                                                    </button>
                                                    <input type="text" class="quantity-input" id="product-quantity"
                                                        value="1" min="1" max="${product.quantity}"
                                                        data-available="${product.quantity}" ${product.quantity <=0
                                                        ? 'disabled' : '' }>
                                                    <button class="quantity-btn quantity-right-plus" type="button"
                                                        data-type="plus" ${product.quantity <=0 ? 'disabled' : '' }>
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                            <button id="add-to-cart" class="add-to-cart"
                                                data-product-id="${product.productId}" ${product.quantity <=0
                                                ? 'disabled' : '' }>
                                                <i class="fas fa-shopping-cart"></i> Add to Cart
                                            </button>
                                        </div>

                                        <!-- Stock warning message -->
                                        <div id="stock-warning-message" class="stock-warning-box"
                                            style="display: none;">
                                            <div class="alert alert-warning">
                                                <i class="fas fa-exclamation-triangle"></i>
                                                <span id="warning-text">Cannot add more than the available stock.</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Product Features -->
                            <div class="row mt-5">
                                <div class="col-12">
                                    <div class="product-features">
                                        <h3 class="features-title">Product Features</h3>
                                        <ul class="feature-list">
                                            <li><i class="zmdi zmdi-check-circle"></i> High-quality materials for
                                                durability</li>
                                            <li><i class="zmdi zmdi-check-circle"></i> Designed for maximum comfort</li>
                                            <li><i class="zmdi zmdi-check-circle"></i> Easy to maintain and clean</li>
                                            <li><i class="zmdi zmdi-check-circle"></i> Environmentally friendly
                                                production</li>
                                            <li><i class="zmdi zmdi-check-circle"></i> 1-year manufacturer warranty</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </c:otherwise>
            </c:choose>
            <!-- End Product Detail Section -->


            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    const quantityInput = document.getElementById('product-quantity');
                    const minusBtn = document.querySelector('.quantity-left-minus');
                    const plusBtn = document.querySelector('.quantity-right-plus');
                    const addToCartBtn = document.getElementById('add-to-cart');
                    const warningBox = document.getElementById('stock-warning-message');
                    const warningText = document.getElementById('warning-text');

                    const availableStock = parseInt(quantityInput.getAttribute('data-available')) || 0;

                    function validateQuantity() {
                        let quantity = parseInt(quantityInput.value) || 0;

                        if (quantity < 1) {
                            quantity = 1;
                        }

                        if (quantity > availableStock) {
                            quantity = availableStock;

                            warningText.textContent = `Cannot add more than ${availableStock} item${availableStock != 1 ? 's' : ''} (available stock).`;
                            warningBox.style.display = 'block';
                            setTimeout(() => {
                                warningBox.style.display = 'none';
                            }, 3000);
                        } else {
                            warningBox.style.display = 'none';
                        }

                        quantityInput.value = quantity;

                        if (quantity >= availableStock) {
                            plusBtn.disabled = true;
                        } else {
                            plusBtn.disabled = false;
                        }

                        if (quantity <= 1) {
                            minusBtn.disabled = true;
                        } else {
                            minusBtn.disabled = false;
                        }
                    }

                    validateQuantity();


                    minusBtn.addEventListener('click', function () {
                        let quantity = parseInt(quantityInput.value) || 0;
                        quantityInput.value = Math.max(1, quantity - 1);
                        validateQuantity();
                    });


                    plusBtn.addEventListener('click', function () {
                        let quantity = parseInt(quantityInput.value) || 0;
                        quantityInput.value = quantity + 1;
                        validateQuantity();
                    });

                    quantityInput.addEventListener('change', validateQuantity);
                    quantityInput.addEventListener('keyup', validateQuantity);

                    addToCartBtn.addEventListener('click', function (e) {
                        validateQuantity();
                    });
                });
            </script>

            <!-- Include the footer -->
            <jsp:include page="footer.jsp" />



            <script src="${pageContext.request.contextPath}/assets/js/cart.js"></script>
        </body>

        </html>