package com.example.controller;

import com.example.model.Student;
import com.example.model.StudentDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/saveStudent")
public class StudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");

        Student s = new Student();

        s.setName(name);
        s.setEmail(email);

        StudentDAO dao = new StudentDAO();

        dao.saveStudent(s);

        resp.sendRedirect("saveStudent.jsp");
    }
}