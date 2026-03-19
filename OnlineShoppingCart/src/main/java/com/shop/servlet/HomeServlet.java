package com.shop.servlet;

import com.shop.dao.CartDao;
import com.shop.dao.CategoryDao;
import com.shop.dao.ProductDao;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private ProductDao productDao;
    private CategoryDao categoryDao;
    private CartDao cartDao;
    
    @Override
    public void init() {
        productDao = new ProductDao();
        categoryDao = new CategoryDao();
        cartDao = new CartDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("featuredProducts", productDao.getFeaturedProducts());
        req.setAttribute("categories", categoryDao.getAllCategories());
        req.setAttribute("newProducts", productDao.getAllProducts().stream().limit(8).collect(java.util.stream.Collectors.toList()));
        
        HttpSession session = req.getSession(false);
        if(session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            session.setAttribute("cartCount", cartDao.getCartCount(user.getId()));
        }
        
        req.getRequestDispatcher("home.jsp").forward(req, resp);
    }
}
