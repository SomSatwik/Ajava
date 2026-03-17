package com.bibliox.servlet;

import com.bibliox.dao.BookDAO;
import com.bibliox.dao.IssuedBookDAO;
import com.bibliox.dao.UserDAO;
import com.bibliox.model.IssuedBook;
import com.bibliox.model.User;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();
    private final UserDAO userDAO = new UserDAO();
    private final IssuedBookDAO issuedBookDAO = new IssuedBookDAO();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        issuedBookDAO.updateOverdueStatuses();

        Map<String, Object> stats = new HashMap<>();
        stats.put("totalBooks", bookDAO.countAll());
        stats.put("issuedBooks", issuedBookDAO.countIssued());
        stats.put("totalMembers", userDAO.countAll());
        stats.put("overdueBooks", issuedBookDAO.countOverdue());

        List<IssuedBook> recentActivity = issuedBookDAO.findAll();
        if (recentActivity.size() > 5) recentActivity = recentActivity.subList(0, 5);

        req.setAttribute("stats", gson.toJson(stats));
        req.setAttribute("recentActivity", recentActivity);
        req.setAttribute("currentUser", (User) req.getSession().getAttribute("currentUser"));

        req.getRequestDispatcher("/pages/dashboard.jsp").forward(req, res);
    }
}
