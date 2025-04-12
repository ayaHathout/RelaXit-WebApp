package com.relaxit.presentation.controllers;

import com.relaxit.domain.Daos.Implementation.CartItemDAOImpl;
import com.relaxit.domain.Daos.Interfaces.CartItemDAO;
import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.services.CartService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import com.google.gson.*;
import java.lang.reflect.Type;

@WebServlet("/cart/*")
public class CartServlet extends HttpServlet {
    private CartService cartService ;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        cartService = new CartService();

        this.gson = new GsonBuilder()
                .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeSerializer())
                .excludeFieldsWithoutExposeAnnotation()
                .create();
    }

    private static class LocalDateTimeSerializer implements JsonSerializer<LocalDateTime> {
        @Override
        public JsonElement serialize(LocalDateTime src, Type typeOfSrc, JsonSerializationContext context) {
            return src == null ? null : new JsonPrimitive(src.toString());
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();

        if (pathInfo != null) {
            if (pathInfo.equals("/view")) {
                showCart(request, response);
                return;
            } else if (pathInfo.equals("/items")) {
                getCartItemsAsJson(request, response);
                return;
            }
        }
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String pathInfo = request.getPathInfo();
        String action = request.getParameter("action");

        // Prevent caching
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Map<String, Object> jsonResponse = new HashMap<>();

        try {
            HttpSession session = request.getSession(true);
            Integer userId = (Integer) session.getAttribute("userId");
            boolean isLoggedIn = (userId != null && userId > 0);

            System.out.println("User ID: " + userId + ", isLoggedIn: " + isLoggedIn);

            if (pathInfo != null && pathInfo.equals("/update")) {
                handleCartUpdate(action, request, session, userId, isLoggedIn, jsonResponse);
            } else {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Invalid path");
            }

            prepareCartResponse(session, userId, isLoggedIn, jsonResponse);

            Map<String, Object> simplifiedResponse = simplifyResponse(jsonResponse);
            out.print(gson.toJson(simplifiedResponse));

        } catch (Exception e) {
            e.printStackTrace();
            jsonResponse.put("success", false);
            jsonResponse.put("error", e.getMessage());
            out.print(gson.toJson(jsonResponse));
        }
    }

    private void handleCartUpdate(String action, HttpServletRequest request, HttpSession session,
                                  Integer userId, boolean isLoggedIn, Map<String, Object> jsonResponse) {
        switch (action) {
            case "add":
                handleAddToCart(request, session, userId, isLoggedIn, jsonResponse);
                break;
            case "remove":
                handleRemoveFromCart(request, session, userId, isLoggedIn, jsonResponse);
                break;
            case "update":
                handleUpdateCartItem(request, session, userId, isLoggedIn, jsonResponse);
                break;
            case "clear":
                handleClearCart(session, userId, isLoggedIn, jsonResponse);
                break;
            default:
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Invalid action");
        }
    }

    private void handleAddToCart(HttpServletRequest request, HttpSession session,
                                 Integer userId, boolean isLoggedIn, Map<String, Object> jsonResponse) {
        try {
            String productIdParam = request.getParameter("productId");
            String quantityParam = request.getParameter("quantity");

            if (productIdParam == null || productIdParam.isEmpty()) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Product ID is required");
                return;
            }

            if (quantityParam == null || quantityParam.isEmpty()) {
                quantityParam = "1"; // Default to 1 if not provided
            }

            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);

            if (productId <= 0) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Invalid product ID");
                return;
            }

            if (quantity <= 0) {
                jsonResponse.put("success", false);
                jsonResponse.put("error", "Quantity must be at least 1");
                return;
            }

            boolean added = false;

            // Only try to add to user's cart if logged in
            if (isLoggedIn && userId != null) {
                added = cartService.addToCart(userId, productId, quantity);
            }

            // If not logged in or if adding to user's cart failed, add to session cart
            if (!isLoggedIn || !added) {
                added = addToSessionCart(session, productId, quantity);
            }

            jsonResponse.put("success", added);

            if (!added) {
                jsonResponse.put("error", "Failed to add item to cart");
            }
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Invalid number format: " + e.getMessage());
        }
    }

    private void handleRemoveFromCart(HttpServletRequest request, HttpSession session,
                                      Integer userId, boolean isLoggedIn, Map<String, Object> jsonResponse) {
        try {
            int cartId = Integer.parseInt(request.getParameter("cartId"));
            boolean removed = false;

            if (isLoggedIn) {
                removed = cartService.removeFromCart(cartId);
            }

            boolean sessionRemoved = removeFromSessionCart(session, cartId);
            removed = removed || sessionRemoved;

            jsonResponse.put("success", removed);
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Invalid cart ID: " + e.getMessage());
        }
    }

    private void handleUpdateCartItem(HttpServletRequest request, HttpSession session,
                                      Integer userId, boolean isLoggedIn, Map<String, Object> jsonResponse) {
        try {
            int itemCartId = Integer.parseInt(request.getParameter("cartId"));
            int newQuantity = Integer.parseInt(request.getParameter("quantity"));
            boolean updated = false;

            if (isLoggedIn) {
                updated = cartService.updateCartItemQuantity(itemCartId, newQuantity);
            }

            boolean sessionUpdated = updateSessionCartItemQuantity(session, itemCartId, newQuantity);
            updated = updated || sessionUpdated;

            jsonResponse.put("success", updated);
        } catch (NumberFormatException e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Invalid number format: " + e.getMessage());
        }
    }

    private void handleClearCart(HttpSession session, Integer userId,
                                 boolean isLoggedIn, Map<String, Object> jsonResponse) {
        boolean cleared = true;

        if (isLoggedIn) {
            cleared = cartService.clearCart(userId);
        }

        clearSessionCart(session);
        jsonResponse.put("success", cleared);
    }

    private void prepareCartResponse(HttpSession session, Integer userId,
                                     boolean isLoggedIn, Map<String, Object> jsonResponse) {
        List<CartItem> cartItems;
        int cartItemCount;
        BigDecimal cartTotal;

        if (isLoggedIn) {
            cartItems = cartService.getCartItemsByUserId(userId);
            cartItemCount =cartService.getCartItemCount(userId);
            cartTotal = BigDecimal.valueOf(cartService.getCartTotal(userId));

            if (cartItems.isEmpty()) {
                cartItems = getSessionCart(session);
                cartItemCount = cartItems.size();
                cartTotal = calculateSessionCartTotal(cartItems);
            }
        } else {
            cartItems = getSessionCart(session);
            cartItemCount = cartItems.size();
            cartTotal = calculateSessionCartTotal(cartItems);
        }

        jsonResponse.put("cartItems", cartItems);
        jsonResponse.put("cartItemCount", cartItemCount);
        jsonResponse.put("cartTotal", cartTotal);
        jsonResponse.put("grandTotal", cartItemCount > 0
                ? cartTotal.add(BigDecimal.valueOf(20.00))
                : BigDecimal.ZERO);

        // For Checkout
        session.setAttribute("grandTotal", cartItemCount > 0
                ? cartTotal.add(BigDecimal.valueOf(20.00))
                : BigDecimal.ZERO);
        session.setAttribute("cartItems", cartItems);
    }

    private Map<String, Object> simplifyResponse(Map<String, Object> response) {
        Map<String, Object> simplified = new HashMap<>();
        simplified.put("success", response.get("success"));
        simplified.put("error", response.get("error"));
        simplified.put("cartItemCount", response.get("cartItemCount"));

        // Handle potential null values
        BigDecimal cartTotal = (BigDecimal) response.get("cartTotal");
        BigDecimal grandTotal = (BigDecimal) response.get("grandTotal");

        simplified.put("cartTotal", cartTotal != null ? cartTotal.doubleValue() : 0.0);
        simplified.put("grandTotal", grandTotal != null ? grandTotal.doubleValue() : 0.0);


        List<Map<String, Object>> simpleItems = new ArrayList<>();
        @SuppressWarnings("unchecked")
        List<CartItem> items = (List<CartItem>) response.get("cartItems");
        for (CartItem item : items) {
            Map<String, Object> simpleItem = new HashMap<>();
            simpleItem.put("cartId", item.getCartId());
            simpleItem.put("quantity", item.getQuantity());
            simpleItem.put("itemTotal", item.getItemTotal().doubleValue());

            Map<String, Object> simpleProduct = new HashMap<>();
            simpleProduct.put("productId", item.getProduct().getProductId());
            simpleProduct.put("name", item.getProduct().getName());
            simpleProduct.put("price", item.getProduct().getPrice().doubleValue());
            simpleProduct.put("imageUrl", item.getProduct().getProductImage() != null ? item.getProduct().getProductImage() : "/assets/images/holder.png");

            simpleItem.put("product", simpleProduct);
            simpleItems.add(simpleItem);
        }
        simplified.put("cartItems", simpleItems);

        return simplified;
    }

    private void showCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        boolean isLoggedIn = (userId != null && userId > 0);

        List<CartItem> cartItems;
        int cartItemCount;
        BigDecimal cartTotal;

        if (isLoggedIn) {
            cartItems = cartService.getCartItemsByUserId(userId);
            cartItemCount = cartService.getCartItemCount(userId);
            cartTotal = BigDecimal.valueOf(cartService.getCartTotal(userId));

            if (cartItems.isEmpty()) {
                cartItems = getSessionCart(session);
                cartItemCount = cartItems.size();
                cartTotal = calculateSessionCartTotal(cartItems);
            }
        } else {
            cartItems = getSessionCart(session);
            cartItemCount = cartItems.size();
            cartTotal = calculateSessionCartTotal(cartItems);
        }

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("cartItemCount", cartItemCount);
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("grandTotal", cartItemCount > 0
                ? cartTotal.add(BigDecimal.valueOf(20.00))
                : BigDecimal.ZERO);

        request.getRequestDispatcher("/views/cart.jsp").forward(request, response);
    }

    private void getCartItemsAsJson(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");
        boolean isLoggedIn = (userId != null && userId > 0);

        List<CartItem> cartItems;
        int cartItemCount;
        BigDecimal cartTotal;

        if (isLoggedIn) {
            cartItems = cartService.getCartItemsByUserId(userId);
            cartItemCount = cartService.getCartItemCount(userId);
            cartTotal = BigDecimal.valueOf(cartService.getCartTotal(userId));

            if (cartItems.isEmpty()) {
                cartItems = getSessionCart(session);
                cartItemCount = cartItems.size();
                cartTotal = calculateSessionCartTotal(cartItems);
            }
        } else {
            cartItems = getSessionCart(session);
            cartItemCount = cartItems.size();
            cartTotal = calculateSessionCartTotal(cartItems);
        }

        Map<String, Object> result = new HashMap<>();
        result.put("cartItems", cartItems);
        result.put("cartItemCount", cartItemCount);
        result.put("cartTotal", cartTotal);
        result.put("grandTotal", cartItemCount > 0
                ? cartTotal.add(BigDecimal.valueOf(20.00))
                : BigDecimal.ZERO);

        response.setContentType("application/json");
        response.getWriter().write(gson.toJson(simplifyResponse(result)));
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getOrCreateSessionCart(HttpSession session) {
        List<CartItem> sessionCart = (List<CartItem>) session.getAttribute("sessionCart");
        if (sessionCart == null) {
            sessionCart = new ArrayList<>();
            session.setAttribute("sessionCart", sessionCart);
        }
        return sessionCart;
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getSessionCart(HttpSession session) {
        List<CartItem> sessionCart = (List<CartItem>) session.getAttribute("sessionCart");
        return sessionCart != null ? sessionCart : new ArrayList<>();
    }

    private boolean addToSessionCart(HttpSession session, int productId, int quantity) {
        try {
            List<CartItem> sessionCart = getOrCreateSessionCart(session);

            for (CartItem item : sessionCart) {
                if (item.getProduct().getProductId() == productId) {
                    item.setQuantity(item.getQuantity() + quantity);
                    item.setItemTotal(item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity())));
                    session.setAttribute("sessionCart", sessionCart);
                    return true;
                }
            }


            Product product = cartService.getProductById(productId);
            if (product == null) return false;

            CartItem newItem = new CartItem();
            newItem.setCartId((long) generateTemporaryId());
            newItem.setProduct(product);
            newItem.setQuantity(quantity);
            newItem.setItemTotal(product.getPrice().multiply(BigDecimal.valueOf(quantity)));

            sessionCart.add(newItem);
            session.setAttribute("sessionCart", sessionCart);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private boolean removeFromSessionCart(HttpSession session, int cartId) {
        List<CartItem> sessionCart = getSessionCart(session);
        boolean removed = sessionCart.removeIf(item -> item.getCartId() == cartId);
        if (removed) {
            session.setAttribute("sessionCart", sessionCart);
        }
        return removed;
    }

    private boolean updateSessionCartItemQuantity(HttpSession session, int cartId, int newQuantity) {
        if (newQuantity <= 0) {
            return removeFromSessionCart(session, cartId);
        }

        List<CartItem> sessionCart = getSessionCart(session);
        for (CartItem item : sessionCart) {
            if (item.getCartId() == cartId) {
                item.setQuantity(newQuantity);
                item.setItemTotal(item.getProduct().getPrice().multiply(BigDecimal.valueOf(newQuantity)));
                session.setAttribute("sessionCart", sessionCart);
                return true;
            }
        }
        return false;
    }

    private boolean clearSessionCart(HttpSession session) {
        session.setAttribute("sessionCart", new ArrayList<CartItem>());
        return true;
    }

    private BigDecimal calculateSessionCartTotal(List<CartItem> sessionCart) {
        return sessionCart.stream()
                .map(CartItem::getItemTotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    private int generateTemporaryId() {
        return Math.abs(UUID.randomUUID().hashCode());
    }

    public void mergeSessionCartWithUserCart(HttpSession session, int userId) {
        if (userId <= 0) return;

        List<CartItem> sessionCart = getSessionCart(session);
        if (sessionCart != null && !sessionCart.isEmpty()) {
            sessionCart.forEach(item ->
                    cartService.addToCart(userId, item.getProduct().getProductId().intValue(), item.getQuantity())
            );
            clearSessionCart(session);
        }
    }
}