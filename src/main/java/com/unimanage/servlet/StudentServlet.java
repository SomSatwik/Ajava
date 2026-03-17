package com.unimanage.servlet;

import com.unimanage.dao.StudentDAO;
import com.unimanage.entity.Student;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentServlet extends HttpServlet {
    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("new".equals(action)) {
            request.getRequestDispatcher("addStudent.jsp").forward(request, response);
        } else {
            List<Student> listStudent = studentDAO.getAllStudents();
            request.setAttribute("listStudent", listStudent);
            request.getRequestDispatcher("students.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String course = request.getParameter("course");
        String enrollmentStr = request.getParameter("enrollmentYear");
        Integer enrollmentYear = enrollmentStr != null && !enrollmentStr.isEmpty() ? Integer.parseInt(enrollmentStr) : 2026;

        Student newStudent = new Student(fullName, email, course, enrollmentYear);
        studentDAO.saveStudent(newStudent);

        response.sendRedirect("students");
    }
}
