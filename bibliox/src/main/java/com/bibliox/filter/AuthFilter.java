package com.bibliox.filter;

import com.bibliox.model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    private static final String[] PUBLIC_PATHS = {"/login", "/css/", "/js/", "/images/", "/index.jsp"};

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;

        String path = request.getServletPath();
        
        // Handle empty path / root context
        if (path == null || path.equals("/") || path.isEmpty()) {
            path = "/index.jsp";
        }

        // Allow public paths
        for (String p : PUBLIC_PATHS) {
            if (path.startsWith(p)) {
                chain.doFilter(req, res);
                return;
            }
        }

        // Check session
        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        chain.doFilter(req, res);
    }
}
