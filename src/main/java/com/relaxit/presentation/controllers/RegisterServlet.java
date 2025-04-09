package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.impl.UserRepositoryImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;
import java.util.logging.Logger;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class RegisterServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    private static final String UPLOAD_PATH = "C:\\Uploads"; // مسار ثابت لويندوز
    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // استقبال البيانات مع التحقق
        String fullName = request.getParameter("luxuryFullName");
        String email = request.getParameter("luxuryRegEmail");
        String password = request.getParameter("luxuryRegPassword");
        String birthdateStr = request.getParameter("luxuryBirthdate");
        String job = request.getParameter("luxuryProfession");
        String address = request.getParameter("luxuryResidence");
        String interests = request.getParameter("luxuryInterests");

        if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty() ||
                password == null || password.isEmpty() || birthdateStr == null || birthdateStr.isEmpty() ||
                job == null || job.isEmpty() || address == null || address.isEmpty()) {
            request.setAttribute("errorMessage", "All required fields must be filled!");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPassword(password);
        try {
            user.setBirthdate(LocalDate.parse(birthdateStr));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Invalid birthdate format! Use YYYY-MM-DD.");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }
        user.setJob(job);
        user.setAddress(address);
        user.setInterests(interests);

        // Handle file upload مع UUID
        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        Part filePart = request.getPart("luxuryProfileImage");
        if (filePart != null && filePart.getSize() > 0) {
            if (!filePart.getContentType().startsWith("image/")) {
                request.setAttribute("errorMessage", "Only image files are allowed!");
                request.getRequestDispatcher("views/register.jsp").forward(request, response);
                return;
            }
            String originalFileName = extractFileName(filePart);
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
            String filePath = UPLOAD_DIR + "/" + uniqueFileName; // المسار النسبي
            String fullFilePath = UPLOAD_PATH + File.separator + uniqueFileName; // المسار الكامل
            LOGGER.info("Saving image to: " + fullFilePath);
            filePart.write(fullFilePath);
            user.setProfileImage(filePath);
        }

        // حفظ اليوزر
        try {
            userService.registerUser(user);
            response.sendRedirect("views/login.jsp");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
        }
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