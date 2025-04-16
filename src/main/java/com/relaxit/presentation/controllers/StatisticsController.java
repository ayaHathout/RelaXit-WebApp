package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.Statistics;
import com.relaxit.domain.services.StatisticsService;
import com.relaxit.repository.Impl.StatisticsRepositoryImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet({"/admin/statistics", "/admin/statistics/data"})
public class StatisticsController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(StatisticsController.class.getName());
    private StatisticsService statisticsService;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            statisticsService = new StatisticsService(new StatisticsRepositoryImpl());
            objectMapper = new ObjectMapper();
            LOGGER.info("StatisticsController initialized successfully.");
        } catch (Exception e) {
            LOGGER.severe("Failed to initialize StatisticsController: " + e.getMessage());
            throw new ServletException("Initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received request for " + request.getServletPath());

        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null ||
            ((com.relaxit.domain.models.User) session.getAttribute("user")).getRole() != com.relaxit.domain.enums.UserRole.ADMIN) {
            LOGGER.warning("Unauthorized access attempt to " + request.getServletPath());
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        try {
            Statistics stats = statisticsService.getStatistics();
            LOGGER.info("Statistics retrieved: totalUsers=" + stats.getTotalUsers() +
                        ", totalProducts=" + stats.getTotalProducts() +
                        ", avgCreditLimit=" + stats.getAvgCreditLimit() +
                        ", totalStock=" + stats.getTotalStock() +
                        ", chartLabels=" + stats.getChartLabels() +
                        ", chartData=" + stats.getChartData());

            String path = request.getServletPath();
            if ("/admin/statistics/data".equals(path)) {
                // Return JSON for AJAX requests
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                objectMapper.writeValue(response.getWriter(), stats);
                LOGGER.info("Sent JSON response for /admin/statistics/data");
            } else {
                // Render JSP for initial page load
                request.setAttribute("stats", stats);
                request.setAttribute("activePage", "statistics");
                String contentPage = "statistics.jsp";
                request.setAttribute("contentPage", contentPage);

                // Set JSON attributes for chart (for initial render)
                String chartLabelsJson = objectMapper.writeValueAsString(stats.getChartLabels());
                String chartDataJson = objectMapper.writeValueAsString(stats.getChartData());
                request.setAttribute("chartLabelsJson", chartLabelsJson);
                request.setAttribute("chartDataJson", chartDataJson);
                LOGGER.info("Set JSON attributes: chartLabelsJson=" + chartLabelsJson + ", chartDataJson=" + chartDataJson);

                LOGGER.info("Set request attribute: contentPage=" + contentPage);
                LOGGER.info("Forwarding to /views/admin/layout.jsp with contentPage=" + contentPage);
                request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
            }
        } catch (Exception e) {
            LOGGER.severe("Error retrieving statistics: " + e.getMessage());
            if ("/admin/statistics/data".equals(request.getServletPath())) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.getWriter().write("{\"error\": \"Failed to retrieve statistics\"}");
            } else {
                throw new ServletException("Error retrieving statistics", e);
            }
        }
    }
}