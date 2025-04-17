package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/check-login")
public class CheckLoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        Map<String, Object> result = new HashMap<>();
        
        HttpSession session = req.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        
        result.put("loggedIn", user != null);
        if (user != null) {
            result.put("userId", user.getUserId());
            result.put("username", user.getFullName());
        }
        
        resp.getWriter().write(new Gson().toJson(result));
    }
}