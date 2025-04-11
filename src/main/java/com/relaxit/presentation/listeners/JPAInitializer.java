package com.relaxit.presentation.listeners;

import com.relaxit.domain.utils.JPAUtil;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class JPAInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        JPAUtil.getEntityManagerFactory();
        System.out.println("JPA initialized, tables should be created");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        JPAUtil.close();
        System.out.println("JPA closed");
    }
}