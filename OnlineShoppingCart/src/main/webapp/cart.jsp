<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .cart-container { display: flex; gap: 40px; align-items: flex-start; }
        .cart-items { flex: 2; }
        .cart-summary { flex: 1; position: sticky; top: 100px; }
        
        .cart-item {
            display: flex; gap: 20px; padding: 20px; border-bottom: 1px solid var(--border);
            background: var(--surface); border-radius: var(--radius); margin-bottom: 20px; align-items: center;
        }
        .ci-img { width: 100px; height: 100px; border-radius: 12px; object-fit: cover; }
        .ci-info { flex: 1; }
        .ci-title { font-size: 1.1rem; font-weight: 600; color: white; display: block; margin-bottom: 5px; }
        .ci-price { color: var(--gold); font-weight: 700; }
        
        .qty-controls { display: flex; align-items: center; gap: 15px; margin-top: 15px; }
        .qty-btn { background: var(--surface2); width: 30px; height: 30px; display: flex; justify-content: center; align-items: center; border-radius: 5px; color: white; border: 1px solid var(--border); transition: 0.3s; cursor: none; }
        .qty-btn:hover { background: var(--gold); color: black; border-color: var(--gold); }
        .qty-val { font-weight: 600; width: 30px; text-align: center; }
        
        .btn-remove { color: var(--red); background: transparent; border: none; font-size: 0.9rem; text-decoration: underline; margin-left: auto; cursor: none; }
        
        .summary-row { display: flex; justify-content: space-between; margin-bottom: 15px; color: var(--text2); font-size: 1rem; }
        .summary-total { display: flex; justify-content: space-between; margin-top: 20px; padding-top: 20px; border-top: 1px solid var(--border); font-size: 1.5rem; font-weight: 700; color: white; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pt-100" style="padding-bottom: 100px;">
        <h1 class="heading-syne" style="font-size: 3rem; margin-bottom: 40px;">YOUR <span style="color:var(--gold);">CART</span></h1>
        
        <c:choose>
            <c:when test="${empty cartItems}">
                <div class="glass-panel text-center" style="padding: 100px 20px;">
                    <div style="font-size: 4rem; margin-bottom: 20px;">🛍️</div>
                    <h2 class="heading-syne mb-40">YOUR CART IS EMPTY</h2>
                    <a href="${pageContext.request.contextPath}/products" class="btn-gold interactive">Discover Products</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="cart-container">
                    <div class="cart-items">
                        <c:forEach var="item" items="${cartItems}">
                            <div class="cart-item" id="item-${item.id}">
                                <img src="${item.product.imageUrl}" class="ci-img" alt="${item.product.name}">
                                <div class="ci-info">
                                    <a href="${pageContext.request.contextPath}/product?id=${item.product.id}" class="ci-title interactive">${item.product.name}</a>
                                    <div class="ci-price">₹<fmt:formatNumber value="${item.product.price}" pattern="#,##0.00"/></div>
                                    <div class="qty-controls">
                                        <button class="qty-btn interactive" onclick="updateQty(${item.id}, ${item.quantity - 1})">-</button>
                                        <span class="qty-val">${item.quantity}</span>
                                        <button class="qty-btn interactive" onclick="updateQty(${item.id}, ${item.quantity + 1})">+</button>
                                    </div>
                                </div>
                                <button class="btn-remove interactive" onclick="updateQty(${item.id}, 0)">Remove</button>
                            </div>
                        </c:forEach>
                    </div>
                    
                    <div class="glass-panel cart-summary">
                        <h3 class="heading-syne" style="margin-bottom: 30px; font-size: 1.5rem;">ORDER SUMMARY</h3>
                        <div class="summary-row">
                            <span>Subtotal</span>
                            <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                        </div>
                        <div class="summary-row">
                            <span>Shipping</span>
                            <span>Calculated at checkout</span>
                        </div>
                        <div class="summary-total">
                            <span>Total</span>
                            <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                        </div>
                        <a href="${pageContext.request.contextPath}/checkout" class="btn-gold interactive" style="width:100%; display:block; text-align:center; padding:15px; margin-top:30px; font-size:1.1rem;">
                            Proceed to Checkout
                        </a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    
    <script>
        async function updateQty(cartItemId, newQty) {
            try {
                const res = await fetch('cart', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: `action=update&cartItemId=\${cartItemId}&quantity=\${newQty}`
                });
                const data = await res.json();
                if(data.success) {
                    location.reload();
                } else {
                    alert(data.error);
                }
            } catch(e) { console.error(e); }
        }
    </script>
</body>
</html>
