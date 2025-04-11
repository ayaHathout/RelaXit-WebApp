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
    public List<Product> getAllProducts(int pageNumber, int pageSize) throws SQLException {
        System.out.println("In getAllProducts() in ProductDaoImpl");

        int startIndex = (pageNumber - 1) *  pageSize;

        String sql = "select * from Product limit ?, ?";

        List<Product> products = new ArrayList();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, startIndex);
            stmt.setInt(2, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product curProduct = new Product();
                curProduct.setName(rs.getString("name"));
                curProduct.setDescription(rs.getString("description"));
                curProduct.setPrice(rs.getBigDecimal("price"));
                // curProduct.setQuantity(rs.getInt("quantity"));
                curProduct.setProductImage(rs.getString("product_image") == null ? null : rs.getString("product_image"));

                products.add(curProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public int getTotalProductsCount() throws SQLException {
        System.out.println("In getTotalProductsCount() in ProductDaoImpl");

        String sql = "SELECT COUNT(*) FROM Product";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next())  return rs.getInt(1);
        }
        return 0;
    }

    public int getTotalProductsCountOfCategory(int categoryId) throws SQLException {
        System.out.println("In getTotalProductsCountOfCategory() in ProductDaoImpl");

        String sql = "SELECT COUNT(*) FROM Product where category_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next())  return rs.getInt(1);
        }
        return 0;
    }

    @Override
    public List<Product> getProductsOfCategory(int pageNumber, int pageSize, int categoryId) throws SQLException {
        System.out.println("In getProductsOfCategory() in ProductDaoImpl");

        int startIndex = (pageNumber - 1) *  pageSize;

        List<Product> products = new ArrayList<>();

        String sql = "Select * from product where category_id = ? limit ?, ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, categoryId);
            stmt.setInt(2, startIndex);
            stmt.setInt(3, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product curProduct = new Product();
                curProduct.setName(rs.getString("name"));
                curProduct.setDescription(rs.getString("description"));
                curProduct.setPrice(rs.getBigDecimal("price"));
                // curProduct.setQuantity(rs.getInt("quantity"));
                curProduct.setProductImage(rs.getString("product_image") == null ? null : rs.getString("product_image"));

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
                    product.setProductImage(rs.getString("image_url") == null ? null : rs.getString("product_image"));
                    
                    return product;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return null;
    }

    @Override
    public List<Product> getBestThreeProducts() {
        System.out.println("In getBestThreeProducts() in ProductDaoImpl");

        String sql = "(SELECT * FROM  iti.product where category_id = 1 limit 1)\n" +
                "union\n" +
                "(SELECT * FROM  iti.product where category_id = 3 limit 1)\n" +
                "union\n" +
                "(SELECT * FROM  iti.product where category_id = 9 limit 1)";

        List<Product> products = new ArrayList();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Product curProduct = new Product();
                curProduct.setName(rs.getString("name"));
                curProduct.setDescription(rs.getString("description"));
                curProduct.setPrice(rs.getBigDecimal("price"));
                // curProduct.setQuantity(rs.getInt("quantity"));
                curProduct.setProductImage(rs.getString("product_image") == null ? null : rs.getString("product_image"));

                products.add(curProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}
