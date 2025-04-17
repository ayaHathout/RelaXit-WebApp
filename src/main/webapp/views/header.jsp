<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
          <li class="nav-item ${param.activePage == 'home' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value='/home'/>">Home</a>
          </li>
          <li class="nav-item ${param.activePage == 'shop' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value='/shop'/>">Shop</a>
          </li>
          <li class="nav-item ${param.activePage == 'about' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value='/views/about.jsp'/>">About us</a>
          </li>
          <li class="nav-item ${param.activePage == 'contact' ? 'active' : ''}">
            <a class="nav-link" href="<c:url value='/views/contact.jsp'/>">Contact us</a>
          </li>
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
                                <a href="<c:url value='/logout'/>" class="logout-link">
                                    <i class="fas fa-sign-out-alt"></i>
                                    <span>Sign Out</span>
                                </a>
                            </li>
                        </ul>
                    </c:when>
                    <c:otherwise>
                        <div class="guest-menu-header">
                            <h4>Welcome</h4>
                            <p>New Customer? <a href="<c:url value='/register'/>" class="start-here-link">Start Here</a></p>
                        </div>
                        <div class="auth-buttons">
                            <a href="<c:url value='/login'/>" class="btn btn-primary login-btn">Sign In</a>
                            <a href="<c:url value='/register'/>" class="btn btn-outline register-btn">Register</a>
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

  <!-- Hero Section -->
  
    <section class="hero">
      <div class="particles-container">
        <!-- Particles generated via JavaScript -->
        
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
      
      <div class="hero-content">
        <h1><span>${not empty param.heroTitle ? param.heroTitle : 'Welcome to RelaXit'}</span></h1>
      </div>
      
      <!-- Wave at bottom -->
      <div class="hero-bottom-wave">
        <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 320" preserveAspectRatio="none" style="width: 100%; height: 100%;">
          <path fill="#ffffff" fill-opacity="1" d="M0,160L48,144C96,128,192,96,288,90.7C384,85,480,107,576,133.3C672,160,768,192,864,186.7C960,181,1056,139,1152,133.3C1248,128,1344,160,1392,176L1440,192L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
        </svg>
      </div>
    </section>
