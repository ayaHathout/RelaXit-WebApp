package com.relaxit.presentation.controllers;

import com.relaxit.domain.Daos.Implementation.ProductDaoImpl;
import com.relaxit.domain.models.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShopServlet extends HttpServlet {
    ProductDaoImpl myProductDaoImpl = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in ShopServlet");
        try {
            List<Product> allProducts = myProductDaoImpl.getAllProducts();
            req.setAttribute("products", allProducts);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
     //   resp.sendRedirect("/relaxit/views/shop.jsp");
        req.getRequestDispatcher("views/shop.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doPost() in ShopServlet");
    }
}
