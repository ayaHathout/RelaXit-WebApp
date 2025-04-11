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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.time.LocalDate;
import java.util.Collections;
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
        String accessToken = request.getParameter("accessToken"); // مش هنستخدمه دلوقتي لأننا مش عايزين People API

        System.out.println("Received Google Sign-In request: idToken=" + idToken + ", accessToken=" + accessToken);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            // التحقق من الـ ID Token
            GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(
                    GoogleNetHttpTransport.newTrustedTransport(), GsonFactory.getDefaultInstance())
                    .setAudience(Collections.singletonList(CLIENT_ID))
                    .build();

            GoogleIdToken googleIdToken = verifier.verify(idToken);
            if (googleIdToken == null) {
                System.out.println("Invalid ID Token");
                out.write("{\"success\": false, \"message\": \"Invalid ID Token\"}");
                out.flush();
                return;
            }

            // استخراج البيانات من الـ Payload
            GoogleIdToken.Payload payload = googleIdToken.getPayload();
            String email = payload.getEmail();
            String name = (String) payload.get("name");
            String picture = (String) payload.get("picture");

            System.out.println("ID Token verified successfully, Email: " + email + ", Name: " + name + ", Picture: " + picture);

            
            User user = userService.getUserByEmail(email);
            boolean isNewUser = (user == null);
            if (isNewUser) {
                user = new User();
                user.setEmail(email);
                user.setFullName(name != null ? name : "Google User"); 
                user.setProfileImage(picture != null ? picture : "uploads/0e5d4160-83af-4e54-8fe2-6d091d580215.jpg");
                user.setBirthdate(LocalDate.of(1990, 1, 1)); 
                user.setJob("Google User"); 
                user.setAddress("Egypt"); 
                user.setInterests(null); 
                user.setRole(UserRole.USER);
                user.setCreditLimit(1200.0);
                user.setPassword(""); 
                try {
                    userService.registerUser(user);
                    System.out.println("User registered successfully: " + email + ", ID: " + user.getUserId());
                    sendWelcomeEmail(email, name != null ? name : "Google User");
                } catch (Exception e) {
                    System.out.println("Failed to register user: " + e.getMessage());
                    e.printStackTrace();
                    out.write("{\"success\": false, \"message\": \"Failed to register user: " + escapeJson(e.getMessage()) + "\"}");
                    out.flush();
                    return;
                }
            } else {
                // تحديث البيانات لو اليوزر موجود
                user.setFullName(name != null ? name : user.getFullName());
                user.setProfileImage(picture != null ? picture : user.getProfileImage());
                try {
                    userService.updateUser(user);
                    System.out.println("User updated successfully: " + email);
                } catch (Exception e) {
                    System.out.println("Failed to update user: " + e.getMessage());
                    e.printStackTrace();
                    out.write("{\"success\": false, \"message\": \"Failed to update user: " + escapeJson(e.getMessage()) + "\"}");
                    out.flush();
                    return;
                }
            }

            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            String redirectUrl = user.getRole() == UserRole.ADMIN ? request.getContextPath() + "/thankyou"
                    : request.getContextPath() + "/profile";

            System.out.println("Redirecting to: " + redirectUrl);
            out.write("{\"success\": true, \"redirectUrl\": \"" + redirectUrl + "\"}");
            out.flush();
        } catch (GeneralSecurityException e) {
            System.out.println("Security error: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Security error: " + escapeJson(e.getMessage()) + "\"}");
            out.flush();
        } catch (Exception e) {
            System.out.println("Unexpected error: " + e.getMessage());
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"Unexpected error: " + escapeJson(e.getMessage()) + "\"}");
            out.flush();
        }
    }

    private String escapeJson(String message) {
        if (message == null) return "";
        return message.replace("\"", "\\\"").replace("\n", "\\n").replace("\t", "\\t").replace("\r", "\\r");
    }

    private void sendWelcomeEmail(String toEmail, String name) {
        final String fromEmail = "sayedmoataz9@gmail.com";
        final String password = "ibgosnhccgidlcrd";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail, "RelaXit"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Welcome to Relaxit!");
            message.setText("Hello " + name + ",\n\nWelcome to Relaxit! Enjoy your time with us.");

            session.setDebug(true);
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