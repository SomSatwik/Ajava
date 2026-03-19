<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<nav class="navbar">
    <a href="${pageContext.request.contextPath}/home" class="nav-logo">
        <span class="lux">LUX</span><span class="cart">CART</span>
    </a>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <a href="${pageContext.request.contextPath}/products">Products</a>
        <a href="${pageContext.request.contextPath}/products?sort=newest">Deals</a>
    </div>
    <div class="nav-actions">
        <a href="${pageContext.request.contextPath}/wishlist" class="nav-icon" title="Wishlist">
            ❤️
        </a>
        <a href="${pageContext.request.contextPath}/cart" class="nav-icon interactive" title="Cart">
            🛍️
            <div class="nav-badge cart-badge">${sessionScope.cartCount != null ? sessionScope.cartCount : 0}</div>
        </a>
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div style="position: relative;" class="user-menu">
                    <a href="${pageContext.request.contextPath}/orders" class="nav-icon interactive" title="My Orders">
                        👤
                    </a>
                </div>
                <c:if test="${sessionScope.user.role == 'ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-icon interactive" title="Admin">⚙️</a>
                </c:if>
                <a href="${pageContext.request.contextPath}/logout" class="nav-icon interactive" title="Logout">🚪</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="nav-icon interactive" title="Login">🔐</a>
            </c:otherwise>
        </c:choose>
    </div>
</nav>

<!-- Background Orbs and Dots shared everywhere -->
<div class="bg-dots"></div>
<div class="ambient-orb orb-1"></div>
<div class="ambient-orb orb-2"></div>
<div class="ambient-orb orb-3"></div>
