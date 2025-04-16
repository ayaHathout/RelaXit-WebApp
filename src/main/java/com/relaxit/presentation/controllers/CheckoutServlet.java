package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.User;
import com.relaxit.domain.services.CartService;
import com.relaxit.domain.services.ProductService;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.Impl.UserRepositoryImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CheckoutServlet extends HttpServlet {


    private CartService cartService;
    private UserService userService;
    private ProductService productService;

    @Override
    public void init() throws ServletException {
        super.init();
        cartService = new CartService();
       userService = new UserService(new UserRepositoryImpl());
        productService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in CheckoutServlet");
        req.getRequestDispatcher("/views/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doPost() in CheckoutServlet");

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        HttpSession session = req.getSession(false);
        if (session == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "No active session. Please log in.");
            out.print(new com.google.gson.Gson().toJson(jsonResponse));
            return;
        }

        User user = (User) session.getAttribute("user");
        if (user == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Please log in to place an order.");
            out.print(new com.google.gson.Gson().toJson(jsonResponse));
            return;
        }

        Long userId = user.getUserId();
        Double grandTotal = (Double) session.getAttribute("grandTotal");
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");

        if (grandTotal == null || cartItems == null || cartItems.isEmpty()) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Your cart is empty or invalid.");
            out.print(new com.google.gson.Gson().toJson(jsonResponse));
            return;
        }

        String paymentMethod = req.getParameter("paymentMethod");
        if (paymentMethod == null || (!paymentMethod.equals("wallet") && !paymentMethod.equals("cash"))) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Please select a valid payment method.");
            out.print(new com.google.gson.Gson().toJson(jsonResponse));
            return;
        }

        try {
            String confirmMessage = "Order placed successfully!";

            // update quantities
            for (CartItem item : cartItems) {
                Long productId = item.getProduct().getProductId();
                int cartQuantity = item.getQuantity();
                int availableQuantity = productService.findById(productId).getQuantity();

                if (availableQuantity < cartQuantity) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Insufficient stock for product ID: " + productId);
                    out.print(new com.google.gson.Gson().toJson(jsonResponse));
                    return;
                }

                int newQuantity = availableQuantity - cartQuantity;
                if (!productService.updateQuantity(productId, newQuantity)) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Failed to update stock for product ID: " + productId);
                    out.print(new com.google.gson.Gson().toJson(jsonResponse));
                    return;
                }
            }

            //payment
            if (paymentMethod.equals("wallet")) {
                Double userCreditLimit = user.getCreditLimit();
                if (userCreditLimit < grandTotal) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Insufficient credit limit. Available: " + userCreditLimit + ", Required: " + grandTotal);
                    out.print(new com.google.gson.Gson().toJson(jsonResponse));
                    return;
                }

                // credit limit
                if (!userService.updateCreditLimit(userId, userCreditLimit - grandTotal)) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Failed to update credit limit.");
                    out.print(new com.google.gson.Gson().toJson(jsonResponse));
                    return;
                }
            }

            // clear cart
            if (!cartService.clearCart(userId)) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Failed to clear cart.");
                out.print(new com.google.gson.Gson().toJson(jsonResponse));
                return;
            }

            // clear session
            session.setAttribute("sessionCart", new ArrayList<CartItem>());
            session.setAttribute("cartItems", new ArrayList<CartItem>());
            session.setAttribute("cartItemCount", 0);
            session.setAttribute("cartTotal", 0.0);
            session.setAttribute("grandTotal", 0.0);
            session.setAttribute("confirmationMessage", confirmMessage);

            jsonResponse.put("success", true);
            jsonResponse.put("message", confirmMessage);
            jsonResponse.put("redirect", "/relaxit/thanks");

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("error", "An error occurred while processing your order: " + e.getMessage());
        }

        out.print(new com.google.gson.Gson().toJson(jsonResponse));
    }
}