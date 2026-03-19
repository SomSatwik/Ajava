package com.shop.servlet;

import com.shop.dao.CategoryDao;
import com.shop.dao.ProductDao;
import com.shop.entity.Category;
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

@WebServlet("/admin/products")
public class AdminProductServlet extends HttpServlet {
    private ProductDao productDao;
    private CategoryDao categoryDao;
    
    @Override
    public void init() {
        productDao = new ProductDao();
        categoryDao = new CategoryDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        
        req.setAttribute("products", productDao.getAllProducts());
        req.setAttribute("categories", categoryDao.getAllCategories());
        req.getRequestDispatcher("/admin/products.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        if (!isAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }
        
        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                Product p = new Product();
                populateProductFromRequest(p, req);
                productDao.addProduct(p);
            } else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                Product p = productDao.getProductById(id);
                if (p != null) {
                    populateProductFromRequest(p, req);
                    productDao.updateProduct(p);
                }
            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                productDao.deleteProduct(id);
            }
            resp.sendRedirect(req.getContextPath() + "/admin/products?success=true");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/admin/products?error=true");
        }
    }
    
    private void populateProductFromRequest(Product p, HttpServletRequest req) {
        p.setName(req.getParameter("name"));
        p.setDescription(req.getParameter("description"));
        p.setPrice(new BigDecimal(req.getParameter("price")));
        
        String originalPrice = req.getParameter("originalPrice");
        if (originalPrice != null && !originalPrice.isEmpty()) {
            p.setOriginalPrice(new BigDecimal(originalPrice));
        } else {
            p.setOriginalPrice(null);
        }
        
        p.setStock(Integer.parseInt(req.getParameter("stock")));
        p.setImageUrl(req.getParameter("imageUrl"));
        
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Category category = categoryDao.getCategoryById(categoryId);
        p.setCategory(category);
        
        p.setBadge(req.getParameter("badge"));
        p.setFeatured(req.getParameter("featured") != null);
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
