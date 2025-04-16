package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.Impl.UserRepositoryImpl;
import com.relaxit.domain.enums.UserRole;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
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

                // Check user role and redirect accordingly
                if (user.getRole() == UserRole.ADMIN) {
                    response.sendRedirect(request.getContextPath() + "/admin/users"); 
                    // admin/users
                } else if (user.getRole() == UserRole.USER) {
                    response.sendRedirect(request.getContextPath() + "/profile"); 
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