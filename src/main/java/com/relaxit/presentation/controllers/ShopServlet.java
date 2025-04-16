package com.relaxit.presentation.controllers;

import com.google.gson.Gson;
import com.relaxit.domain.dtos.ProductDTO;
import com.relaxit.domain.services.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ShopServlet extends HttpServlet {
    private ProductService productService = new ProductService();

    // ProductDaoImpl myProductDaoImpl = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in ShopServlet");

        int pageNumber = 1, pageSize = 6;

        if (req.getParameter("page") != null)
            pageNumber = Integer.parseInt(req.getParameter("page"));


        //  List<Product> allProducts = productService.getAllProducts(pageNumber, pageSize);

        List<ProductDTO> allProducts = productService.getAllProductsInProductDTO(pageNumber, pageSize);
        long totalNumberOfProducts = productService.getTotalProductsCount();
/*
        req.setAttribute("products", allProducts);
        req.setAttribute("totalProducts", totalNumberOfProducts);
        req.setAttribute("pageNumber", pageNumber);
        req.setAttribute("pageSize", pageSize);
        req.setAttribute("totalPages", (int) Math.ceil((double) totalNumberOfProducts / pageSize));
*/


        Gson gson = new Gson();
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("products", allProducts);
        responseData.put("totalProducts", totalNumberOfProducts);
        responseData.put("pageNumber", pageNumber);
        responseData.put("pageSize", pageSize);
        responseData.put("totalPages", (int) Math.ceil((double) totalNumberOfProducts / pageSize));

        String json = gson.toJson(responseData);

        System.out.println("json --> " + json);

        resp.setContentType("text/event-stream");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.write("data: " + json + "\n\n");
        out.flush();

        //   resp.sendRedirect("/relaxit/views/shop.jsp");
        //req.getRequestDispatcher("views/shop.jsp").forward(req, resp);
    }
}
