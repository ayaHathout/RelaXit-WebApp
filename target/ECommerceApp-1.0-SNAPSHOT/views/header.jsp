<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
            <a class="nav-link" href="<c:url value='home'/>">Home</a>
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
                <i class="fas fa-user"></i>
            </div>
            <div class="user-menu">
                <div class="user-menu-header">
                    <p>New Customer?</p>
                    <a href="<c:url value='/views/register.jsp'/>">Start Here</a>
                </div>
                <ul class="user-menu-links">
                    <li><a href="<c:url value='/views/login'/>">Sign In</a></li>
                    <li><a href="<c:url value='/account.jsp'/>">My Account</a></li>
                    <li><a href="<c:url value='/views/orders.jsp'/>">My Orders</a></li>
                </ul>
            </div>
          </li>
  
          <!-- Shopping Cart -->
          <li class="nav-item mini-cart">
            <a class="cart-icon nav-link" href="#">
                <i class="zmdi zmdi-shopping-cart"></i>
                <span class="cart-counter">${cartItemCount != null ? cartItemCount : '0'}</span>
            </a>
            <div class="mini-cart-brief text-left">
                <div class="cart-items">
                    <p class="mb-0">You have <span class="item-count">${cartItemCount != null ? cartItemCount : '0'}</span> items in your shopping bag</p>
                </div>
                <div class="all-cart-product clearfix">
                    <!-- Items will be inserted here by JavaScript -->
                </div>
                <div class="cart-totals">
                    <h5 class="mb-0">TOTAL<span class="float-end cart-total">$${cartTotal != null ? cartTotal : '0.00'}</span></h5>
                </div>
                <div class="cart-bottom clearfix">
                    <a href="<c:url value='/cart/view'/>" class="btn btn-outline-secondary float-start">VIEW CART</a>
                    <a href="<c:url value='/views/checkout.jsp'/>" class="btn btn-primary float-end ${empty cartItems ? 'disabled' : ''}">CHECK OUT</a>
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
