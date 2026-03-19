package com.shop.servlet;

import com.shop.dao.CategoryDao;
import com.shop.dao.ProductDao;
import com.shop.entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {
    private ProductDao productDao;
    private CategoryDao categoryDao;
    
    @Override
    public void init() {
        productDao = new ProductDao();
        categoryDao = new CategoryDao();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryIdStr = req.getParameter("category");
        String search = req.getParameter("search");
        String sort = req.getParameter("sort");
        String pageStr = req.getParameter("page");
        
        List<Product> products;
        
        if (search != null && !search.trim().isEmpty()) {
            products = productDao.searchProducts(search);
        } else if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            products = productDao.getProductsByCategory(Integer.parseInt(categoryIdStr));
        } else if (sort != null && !sort.trim().isEmpty()) {
            products = productDao.getProductsSorted(sort);
        } else {
            products = productDao.getAllProducts();
        }
        
        // Simple pagination (9 per page)
        int page = (pageStr != null && !pageStr.isEmpty()) ? Integer.parseInt(pageStr) : 1;
        int pageSize = 9;
        int totalProducts = products.size();
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
        if (totalPages == 0) totalPages = 1;
        
        int fromIndex = (page - 1) * pageSize;
        int toIndex = Math.min(fromIndex + pageSize, totalProducts);
        
        if (fromIndex <= totalProducts && fromIndex >= 0) {
            req.setAttribute("products", products.subList(fromIndex, toIndex));
        } else {
            req.setAttribute("products", java.util.Collections.emptyList());
        }
        
        req.setAttribute("categories", categoryDao.getAllCategories());
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);
        req.setAttribute("search", search);
        req.setAttribute("sort", sort);
        req.setAttribute("categoryId", categoryIdStr);
        
        req.getRequestDispatcher("products.jsp").forward(req, resp);
    }
}
