package com.relaxit.repository.Impl;

import com.relaxit.domain.models.Product;
import com.relaxit.domain.models.Category;
import com.relaxit.domain.utils.JPAUtil;
import com.relaxit.repository.Interfaces.ProductRepository;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.persistence.TypedQuery;

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
        entityManager.clear();
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

            //loading category
            if (product.getCategory() != null) {
                Category category = new Category();
                category.setCategoryId(product.getCategory().getCategoryId());
                category.setName(product.getCategory().getName());
                category.setDescription(product.getCategory().getDescription());
                curProduct.setCategory(category);
            }
            products.add(curProduct);
        }
        return products;
    }

    public long getTotalProductsCount() {
        System.out.println("In getTotalProductsCount() in ProductRepositoryImpl");
        entityManager.clear();
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
        entityManager.clear();
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
        entityManager.clear();
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
        System.out.println("Finding product by ID: " + id);
        try {
            Product product = entityManager.find(Product.class, id);
            if (product != null) {
                product.getProductId(); 
                product.getName();
                product.getDescription();
                product.getPrice();
                product.getQuantity();
                product.getProductImage();

                System.out.println("Found product: " + product.getName());
            } else {
                System.out.println("Product not found with ID: " + id);
            }
            return product;
        } catch (Exception e) {
            System.out.println("Error finding product: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }
// @Override
// public Product findById(Long id) {
//     System.out.println("Finding product by ID: " + id);
//     try {
//         TypedQuery<Product> query = entityManager.createQuery(
//             "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE p.productId = :id", Product.class);
//         query.setParameter("id", id);
//         Product product = query.getSingleResult();
//         System.out.println("Found product: " + (product != null ? product.getName() : "null"));
//         return product;
//     } catch (NoResultException e) {
//         System.out.println("Product not found with ID: " + id);
//         return null;
//     } catch (Exception e) {
//         System.out.println("Error finding product: " + e.getMessage());
//         e.printStackTrace();
//         throw new RuntimeException("Failed to find product", e);
//     }
// }
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

    @Override
    public Product save(Product product) {
        EntityTransaction trans = entityManager.getTransaction();
        try {
            trans.begin();
            if (product.getProductId() == null) {
                entityManager.persist(product);
            } else {
                product = entityManager.merge(product);
            }
            trans.commit();
            return product;
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public void delete(Long id) {
        EntityTransaction trans = entityManager.getTransaction();
        try {
            trans.begin();
            Product product = entityManager.find(Product.class, id);
            if (product != null) {
                entityManager.remove(product);
            }
            trans.commit();
        } catch (Exception e) {
            if (trans.isActive()) {
                trans.rollback();
            }
            throw e;
        }
    }

    @Override
    public List<Product> searchProducts(String keyword, int pageNumber, int pageSize) {
        System.out.println(
                "Searching products with keyword: " + keyword + ", page: " + pageNumber + ", size: " + pageSize);
        try {
            entityManager.clear();
            TypedQuery<Product> query = entityManager.createQuery(
                    "SELECT p FROM Product p LEFT JOIN FETCH p.category WHERE LOWER(p.name) LIKE LOWER(:keyword) OR LOWER(p.description) LIKE LOWER(:keyword)",
                    Product.class);
            query.setParameter("keyword", "%" + keyword + "%");
            query.setFirstResult((pageNumber - 1) * pageSize);
            query.setMaxResults(pageSize);
            List<Product> results = query.getResultList();
            System.out.println("Found " + results.size() + " products for keyword: " + keyword);
            return results;
        } catch (Exception e) {
            System.out.println("Error searching products: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    @Override
    public long getTotalSearchProductsCount(String keyword) {
        System.out.println("Counting products for keyword: " + keyword);
        try {
            entityManager.clear();
            Query query = entityManager.createQuery(
                "SELECT COUNT(p) FROM Product p WHERE LOWER(p.name) LIKE LOWER(:keyword) OR LOWER(p.description) LIKE LOWER(:keyword)");
            query.setParameter("keyword", "%" + keyword + "%");
            long count = (long) query.getSingleResult();
            System.out.println("Total products for keyword " + keyword + ": " + count);
            return count;
        } catch (Exception e) {
            System.out.println("Error counting search products: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    @Override
    public void close() {
        entityManager.close();
    }

}
