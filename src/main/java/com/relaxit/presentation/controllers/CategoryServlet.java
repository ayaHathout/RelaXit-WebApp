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

public class CategoryServlet extends HttpServlet {
    ProductDaoImpl myProductDaoImpl = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("In doGet() in CategoryServlet");

        int pageNumber = 1, pageSize = 6;
        String categoryName = null;

        if (req.getParameter("page") != null)
            pageNumber = Integer.parseInt(req.getParameter("page"));

        int categoryId = Integer.parseInt(req.getParameter("category-id"));

        try {
            List<Product> allProducts = myProductDaoImpl.getProductsOfCategory(pageNumber, pageSize, categoryId);
            int totalNumberOfProducts = myProductDaoImpl.getTotalProductsCountOfCategory(categoryId);

            req.setAttribute("products", allProducts);
            req.setAttribute("totalProducts", totalNumberOfProducts);
            req.setAttribute("pageNumber", pageNumber);
            req.setAttribute("pageSize", pageSize);
            req.setAttribute("totalPages", (int) Math.ceil((double) totalNumberOfProducts / pageSize));
            req.setAttribute("categoryId", categoryId);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        switch (categoryId) {
            case 1:
                categoryName = "Fixed Chairs";
                break;

            case 2:
                categoryName = "Adjustable Chairs";
                break;

            case 3:
                categoryName = "Lumbar Support Products";
                break;

            case 4:
                categoryName = "Posture Correctors";
                break;

            case 5:
                categoryName = "Chair Pads";
                break;

            case 6:
                categoryName = "Specialty Cushions";
                break;

            case 7:
                categoryName = "Neck Pillows";
                break;

            case 8:
                categoryName = "Portable Solutions";
                break;

            case 9:
                categoryName = "Desk Ergonomics";
                break;

            case 10:
                categoryName = "Comfort Add-ons";
                break;

            default:
                categoryName = "";
                break;
        }

        req.setAttribute("categoryName", categoryName);

        //   resp.sendRedirect("/relaxit/views/shop.jsp");
        req.getRequestDispatcher("views/category.jsp").forward(req, resp);
    }
}
