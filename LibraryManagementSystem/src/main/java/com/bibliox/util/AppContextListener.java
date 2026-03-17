package com.bibliox.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("[BiblioX] Starting up...");
        HibernateUtil.getSessionFactory(); // init SessionFactory
        DataSeeder.seed();
        System.out.println("[BiblioX] Ready!");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        HibernateUtil.shutdown();
        System.out.println("[BiblioX] Shutdown complete.");
    }
}
