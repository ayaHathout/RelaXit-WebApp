package com.relaxit.repository.Impl;

import com.relaxit.domain.models.Product;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.Interfaces.ProductRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Query;
import java.util.ArrayList;
import java.util.List;

public class ProductRepositoryImpl implements ProductRepository {
    private final EntityManager entityManager;
    private String sql;
    private Query query;

    public ProductRepositoryImpl () {
        entityManager = JPAUtil.getEntityManager();
        sql = null;
        query = null;
    }

    @Override
    public List<Product> getAllProducts(int pageNumber, int pageSize) {
        System.out.println("In getAllProducts() in ProductRepositoryImpl");

        int startIndex = (pageNumber - 1) *  pageSize;

        sql = "select * from products limit ?1, ?2";
        query = entityManager.createNativeQuery(sql, Product.class).setParameter(1, startIndex).setParameter(2, pageSize);
        List<Product> resultList = query.getResultList();

        List<Product> products = new ArrayList();
        for (Product product: resultList) {
            Product curProduct = new Product();
            curProduct.setProductId(product.getProductId());
            curProduct.setName(product.getName());
            curProduct.setDescription(product.getDescription());
            curProduct.setPrice(product.getPrice());
            curProduct.setQuantity(product.getQuantity());
            curProduct.setProductImage(product.getProductImage() == null ? null : product.getProductImage());

            products.add(curProduct);
        }
        return products;
    }

    public long getTotalProductsCount() {
        System.out.println("In getTotalProductsCount() in ProductRepositoryImpl");

        sql = "SELECT COUNT(p) FROM Product p";
        query = entityManager.createQuery(sql);
        return (long) query.getSingleResult();
    }

    public long getTotalProductsCountOfCategory(int categoryId) {
        System.out.println("In getTotalProductsCountOfCategory() in ProductRepositoryImpl");

        sql = "SELECT COUNT(p) FROM Product p where p.category.categoryId = ?1";
        query = entityManager.createQuery(sql).setParameter(1, categoryId);
        return (long) query.getSingleResult();
    }

    @Override
    public List<Product> getProductsOfCategory(int pageNumber, int pageSize, int categoryId) {
        System.out.println("In getProductsOfCategory() in ProductRepositoryImpl");

        int startIndex = (pageNumber - 1) *  pageSize;

        sql = "select * from products where category_id = ?1 limit ?2, ?3";
        query = entityManager.createNativeQuery(sql, Product.class).setParameter(1, categoryId).setParameter(2, startIndex).setParameter(3, pageSize);
        List<Product> resultList = query.getResultList();

        List<Product> products = new ArrayList();
        for (Product product: resultList) {
            Product curProduct = new Product();
            curProduct.setProductId(product.getProductId());
            curProduct.setName(product.getName());
            curProduct.setDescription(product.getDescription());
            curProduct.setPrice(product.getPrice());
            curProduct.setQuantity(product.getQuantity());
            curProduct.setProductImage(product.getProductImage() == null ? null : product.getProductImage());

            products.add(curProduct);
        }
        return products;
    }

    @Override
    public List<Product> getBestThreeProducts() {
        System.out.println("In getBestThreeProducts() in ProductRepositoryImpl");

        sql = "(select * from products where category_id = 1 limit 1) union (select * from products where category_id = 3 limit 1) union (select * from products where category_id = 9 limit 1)";
        query = entityManager.createNativeQuery(sql, Product.class);
        List<Product> resultList = query.getResultList();

        List<Product> products = new ArrayList();
        for (Product product: resultList) {
            Product curProduct = new Product();
            curProduct.setProductId(product.getProductId());
            curProduct.setName(product.getName());
            curProduct.setDescription(product.getDescription());
            curProduct.setPrice(product.getPrice());
            curProduct.setQuantity(product.getQuantity());
            curProduct.setProductImage(product.getProductImage() == null ? null : product.getProductImage());

            products.add(curProduct);
        }
        return products;
    }

    @Override
    public Product findById(Long id) {
        EntityManager em = JPAUtil.getEntityManager();
        try {
            return em.find(Product.class, id);
        } finally {
            em.close();
        }
    }

    @Override
    public boolean updateQuantity(Long productId, Integer newQuantity) {
        System.out.println("In updateQuantity() in ProductRepositoryImpl");

        System.out.println(productId + ": " + newQuantity);

        EntityTransaction entityTransaction = null;
        try {
            entityTransaction = entityManager.getTransaction();
            entityTransaction.begin();

            String sql = "UPDATE Product SET quantity = :newQuantity WHERE productId = :productId";
            Query query = entityManager.createQuery(sql)
                    .setParameter("newQuantity", newQuantity)
                    .setParameter("productId", productId);

            int updateCount = query.executeUpdate();
            entityTransaction.commit();
            return updateCount > 0;
        } catch (Exception e) {
            if (entityTransaction != null && entityTransaction.isActive())
                entityTransaction.rollback();

            throw new RuntimeException("Failed to update quantity", e);
        }
    }
}
