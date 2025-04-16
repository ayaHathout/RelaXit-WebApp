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

    public boolean addToCart(Long userId, Long productId, int quantity) {
        if (userId == null || userId <= 0 || productId == null || productId <= 0 || quantity <= 0) {
            return false;
        }

        try {
            User user = userRepository.findById(userId);
            Product product = productRepository.findById(productId);

            if (user == null || product == null) {
                return false;
            }

            // Check stock availability
            if (quantity > product.getQuantity()) {
                return false;
            }

            List<CartItem> existingItems = cartItemRepository.findByUserIdAndProductId(userId, productId);

            if (!existingItems.isEmpty()) {
                CartItem item = existingItems.get(0);
                int newQuantity = item.getQuantity() + quantity;
                if (newQuantity > product.getQuantity()) {
                    return false;
                }
                item.setQuantity(newQuantity);
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
        }
    }

    public boolean removeFromCart(Long cartId) {
        if (cartId == null || cartId <= 0) {
            return false;
        }

        try {
            cartItemRepository.deleteById(cartId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeProductFromCart(Long userId, Long productId) {
        if (userId == null || userId <= 0 || productId == null || productId <= 0) {
            return false;
        }

        try {
            cartItemRepository.deleteByUserIdAndProductId(userId, productId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateCartItemQuantity(Long cartId, int quantity) {
        if (cartId == null || cartId <= 0) {
            return false;
        }

        if (quantity <= 0) {
            return removeFromCart(cartId);
        }

        try {
            CartItem cartItem = cartItemRepository.findById(cartId);
            if (cartItem == null) {
                return false;
            }

            // Check stock availability
            Product product = cartItem.getProduct();
            if (quantity > product.getQuantity()) {
                return false;
            }

            cartItem.setQuantity(quantity);
            cartItemRepository.update(cartItem);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<CartItem> getCartItemsByUserId(Long userId) {
        if (userId == null || userId <= 0) {
            return new ArrayList<>();
        }

        try {
            return cartItemRepository.findByUserId(userId);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public int getCartItemCount(Long userId) {
        if (userId == null || userId <= 0) {
            return 0;
        }

        try {
            Long count = cartItemRepository.countItemsByUserId(userId);
            return count != null ? count.intValue() : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public double getCartTotal(Long userId) {
        if (userId == null || userId <= 0) {
            return 0.0;
        }

        try {
            BigDecimal total = cartItemRepository.calculateTotalByUserId(userId);
            return total != null ? total.doubleValue() : 0.0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0.0;
        }
    }

    public boolean clearCart(Long userId) {
        if (userId == null || userId <= 0) {
            return false;
        }

        try {
            cartItemRepository.deleteByUserId(userId);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Product getProductById(Long productId) {
        if (productId == null || productId <= 0) {
            return null;
        }

        try {
            return productRepository.findById(productId);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getExistingCartQuantity(Long userId, Long productId) {
        if (userId == null || userId <= 0 || productId == null || productId <= 0) {
            return 0;
        }

        try {
            List<CartItem> items = cartItemRepository.findByUserIdAndProductId(userId, productId);
            return items.isEmpty() ? 0 : items.get(0).getQuantity();
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public void mergeSessionCartWithUserCart(Long userId, List<CartItem> sessionCart) {
        if (userId == null || sessionCart == null || sessionCart.isEmpty()) {
            return;
        }

        try {
            for (CartItem item : sessionCart) {
                Long productId = item.getProduct().getProductId();
                int quantity = item.getQuantity();
                Product product = getProductById(productId);
                if (product != null) {
                    int availableQuantity = product.getQuantity();
                    int existingQuantity = getExistingCartQuantity(userId, productId);
                    int totalRequested = existingQuantity + quantity;
                    if (totalRequested <= availableQuantity) {
                        addToCart(userId, productId, quantity);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}