package com.relaxit.presentation.controllers;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.json.gson.GsonFactory;
import com.relaxit.domain.enums.UserRole;
import com.relaxit.domain.models.User;
import com.relaxit.domain.services.UserService;
import com.relaxit.repository.impl.UserRepositoryImpl;

import jakarta.servlet.ServletException;
// import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

// import jakarta.mail.*;
// import jakarta.mail.internet.InternetAddress;
// import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.time.LocalDate;
import java.util.Collections;
// import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.util.Properties;

public class GoogleLoginServlet extends HttpServlet {
    private UserService userService;
    private static final String CLIENT_ID = "1000171418756-7fohbjvk79c7rovji8b6gu7lks2csgi2.apps.googleusercontent.com";

    @Override
    public void init() throws ServletException {
        userService = new UserService(new UserRepositoryImpl());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idToken = request.getParameter("idToken");

        System.out.println("Received Google Sign-In request: idToken=" + idToken);

        response.setContentType("application/json");

        try {
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(), GsonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken googleIdToken = verifier.verify(idToken);
            if (googleIdToken == null) {
                System.out.println("Invalid ID Token");
                response.getWriter().write("{\"success\": false, \"message\": \"Invalid ID Token\"}");
                return;
            }

            GoogleIdToken.Payload payload = googleIdToken.getPayload();
            String email = payload.getEmail();
            String name = (String) payload.get("name");
            String picture = (String) payload.get("picture"); 

            System.out.println(
                    "ID Token verified successfully, Email: " + email + ", Name: " + name + ", Picture: " + picture);

            User user = userService.getUserByEmail(email);
            if (user == null) {
                user = new User();
                user.setEmail(email);
                user.setFullName(name);
                if (picture == null || picture.isEmpty()) {
                    user.setProfileImage("uploads/0e5d4160-83af-4e54-8fe2-6d091d580215.jpg");
                } else {
                    user.setProfileImage(picture);
                }
                user.setBirthdate(LocalDate.of(1990, 1, 1));
                user.setJob("Google User");
                user.setAddress("Unknown");
                user.setRole(UserRole.USER);
                user.setCreditLimit(1200.0);
                user.setPassword("");
                try {
                    userService.registerUser(user);
                    System.out.println("User registered successfully: " + email + ", ID: " + user.getUserId());
                } catch (Exception e) {
                    System.out.println("Failed to register user: " + e.getMessage());
                    e.printStackTrace();
                }
            } else {
                // تحديث اليوزر لو موجود
                user.setFullName(name);
                user.setProfileImage(picture);
                try {
                    userService.updateUser(user);
                    System.out.println("User updated successfully: " + email);
                } catch (Exception e) {
                    System.out.println("Failed to update user: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            sendWelcomeEmail(email, name);

            String redirectUrl = user.getRole() == UserRole.ADMIN ? request.getContextPath() + "/thankyou"
                    : request.getContextPath() + "/profile";

            System.out.println("Redirecting to: " + redirectUrl);
            response.getWriter().write("{\"success\": true, \"redirectUrl\": \"" + redirectUrl + "\"}");
        } catch (GeneralSecurityException e) {
            System.out.println("Security error: " + e.getMessage());
            response.getWriter().write("{\"success\": false, \"message\": \"Security error: " + e.getMessage() + "\"}");
            e.printStackTrace();
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
            response.getWriter()
                    .write("{\"success\": false, \"message\": \"Unexpected error: " + e.getMessage() + "\"}");
            e.printStackTrace();
        }
    }

    private void sendWelcomeEmail(String toEmail, String name) {
        final String fromEmail = "excelmohamed@gmail.com"; 
        final String password = "hcqcqfvxftcywnca"; 

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "RelaXit")); // هنا بنحدد الاسم "RelaXit"
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to Relaxit!");
            message.setText("Hello " + name + ",\n\nWelcome to Relaxit! Enjoy your time with us.");

            Transport.send(message);
            System.out.println("Email sent successfully to: " + toEmail);
        } catch (MessagingException e) {
            System.err.println("Failed to send email to " + toEmail + ": " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
        }
    }

}