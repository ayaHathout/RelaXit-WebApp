package com.relaxit.domain.Daos.Implementation;

import com.relaxit.domain.Daos.Interfaces.CartItemDAO;
import com.relaxit.domain.Daos.Interfaces.ProductDAO;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.utils.Connectivity;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class CartItemDAOImpl implements CartItemDAO {
    
    Connectivity connectivity;
    Connection connection;
    
    public CartItemDAOImpl() {
        connectivity = new Connectivity();
        connection = connectivity.getConnection();
    }
    
    @Override
    public boolean addToCart(int userId, int productId, int quantity) {
       
        if (userId <= 0) {
            return false;
        }
        
        String sql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE quantity = quantity + ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            stmt.setInt(4, quantity);
            
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean removeFromCart(int cartId) {
        try {
            String query = "DELETE FROM cart_items WHERE cart_id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setInt(1, cartId);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean removeProductFromCart(int userId, int productId) {
        try {
            String query = "DELETE FROM cart_items WHERE user_id = ? AND product_id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setInt(1, userId);
                stmt.setInt(2, productId);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public boolean updateCartItemQuantity(int cartId, int quantity) {
        try {
            if (quantity <= 0) {
                return removeFromCart(cartId);
            }
            
            String query = "UPDATE cart_items SET quantity = ? WHERE cart_id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setInt(1, quantity);
                stmt.setInt(2, cartId);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    @Override
    public List<CartItem> getCartItemsByUserId(int userId) {
        
        if (userId <= 0) {
            return new ArrayList<>();
        }
        
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT ci.cart_id, ci.user_id, ci.product_id, ci.quantity, " +
                "p.name, p.description, p.price, p.image_url " +
                "FROM cart_items ci " +
                "JOIN products p ON ci.product_id = p.product_id " +
                "WHERE ci.user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setProductId((long)rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(new BigDecimal(rs.getDouble("price")));
                product.setProductImage(rs.getString("image_url") == null ? null : rs.getString("product_image"));
                
                CartItem cartItem = new CartItem();
                cartItem.setCartId((long)rs.getInt("cart_id"));
                cartItem.setProduct(product);
                cartItem.setQuantity(rs.getInt("quantity"));
                cartItem.setItemTotal(product.getPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())));
                
                cartItems.add(cartItem);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return cartItems;
    }
    
    @Override
    public int getCartItemCount(int userId) {
        if (userId <= 0) {
            return 0;
        }
        
        String sql = "SELECT SUM(quantity) FROM cart_items WHERE user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt(1);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0;
    }
    
    @Override
    public double getCartTotal(int userId) {
        if (userId <= 0) {
            return 0.0;
        }
        
        String sql = "SELECT SUM(p.price * ci.quantity) AS total " +
                "FROM cart_items ci " +
                "JOIN products p ON ci.product_id = p.product_id " +
                "WHERE ci.user_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("total");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return 0.0;
    }
    
    @Override
    public boolean clearCart(int userId) {
        try {
            String query = "DELETE FROM cart_items WHERE user_id = ?";
            try (PreparedStatement stmt = connection.prepareStatement(query)) {
                stmt.setInt(1, userId);
                return stmt.executeUpdate() > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Product getProductById(int productId) {
        Product product = null;
        String sql = "SELECT * FROM products WHERE product_id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                product = new Product();
                product.setProductId((long) rs.getInt("product_id"));
                product.setName(rs.getString("name"));
                product.setDescription(rs.getString("description"));
                product.setPrice(new BigDecimal(rs.getString("price")));
                product.setProductImage(rs.getString("image_url") == null ? null : rs.getString("product_image"));
            } 
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return product;
    }
}