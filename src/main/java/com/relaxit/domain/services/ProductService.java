package com.relaxit.domain.services;

import com.relaxit.domain.models.Product;
import com.relaxit.repository.Impl.ProductRepositoryImpl;
import com.relaxit.repository.Interfaces.ProductRepository;

import java.util.List;

public class ProductService {
    private ProductRepository productRepository;

    public ProductService () {
        productRepository = new ProductRepositoryImpl();
    }

    public List<Product> getAllProducts(int pageNumber, int pageSize) {
        return productRepository.getAllProducts(pageNumber, pageSize);
    }

    public long getTotalProductsCount() {
        return productRepository.getTotalProductsCount();
    }

    public List<Product> getProductsOfCategory(int pageNumber, int pageSize, int categoryId) {
        return productRepository.getProductsOfCategory(pageNumber, pageSize, categoryId);
    }

    public long getTotalProductsCountOfCategory(int categoryId) {
        return productRepository.getTotalProductsCountOfCategory(categoryId);
    }

    public List<Product> getBestThreeProducts() {
        return productRepository.getBestThreeProducts();
    }
}
