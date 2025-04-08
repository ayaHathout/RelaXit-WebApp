package com.relaxit.domain.Daos.Implementation;

import com.relaxit.domain.Daos.Interfaces.ProductDAO;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.utils.Connectivity;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDaoImpl implements ProductDAO {
    Connectivity connectivity;
    Connection connection;

    public ProductDaoImpl() {
        connectivity = new Connectivity();
        connection = connectivity.getConnection();
    }

    @Override
    public List<Product> getAllProducts() throws SQLException {
        System.out.println("In getAllProducts() in ProductDaoImpl");

        String sql = "select * from products";
        List<Product> products = new ArrayList();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product curProduct = new Product();
                curProduct.setProductId((long) rs.getInt("product_id"));
                curProduct.setName(rs.getString("name"));
                curProduct.setDescription(rs.getString("description"));
                curProduct.setPrice(rs.getBigDecimal("price"));
                // curProduct.setQuantity(rs.getInt("quantity"));
                curProduct.setProductImage(rs.getBlob("image_url") == null ? null : rs.getBytes("product_image"));

                products.add(curProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    @Override
    public Product getProductById(int productId) {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        
        try (Connection conn = Connectivity.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, productId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Product product = new Product();
                    product.setProductId((long) rs.getInt("product_id"));
                    product.setName(rs.getString("name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(new BigDecimal(rs.getString("price")));
                    product.setProductImage(rs.getBlob("image_url") == null ? null : rs.getBytes("product_image"));
                    
                    return product;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }
}
