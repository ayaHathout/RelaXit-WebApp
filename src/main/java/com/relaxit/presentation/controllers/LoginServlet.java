package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.User;
import com.relaxit.domain.services.CartService;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.Impl.UserRepositoryImpl;
import com.relaxit.domain.enums.UserRole;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class LoginServlet extends HttpServlet {

    private UserService userService;
     private CartService cartService;

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
        cartService = new CartService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("luxuryEmail");
        String password = request.getParameter("luxuryPassword");

        try {
            User user = userService.loginUser(email, password);
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);

                 // Merge session cart with user cart
                 List<CartItem> sessionCart = (List<CartItem>) session.getAttribute("sessionCart");
                 if (sessionCart != null && !sessionCart.isEmpty()) {
                     cartService.mergeSessionCartWithUserCart(user.getUserId(), sessionCart);
                     session.setAttribute("sessionCart", new ArrayList<CartItem>());
                 }

                // Check user role and redirect accordingly
                if (user.getRole() == UserRole.ADMIN) {
                    response.sendRedirect(request.getContextPath() + "/admin/users"); 
                    // admin/users
                } else if (user.getRole() == UserRole.USER) {
                    response.sendRedirect(request.getContextPath() + "/home"); 
                    // home
                } else {
                    request.setAttribute("error", "Unknown user role");
                    request.getRequestDispatcher("/views/login.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            }
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
        }
    }
}