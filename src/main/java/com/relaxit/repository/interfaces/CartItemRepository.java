package com.relaxit.repository.interfaces;
import com.relaxit.domain.models.CartItem;
import java.math.BigDecimal;
import java.util.List;

public interface CartItemRepository {
    CartItem findById(Long id);
    List<CartItem> findByUserId(Long userId);
    List<CartItem> findByUserIdAndProductId(Long userId, Long productId);
    void save(CartItem cartItem);
    void update(CartItem cartItem);
    void delete(CartItem cartItem);
    void deleteById(Long id);
    void deleteByUserIdAndProductId(Long userId, Long productId);
    void deleteByUserId(Long userId);
    Long countItemsByUserId(Long userId);
    BigDecimal calculateTotalByUserId(Long userId);
}
