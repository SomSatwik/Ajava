<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .order-card {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: var(--radius-lg); margin-bottom: 30px; box-shadow: var(--shadow-card);
            overflow: hidden;
        }
        .order-header {
            background: var(--surface2); padding: 20px 30px; border-bottom: 1px solid var(--border);
            display: flex; justify-content: space-between; align-items: center;
        }
        .order-meta { display: flex; gap: 40px; color: var(--text2); font-size: 0.9rem; }
        .order-meta-val { color: white; font-weight: 600; font-size: 1.1rem; display: block; margin-top: 5px; }
        .status-badge {
            padding: 8px 16px; border-radius: 20px; font-weight: 700; font-size: 0.8rem; letter-spacing: 0.1em;
        }
        .status-PENDING { background: rgba(245,158,11,0.1); color: var(--amber); border: 1px solid var(--amber); }
        .status-CONFIRMED { background: rgba(6,182,212,0.1); color: var(--cyan); border: 1px solid var(--cyan); }
        .status-SHIPPED { background: rgba(124,58,237,0.1); color: var(--violet-light); border: 1px solid var(--violet); }
        .status-DELIVERED { background: rgba(16,185,129,0.1); color: var(--green); border: 1px solid var(--green); }
        .status-CANCELLED { background: rgba(244,63,94,0.1); color: var(--red); border: 1px solid var(--red); }
        
        .order-items { padding: 30px; }
        .oi-row { display: flex; align-items: center; gap: 20px; margin-bottom: 20px; }
        .oi-row:last-child { margin-bottom: 0; }
        .oi-img { width: 80px; height: 80px; object-fit: cover; border-radius: 12px; }
        .oi-info { flex: 1; }
        .oi-name { font-weight: 600; font-size: 1.1rem; margin-bottom: 5px; display: block; color: white; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pt-100" style="padding-bottom: 100px;">
        <h1 class="heading-syne" style="font-size: 3rem; margin-bottom: 10px;">ORDER <span style="color:var(--gold);">HISTORY</span></h1>
        
        <c:if test="${param.success == 'true'}">
            <div style="background: rgba(16,185,129,0.1); border: 1px solid var(--green); color: white; padding: 20px; border-radius: var(--radius); margin-top: 20px; margin-bottom: 40px; display: flex; align-items: center; gap: 15px;">
                <span style="font-size: 2rem;">🎉</span>
                <div>
                    <h3 style="margin-bottom: 5px;">Order Placed Successfully!</h3>
                    <p style="color: var(--text2); font-size: 0.9rem;">Thank you for your purchase. Your order is being processed.</p>
                </div>
            </div>
        </c:if>

        <div style="margin-top: 40px;">
            <c:choose>
                <c:when test="${empty orders}">
                    <div class="glass-panel text-center" style="padding: 100px 20px;">
                        <h2 class="heading-syne mb-40">NO ORDERS YET</h2>
                        <a href="${pageContext.request.contextPath}/products" class="btn-gold interactive">Start Shopping</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="o" items="${orders}">
                        <div class="order-card">
                            <div class="order-header">
                                <div class="order-meta">
                                    <div>
                                        ORDER PLACED
                                        <span class="order-meta-val"><fmt:formatDate value="${o.orderDate}" pattern="MMM dd, yyyy" /></span>
                                    </div>
                                    <div>
                                        TOTAL
                                        <span class="order-meta-val">₹<fmt:formatNumber value="${o.totalAmount}" pattern="#,##0.00"/></span>
                                    </div>
                                    <div>
                                        ORDER ID
                                        <span class="order-meta-val">#${o.id}</span>
                                    </div>
                                </div>
                                <div class="status-badge status-${o.status}">
                                    ${o.status}
                                </div>
                            </div>
                            <div class="order-items">
                                <c:forEach var="item" items="${o.orderItems}">
                                    <div class="oi-row">
                                        <img src="${item.product.imageUrl}" class="oi-img" alt="${item.product.name}">
                                        <div class="oi-info">
                                            <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" class="oi-name interactive">${item.product.name}</a>
                                            <div style="color: var(--text2); font-size: 0.9rem;">Qty: ${item.quantity}</div>
                                        </div>
                                        <div style="font-weight: 700; font-size: 1.1rem; color: var(--gold);">
                                            ₹<fmt:formatNumber value="${item.priceAtTime * item.quantity}" pattern="#,##0.00"/>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</body>
</html>
