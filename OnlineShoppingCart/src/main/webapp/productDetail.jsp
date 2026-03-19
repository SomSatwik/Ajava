<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${product.name} - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .pd-section { padding-top: 100px; padding-bottom: 50px; display: flex; gap: 50px; }
        .pd-img-box { flex: 1; border-radius: 24px; overflow: hidden; border: 1px solid var(--border); background: var(--surface); blend-mode: screen; }
        .pd-img-box img { width: 100%; height: auto; display: block; }
        .pd-info { flex: 1; }
        .pd-cat { color: var(--gold); letter-spacing: 0.1em; font-weight: 600; font-size: 0.9rem; text-transform: uppercase; margin-bottom: 10px; }
        .pd-title { font-size: 3rem; line-height: 1.1; margin-bottom: 20px; }
        .pd-price { font-size: 2rem; font-weight: 700; color: white; display: flex; align-items: center; gap: 15px; margin-bottom: 30px; }
        .pd-old-price { font-size: 1.2rem; color: var(--text3); text-decoration: line-through; }
        .pd-desc { color: var(--text2); line-height: 1.8; margin-bottom: 40px; font-size: 1.1rem; }
        
        .qty-box { display: flex; align-items: center; gap: 20px; margin-bottom: 30px; }
        .qty-input { background: var(--surface2); border: 1px solid var(--border); color: white; padding: 12px 20px; border-radius: 30px; width: 100px; text-align: center; outline: none; }
        .btn-large { padding: 16px 40px; font-size: 1.1rem; border-radius: 40px; display: flex; align-items: center; justify-content: center; gap: 10px; cursor: none; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pd-section">
        <div class="pd-img-box">
            <img src="${product.imageUrl}" alt="${product.name}">
        </div>
        <div class="pd-info">
            <div class="pd-cat">${product.category.name}</div>
            <h1 class="heading-syne pd-title">${product.name}</h1>
            
            <div style="color:var(--gold); font-size:1.2rem; margin-bottom:20px;">
                ★★★★★ <span style="color:var(--text3); font-size:1rem;">(${product.reviewCount} Reviews)</span>
            </div>
            
            <div class="pd-price">
                ₹<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                <c:if test="${product.originalPrice != null}">
                    <span class="pd-old-price">₹<fmt:formatNumber value="${product.originalPrice}" pattern="#,##0.00"/></span>
                </c:if>
            </div>
            
            <p class="pd-desc">${product.description}</p>
            
            <c:if test="${product.stock < 10 && product.stock > 0}">
                <div style="color: var(--amber); margin-bottom: 20px; font-weight: 600;">⚠️ Hurry, only ${product.stock} left in stock!</div>
            </c:if>
            
            <c:choose>
                <c:when test="${product.stock > 0}">
                    <div class="qty-box">
                        <input type="number" id="qty" class="qty-input interactive" value="1" min="1" max="${product.stock}">
                        <button class="btn-gold btn-large interactive" onclick="addToCart(${product.id}, document.getElementById('qty').value)" style="flex:1;">
                            🛍️ Add to Cart
                        </button>
                        <a href="#" class="btn-ghost btn-large btn-wishlist interactive ${inWishlist ? 'active' : ''}" data-id="${product.id}" style="padding: 16px; width: 60px;">
                            ${inWishlist ? '❤️' : '🤍'}
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="qty-box">
                        <button class="btn-ghost btn-large interactive" style="flex:1; opacity: 0.5;" disabled>Out of Stock</button>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <div style="margin-top: 50px; padding-top: 30px; border-top: 1px solid var(--border);">
                <div style="display: flex; gap: 30px; color: var(--text2); font-size: 0.9rem;">
                    <div>🚚 Free Global Shipping</div>
                    <div>🛡️ Authenticity Guaranteed</div>
                    <div>↩️ 30-Day Returns</div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
