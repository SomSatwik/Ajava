<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .checkout-layout { display: flex; gap: 40px; align-items: flex-start; }
        .checkout-form { flex: 2; padding-right: 40px; border-right: 1px solid var(--border); }
        .checkout-summary { flex: 1; position: sticky; top: 100px; }
        .co-item { display: flex; align-items: center; gap: 15px; margin-bottom: 20px; }
        .co-img { width: 60px; height: 60px; border-radius: 8px; object-fit: cover; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pt-100" style="padding-bottom: 100px;">
        <h1 class="heading-syne" style="font-size: 2.5rem; margin-bottom: 40px;">SECURE <span style="color:var(--gold);">CHECKOUT</span></h1>
        
        <c:if test="${not empty error}">
            <div style="background: rgba(244,63,94,0.1); border: 1px solid var(--red); color: white; padding: 15px; border-radius: var(--radius); margin-bottom: 30px;">
                ${error}
            </div>
        </c:if>

        <div class="checkout-layout">
            <div class="checkout-form">
                <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                    <h3 class="heading-syne" style="margin-bottom: 20px; font-size: 1.5rem; color: var(--gold);">1. Contact Information</h3>
                    <div style="margin-bottom: 40px; color: var(--text2);">
                        Logged in as <b>${sessionScope.user.email}</b>
                    </div>
                    
                    <h3 class="heading-syne" style="margin-bottom: 20px; font-size: 1.5rem; color: var(--gold);">2. Shipping Address</h3>
                    <div class="form-group">
                        <textarea name="shippingAddress" class="form-input interactive" rows="4" required placeholder="Enter full delivery address...">${not empty sessionScope.user.address ? sessionScope.user.address : ''}</textarea>
                    </div>
                    
                    <h3 class="heading-syne" style="margin-bottom: 20px; margin-top: 40px; font-size: 1.5rem; color: var(--gold);">3. Payment Method</h3>
                    <div class="form-group" style="display: flex; gap: 20px;">
                        <label style="background: var(--surface2); padding: 15px 20px; border-radius: var(--radius); display: flex; align-items: center; gap: 10px; cursor: none; border: 1px solid var(--border);" class="interactive">
                            <input type="radio" name="paymentMethod" value="CREDIT_CARD" checked style="cursor: none;"> Credit Card
                        </label>
                        <label style="background: var(--surface2); padding: 15px 20px; border-radius: var(--radius); display: flex; align-items: center; gap: 10px; cursor: none; border: 1px solid var(--border);" class="interactive">
                            <input type="radio" name="paymentMethod" value="PAYPAL" style="cursor: none;"> PayPal
                        </label>
                        <label style="background: var(--surface2); padding: 15px 20px; border-radius: var(--radius); display: flex; align-items: center; gap: 10px; cursor: none; border: 1px solid var(--border);" class="interactive">
                            <input type="radio" name="paymentMethod" value="COD" style="cursor: none;"> Cash on Delivery
                        </label>
                    </div>
                    
                    <!-- Dummy CC Form -->
                    <div style="background: var(--surface2); padding: 25px; border-radius: var(--radius); margin-top: 20px; margin-bottom: 40px;">
                        <div class="form-group">
                            <label>Card Number</label>
                            <input type="text" class="form-input interactive" placeholder="0000 0000 0000 0000">
                        </div>
                        <div style="display: flex; gap: 20px;">
                            <div class="form-group" style="flex: 1;">
                                <label>Expiration</label>
                                <input type="text" class="form-input interactive" placeholder="MM/YY">
                            </div>
                            <div class="form-group" style="flex: 1;">
                                <label>CVC</label>
                                <input type="text" class="form-input interactive" placeholder="123">
                            </div>
                        </div>
                    </div>
                    
                    <button type="submit" class="btn-gold interactive" style="width: 100%; padding: 18px; font-size: 1.2rem;">Complete Order</button>
                    <p style="text-align: center; margin-top: 20px; color: var(--text3); font-size: 0.8rem;">🔒 Payments are secure and encrypted.</p>
                </form>
            </div>
            
            <div class="glass-panel checkout-summary">
                <h3 class="heading-syne" style="margin-bottom: 30px; font-size: 1.2rem;">IN YOUR BAG</h3>
                
                <div style="margin-bottom: 30px; max-height: 300px; overflow-y: auto;">
                    <c:forEach var="item" items="${cartItems}">
                        <div class="co-item">
                            <img src="${item.product.imageUrl}" class="co-img">
                            <div style="flex: 1;">
                                <div style="font-weight: 600; font-size: 0.9rem;">${item.product.name}</div>
                                <div style="color: var(--text2); font-size: 0.8rem;">Qty: ${item.quantity}</div>
                            </div>
                            <div style="font-weight: 700; color: var(--gold);">₹<fmt:formatNumber value="${item.product.price * item.quantity}" pattern="#,##0.00"/></div>
                        </div>
                    </c:forEach>
                </div>
                
                <div style="border-top: 1px solid var(--border); padding-top: 20px;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 10px; color: var(--text2);">
                        <span>Subtotal</span>
                        <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                    </div>
                    <div style="display: flex; justify-content: space-between; margin-bottom: 20px; color: var(--text2);">
                        <span>Shipping</span>
                        <span style="color: var(--green);">Free</span>
                    </div>
                    <div style="display: flex; justify-content: space-between; font-size: 1.5rem; font-weight: 700; color: white;">
                        <span>Total</span>
                        <span>₹<fmt:formatNumber value="${cartTotal}" pattern="#,##0.00"/></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
