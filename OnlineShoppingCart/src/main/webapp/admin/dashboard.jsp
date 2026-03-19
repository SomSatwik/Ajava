<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .admin-layout { display: flex; min-height: 100vh; padding-top: 80px; }
        .admin-sidebar {
            width: 250px; background: var(--surface); border-right: 1px solid var(--border);
            padding: 30px; position: fixed; height: calc(100vh - 80px);
        }
        .admin-nav { display: flex; flex-direction: column; gap: 10px; }
        .admin-nav a {
            padding: 12px 20px; border-radius: 8px; color: var(--text2);
            transition: 0.3s; display: flex; align-items: center; gap: 10px;
        }
        .admin-nav a:hover, .admin-nav a.active {
            background: rgba(212,168,83,0.1); color: var(--gold);
        }
        .admin-main { flex: 1; margin-left: 250px; padding: 40px; }
        
        .stat-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 40px; }
        .stat-card {
            background: var(--surface2); padding: 25px; border-radius: var(--radius);
            border: 1px solid var(--border);
        }
        .stat-label { color: var(--text2); font-size: 0.9rem; letter-spacing: 0.05em; margin-bottom: 10px; text-transform: uppercase; }
        .stat-value { font-size: 2.5rem; font-weight: 700; color: white; display: flex; align-items: center; gap: 10px; }
        
        table.admin-table { width: 100%; border-collapse: collapse; }
        .admin-table th { text-align: left; padding: 15px; border-bottom: 1px solid var(--border); color: var(--text2); font-weight: 400; font-size: 0.9rem; }
        .admin-table td { padding: 15px; border-bottom: 1px solid var(--border); color: white; }
    </style>
</head>
<body>
    <jsp:include page="../includes/navbar.jsp" />

    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3 class="heading-syne" style="margin-bottom: 30px; font-size: 1.2rem;">ADMIN PANEL</h3>
            <div class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="interactive active">📊 Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="interactive">🛍️ Products</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="interactive">📦 Orders</a>
            </div>
        </div>
        
        <div class="admin-main">
            <h1 class="heading-syne" style="font-size: 2.5rem; margin-bottom: 30px;">OVERVIEW</h1>
            
            <div class="stat-grid">
                <div class="stat-card">
                    <div class="stat-label">Total Revenue</div>
                    <div class="stat-value" style="color: var(--gold);">$<fmt:formatNumber value="${totalRevenue}" pattern="#,##0.00"/></div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Total Orders</div>
                    <div class="stat-value">${totalOrders}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Total Users</div>
                    <div class="stat-value">${totalUsers}</div>
                </div>
                <div class="stat-card">
                    <div class="stat-label">Products</div>
                    <div class="stat-value">${totalProducts}</div>
                </div>
            </div>
            
            <h2 class="heading-syne" style="margin-bottom: 20px; margin-top: 50px; font-size: 1.5rem; color: var(--amber);">⚠️ LOW STOCK ALERTS</h2>
            <div class="glass-panel">
                <c:choose>
                    <c:when test="${empty lowStockProducts}">
                        <div style="color: var(--text2); padding: 20px;">All products are well stocked.</div>
                    </c:when>
                    <c:otherwise>
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Product</th>
                                    <th>Current Stock</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${lowStockProducts}">
                                    <tr>
                                        <td>#${p.id}</td>
                                        <td>
                                            <div style="display: flex; align-items: center; gap: 15px;">
                                                <img src="${p.imageUrl}" style="width:40px; height:40px; border-radius:6px; object-fit:cover;">
                                                <span>${p.name}</span>
                                            </div>
                                        </td>
                                        <td style="color: var(--red); font-weight: 700;">${p.stock}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${p.id}" class="btn-ghost interactive" style="padding: 6px 12px; font-size: 0.8rem;">Update Stock</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</body>
</html>
