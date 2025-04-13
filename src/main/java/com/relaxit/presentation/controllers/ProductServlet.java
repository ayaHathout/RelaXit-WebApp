package com.relaxit.presentation.controllers;

import com.relaxit.domain.Daos.Implementation.ProductDaoImpl;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.services.CartService;
import com.relaxit.domain.services.ProductService;
import com.relaxit.repository.Impl.ProductRepositoryImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.annotation.WebServlet;
import com.relaxit.domain.services.ProductService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/product/*")
public class ProductServlet extends HttpServlet {

    private ProductService ProductService;

    @Override
    public void init() throws ServletException {
        super.init();
        ProductService = new ProductService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        System.out.println("PathInfo: " + pathInfo);

        if (pathInfo != null && pathInfo.startsWith("/")) {
            try {
                String idStr = pathInfo.substring(1);
                Long productId = Long.parseLong(idStr);
                System.out.println("Looking for product with ID: " + productId);

                Product product = ProductService.findById(productId);
                System.out.println("Product found: " + (product != null ? "Yes" : "No"));

                if (product != null) {

                    System.out.println("Product Name: " + product.getName());
                    System.out.println("Product Price: " + product.getPrice());

                    request.setAttribute("product", product);
                    request.getRequestDispatcher("/views/product-detail.jsp").forward(request, response);
                    return;
                }
            } catch (NumberFormatException e) {
                System.out.println("Error parsing product ID: " + e.getMessage());
                e.printStackTrace();
            }
        }
        System.out.println("Product not found or invalid ID, redirecting to home");
        response.sendRedirect(request.getContextPath() + "/home");
    }
}