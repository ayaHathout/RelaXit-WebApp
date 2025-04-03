package com.relaxit.domain.Daos.Implementation;

import com.relaxit.domain.Daos.Interfaces.ProductDAO;
import com.relaxit.domain.models.Product;
import com.relaxit.domain.utils.Connectivity;

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

        String sql = "select * from Product";
        List<Product> products = new ArrayList();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product curProduct = new Product();
                curProduct.setName(rs.getString("name"));
                curProduct.setDescription(rs.getString("description"));
                curProduct.setPrice(rs.getBigDecimal("price"));
               // curProduct.setQuantity(rs.getInt("quantity"));
                curProduct.setProductImage(rs.getBlob("product_image") == null ? null : rs.getBytes("product_image"));

                products.add(curProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
