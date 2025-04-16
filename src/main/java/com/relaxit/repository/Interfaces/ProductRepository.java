package com.relaxit.repository.Interfaces;

import com.relaxit.domain.dtos.ProductDTO;
import com.relaxit.domain.models.Product;
import java.util.List;

public interface ProductRepository {
    public List<Product> getAllProducts(int pageNumber, int pageSize);
    public long getTotalProductsCount();
    public List<Product> getProductsOfCategory(int pageNumber, int pageSize, int categoryId);
    public long getTotalProductsCountOfCategory(int categoryId);
    public List<Product> getBestThreeProducts();
    public boolean updateQuantity(Long productId, Integer newQuantity);

    Product findById(Long id);
    Product save(Product product);
    void delete(Long id);

    List<Product> searchProducts(String keyword, int pageNumber, int pageSize);
    public long getTotalSearchProductsCount(String keyword);

    public List<ProductDTO> getAllProductsInProductDTO(int pageNumber, int pageSize);
    public List<ProductDTO> getProductsOfCategoryInProductDTO(int pageNumber, int pageSize, int categoryId);
    void close();
}
