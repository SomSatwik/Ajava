package com.shop.dao;

import com.shop.entity.CartItem;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.math.BigDecimal;
import java.util.List;

public class CartDao {
    
    public void addToCart(CartItem item) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(item);
            transaction.commit();
        } catch (Exception e) {if(transaction!=null) transaction.rollback(); e.printStackTrace();}
    }
    
    public List<CartItem> getCartByUser(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<CartItem> query = session.createQuery("SELECT c FROM CartItem c JOIN FETCH c.product WHERE c.user.id = :uid", CartItem.class);
            query.setParameter("uid", userId);
            return query.list();
        }
    }
    
    public void updateQuantity(int cartItemId, int qty) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            CartItem item = session.get(CartItem.class, cartItemId);
            if(item != null) {
                item.setQuantity(qty);
                session.update(item);
            }
            transaction.commit();
        } catch (Exception e) {if(transaction!=null) transaction.rollback(); e.printStackTrace();}
    }
    
    public void removeFromCart(int cartItemId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            CartItem item = session.get(CartItem.class, cartItemId);
            if(item != null) session.delete(item);
            transaction.commit();
        } catch (Exception e) {if(transaction!=null) transaction.rollback(); e.printStackTrace();}
    }
    
    public void clearCart(int userId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Query query = session.createQuery("DELETE FROM CartItem c WHERE c.user.id = :uid");
            query.setParameter("uid", userId);
            query.executeUpdate();
            transaction.commit();
        } catch (Exception e) {if(transaction!=null) transaction.rollback(); e.printStackTrace();}
    }
    
    public BigDecimal getCartTotal(int userId) {
        BigDecimal total = BigDecimal.ZERO;
        List<CartItem> items = getCartByUser(userId);
        for(CartItem item : items) {
            BigDecimal price = item.getProduct().getPrice();
            BigDecimal qty = new BigDecimal(item.getQuantity());
            total = total.add(price.multiply(qty));
        }
        return total;
    }
    
    public int getCartCount(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT count(c.id) FROM CartItem c WHERE c.user.id = :uid", Long.class);
            query.setParameter("uid", userId);
            Long result = query.uniqueResult();
            return result != null ? result.intValue() : 0;
        } catch (Exception e) { return 0; }
    }
    
    public boolean itemExistsInCart(int userId, int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery("SELECT count(c.id) FROM CartItem c WHERE c.user.id = :uid AND c.product.id = :pid", Long.class);
            query.setParameter("uid", userId);
            query.setParameter("pid", productId);
            return query.uniqueResult() > 0;
        }
    }
    
    public CartItem getCartItemByProduct(int userId, int productId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<CartItem> query = session.createQuery("FROM CartItem c WHERE c.user.id = :uid AND c.product.id = :pid", CartItem.class);
            query.setParameter("uid", userId);
            query.setParameter("pid", productId);
            return query.setMaxResults(1).uniqueResult();
        }
    }
}
