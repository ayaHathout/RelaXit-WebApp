package com.relaxit.presentation.controllers;

import com.relaxit.domain.models.Category;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.services.CategoryService;
import com.relaxit.domain.services.ProductService;
import com.google.gson.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@WebServlet(urlPatterns = {
        "/admin/products",
        "/admin/products/*",
        "/admin/products/list",
        "/admin/products/add",
        "/admin/products/update",
        "/admin/products/delete/*"
})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 10, // 10 MB
        maxRequestSize = 1024 * 1024 * 30 // 30 MB
)
public class AdminProductServlet extends HttpServlet {

    private static final String UPLOAD_DIR = "Uploads";
    private static final String UPLOAD_PATH = "C:\\Uploads";
    private ProductService productService;
    private CategoryService categoryService;
    private final Gson gson;

    public AdminProductServlet() {
        GsonBuilder gsonBuilder = new GsonBuilder();
        gsonBuilder.excludeFieldsWithoutExposeAnnotation();
        gsonBuilder.registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter());
        gsonBuilder.setPrettyPrinting();
        this.gson = gsonBuilder.create();
    }

    @Override
    public void init() throws ServletException {
        categoryService = new CategoryService();
        productService = new ProductService();
    }

    private static class LocalDateTimeAdapter
            implements JsonSerializer<LocalDateTime>, JsonDeserializer<LocalDateTime> {
        private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ISO_LOCAL_DATE_TIME;

        @Override
        public JsonElement serialize(LocalDateTime src, java.lang.reflect.Type typeOfSrc,
                JsonSerializationContext context) {
            return src != null ? new JsonPrimitive(FORMATTER.format(src)) : JsonNull.INSTANCE;
        }

        @Override
        public LocalDateTime deserialize(JsonElement json, java.lang.reflect.Type typeOfT,
                JsonDeserializationContext context)
                throws JsonParseException {
            return json.isJsonNull() ? null : LocalDateTime.parse(json.getAsString(), FORMATTER);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String servletPath = request.getServletPath();

        System.out.println("doGet - servletPath: " + servletPath + ", pathInfo: " + pathInfo);

        if (servletPath.equals("/admin/products/list")) {
            listProducts(request, response);
        } else if (pathInfo == null || pathInfo.equals("/")) {
            showDashboard(request, response);
        } else if (servletPath.equals("/admin/products") && pathInfo != null && !pathInfo.equals("/")) {
            try {
                Long productId = Long.parseLong(pathInfo.substring(1));
                getProductDetails(productId, response);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Resource not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        String pathInfo = request.getPathInfo();

        if (servletPath.equals("/admin/products/add")) {
            addProduct(request, response);
        } else if (servletPath.equals("/admin/products/update")) {
            updateProduct(request, response);
        } else if (servletPath.equals("/admin/products/delete") && pathInfo != null) {
            try {
                Long productId = Long.parseLong(pathInfo.substring(1));
                setProductQuantityToZero(productId, response);
            } catch (NumberFormatException e) {
                sendJsonResponse(response, false, "Invalid product ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request");
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageNumber = 1;
        int pageSize = 10;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                pageNumber = Integer.parseInt(pageParam);
            }
            String sizeParam = request.getParameter("size");
            if (sizeParam != null) {
                pageSize = Integer.parseInt(sizeParam);
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid page or size parameter: " + e.getMessage());
        }

        List<Product> products = null;
        long totalProducts = 0;
        List<Category> categories = null;

        try {
            products = productService.getAllProducts(pageNumber, pageSize);
            totalProducts = productService.getTotalProductsCount();
            categories = categoryService.getAllCategories();
        } catch (Exception e) {
            System.out.println("Error fetching data: " + e.getMessage());
            e.printStackTrace();
        }

        products = (products != null) ? products : new ArrayList<>();
        categories = (categories != null) ? categories : new ArrayList<>();
        totalProducts = (products.isEmpty() && totalProducts == 0) ? 0 : totalProducts;

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        System.out.println("Products size: " + products.size());
        System.out.println("Total Products: " + totalProducts);
        System.out.println("Categories size: " + categories.size());
        System.out.println("Total Pages: " + totalPages);

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalProducts", totalProducts);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("contentPage", "product-management.jsp");
        request.setAttribute("activePage", "products");

        System.out.println("Forwarding to /views/admin/layout.jsp");
        try {
            request.getRequestDispatcher("/views/admin/layout.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("Forwarding failed: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to render page");
        }
    }

    private void listProducts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageNumber = 1;
        int pageSize = 10;
        String keyword = request.getParameter("keyword");
        String categoryIdStr = request.getParameter("categoryId");
        Integer categoryId = null;

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                pageNumber = Integer.parseInt(pageParam);
            }
            String sizeParam = request.getParameter("size");
            if (sizeParam != null) {
                pageSize = Integer.parseInt(sizeParam);
            }
            if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
                categoryId = Integer.parseInt(categoryIdStr);
            }
        } catch (NumberFormatException e) {
            System.out.println("Invalid page, size, or categoryId parameter: " + e.getMessage());
        }

        List<Product> products;
        long totalProducts;

        try {
            if (keyword != null && !keyword.isEmpty()) {
                products = productService.searchProducts(keyword, pageNumber, pageSize);
                totalProducts = productService.getTotalSearchProductsCount(keyword);
            } else if (categoryId != null) {
                products = productService.getProductsOfCategory(pageNumber, pageSize, categoryId);
                totalProducts = productService.getTotalProductsCountOfCategory(categoryId);
            } else {
                products = productService.getAllProducts(pageNumber, pageSize);
                totalProducts = productService.getTotalProductsCount();
            }
        } catch (Exception e) {
            System.out.println("Error fetching products: " + e.getMessage());
            e.printStackTrace();
            products = new ArrayList<>();
            totalProducts = 0;
        }

        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("products", products);
        responseData.put("currentPage", pageNumber);
        responseData.put("pageSize", pageSize);
        responseData.put("totalProducts", totalProducts);
        responseData.put("totalPages", totalPages);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            response.getWriter().write(gson.toJson(responseData));
        } catch (JsonIOException e) {
            System.out.println("Error serializing product list: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            sendJsonResponse(response, false, "Error fetching product list");
        }
    }

    private void getProductDetails(Long productId, HttpServletResponse response)
            throws IOException {
        try {
            Product product = productService.findById(productId);
            if (product != null) {
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(gson.toJson(product));
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                sendJsonResponse(response, false, "Product not found");
            }
        } catch (JsonIOException e) {
            System.out.println("Error serializing product details: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            sendJsonResponse(response, false, "Error fetching product details");
        } catch (Exception e) {
            System.out.println("Error fetching product details: " + e.getMessage());
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            sendJsonResponse(response, false, "Error fetching product details");
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Product product = new Product();
        setProductFields(product, request);

        String imageUrl = processProductImage(request);
        if (imageUrl != null) {
            product.setProductImage(imageUrl);
        }

        try {
            Product savedProduct = productService.saveProduct(product);
            if (savedProduct != null) {
                sendJsonResponse(response, true, "Product added successfully");
            } else {
                sendJsonResponse(response, false, "Failed to add product");
            }
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error: " + e.getMessage());
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productIdStr = request.getParameter("productId");
        if (productIdStr == null || productIdStr.isEmpty()) {
            sendJsonResponse(response, false, "Product ID is required");
            return;
        }

        try {
            Long productId = Long.parseLong(productIdStr);
            Product product = productService.findById(productId);

            if (product == null) {
                sendJsonResponse(response, false, "Product not found");
                return;
            }

            String originalImageUrl = product.getProductImage();

            setProductFields(product, request);

            String removeImage = request.getParameter("removeImage");
            if (removeImage != null && removeImage.equals("on")) {
                product.setProductImage(null);
            } else {
                Part filePart = request.getPart("productImage");
                if (filePart != null && filePart.getSize() > 0) {
                    String imageUrl = processProductImage(request);
                    if (imageUrl != null) {
                        product.setProductImage(imageUrl);
                    }
                } else {
                    product.setProductImage(originalImageUrl);
                }
            }

            Product updatedProduct = productService.saveProduct(product);
            if (updatedProduct != null) {
                sendJsonResponse(response, true, "Product updated successfully");
            } else {
                sendJsonResponse(response, false, "Failed to update product");
            }
        } catch (NumberFormatException e) {
            sendJsonResponse(response, false, "Invalid product ID");
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error: " + e.getMessage());
        }
    }

    private void setProductQuantityToZero(Long productId, HttpServletResponse response)
            throws IOException {
        try {
            boolean updated = productService.updateQuantity(productId, 0);
            if (updated) {
                sendJsonResponse(response, true, "Product quantity set to zero successfully");
            } else {
                sendJsonResponse(response, false, "Product not found");
            }
        } catch (Exception e) {
            sendJsonResponse(response, false, "Error setting product quantity to zero: " + e.getMessage());
        }
    }

    private void setProductFields(Product product, HttpServletRequest request) {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String quantityStr = request.getParameter("quantity");
        String categoryIdStr = request.getParameter("categoryId");

        if (name != null && !name.isEmpty()) {
            product.setName(name);
        }

        if (description != null) {
            product.setDescription(description);
        }

        if (priceStr != null && !priceStr.isEmpty()) {
            try {
                BigDecimal price = new BigDecimal(priceStr);
                product.setPrice(price);
            } catch (NumberFormatException e) {
                System.out.println("Invalid price format: " + priceStr);
            }
        }

        if (quantityStr != null && !quantityStr.isEmpty()) {
            try {
                Integer quantity = Integer.parseInt(quantityStr);
                product.setQuantity(quantity);
            } catch (NumberFormatException e) {
                System.out.println("Invalid quantity format: " + quantityStr);
            }
        }

        if (categoryIdStr != null && !categoryIdStr.isEmpty()) {
            try {
                Long categoryId = Long.parseLong(categoryIdStr);
                Category category = categoryService.findById(categoryId);
                product.setCategory(category);
            } catch (NumberFormatException e) {
                System.out.println("Invalid category ID: " + categoryIdStr);
            }
        }
    }

    private String processProductImage(HttpServletRequest request) throws ServletException, IOException {
        Part filePart = request.getPart("productImage");
        if (filePart == null || filePart.getSize() == 0) {
            return null;
        }

        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String fileExtension = fileName.substring(fileName.lastIndexOf("."));
        String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

        File uploadDir = new File(UPLOAD_PATH);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }

        filePart.write(UPLOAD_PATH + File.separator + uniqueFileName);

        return "/Uploads/" + uniqueFileName;
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message)
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Map<String, Object> jsonResponse = new HashMap<>();
        jsonResponse.put("success", success);
        jsonResponse.put("message", message);

        PrintWriter out = response.getWriter();
        out.print(gson.toJson(jsonResponse));
        out.flush();
    }
}
