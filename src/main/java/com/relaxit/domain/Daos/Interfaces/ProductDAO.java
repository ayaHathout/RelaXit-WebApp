package com.relaxit.domain.Daos.Interfaces;

import com.relaxit.domain.models.Product;

import java.sql.SQLException;
import java.util.List;

public interface ProductDAO {
    List<Product> getAllProducts(int pageNumber, int pageSize) throws SQLException;
    int getTotalProductsCount() throws SQLException;
    List<Product> getProductsOfCategory(int pageNumber, int pageSize, int categoryId) throws SQLException;
    int getTotalProductsCountOfCategory(int categoryId) throws SQLException;
    public Product getProductById(int productId);
}
