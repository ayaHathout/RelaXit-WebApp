package com.relaxit.presentation.filters;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.User;
import com.relaxit.domain.services.CartService;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebFilter("/*")
public class CartFilter implements Filter {

    private CartService cartService;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        cartService = new CartService();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(true);

        String requestURI = httpRequest.getRequestURI();
        if (requestURI.matches(".*\\.(css|js|png|jpg|jpeg|gif|svg)$") ||
                requestURI.contains("/cart/update") ||
                requestURI.contains("/cart/items")) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) session.getAttribute("user");
        Long userId = user != null ? user.getUserId() : null;
        boolean isLoggedIn = userId != null;

        try {
            List<CartItem> cartItems;
            int cartItemCount;
            BigDecimal cartTotal;

            if (isLoggedIn && userId != null) {
                cartItems = cartService.getCartItemsByUserId(userId);
                cartItemCount = cartService.getCartItemCount(userId);
                cartTotal = BigDecimal.valueOf(cartService.getCartTotal(userId));
            } else {
                cartItems = getSessionCart(session);
                cartItemCount = calculateSessionCartItemCount(cartItems);
                cartTotal = calculateSessionCartTotal(cartItems);
            }

            session.setAttribute("cartItems", cartItems);
            session.setAttribute("cartItemCount", cartItemCount);
            session.setAttribute("cartTotal", cartTotal.doubleValue());
            session.setAttribute("grandTotal", cartItemCount > 0 ?
                    cartTotal.add(BigDecimal.valueOf(20.00)).doubleValue() : 0.00);

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("cartItems", new ArrayList<>());
            session.setAttribute("cartItemCount", 0);
            session.setAttribute("cartTotal", 0.0);
            session.setAttribute("grandTotal", 0.0);
        }

        chain.doFilter(request, response);
    }

    @SuppressWarnings("unchecked")
    private List<CartItem> getSessionCart(HttpSession session) {
        List<CartItem> sessionCart = (List<CartItem>) session.getAttribute("sessionCart");
        return sessionCart != null ? sessionCart : new ArrayList<>();
    }

    private BigDecimal calculateSessionCartTotal(List<CartItem> sessionCart) {
        BigDecimal total = BigDecimal.ZERO;
        for (CartItem item : sessionCart) {
            total = total.add(item.getItemTotal());
        }
        return total;
    }

    private int calculateSessionCartItemCount(List<CartItem> sessionCart) {
        return sessionCart.stream()
                .mapToInt(CartItem::getQuantity)
                .sum();
    }

    @Override
    public void destroy() {
    }
}