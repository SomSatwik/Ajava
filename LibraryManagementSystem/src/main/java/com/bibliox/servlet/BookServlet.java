package com.bibliox.servlet;

import com.bibliox.dao.BookDAO;
import com.bibliox.model.Book;
import com.bibliox.model.Role;
import com.bibliox.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    private final BookDAO bookDAO = new BookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String query = req.getParameter("q");
        List<Book> books = (query != null && !query.isBlank())
                ? bookDAO.search(query)
                : bookDAO.findAll();

        req.setAttribute("books", books);
        req.setAttribute("searchQuery", query);
        req.getRequestDispatcher("/pages/books.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser.getRole() == Role.USER) {
            res.sendRedirect(req.getContextPath() + "/dashboard");
            return;
        }

        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Book book = new Book();
            book.setTitle(req.getParameter("title"));
            book.setAuthor(req.getParameter("author"));
            book.setIsbn(req.getParameter("isbn"));
            book.setGenre(req.getParameter("genre"));
            int copies = Integer.parseInt(req.getParameter("totalCopies"));
            book.setTotalCopies(copies);
            book.setAvailableCopies(copies);
            bookDAO.save(book);

        } else if ("delete".equals(action)) {
            if (currentUser.getRole() == Role.SUPER_ADMIN) {
                Long id = Long.parseLong(req.getParameter("bookId"));
                bookDAO.delete(id);
            }
        }

        res.sendRedirect(req.getContextPath() + "/books");
    }
}
