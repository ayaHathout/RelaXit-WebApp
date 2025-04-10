package com.relaxit;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import com.relaxit.domain.enums.UserRole;
import com.relaxit.domain.models.*;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

public class JPAUtil {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("myJPAUnit");
    
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }
    
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public static void close() {
        emf.close();
    }

   public static void main(String[] args) {
    EntityManager em = getEntityManager();
    EntityTransaction trans = em.getTransaction();

    try {
        trans.begin();

        // 1. Create category
        Category furniture = new Category();
        furniture.setName("Furniture");
        furniture.setDescription("Stylish and functional furniture for home and office.");
        em.persist(furniture);

        // 2. Create products
        Product chair = new Product();
        chair.setName("Office Chair");
        chair.setDescription("Ergonomic chair with adjustable height and lumbar support.");
        chair.setPrice(new BigDecimal("299.99"));
        chair.setQuantity(15);
        chair.setCategory(furniture);

        Product desk = new Product();
        desk.setName("Wooden Desk");
        desk.setDescription("Spacious wooden desk for work or study.");
        desk.setPrice(new BigDecimal("499.50"));
        desk.setQuantity(10);
        desk.setCategory(furniture);

        Product lamp = new Product();
        lamp.setName("LED Lamp");
        lamp.setDescription("Modern desk lamp with adjustable brightness.");
        lamp.setPrice(new BigDecimal("89.99"));
        lamp.setQuantity(25);
        lamp.setCategory(furniture);

        em.persist(chair);
        em.persist(desk);
        em.persist(lamp);

        // 3. Create users
        User user1 = new User("sara@example.com", "pass123", "Sara Ahmed", 
            LocalDate.of(2000, 5, 15), "Engineer", "Nasr City", "Reading, Tech");
        user1.setRole(UserRole.USER);
        em.persist(user1);

        User user2 = new User("omar@example.com", "123456", "Omar Nabil", 
            LocalDate.of(1998, 11, 22), "Designer", "Heliopolis", "Art, Gaming");
        user2.setRole(UserRole.USER);
        em.persist(user2);

        // 4. Add items to their carts
        CartItem item1 = new CartItem();
        item1.setUser(user1);
        item1.setProduct(chair);
        item1.setQuantity(2);
        item1.setItemTotal(item1.getItemTotal());
        em.persist(item1);

        CartItem item2 = new CartItem();
        item2.setUser(user1);
        item2.setProduct(lamp);
        item2.setQuantity(1);
        item2.setItemTotal(item2.getItemTotal());
        em.persist(item2);

        CartItem item3 = new CartItem();
        item3.setUser(user2);
        item3.setProduct(desk);
        item3.setQuantity(1);
        item3.setItemTotal(item3.getItemTotal());
        em.persist(item3);

        trans.commit();
        System.out.println("Data inserted successfully.");

    } catch (Exception e) {
        if (trans.isActive()) {
            trans.rollback();
        }
        e.printStackTrace();
    } finally {
        em.close();
        close();
    }
}

}