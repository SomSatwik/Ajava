package com.example.controller;

import com.example.model.Student;
import com.example.model.StudentDAO;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/getStudent")
public class GetStudentServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws IOException {

        int id = Integer.parseInt(req.getParameter("id"));

        StudentDAO dao = new StudentDAO();

        Student student = dao.getStudent(id);

        resp.setContentType("text/html");

        PrintWriter out = resp.getWriter();

        if(student != null){

            out.println("<h2>Student Details</h2>");
            out.println("ID: " + student.getId() + "<br>");
            out.println("Name: " + student.getName() + "<br>");
            out.println("Email: " + student.getEmail());

        }else{

            out.println("<h2 style='color:red'>Student does not exist in database</h2>");

        }
    }
}