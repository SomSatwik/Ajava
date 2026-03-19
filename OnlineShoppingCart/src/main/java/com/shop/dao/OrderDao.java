package com.shop.dao;

import com.shop.entity.Order;
import com.shop.entity.OrderItem;
import com.shop.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class OrderDao {
    
    public boolean placeOrder(Order order, List<OrderItem> items) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            
            session.save(order);
            for(OrderItem item : items) {
                item.setOrder(order);
                session.save(item);
            }
            
            transaction.commit();
            return true;
        } catch (Exception e) {
            if(transaction != null) transaction.rollback();
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Order> getOrdersByUser(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Order> query = session.createQuery("FROM Order o WHERE o.user.id = :uid ORDER BY o.orderDate DESC", Order.class);
            query.setParameter("uid", userId);
            return query.list();
        }
    }
    
    public List<Order> getAllOrders() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Order o ORDER BY o.orderDate DESC", Order.class).list();
        }
    }
    
    public Order getOrderById(int id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Order o = session.get(Order.class, id);
            if(o != null) {
                // Initialize lazy collection
                o.getOrderItems().size();
            }
            return o;
        }
    }
    
    public void updateOrderStatus(int orderId, String status) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Order o = session.get(Order.class, orderId);
            if(o != null) {
                o.setStatus(status);
                session.update(o);
            }
            transaction.commit();
        } catch (Exception e) {if(transaction!=null) transaction.rollback(); e.printStackTrace();}
    }
    
    public Map<String, Object> getOrderStats() {
        Map<String, Object> stats = new HashMap<>();
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Double totalRevenue = session.createQuery("SELECT sum(o.totalAmount) FROM Order o WHERE o.status != 'CANCELLED'", Double.class).uniqueResult();
            stats.put("totalRevenue", totalRevenue != null ? totalRevenue : 0.0);
            
            Long pendingCount = session.createQuery("SELECT count(o.id) FROM Order o WHERE o.status = 'PENDING'", Long.class).uniqueResult();
            stats.put("pendingCount", pendingCount != null ? pendingCount : 0);
            
            Long totalOrders = session.createQuery("SELECT count(o.id) FROM Order o", Long.class).uniqueResult();
            stats.put("totalOrders", totalOrders != null ? totalOrders : 0);
        }
        return stats;
    }
}
