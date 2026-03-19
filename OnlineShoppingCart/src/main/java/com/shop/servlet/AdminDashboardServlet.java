package com.shop.servlet;

import com.shop.dao.OrderDao;
import com.shop.dao.ProductDao;
import com.shop.dao.UserDao;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private OrderDao orderDao;
    private ProductDao productDao;
    private UserDao userDao;
    
    @Override
    public void init() {
        orderDao = new OrderDao();
        productDao = new ProductDao();
        userDao = new UserDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        
        Map<String, Object> stats = orderDao.getOrderStats();
        
        req.setAttribute("stats", stats);
        req.setAttribute("productCount", productDao.getAllProducts().size());
        req.setAttribute("userCount", userDao.getAllUsers().size());
        req.setAttribute("lowStockProducts", productDao.getLowStockProducts());
        
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
    
    private boolean isAdmin(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            return "ADMIN".equals(user.getRole());
        }
        return false;
    }
}
