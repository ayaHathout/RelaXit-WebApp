package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.services.ProductService;
import com.relaxit.domain.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ThanksServlet extends HttpServlet {
    private UserService userService = new UserService();
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in ThanksServlet");
        req.getRequestDispatcher("views/thankyou.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doPost() in ThanksServlet");

        double grandTotal = 0;
        String paymentMethod = null, confirmMessage = null;;
        // long userId = -1;
        long userId = 1;
        List<CartItem> cartItems = new ArrayList<>();

        HttpSession session = req.getSession(false);
        if (session != null) {
            grandTotal = (double) session.getAttribute("grandTotal");
          //  userId = (long) session.getAttribute("userId");
            cartItems = (List<CartItem>) session.getAttribute("cartItems");

            System.out.println("grandTotal = " + grandTotal);
            System.out.println("userId = " + userId);
            System.out.println("cart items: " + cartItems);
        }
        //  else  req.getRequestDispatcher("views/login.jsp").forward(req, resp);

        //System.out.println("grandTotal = " + session.getAttribute("grandTotal"));
        //System.out.println("userId = " + userId);
        //System.out.println("cart items: " + session.getAttribute("cartItems"));

        if (req.getParameter("paymentMethod") != null) {
            paymentMethod = req.getParameter("paymentMethod");
            System.out.println("paymentMethod --> " + paymentMethod);
        }
        else System.out.println("No payment method choosen!");

        if (paymentMethod.equals("wallet")) {
            //if (userId != -1) {
                Double userCreditLimit = userService.getCreditLimitByUserId(userId);
                if (userCreditLimit >= grandTotal) {
                    userCreditLimit -= grandTotal;
                    System.out.println(userCreditLimit + ": " + grandTotal + "ffffffffffffffffffffffffffffffff");
                    if (userService.updateCreditLimit(userId, userCreditLimit))
                        confirmMessage = "Successful purchasing!";
                }
                else  confirmMessage = "Unsuccessful purchasing...Your credit card limit is not sufficient!";
                System.out.println("confirmMessage" + confirmMessage);
                req.setAttribute("message", confirmMessage);
                req.getRequestDispatcher("views/confirmation.jsp").forward(req, resp);
           // }
            //else req.getRequestDispatcher("views/login.jsp").forward(req, resp);
        }

        // Decrease Quantities
        for (CartItem item : cartItems) {
            Long productId = item.getProduct().getProductId();
            int availableQuantity = item.getProduct().getQuantity(); // Product's available quantity
            int inCartQuantity = item.getQuantity(); // Quantity in shopping cart

            System.out.println(productId + ": " + (availableQuantity - inCartQuantity));

             if (availableQuantity < inCartQuantity)
                 System.out.println("No sufficient quantity from product whose id = " + productId);
             else {
                 availableQuantity -= inCartQuantity;
                 if (productService.updateQuantity(productId, availableQuantity))
                     System.out.println("The quantity of product whose id = " + productService + " has been updated successfully!");
             }

            System.out.println("Product ID: " + productId);
            System.out.println("Available in stock: " + availableQuantity);
            System.out.println("In cart: " + inCartQuantity);
            System.out.println("------------------");
        }
    }
}
