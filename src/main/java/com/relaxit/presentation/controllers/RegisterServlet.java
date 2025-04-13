package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.User;
import com.relaxit.domain.enums.UserRole;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.Impl.UserRepositoryImpl;
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
    private static final String UPLOAD_PATH = "C:\\Uploads";
    private static final Logger LOGGER = Logger.getLogger(RegisterServlet.class.getName());
    private UserService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        LOGGER.info("Received Register request");
    
        String fullName = request.getParameter("luxuryFullName");
        String email = request.getParameter("luxuryRegEmail");
        String password = request.getParameter("luxuryRegPassword");
        String birthdateStr = request.getParameter("luxuryBirthdate");
        String job = request.getParameter("luxuryProfession");
        String address = request.getParameter("luxuryResidence");
        String interests = request.getParameter("luxuryInterests");
    
        LOGGER.info("Form data: fullName=" + fullName + ", email=" + email + ", birthdate=" + birthdateStr +
                ", job=" + job + ", address=" + address + ", interests=" + interests);
        LOGGER.info("Raw password from form: " + password);
    
        if (fullName == null || fullName.isEmpty() || email == null || email.isEmpty() ||
                password == null || password.isEmpty() || birthdateStr == null || birthdateStr.isEmpty() ||
                job == null || job.isEmpty() || address == null || address.isEmpty()) {
            LOGGER.warning("Validation failed: All required fields must be filled!");
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
            LOGGER.warning("Invalid birthdate format: " + e.getMessage());
            request.setAttribute("errorMessage", "Invalid birthdate format! Use YYYY-MM-DD.");
            request.getRequestDispatcher("views/register.jsp").forward(request, response);
            return;
        }
        user.setJob(job);
        user.setAddress(address);
        user.setInterests(interests);
        user.setRole(UserRole.USER);
        user.setCreditLimit(1200.0);
    
        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
    
        Part filePart = request.getPart("luxuryProfileImage");
        if (filePart != null && filePart.getSize() > 0) {
            if (!filePart.getContentType().startsWith("image/")) {
                LOGGER.warning("Invalid file type: Only image files are allowed!");
                request.setAttribute("errorMessage", "Only image files are allowed!");
                request.getRequestDispatcher("views/register.jsp").forward(request, response);
                return;
            }
            String originalFileName = extractFileName(filePart);
            String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
            String filePath = UPLOAD_DIR + "/" + uniqueFileName;
            String fullFilePath = UPLOAD_PATH + File.separator + uniqueFileName;
            LOGGER.info("Saving image to: " + fullFilePath);
            try {
                filePart.write(fullFilePath);
                user.setProfileImage(filePath);
            } catch (IOException e) {
                LOGGER.severe("Failed to save image: " + e.getMessage());
                request.setAttribute("errorMessage", "Failed to upload image: " + e.getMessage());
                request.getRequestDispatcher("views/register.jsp").forward(request, response);
                return;
            }
        }
    
        try {
            userService.registerUser(user);
            LOGGER.info("User registered successfully: " + email);
           
            request.setAttribute("successMessage", "Registration successful! Please log in.");
            request.getRequestDispatcher("/views/login.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Failed to register user: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to register user: " + e.getMessage());
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