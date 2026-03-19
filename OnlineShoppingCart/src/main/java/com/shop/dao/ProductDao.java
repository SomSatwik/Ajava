package com.shop.dao;

import com.shop.entity.Product;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class ProductDao {
    
    public List<Product> getAllProducts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Product p ORDER BY p.createdAt DESC", Product.class).list();
        }
    }
    
    public Product getProductById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Product.class, id);
        }
    }
    
    public List<Product> getProductsByCategory(int categoryId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Product> query = session.createQuery("FROM Product p WHERE p.category.id = :cid ORDER BY p.id DESC", Product.class);
            query.setParameter("cid", categoryId);
            return query.list();
        }
    }
    
    public List<Product> searchProducts(String keyword) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Product> query = session.createQuery("FROM Product p WHERE lower(p.name) LIKE :kw OR lower(p.description) LIKE :kw ORDER BY p.id DESC", Product.class);
            query.setParameter("kw", "%" + keyword.toLowerCase() + "%");
            return query.list();
        }
    }
    
    public List<Product> getFeaturedProducts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Product p WHERE p.featured = true", Product.class).setMaxResults(8).list();
        }
    }
    
    public void addProduct(Product p) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(p);
            transaction.commit();
        } catch (Exception e) {if (transaction != null) transaction.rollback(); e.printStackTrace();}
    }
    
    public void updateProduct(Product p) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.update(p);
            transaction.commit();
        } catch (Exception e) {if (transaction != null) transaction.rollback(); e.printStackTrace();}
    }
    
    public void deleteProduct(int id) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Product p = session.get(Product.class, id);
            if(p != null) session.delete(p);
            transaction.commit();
        } catch (Exception e) {if (transaction != null) transaction.rollback(); e.printStackTrace();}
    }
    
    public List<Product> getProductsSorted(String sortBy) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            String q = "FROM Product p ";
            if("price_asc".equals(sortBy)) q += "ORDER BY p.price ASC";
            else if("price_desc".equals(sortBy)) q += "ORDER BY p.price DESC";
            else if("rating".equals(sortBy)) q += "ORDER BY p.rating DESC";
            else q += "ORDER BY p.createdAt DESC";
            return session.createQuery(q, Product.class).list();
        }
    }
    
    public List<Product> getLowStockProducts() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Product p WHERE p.stock < 10", Product.class).list();
        }
    }
}
