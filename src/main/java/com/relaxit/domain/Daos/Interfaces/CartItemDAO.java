package com.relaxit.domain.Daos.Interfaces;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.Product;
import java.util.List;

public interface CartItemDAO {
    
    boolean addToCart(int userId, int productId, int quantity);
    boolean removeFromCart(int cartId);
    boolean removeProductFromCart(int userId, int productId);
    boolean updateCartItemQuantity(int cartId, int quantity);
    List<CartItem> getCartItemsByUserId(int userId);
    int getCartItemCount(int userId);
    double getCartTotal(int userId);
    boolean clearCart(int userId);
    public Product getProductById(int productId);
}