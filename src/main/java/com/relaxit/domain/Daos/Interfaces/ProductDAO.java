package com.relaxit.domain.Daos.Interfaces;

import com.relaxit.domain.models.Product;

import java.sql.SQLException;
import java.util.List;

public interface ProductDAO {
    List<Product> getAllProducts() throws SQLException;
    public Product getProductById(int productId);
    
}
