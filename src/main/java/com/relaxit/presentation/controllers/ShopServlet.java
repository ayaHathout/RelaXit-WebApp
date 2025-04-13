package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.Product;
import com.relaxit.domain.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class ShopServlet extends HttpServlet {
    private ProductService productService = new ProductService();

   // ProductDaoImpl myProductDaoImpl = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in ShopServlet");

        int pageNumber = 1, pageSize = 6;

        if (req.getParameter("page") != null)
            pageNumber = Integer.parseInt(req.getParameter("page"));


        List<Product> allProducts = productService.getAllProducts(pageNumber, pageSize);
        long totalNumberOfProducts = productService.getTotalProductsCount();

        req.setAttribute("products", allProducts);
        req.setAttribute("totalProducts", totalNumberOfProducts);
        req.setAttribute("pageNumber", pageNumber);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", (int) Math.ceil((double) totalNumberOfProducts / pageSize));

        //   resp.sendRedirect("/relaxit/views/shop.jsp");
        req.getRequestDispatcher("views/shop.jsp").forward(req, resp);
    }
}
