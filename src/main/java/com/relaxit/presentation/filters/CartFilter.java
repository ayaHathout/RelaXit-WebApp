package com.relaxit.presentation.filters;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.Daos.Implementation.CartItemDAOImpl;
import com.relaxit.domain.Daos.Interfaces.CartItemDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

@WebFilter("/*")
public class CartFilter implements Filter {
    private CartItemDAO cartItemDAO;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        cartItemDAO = new CartItemDAOImpl();
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpSession session = httpRequest.getSession(true);
        
        // Skip static resources and AJAX requests
        String requestURI = httpRequest.getRequestURI();
        if (requestURI.matches(".*\\.(css|js|png|jpg|jpeg|gif|svg)$") || 
            requestURI.contains("/cart/update") || 
            requestURI.contains("/cart/items")) {
            chain.doFilter(request, response);
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        boolean isLoggedIn = (userId != null && userId > 0);
        
        try {
            List<CartItem> cartItems;
            int cartItemCount;
            BigDecimal cartTotal;
            
            if (isLoggedIn) {
                cartItems = cartItemDAO.getCartItemsByUserId(userId);
                cartItemCount = cartItemDAO.getCartItemCount(userId);
                cartTotal = BigDecimal.valueOf(cartItemDAO.getCartTotal(userId));
                
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
    
    @Override
    public void destroy() {
        
    }
}