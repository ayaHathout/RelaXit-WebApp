package com.relaxit.domain.utils;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.hibernate.cfg.AvailableSettings;

import com.relaxit.domain.enums.UserRole;
import com.relaxit.domain.models.*;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.Persistence;

public class JPAUtil {
     private static final EntityManagerFactory emf;
     static {
         emf = Persistence.createEntityManagerFactory("myJPAUnit",
                 Map.of(AvailableSettings.DATASOURCE, createHikariCpDataSource()));
     }

     private static HikariDataSource createHikariCpDataSource() {
       
    HikariConfig config = new HikariConfig();
    HikariDataSource ds;

    config.setJdbcUrl("jdbc:mysql://localhost:3306/relaxit");
    config.setUsername("root");
    config.setPassword("M@12345678");
    config.setMaximumPoolSize(30);
    config.addDataSourceProperty("cachePrepStmts", true);
    config.addDataSourceProperty("prepStmtCacheSize", 250);
    config.addDataSourceProperty("prepStmtCacheSqlLimit", 2048);
    config.setDriverClassName("com.mysql.cj.jdbc.Driver");
    ds = new HikariDataSource(config);
    return ds;
}
    
    public static EntityManagerFactory getEntityManagerFactory() {
        return emf;
    }
    
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
    
    public static void close() {
        emf.close();
    }
}