package com.relaxit.domain.Daos.Interfaces;

import com.relaxit.domain.models.Product;

import java.sql.SQLException;
import java.util.List;

public interface ProductDAO {
    List<Product> getAllProducts(int pageNumber, int pageSize) throws SQLException;
    public int getTotalProductsCount() throws SQLException;
}
