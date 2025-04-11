package com.relaxit.domain.services;

import com.relaxit.domain.models.CartItem;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.models.User;
import com.relaxit.repository.Impl.CartItemRepositoryImpl;
import com.relaxit.repository.Impl.ProductRepositoryImpl;
import com.relaxit.repository.Impl.UserRepositoryImpl;
import com.relaxit.repository.Interfaces.CartItemRepository;
import com.relaxit.repository.Interfaces.ProductRepository;
import com.relaxit.repository.Interfaces.UserRepository;


import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class CartService {

    private CartItemRepository cartItemRepository;
    private ProductRepository productRepository;
    private UserRepository userRepository;

    public CartService() {
        this.cartItemRepository = new CartItemRepositoryImpl();
        this.productRepository = new ProductRepositoryImpl();
        this.userRepository = new UserRepositoryImpl();
    }

    public boolean addToCart(int userId, int productId, int quantity) {
        if (userId <= 0 || quantity <= 0) {
            return false;
        }

        try {
            User user = userRepository.findById((long) userId);
            Product product = productRepository.findById((long) productId);

            if (user == null || product == null) {
                return false;
            }

            List<CartItem> existingItems = cartItemRepository.findByUserIdAndProductId((long) userId, (long) productId);

            if (!existingItems.isEmpty()) {
                CartItem item = existingItems.get(0);
                item.setQuantity(item.getQuantity() + quantity);
                cartItemRepository.update(item);
            } else {
                CartItem newItem = new CartItem();
                newItem.setUser(user);
                newItem.setProduct(product);
                newItem.setQuantity(quantity);
                cartItemRepository.save(newItem);
            }

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cartItemRepository.close();
        }
    }

    public boolean removeFromCart(int cartId) {
        if (cartId <= 0) {
            return false;
        }

        try {
            cartItemRepository.deleteById((long) cartId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cartItemRepository.close();
        }
    }

    public boolean removeProductFromCart(int userId, int productId) {
        if (userId <= 0 || productId <= 0) {
            return false;
        }

        try {
            cartItemRepository.deleteByUserIdAndProductId((long) userId, (long) productId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cartItemRepository.close();
        }
    }

    public boolean updateCartItemQuantity(int cartId, int quantity) {
        if (cartId <= 0) {
            return false;
        }

        if (quantity <= 0) {
            return removeFromCart(cartId);
        }

        try {
            CartItem cartItem = cartItemRepository.findById((long) cartId);
            if (cartItem == null) {
                return false;
            }

            cartItem.setQuantity(quantity);
            cartItemRepository.update(cartItem);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cartItemRepository.close();
        }
    }

    public List<CartItem> getCartItemsByUserId(int userId) {
        if (userId <= 0) {
            return new ArrayList<>();
        }

        try {
            return cartItemRepository.findByUserId((long) userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        } finally {
            cartItemRepository.close();
        }
    }

    public int getCartItemCount(int userId) {
        if (userId <= 0) {
            return 0;
        }

        try {
            Long count = cartItemRepository.countItemsByUserId((long) userId);
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        } finally {
            cartItemRepository.close();
        }
    }


    public double getCartTotal(int userId) {
        if (userId <= 0) {
            return 0.0;
        }

        try {
            BigDecimal total = cartItemRepository.calculateTotalByUserId((long) userId);
            return total != null ? total.doubleValue() : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        } finally {
            cartItemRepository.close();
        }
    }

    public boolean clearCart(int userId) {
        if (userId <= 0) {
            return false;
        }

        try {
            cartItemRepository.deleteByUserId((long) userId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            cartItemRepository.close();
        }
    }

    public Product getProductById(int productId) {
        if (productId <= 0) {
            return null;
        }

        try {
            return productRepository.findById((long) productId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            cartItemRepository.close();
        }
    }
}
