package com.bibliox.servlet;

import com.bibliox.dao.IssuedBookDAO;
import com.bibliox.model.IssuedBook;
import com.bibliox.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/my-books")
public class MyBooksServlet extends HttpServlet {

    private final IssuedBookDAO issuedBookDAO = new IssuedBookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        IssuedBook activeBook = issuedBookDAO.findActiveByUser(currentUser.getId());
        List<IssuedBook> history = issuedBookDAO.findByUser(currentUser.getId());

        req.setAttribute("activeBook", activeBook);
        req.setAttribute("history", history);
        req.getRequestDispatcher("/pages/my-books.jsp").forward(req, res);
    }
}
