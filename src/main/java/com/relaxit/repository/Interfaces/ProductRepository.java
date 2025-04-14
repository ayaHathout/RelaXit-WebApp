package com.relaxit.repository.Interfaces;

import com.relaxit.domain.models.Product;
import com.relaxit.presentation.utils.ProductDTO;

import java.util.List;

public interface ProductRepository {
    public List<Product> getAllProducts(int pageNumber, int pageSize);
    public long getTotalProductsCount();
    public List<Product> getProductsOfCategory(int pageNumber, int pageSize, int categoryId);
    public long getTotalProductsCountOfCategory(int categoryId);
    public List<Product> getBestThreeProducts();
    public boolean updateQuantity(Long productId, Integer newQuantity);
    public List<ProductDTO> getAllProductsInProductDTO(int pageNumber, int pageSize);

    Product findById(Long id);
}
