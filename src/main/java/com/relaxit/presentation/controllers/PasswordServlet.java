package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.impl.UserRepositoryImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.logging.Logger;

@WebServlet({"/checkPassword", "/updatePassword"})
public class PasswordServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(PasswordServlet.class.getName());
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession(false);
        response.setContentType("application/json");

        if (session == null || session.getAttribute("user") == null) {
            LOGGER.warning("No active session or user not logged in");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"success\": false, \"message\": \"Not logged in\"}");
            return;
        }

        User user = (User) session.getAttribute("user");
        LOGGER.info("Processing request for user: " + user.getEmail());

        if ("/checkPassword".equals(path)) {
            String currentPassword = request.getParameter("currentPassword");
            LOGGER.info("Checking password for: " + user.getEmail());
            boolean valid = userService.loginUser(user.getEmail(), currentPassword) != null;
            LOGGER.info("Password valid: " + valid);
            response.getWriter().write("{\"valid\": " + valid + "}");
        } else if ("/updatePassword".equals(path)) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");

            if (currentPassword == null || newPassword == null || currentPassword.isEmpty() || newPassword.isEmpty()) {
                LOGGER.warning("Missing password parameters");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"success\": false, \"message\": \"All fields are required\"}");
                return;
            }

            LOGGER.info("Verifying current password for update");
            if (userService.loginUser(user.getEmail(), currentPassword) == null) {
                LOGGER.warning("Current password incorrect for: " + user.getEmail());
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"success\": false, \"message\": \"Current password is incorrect\"}");
                return;
            }

            try {
                LOGGER.info("Updating password for: " + user.getEmail());
                String hashedNewPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
                user.setPassword(hashedNewPassword);
                userService.updateUser(user);
                session.setAttribute("user", user); // Update session
                LOGGER.info("Password updated successfully for: " + user.getEmail());
                response.getWriter().write("{\"success\": true, \"message\": \"Password updated successfully\"}");
            } catch (Exception e) {
                LOGGER.severe("Error updating password for " + user.getEmail() + ": " + e.getMessage());
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                response.getWriter().write("{\"success\": false, \"message\": \"Error updating password: " + e.getMessage() + "\"}");
            }
        }
    }
}