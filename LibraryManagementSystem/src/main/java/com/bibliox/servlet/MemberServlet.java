package com.bibliox.servlet;

import com.bibliox.dao.UserDAO;
import com.bibliox.model.Role;
import com.bibliox.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/members")
public class MemberServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser.getRole() == Role.USER) {
            res.sendRedirect(req.getContextPath() + "/my-books");
            return;
        }

        List<User> members = userDAO.findAll();
        req.setAttribute("members", members);
        req.getRequestDispatcher("/pages/members.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser.getRole() != Role.SUPER_ADMIN) {
            res.sendRedirect(req.getContextPath() + "/members");
            return;
        }

        Long userId = Long.parseLong(req.getParameter("userId"));
        Role newRole = Role.valueOf(req.getParameter("role"));
        User user = userDAO.findById(userId);
        if (user != null) {
            user.setRole(newRole);
            userDAO.update(user);
        }
        res.sendRedirect(req.getContextPath() + "/members");
    }
}
