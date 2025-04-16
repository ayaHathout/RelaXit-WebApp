package com.relaxit.presentation.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/checkCreditLimit")
public class CreditLimitServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(CreditLimitServlet.class.getName());
    private static final double MAX_CREDIT_LIMIT = 100000.0;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");

        String creditLimitStr = request.getParameter("creditLimit");
        if (creditLimitStr == null || creditLimitStr.trim().isEmpty()) {
            LOGGER.warning("Missing credit limit parameter");
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"valid\": false, \"message\": \"Credit Limit is required\"}");
            return;
        }

        try {
            double creditLimit = Double.parseDouble(creditLimitStr);
            boolean valid = creditLimit <= MAX_CREDIT_LIMIT;
            LOGGER.info("Credit limit check: " + creditLimit + " <= " + MAX_CREDIT_LIMIT + " -> " + valid);
            response.getWriter().write("{\"valid\": " + valid + "}");
        } catch (NumberFormatException e) {
            LOGGER.warning("Invalid credit limit format: " + creditLimitStr);
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"valid\": false, \"message\": \"Credit Limit must be a valid number\"}");
        }
    }
}