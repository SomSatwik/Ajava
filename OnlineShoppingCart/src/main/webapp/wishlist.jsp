<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Wishlist - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pt-100" style="padding-bottom: 100px;">
        <h1 class="heading-syne" style="font-size: 3rem; margin-bottom: 40px; text-align: center;">YOUR <span style="color:var(--gold);">WISHLIST</span></h1>
        
        <c:choose>
            <c:when test="${empty wishlists}">
                <div class="glass-panel text-center" style="padding: 100px 20px;">
                    <div style="font-size: 4rem; margin-bottom: 20px;">🤍</div>
                    <h2 class="heading-syne mb-40">YOUR WISHLIST IS EMPTY</h2>
                    <a href="${pageContext.request.contextPath}/products" class="btn-gold interactive">Discover Products</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="products-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px;">
                    <c:forEach var="w" items="${wishlists}">
                        <div class="product-card interactive" style="width: 100%; border-radius:20px; border:1px solid var(--border); overflow:hidden; background:var(--surface); position:relative;" id="wishlist-item-${w.product.id}">
                            <div style="height:260px; overflow:hidden; position:relative;" class="pc-img-area">
                                <a href="#" class="btn-wishlist interactive active" data-id="${w.product.id}" onclick="removeFromWishlist(event, ${w.product.id})" style="position:absolute; top:12px; right:12px; z-index:2; width:36px; height:36px; border-radius:50%; background:rgba(0,0,0,0.5); backdrop-filter:blur(4px); display:flex; align-items:center; justify-content:center; font-size:1.1rem; border:1px solid rgba(255,255,255,0.2);">❤️</a>
                                <img src="${w.product.imageUrl}" style="width:100%; height:100%; object-fit:cover; transition:transform 0.5s;" alt="${w.product.name}">
                                <button style="position:absolute; bottom:0; left:0; width:100%; background:linear-gradient(135deg, var(--gold), var(--amber)); padding:12px; border:none; color:black; font-weight:700; transform:translateY(100%); transition:0.3s;" onclick="addToCart(${w.product.id})" class="quick-add interactive">⚡ Quick Add</button>
                            </div>
                            <div style="padding: 16px;">
                                <div style="font-size:0.7rem; color:var(--gold); text-transform:uppercase; margin-bottom:5px;">${w.product.category.name}</div>
                                <a href="${pageContext.request.contextPath}/product?id=${w.product.id}" style="font-weight:600; font-size:1rem; color:white; display:block; margin-bottom:8px; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;" class="interactive">${w.product.name}</a>
                                <div style="display:flex; justify-content:space-between; align-items:center;">
                                    <span style="font-weight:700; font-size:1.2rem; color:white;">₹<fmt:formatNumber value="${w.product.price}" pattern="#,##0.00"/></span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
    <script>
        async function removeFromWishlist(e, productId) {
            e.preventDefault();
            try {
                const res = await fetch('${pageContext.request.contextPath}/wishlist', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                    body: `action=toggle&productId=\${productId}`
                });
                const data = await res.json();
                if(data.success) {
                    const card = document.getElementById('wishlist-item-' + productId);
                    if(card) {
                        card.style.transform = 'scale(0.8)';
                        card.style.opacity = '0';
                        setTimeout(() => { card.remove(); }, 300);
                    }
                }
            } catch(e) { console.error(e); }
        }
    </script>
</body>
</html>
