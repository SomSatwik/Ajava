package com.example.controller;

import com.example.model.StudentDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/deleteStudent")
public class DeleteStudentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        StudentDAO dao = new StudentDAO();

        dao.deleteStudent(id);

        resp.sendRedirect("deleteStudent.jsp");
    }
}