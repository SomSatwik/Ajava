<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Orders - Admin LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .admin-layout { display: flex; min-height: 100vh; padding-top: 80px; }
        .admin-sidebar {
            width: 250px; background: var(--surface); border-right: 1px solid var(--border);
            padding: 30px; position: fixed; height: calc(100vh - 80px);
        }
        .admin-nav { display: flex; flex-direction: column; gap: 10px; }
        .admin-nav a { padding: 12px 20px; border-radius: 8px; color: var(--text2); transition: 0.3s; display: flex; align-items: center; gap: 10px; }
        .admin-nav a:hover, .admin-nav a.active { background: rgba(212,168,83,0.1); color: var(--gold); }
        .admin-main { flex: 1; margin-left: 250px; padding: 40px; }
        
        table.admin-table { width: 100%; border-collapse: collapse; }
        .admin-table th { text-align: left; padding: 15px; border-bottom: 1px solid var(--border); color: var(--text2); font-weight: 400; font-size: 0.9rem; }
        .admin-table td { padding: 15px; border-bottom: 1px solid var(--border); color: white; vertical-align: middle; }
        
        .status-badge { padding: 6px 12px; border-radius: 20px; font-weight: 700; font-size: 0.7rem; letter-spacing: 0.1em; display: inline-block; }
        .status-PENDING { background: rgba(245,158,11,0.1); color: var(--amber); border: 1px solid var(--amber); }
        .status-CONFIRMED { background: rgba(6,182,212,0.1); color: var(--cyan); border: 1px solid var(--cyan); }
        .status-SHIPPED { background: rgba(124,58,237,0.1); color: var(--violet-light); border: 1px solid var(--violet); }
        .status-DELIVERED { background: rgba(16,185,129,0.1); color: var(--green); border: 1px solid var(--green); }
        .status-CANCELLED { background: rgba(244,63,94,0.1); color: var(--red); border: 1px solid var(--red); }
        
        .filter-tabs { display: flex; gap: 15px; margin-bottom: 30px; }
        .filter-tab { padding: 10px 20px; border-radius: 30px; border: 1px solid var(--border); color: var(--text2); text-decoration: none; transition: 0.3s; font-size: 0.9rem; }
        .filter-tab:hover, .filter-tab.active { background: var(--surface2); color: white; border-color: var(--gold); }
    </style>
</head>
<body>
    <jsp:include page="../includes/navbar.jsp" />

    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3 class="heading-syne" style="margin-bottom: 30px; font-size: 1.2rem;">ADMIN PANEL</h3>
            <div class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="interactive">📊 Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="interactive">🛍️ Products</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="interactive active">📦 Orders</a>
            </div>
        </div>
        
        <div class="admin-main">
            <h1 class="heading-syne" style="font-size: 2.5rem; margin-bottom: 30px;">ORDER MANAGEMENT</h1>
            
            <c:if test="${not empty message}">
                <div style="background: rgba(16,185,129,0.1); border: 1px solid var(--green); color: white; padding: 15px; border-radius: var(--radius); margin-bottom: 20px;">
                    ${message}
                </div>
            </c:if>

            <div class="filter-tabs">
                <a href="?status=ALL" class="filter-tab interactive ${empty param.status || param.status == 'ALL' ? 'active' : ''}">All Orders</a>
                <a href="?status=PENDING" class="filter-tab interactive ${param.status == 'PENDING' ? 'active' : ''}">Pending</a>
                <a href="?status=CONFIRMED" class="filter-tab interactive ${param.status == 'CONFIRMED' ? 'active' : ''}">Confirmed</a>
                <a href="?status=SHIPPED" class="filter-tab interactive ${param.status == 'SHIPPED' ? 'active' : ''}">Shipped</a>
                <a href="?status=DELIVERED" class="filter-tab interactive ${param.status == 'DELIVERED' ? 'active' : ''}">Delivered</a>
            </div>

            <div class="glass-panel" style="padding: 0; overflow: hidden;">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Date</th>
                            <th>Customer</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Update Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="o" items="${orders}">
                            <tr>
                                <td><strong style="color:var(--gold);">#${o.id}</strong></td>
                                <td><fmt:formatDate value="${o.orderDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
                                    <div>${o.user.name}</div>
                                    <div style="font-size: 0.8rem; color: var(--text2);">${o.user.email}</div>
                                </td>
                                <td style="font-weight: 700;">₹<fmt:formatNumber value="${o.totalAmount}" pattern="#,##0.00"/></td>
                                <td>
                                    <span class="status-badge status-${o.status}">${o.status}</span>
                                </td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/orders" method="post" style="display: flex; gap: 10px; align-items: center;">
                                        <input type="hidden" name="action" value="updateStatus">
                                        <input type="hidden" name="orderId" value="${o.id}">
                                        <select name="status" class="interactive" style="background: var(--surface); border: 1px solid var(--border); color: white; padding: 6px 12px; border-radius: 4px; outline: none;">
                                            <option value="PENDING" ${o.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                            <option value="CONFIRMED" ${o.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                            <option value="SHIPPED" ${o.status == 'SHIPPED' ? 'selected' : ''}>Shipped</option>
                                            <option value="DELIVERED" ${o.status == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                            <option value="CANCELLED" ${o.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                        </select>
                                        <button type="submit" class="btn-ghost interactive" style="padding: 6px 12px; font-size: 0.8rem;">Update</button>
                                    </form>
                                    <div style="margin-top: 10px; font-size: 0.8rem;">
                                        <a href="#" class="interactive" style="color: var(--text2); text-decoration: underline;" onclick="alert('Address: ${o.shippingAddress}\nPayment: ${o.paymentMethod}')">View Details</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <c:if test="${empty orders}">
                    <div style="padding: 40px; text-align: center; color: var(--text2);">No orders found.</div>
                </c:if>
            </div>
        </div>
    </div>
</body>
</html>
