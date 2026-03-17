package com.bibliox.servlet;

import com.bibliox.dao.UserDAO;
import com.bibliox.model.Role;
import com.bibliox.model.User;
import com.bibliox.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // If already logged in, redirect
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("currentUser") != null) {
            User user = (User) session.getAttribute("currentUser");
            redirectByRole(user, req, res);
            return;
        }
        req.getRequestDispatcher("/pages/login.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        User user = userDAO.findByEmail(email);

        if (user != null && PasswordUtil.verify(password, user.getPassword())) {
            HttpSession session = req.getSession(true);
            session.setAttribute("currentUser", user);
            session.setAttribute("userName", user.getName());
            session.setAttribute("userRole", user.getRole().name());
            redirectByRole(user, req, res);
        } else {
            res.sendRedirect(req.getContextPath() + "/login?error=1");
        }
    }

    private void redirectByRole(User user, HttpServletRequest req, HttpServletResponse res)
            throws IOException {
        String ctx = req.getContextPath();
        if (user.getRole() == Role.USER) {
            res.sendRedirect(ctx + "/my-books");
        } else {
            res.sendRedirect(ctx + "/dashboard");
        }
    }
}
