package com.bibliox.servlet;

import com.bibliox.dao.BookDAO;
import com.bibliox.dao.IssuedBookDAO;
import com.bibliox.dao.UserDAO;
import com.bibliox.model.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/issue")
public class IssueServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final BookDAO bookDAO = new BookDAO();
    private final IssuedBookDAO issuedBookDAO = new IssuedBookDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser.getRole() == Role.USER) {
            res.sendRedirect(req.getContextPath() + "/my-books");
            return;
        }

        List<User> members = userDAO.findAll();
        List<Book> books = bookDAO.findAll();
        List<IssuedBook> issuedBooks = issuedBookDAO.findAll();

        req.setAttribute("members", members);
        req.setAttribute("books", books);
        req.setAttribute("issuedBooks", issuedBooks);
        req.getRequestDispatcher("/pages/issue.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        if (currentUser.getRole() == Role.USER) {
            res.sendRedirect(req.getContextPath() + "/my-books");
            return;
        }

        String action = req.getParameter("action");

        if ("issue".equals(action)) {
            Long userId = Long.parseLong(req.getParameter("userId"));
            Long bookId = Long.parseLong(req.getParameter("bookId"));

            // Check if user already has a book
            IssuedBook existing = issuedBookDAO.findActiveByUser(userId);
            if (existing != null) {
                res.sendRedirect(req.getContextPath() + "/issue?error=alreadyissued");
                return;
            }

            Book book = bookDAO.findById(bookId);
            if (book == null || book.getAvailableCopies() <= 0) {
                res.sendRedirect(req.getContextPath() + "/issue?error=unavailable");
                return;
            }

            User user = userDAO.findById(userId);
            IssuedBook issuedBook = new IssuedBook();
            issuedBook.setUser(user);
            issuedBook.setBook(book);
            issuedBookDAO.save(issuedBook);

            book.setAvailableCopies(book.getAvailableCopies() - 1);
            bookDAO.update(book);

        } else if ("return".equals(action)) {
            Long issuedBookId = Long.parseLong(req.getParameter("issuedBookId"));
            IssuedBook issuedBook = issuedBookDAO.findById(issuedBookId);
            if (issuedBook != null) {
                issuedBook.setReturnDate(LocalDateTime.now());
                issuedBook.setStatus(IssueStatus.RETURNED);
                issuedBookDAO.update(issuedBook);

                Book book = issuedBook.getBook();
                book.setAvailableCopies(book.getAvailableCopies() + 1);
                bookDAO.update(book);
            }
        }

        res.sendRedirect(req.getContextPath() + "/issue");
    }
}
