package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class RegisterServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = new User();
        user.setFullName(request.getParameter("luxuryFullName"));
        user.setEmail(request.getParameter("luxuryRegEmail"));
        String passwordFromForm = request.getParameter("luxuryRegPassword");
        System.out.println("Password from form: " + passwordFromForm); // Debug
        user.setPassword(passwordFromForm);
        user.setBirthdate(LocalDate.parse(request.getParameter("luxuryBirthdate")));
        user.setJob(request.getParameter("luxuryProfession"));
        user.setAddress(request.getParameter("luxuryResidence"));
        user.setInterests(request.getParameter("luxuryInterests"));

        // File upload logic
        String applicationPath = request.getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists())
            uploadDir.mkdir();

        Part filePart = request.getPart("luxuryProfileImage");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = extractFileName(filePart);
            String filePath = UPLOAD_DIR + File.separator + fileName;
            filePart.write(uploadPath + File.separator + fileName);
            user.setProfileImage(filePath);
        }

        userService.registerUser(user);
        response.sendRedirect("views/login.jsp");
    }

    private String extractFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        String[] items = contentDisposition.split(";");
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
}