package com.relaxit.domain.models;

import java.io.Serializable;
import java.math.BigDecimal;

public class Product implements Serializable {

    private Long productId;
    private String name;
    private String description;
    private BigDecimal price;
    private Integer quantity;
    private Category category;
    private byte[] productImage;


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

    public byte[] getProductImage() {
        return productImage;
    }

    public void setProductImage(byte[] picture) {
        this.productImage = picture;
    }
    
}