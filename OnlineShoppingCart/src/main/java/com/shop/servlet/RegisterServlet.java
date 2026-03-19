package com.shop.servlet;

import com.shop.dao.UserDao;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDao userDao;
    
    @Override
    public void init() {
        userDao = new UserDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("register.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        
        try {
            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password); // in a real app, hash the password
            user.setPhone(phone);
            user.setAddress(address);
            user.setRole("CUSTOMER");
            
            userDao.register(user);
            resp.sendRedirect(req.getContextPath() + "/login?registered=true");
        } catch (Exception e) {
            req.setAttribute("error", "Registration failed. Email might already exist.");
            req.getRequestDispatcher("register.jsp").forward(req, resp);
        }
    }
}
