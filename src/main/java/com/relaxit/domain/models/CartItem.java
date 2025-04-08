package com.relaxit.domain.models;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class CartItem implements Serializable {

    private Long cartId;
    private Long userId;
    private Product product;
    private int quantity = 1;
    private LocalDateTime addedAt;
     private BigDecimal itemTotal;

    public CartItem() {
    }

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getProductId() {
        return product != null ? product.getProductId() : null;
    }

    public void setProductId(Long productId) {
        if (this.product == null) {
            this.product = new Product();
        }
        this.product.setProductId(productId);
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(LocalDateTime addedAt) {
        this.addedAt = addedAt;
    }

    public Product getProduct() {
        return product;
    }
    
    public void setProduct(Product product) {
        this.product = product;
    }

    public BigDecimal getItemTotal() {
        if (product != null && product.getPrice() != null) {
            return product.getPrice().multiply(new BigDecimal(quantity));
        }
        return BigDecimal.ZERO;
    }
    public void setItemTotal(BigDecimal itemTotal) {
        this.itemTotal = itemTotal;
    }
    
}
