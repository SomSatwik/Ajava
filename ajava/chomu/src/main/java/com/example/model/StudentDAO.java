package com.example.model;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class StudentDAO {

    public void saveStudent(Student s) {

        Session session = HibernateUtil
                .getSessionFactory()
                .openSession();

        Transaction tx = session.beginTransaction();

        session.save(s);

        tx.commit();
        session.close();
    }

    public void deleteStudent(int id) {

        Session session = HibernateUtil
                .getSessionFactory()
                .openSession();

        Transaction tx = session.beginTransaction();

        Student s = session.get(Student.class, id);

        if (s != null) {
            session.delete(s);
        }

        tx.commit();
        session.close();
    }
    public Student getStudent(int id){

        Session session = HibernateUtil
                .getSessionFactory()
                .openSession();

        Student s = session.get(Student.class,id);

        session.close();

        return s;
    }
}