package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.User;
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
        String paymentMethod = null, confirmMessage = "Successful purchasing!";
        User curUser = new User();
        List<CartItem> cartItems = new ArrayList<>();

        HttpSession session = req.getSession(false);
        if (session != null) {
            if (session.getAttribute("grandTotal") != null && session.getAttribute("user") != null && session.getAttribute("cartItems") != null) {
                grandTotal = (double) session.getAttribute("grandTotal");
                curUser = (User) session.getAttribute("user");
                cartItems = (List<CartItem>) session.getAttribute("cartItems");
                System.out.println("Sessionnnnnnnnnnnnnnnnnnnnnnnnnnnn");
            }
            else {
                System.out.println("Noooooooooooooooooooooooooooooooooot");
                resp.sendRedirect("/relaxit/login");
                return;
            }
        }
        else {
            System.out.println("NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN");
            resp.sendRedirect("/relaxit/login");
            return;
        }

        System.out.println("grandTotal = " + grandTotal);
        System.out.println("curUser" + curUser);
        System.out.println("cart items: " + cartItems);

        if (req.getParameter("paymentMethod") != null) {
            paymentMethod = req.getParameter("paymentMethod");
            System.out.println("paymentMethod --> " + paymentMethod);
        }
        else System.out.println("No payment method choosen!");

        if (paymentMethod.equals("wallet")) {
            Double userCreditLimit = curUser.getCreditLimit();
            if (userCreditLimit >= grandTotal) {
                userCreditLimit -= grandTotal;
                System.out.println(userCreditLimit + ": " + grandTotal + "ffffffffffffffffffffffffffffffff");
                if (userService.updateCreditLimit(curUser.getUserId(), userCreditLimit))
                    confirmMessage = "Successful purchasing!";
            }
            else  confirmMessage = "Unsuccessful purchasing...Your credit card limit is not sufficient!";
            System.out.println("confirmMessage" + confirmMessage);
            req.setAttribute("message", confirmMessage);
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

            /*System.out.println("Product ID: " + productId);
            System.out.println("Available in stock: " + availableQuantity);
            System.out.println("In cart: " + inCartQuantity);
            System.out.println("------------------");*/
        }

        System.out.println("Confirsmation Message -> " + confirmMessage);
        req.getRequestDispatcher("views/confirmation.jsp").forward(req, resp);
    }
}
