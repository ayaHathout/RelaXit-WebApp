package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.Impl.UserRepositoryImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import java.io.IOException;
import java.util.List;
import java.util.logging.Logger;

@WebServlet({"/admin/users", "/admin/users/search"})
public class UserController extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(UserController.class.getName());
    private UserService userService;
    private ObjectMapper objectMapper;

    @Override
    public void init() throws ServletException {
        try {
            userService = new UserService(new UserRepositoryImpl());
            objectMapper = new ObjectMapper();
            objectMapper.registerModule(new JavaTimeModule()); // Support LocalDate/LocalDateTime
            LOGGER.info("UserController initialized successfully.");
        } catch (Exception e) {
            LOGGER.severe("Failed to initialize UserController: " + e.getMessage());
            throw new ServletException("Initialization failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        LOGGER.info("Received request for: " + request.getServletPath() + ", Query: " + request.getQueryString());

        // Check if user is admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null || 
            ((User) session.getAttribute("user")).getRole() != com.relaxit.domain.enums.UserRole.ADMIN) {
            LOGGER.warning("Unauthorized access attempt. Session: " + (session == null ? "null" : "valid"));
            if (request.getServletPath().equals("/admin/users/search")) {
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                    String json = objectMapper.writeValueAsString(new ErrorResponse("Unauthorized: Please log in as admin."));
                    LOGGER.info("Sending unauthorized response: " + json);
                    response.getWriter().write(json);
                } catch (Exception e) {
                    LOGGER.severe("Failed to write unauthorized response: " + e.getMessage());
                    response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    response.getWriter().write("{\"error\": \"Server error while handling unauthorized access.\"}");
                }
                return;
            } else {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }
        }

        // Handle search
        String search = request.getParameter("search");
        LOGGER.info("Search term: " + (search == null ? "empty" : search));
        List<User> users;
        try {
            users = userService.searchUsersByName(search);
            LOGGER.info("Found " + users.size() + " users.");
        } catch (Exception e) {
            LOGGER.severe("Error searching users: " + e.getMessage());
            if (request.getServletPath().equals("/admin/users/search")) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                try {
                    String json = objectMapper.writeValueAsString(new ErrorResponse("Server error: " + e.getMessage()));
                    LOGGER.info("Sending error response: " + json);
                    response.getWriter().write(json);
                } catch (Exception ex) {
                    LOGGER.severe("Failed to write error response: " + ex.getMessage());
                    response.getWriter().write("{\"error\": \"Server error while handling search error.\"}");
                }
                return;
            } else {
                throw new ServletException("Error searching users", e);
            }
        }

        // Check if request is for JSON (AJAX)
        if (request.getServletPath().equals("/admin/users/search")) {
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            try {
                String json = objectMapper.writeValueAsString(users);
                LOGGER.info("Sending JSON response: " + json);
                response.getWriter().write(json);
            } catch (Exception e) {
                LOGGER.severe("Failed to serialize users: " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"error\": \"Server error while serializing users.\"}");
            }
        } else {
            // Set attributes for JSP
            request.setAttribute("users", users);
            request.setAttribute("activePage", "users");
            String contentPage = "users.jsp";
            request.setAttribute("contentPage", contentPage);
            LOGGER.info("Set request attribute: contentPage=" + contentPage);
            LOGGER.info("Forwarding to /views/admin/layout.jsp with contentPage=" + contentPage);
            request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
        }
    }

    // Helper class for error responses
    private static class ErrorResponse {
        private String error;

        public ErrorResponse(String error) {
            this.error = error;
        }

        public String getError() {
            return error;
        }
    }
}