package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.impl.UserRepositoryImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.util.UUID;
import java.util.logging.Logger;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class ProfileServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "uploads";
    private static final String UPLOAD_PATH = "C:\\Uploads";
    private static final Logger LOGGER = Logger.getLogger(ProfileServlet.class.getName());
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        LOGGER.info("User profile image in session: " + user.getProfileImage());
        request.setAttribute("user", user);
        request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/views/login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        String fullName = request.getParameter("editFullName");
        String job = request.getParameter("editJob");
        String address = request.getParameter("editAddress");
        String interests = request.getParameter("editInterests");
        String birthdateStr = request.getParameter("editBirthdate");

        if (fullName == null || fullName.isEmpty() || job == null || job.isEmpty() ||
                address == null || address.isEmpty() || birthdateStr == null || birthdateStr.isEmpty()) {
            request.setAttribute("errorMessage", "All required fields must be filled!");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        user.setFullName(fullName);
        user.setJob(job);
        user.setAddress(address);
        user.setInterests(interests);
        try {
            user.setBirthdate(LocalDate.parse(birthdateStr));
        } catch (Exception e) {
            request.setAttribute("errorMessage", "Invalid birthdate format! Use YYYY-MM-DD.");
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
            return;
        }

        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        Part filePart = request.getPart("editProfileImage");
        if (filePart != null && filePart.getSize() > 0) {
            if (!filePart.getContentType().startsWith("image/")) {
                request.setAttribute("errorMessage", "Only image files are allowed!");
                request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
                return;
            }
            String originalFileName = extractFileName(filePart);
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
            String filePath = UPLOAD_DIR + "/" + uniqueFileName;
            String fullFilePath = UPLOAD_PATH + File.separator + uniqueFileName;
            LOGGER.info("Saving image to: " + fullFilePath);
            filePart.write(fullFilePath);
            user.setProfileImage(filePath);
        } else {
            LOGGER.info("No new image uploaded, keeping existing: " + user.getProfileImage());
        }

        try {
            userService.updateUser(user);
            session.setAttribute("user", user);
            response.sendRedirect(request.getContextPath() + "/profile");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", e.getMessage());
            request.getRequestDispatcher("/views/profile.jsp").forward(request, response);
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