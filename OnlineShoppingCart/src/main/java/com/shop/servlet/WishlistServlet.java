package com.shop.servlet;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.shop.dao.WishlistDao;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {
    private WishlistDao wishlistDao;
    private ObjectMapper mapper;
    
    @Override
    public void init() {
        wishlistDao = new WishlistDao();
        mapper = new ObjectMapper();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = getUser(req);
        if (user == null) {
            resp.sendRedirect("login");
            return;
        }
        req.setAttribute("wishlists", wishlistDao.getWishlistByUser(user.getId()));
        req.getRequestDispatcher("wishlist.jsp").forward(req, resp);
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
            if ("toggle".equals(action)) {
                int productId = Integer.parseInt(req.getParameter("productId"));
                boolean inWishlist = wishlistDao.isInWishlist(user.getId(), productId);
                
                if (inWishlist) {
                    wishlistDao.removeFromWishlist(user.getId(), productId);
                    jsonResponse.put("inWishlist", false);
                } else {
                    wishlistDao.addToWishlist(user.getId(), productId);
                    jsonResponse.put("inWishlist", true);
                }
                jsonResponse.put("success", true);
            }
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
