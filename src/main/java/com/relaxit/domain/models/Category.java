package com.relaxit.domain.models;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.annotations.Expose;

@Entity
@Table(name = "categories")
public class Category implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "category_id")
    @Expose
    private Long categoryId;

    @Column(name = "name", nullable = false, length = 50)
    @Expose
    private String name;

    @Column(name = "description", columnDefinition = "TEXT")
    @Expose
    private String description;

    @OneToMany(mappedBy = "category")
    private List<Product> products = new ArrayList<>();

    public Category() {

    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
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

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

}
