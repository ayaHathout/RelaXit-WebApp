package com.relaxit.presentation.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/checkPasswordMatch")
public class PasswordMatchServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PasswordMatchServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");

        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (password == null || confirmPassword == null || password.isEmpty() || confirmPassword.isEmpty()) {
            LOGGER.warning("Missing password parameters");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"match\": false, \"message\": \"Password and Confirm Password are required\"}");
            return;
        }

        boolean match = password.equals(confirmPassword);
        LOGGER.info("Password match check: " + match);
        response.getWriter().write("{\"match\": " + match + "}");
    }
}