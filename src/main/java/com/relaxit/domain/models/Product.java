package com.relaxit.domain.models;
import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.annotations.Expose;

@Entity
@Table(name = "products")
public class Product implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    @Expose
    private Long productId;

    @Column(name = "name", nullable = false, length = 100)
    @Expose
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    @Expose
    private String description;

    @Column(name = "price", nullable = false)
    @Expose
    private BigDecimal price;

    @Column(name = "quantity", nullable = false)
    @Expose
    private Integer quantity;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "category_id")
    @Expose
    private Category category;

    @Column(name = "image_url", length = 255)
    @Expose
    private String productImage;

    @OneToMany(mappedBy = "product")
    private List<CartItem> cartItems = new ArrayList<>();
    
    @OneToMany(mappedBy = "product")
    private List<OrderItem> orderItems = new ArrayList<>();

    public Product() {
    }

    public Long getProductId() {
        return productId;
    }

    public void setProductId(Long id) {
        productId = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getProductImage() {
        return productImage;
    }

    public void setProductImage(String picture) {
        this.productImage = picture;
    }

    
    public List<CartItem> getCartItems() {
        return cartItems;
    }

    public void setCartItems(List<CartItem> cartItems) {
        this.cartItems = cartItems;
    }

    public List<OrderItem> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItem> orderItems) {
        this.orderItems = orderItems;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", price=" + price +
                ", quantity=" + quantity +
                '}';
    }
}