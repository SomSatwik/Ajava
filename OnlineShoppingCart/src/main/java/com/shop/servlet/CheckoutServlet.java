package com.shop.servlet;

import com.shop.dao.CartDao;
import com.shop.dao.OrderDao;
import com.shop.dao.ProductDao;
import com.shop.entity.CartItem;
import com.shop.entity.Order;
import com.shop.entity.OrderItem;
import com.shop.entity.Product;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartDao cartDao;
    private OrderDao orderDao;
    private ProductDao productDao;
    
    @Override
    public void init() {
        cartDao = new CartDao();
        orderDao = new OrderDao();
        productDao = new ProductDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUser(req);
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        
        List<CartItem> cartItems = cartDao.getCartByUser(user.getId());
        if (cartItems.isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }
        
        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartTotal", cartDao.getCartTotal(user.getId()));
        req.getRequestDispatcher("checkout.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUser(req);
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        
        String address = req.getParameter("shippingAddress");
        String payment = req.getParameter("paymentMethod");
        
        List<CartItem> cartItems = cartDao.getCartByUser(user.getId());
        if (cartItems.isEmpty()) {
            resp.sendRedirect("cart");
            return;
        }
        
        BigDecimal total = cartDao.getCartTotal(user.getId());
        
        Order order = new Order();
        order.setUser(user);
        order.setTotalAmount(total);
        order.setShippingAddress(address);
        order.setPaymentMethod(payment);
        order.setStatus("CONFIRMED");
        
        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItem ci : cartItems) {
            OrderItem oi = new OrderItem();
            oi.setProduct(ci.getProduct());
            oi.setQuantity(ci.getQuantity());
            oi.setPriceAtTime(ci.getProduct().getPrice());
            orderItems.add(oi);
            
            // Reduce stock
            Product p = ci.getProduct();
            p.setStock(p.getStock() - ci.getQuantity());
            productDao.updateProduct(p);
        }
        
        if (orderDao.placeOrder(order, orderItems)) {
            cartDao.clearCart(user.getId());
            req.getSession().setAttribute("cartCount", 0);
            resp.sendRedirect("orders?success=true");
        } else {
            req.setAttribute("error", "Order placement failed.");
            doGet(req, resp);
        }
    }
    
    private User getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }
}
