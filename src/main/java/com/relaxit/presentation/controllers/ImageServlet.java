package com.relaxit.presentation.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

    private static final String UPLOAD_PATH = "C:\\Uploads";
    private static final String DEFAULT_IMAGE = "0e5d4160-83af-4e54-8fe2-6d091d580215.jpg"; 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String filePath = request.getPathInfo(); 
        File imageFile;

        
        if (filePath == null || filePath.isEmpty()) {
            imageFile = new File(UPLOAD_PATH + File.separator + DEFAULT_IMAGE);
        } else {
            imageFile = new File(UPLOAD_PATH + File.separator + filePath.substring("/uploads/".length()));
        }

       
        if (!imageFile.exists()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        
        String contentType = getServletContext().getMimeType(imageFile.getName());
        if (contentType == null) {
            contentType = "application/octet-stream";
        }
        response.setContentType(contentType);
        response.setContentLength((int) imageFile.length());

       
        try (FileInputStream in = new FileInputStream(imageFile);
             OutputStream out = response.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int bytesRead;
            while ((bytesRead = in.read(buffer)) != -1) {
                out.write(buffer, 0, bytesRead);
            }
        }
    }
}