package com.bibliox.dao;

import com.bibliox.model.IssuedBook;
import com.bibliox.model.IssueStatus;
import com.bibliox.util.HibernateUtil;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.time.LocalDateTime;
import java.util.List;

public class IssuedBookDAO {

    public void save(IssuedBook issuedBook) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.persist(issuedBook);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public void update(IssuedBook issuedBook) {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.merge(issuedBook);
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }

    public IssuedBook findById(Long id) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(IssuedBook.class, id);
        }
    }

    public List<IssuedBook> findAll() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM IssuedBook ORDER BY issuedDate DESC", IssuedBook.class).list();
        }
    }

    public IssuedBook findActiveByUser(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM IssuedBook WHERE user.id = :uid AND status = :status",
                    IssuedBook.class)
                    .setParameter("uid", userId)
                    .setParameter("status", IssueStatus.ISSUED)
                    .uniqueResult();
        }
    }

    public List<IssuedBook> findByUser(Long userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM IssuedBook WHERE user.id = :uid ORDER BY issuedDate DESC",
                    IssuedBook.class)
                    .setParameter("uid", userId)
                    .list();
        }
    }

    public List<IssuedBook> findOverdue() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM IssuedBook WHERE status = :status AND dueDate < :now",
                    IssuedBook.class)
                    .setParameter("status", IssueStatus.ISSUED)
                    .setParameter("now", LocalDateTime.now())
                    .list();
        }
    }

    public long countIssued() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "SELECT COUNT(i) FROM IssuedBook i WHERE i.status = :status",
                    Long.class).setParameter("status", IssueStatus.ISSUED).uniqueResult();
        }
    }

    public long countOverdue() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "SELECT COUNT(i) FROM IssuedBook i WHERE i.status = :status AND i.dueDate < :now",
                    Long.class)
                    .setParameter("status", IssueStatus.ISSUED)
                    .setParameter("now", LocalDateTime.now())
                    .uniqueResult();
        }
    }

    public void updateOverdueStatuses() {
        Transaction tx = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            tx = session.beginTransaction();
            session.createMutationQuery(
                    "UPDATE IssuedBook SET status = :overdue WHERE status = :issued AND dueDate < :now")
                    .setParameter("overdue", IssueStatus.OVERDUE)
                    .setParameter("issued", IssueStatus.ISSUED)
                    .setParameter("now", LocalDateTime.now())
                    .executeUpdate();
            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            throw e;
        }
    }
}
