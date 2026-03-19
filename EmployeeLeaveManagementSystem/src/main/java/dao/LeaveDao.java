package dao;

import model.LeaveRequest;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.query.Query;
import util.HibernateUtil;

import java.util.List;

public class LeaveDao {

    public void applyLeave(LeaveRequest leaveRequest) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            session.save(leaveRequest);
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public List<LeaveRequest> getLeavesByEmployee(int employeeId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<LeaveRequest> query = session.createQuery(
                    "FROM LeaveRequest lr JOIN FETCH lr.employee WHERE lr.employee.id = :empId ORDER BY lr.appliedOn DESC",
                    LeaveRequest.class);
            query.setParameter("empId", employeeId);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<LeaveRequest> getAllLeaves() {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery(
                    "FROM LeaveRequest lr JOIN FETCH lr.employee ORDER BY lr.appliedOn DESC",
                    LeaveRequest.class).list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateStatus(int leaveId, String status) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            LeaveRequest lr = session.get(LeaveRequest.class, leaveId);
            if (lr != null) {
                lr.setStatus(status);
                session.update(lr);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) transaction.rollback();
            e.printStackTrace();
        }
    }

    public long countByStatus(String status) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(*) FROM LeaveRequest WHERE status = :status", Long.class);
            query.setParameter("status", status);
            Long count = query.uniqueResult();
            return count != null ? count : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public long countByStatusAndEmployee(String status, int employeeId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<Long> query = session.createQuery(
                    "SELECT COUNT(*) FROM LeaveRequest WHERE status = :status AND employee.id = :empId", Long.class);
            query.setParameter("status", status);
            query.setParameter("empId", employeeId);
            Long count = query.uniqueResult();
            return count != null ? count : 0;
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<LeaveRequest> getRecentLeaves(int limit) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            Query<LeaveRequest> query = session.createQuery(
                    "FROM LeaveRequest lr JOIN FETCH lr.employee ORDER BY lr.appliedOn DESC",
                    LeaveRequest.class);
            query.setMaxResults(limit);
            return query.list();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
