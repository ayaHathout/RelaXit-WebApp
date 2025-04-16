package com.relaxit.domain.services;

import com.relaxit.domain.models.Product;
import com.relaxit.repository.Impl.ProductRepositoryImpl;
import com.relaxit.repository.Interfaces.ProductRepository;

import java.math.BigDecimal;
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

    public Product findById(Long id) {
        return productRepository.findById(id);
    }

    public boolean updateQuantity(Long productId, Integer newQuantity) {
        return productRepository.updateQuantity(productId, newQuantity);
    }
    
    public Product saveProduct(Product product) {
        return productRepository.save(product);
    }
    
    public void deleteProduct(Long id) {
        productRepository.delete(id);
    }
    
    public List<Product> searchProducts(String keyword, int pageNumber, int pageSize) {
        return productRepository.searchProducts(keyword, pageNumber, pageSize);
    }

    public long getTotalSearchProductsCount(String keyword) {
        return productRepository.getTotalSearchProductsCount(keyword);
    }
    
    public void updateProductQuantity(Long productId, Integer newQuantity) {
        Product product = findById(productId);
        if (product != null && newQuantity >= 0) {
            product.setQuantity(newQuantity);
            productRepository.save(product);
        }
    }
    
    public void updateProductPrice(Long productId, BigDecimal newPrice) {
        Product product = findById(productId);
        if (product != null && newPrice.compareTo(BigDecimal.ZERO) >= 0) {
            product.setPrice(newPrice);
            productRepository.save(product);
        }
    }

}
