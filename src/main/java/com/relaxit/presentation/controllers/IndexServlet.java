package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.Product;
import com.relaxit.domain.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class IndexServlet extends HttpServlet {
  //  ProductDaoImpl myProductDaoImpl = new ProductDaoImpl();
    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in IndexServlet");

        List<Product> allProducts = productService.getBestThreeProducts();
        req.setAttribute("products", allProducts);

         HttpSession session = req.getSession(false);
         if (session != null && session.getAttribute("user") != null) {
            req.setAttribute("user", session.getAttribute("user"));
          }
        //   resp.sendRedirect("/relaxit/views/shop.jsp");
        req.getRequestDispatcher("/views/index.jsp").forward(req, resp);
    }
}
