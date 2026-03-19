package com.shop.servlet;

import com.shop.dao.ProductDao;
import com.shop.dao.WishlistDao;
import com.shop.entity.Product;
import com.shop.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {
    private ProductDao productDao;
    private WishlistDao wishlistDao;
    
    @Override
    public void init() {
        productDao = new ProductDao();
        wishlistDao = new WishlistDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            resp.sendRedirect("products");
            return;
        }
        
        int id = Integer.parseInt(idStr);
        Product product = productDao.getProductById(id);
        
        if (product == null) {
            resp.sendRedirect("products");
            return;
        }
        
        List<Product> relatedProducts = productDao.getProductsByCategory(product.getCategory().getId())
                .stream()
                .filter(p -> p.getId() != product.getId())
                .limit(4)
                .collect(Collectors.toList());
                
        boolean inWishlist = false;
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            User user = (User) session.getAttribute("user");
            inWishlist = wishlistDao.isInWishlist(user.getId(), product.getId());
        }
        
        req.setAttribute("product", product);
        req.setAttribute("relatedProducts", relatedProducts);
        req.setAttribute("inWishlist", inWishlist);
        
        req.getRequestDispatcher("productDetail.jsp").forward(req, resp);
    }
}
