package com.shop.dao;

import com.shop.entity.Product;
import com.shop.entity.User;
import com.shop.entity.Wishlist;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.List;

public class WishlistDao {
    
    public void addToWishlist(int userId, int productId) {
        if (isInWishlist(userId, productId)) return;
        
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Wishlist item = new Wishlist();
            
            User user = session.get(User.class, userId);
            Product product = session.get(Product.class, productId);
            
            item.setUser(user);
            item.setProduct(product);
            
            session.save(item);
            transaction.commit();
        } catch (Exception e) {
            if(transaction!=null) transaction.rollback();
            e.printStackTrace();
        }
    }
    
    public void removeFromWishlist(int userId, int productId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Query query = session.createQuery("DELETE FROM Wishlist w WHERE w.user.id = :uid AND w.product.id = :pid");
            query.setParameter("uid", userId);
            query.setParameter("pid", productId);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {if(transaction!=null) transaction.rollback(); e.printStackTrace();}
    }
    
    public List<Wishlist> getWishlistByUser(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Wishlist> query = session.createQuery("SELECT w FROM Wishlist w JOIN FETCH w.product WHERE w.user.id = :uid", Wishlist.class);
            query.setParameter("uid", userId);
            return query.list();
        }
    }
    
    public boolean isInWishlist(int userId, int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT count(w.id) FROM Wishlist w WHERE w.user.id = :uid AND w.product.id = :pid", Long.class);
            query.setParameter("uid", userId);
            query.setParameter("pid", productId);
            return query.uniqueResult() > 0;
        }
    }
}
