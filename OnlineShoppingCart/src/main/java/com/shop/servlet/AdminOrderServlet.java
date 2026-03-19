package com.shop.servlet;

import com.shop.dao.OrderDao;
import com.shop.entity.Order;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orders")
public class AdminOrderServlet extends HttpServlet {
    private OrderDao orderDao;
    
    @Override
    public void init() {
        orderDao = new OrderDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        
        List<Order> orders = orderDao.getAllOrders();
        
        String statusFilter = req.getParameter("status");
        if(statusFilter != null && !statusFilter.isEmpty()) {
            orders = orders.stream()
                .filter(o -> o.getStatus().equals(statusFilter))
                .collect(java.util.stream.Collectors.toList());
        }
        
        req.setAttribute("orders", orders);
        req.setAttribute("statusFilter", statusFilter);
        req.getRequestDispatcher("/admin/orders.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        
        String action = req.getParameter("action");
        if ("updateStatus".equals(action)) {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String status = req.getParameter("status");
            orderDao.updateOrderStatus(orderId, status);
        }
        
        resp.sendRedirect(req.getContextPath() + "/admin/orders?success=true");
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
