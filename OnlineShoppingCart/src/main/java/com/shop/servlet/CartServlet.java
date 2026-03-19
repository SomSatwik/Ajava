package com.shop.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.shop.dao.CartDao;
import com.shop.dao.ProductDao;
import com.shop.entity.CartItem;
import com.shop.entity.Product;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDao cartDao;
    private ProductDao productDao;
    private ObjectMapper mapper;
    
    @Override
    public void init() {
        cartDao = new CartDao();
        productDao = new ProductDao();
        mapper = new ObjectMapper();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUser(req);
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        
        List<CartItem> cartItems = cartDao.getCartByUser(user.getId());
        BigDecimal total = cartDao.getCartTotal(user.getId());
        
        req.setAttribute("cartItems", cartItems);
        req.setAttribute("cartTotal", total);
        req.getRequestDispatcher("cart.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();
        ObjectNode jsonResponse = mapper.createObjectNode();
        
        User user = getUser(req);
        if (user == null) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", "Not logged in");
            out.print(jsonResponse.toString());
            return;
        }
        
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                int quantity = req.getParameter("quantity") != null ? Integer.parseInt(req.getParameter("quantity")) : 1;
                
                Product p = productDao.getProductById(productId);
                if(p == null || p.getStock() < quantity) {
                    jsonResponse.put("success", false);
                    jsonResponse.put("error", "Out of stock");
                } else {
                    CartItem existing = cartDao.getCartItemByProduct(user.getId(), productId);
                    if (existing != null) {
                        cartDao.updateQuantity(existing.getId(), existing.getQuantity() + quantity);
                    } else {
                        CartItem newItem = new CartItem();
                        newItem.setUser(user);
                        newItem.setProduct(p);
                        newItem.setQuantity(quantity);
                        cartDao.addToCart(newItem);
                    }
                    jsonResponse.put("success", true);
                }
            } else if ("update".equals(action)) {
                int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));
                if (quantity <= 0) {
                    cartDao.removeFromCart(cartItemId);
                } else {
                    cartDao.updateQuantity(cartItemId, quantity);
                }
                jsonResponse.put("success", true);
            } else if ("remove".equals(action)) {
                int cartItemId = Integer.parseInt(req.getParameter("cartItemId"));
                cartDao.removeFromCart(cartItemId);
                jsonResponse.put("success", true);
            }
            
            // update session counts
            HttpSession session = req.getSession();
            int count = cartDao.getCartCount(user.getId());
            BigDecimal total = cartDao.getCartTotal(user.getId());
            session.setAttribute("cartCount", count);
            jsonResponse.put("cartCount", count);
            jsonResponse.put("cartTotal", total);
            
        } catch (Exception e) {
            jsonResponse.put("success", false);
            jsonResponse.put("error", e.getMessage());
        }
        
        out.print(jsonResponse.toString());
    }
    
    private User getUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            return (User) session.getAttribute("user");
        }
        return null;
    }
}
