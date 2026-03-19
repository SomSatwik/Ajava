<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>LUXCART - The Future of Style</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .hero-section {
            height: 100vh; position: relative; overflow: hidden;
            display: flex; align-items: center; padding: 0 5%;
        }
        .hero-left {
            flex: 1; z-index: 10; max-width: 600px;
        }
        .hero-right {
            flex: 1; position: relative; height: 100%;
            display: flex; justify-content: center; align-items: center;
        }
        .pill-badge {
            background: rgba(212,168,83,0.1); color: var(--gold); border: 1px solid var(--gold);
            padding: 4px 12px; border-radius: 20px; font-size: 0.7rem; letter-spacing: 0.15em;
            display: inline-block; margin-bottom: 20px; font-weight: 700;
        }
        .hero-heading { font-size: 5rem; line-height: 1.1; margin-bottom: 20px; }
        .hero-heading .line1 { color: white; display: block; animation: slideInLeft 0.6s ease forwards; }
        .hero-heading .line2 {
            background: linear-gradient(90deg, var(--gold), var(--amber));
            -webkit-background-clip: text; color: transparent; display: block;
            animation: slideInLeft 0.6s 0.2s ease forwards; opacity: 0;
        }
        .hero-heading .line3 {
            -webkit-text-stroke: 1px rgba(255,255,255,0.3); color: transparent; display: block;
            animation: slideInLeft 0.6s 0.4s ease forwards; opacity: 0;
        }
        .hero-actions { display: flex; gap: 20px; margin-top: 40px; }
        .hero-stats { margin-top: 30px; font-size: 0.85rem; color: var(--text2); }
        .hero-stats span { margin-right: 15px; }
        
        .floating-frame {
            width: 400px; height: 500px; border-radius: 24px;
            border: 1px solid var(--gold); box-shadow: inset 0 0 40px rgba(0,0,0,0.5);
            overflow: visible; position: relative;
            animation: float 6s ease-in-out infinite; z-index: 5;
            background: url('https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=600') center/cover;
        }
        .float-card {
            background: rgba(15,15,26,0.8); backdrop-filter: blur(10px);
            border: 1px solid var(--border); padding: 12px 20px; border-radius: 12px;
            position: absolute; color: white; font-weight: 600; font-size: 0.9rem;
        }
        .fc-top { top: -20px; right: -30px; animation: float 5s ease-in-out infinite alternate; }
        .fc-bot { bottom: 30px; left: -40px; animation: float 7s ease-in-out infinite alternate; }
        
        .scroll-indicator {
            position: absolute; bottom: 30px; left: 50%; transform: translateX(-50%);
            font-size: 0.7rem; font-family: monospace; color: var(--text2); letter-spacing: 0.2em;
            display: flex; flex-direction: column; align-items: center; gap: 8px;
        }
        .scroll-indicator::after {
            content: ''; width: 1px; height: 30px; background: var(--text2);
            animation: bounce 2s infinite;
        }

        .category-grid {
            display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px; margin-top: 40px;
        }
        .cat-card {
            height: 200px; background: var(--surface2); border: 1px solid var(--border);
            border-radius: 20px; position: relative; overflow: hidden; transition: 0.4s;
            display: flex; flex-direction: column; justify-content: flex-end; padding: 20px;
        }
        .cat-card:hover { transform: scale(1.04); border-color: var(--gold); }
        .cat-card-inner { position: absolute; inset: 0; opacity: 0.6; transition: 0.4s; z-index: 0; }
        .cat-card:hover .cat-card-inner { opacity: 1; }
        .cat-card .icon { font-size: 3rem; margin-bottom: 20px; position: relative; z-index: 1; transition: 0.4s; }
        .cat-card:hover .icon { transform: scale(1.2) rotate(5deg); }
        .cat-content { position: relative; z-index: 1; }
        .cat-name { font-weight: 700; color: white; font-size: 1.1rem; }
        
        /* Product 3D Grid */
        .products-scroll {
            display: flex; gap: 30px; padding: 40px 0;
            overflow-x: auto; scrollbar-width: none;
        }
        .products-scroll::-webkit-scrollbar { display: none; }
        
        .product-card {
            min-width: 280px; width: 280px; background: var(--surface);
            border: 1px solid var(--border); border-radius: 20px;
            overflow: hidden; box-shadow: var(--shadow-card);
            transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .pc-img-area { height: 260px; position: relative; overflow: hidden; }
        .pc-img-area img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .product-card:hover .pc-img-area img { transform: scale(1.08); }
        
        .pc-badge {
            position: absolute; top: 12px; left: 12px; z-index: 2;
            padding: 4px 10px; border-radius: 12px; font-size: 0.7rem; font-weight: 700;
        }
        .badge-NEW { background: var(--violet); color: white; }
        .badge-SALE { background: var(--red); color: white; }
        .badge-HOT { background: var(--amber); color: black; }
        
        .btn-wishlist {
            position: absolute; top: 12px; right: 12px; z-index: 2;
            width: 36px; height: 36px; border-radius: 50%;
            background: rgba(0,0,0,0.5); backdrop-filter: blur(4px);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem; border: 1px solid rgba(255,255,255,0.2);
            transition: 0.3s;
        }
        .btn-wishlist:hover { transform: scale(1.1); }
        
        .quick-add {
            position: absolute; bottom: 0; left: 0; width: 100%;
            background: linear-gradient(135deg, var(--gold), var(--amber)); color: black;
            padding: 12px; text-align: center; font-weight: 700; z-index: 2;
            transform: translateY(100%); transition: 0.3s; border: none; font-size: 0.9rem;
        }
        .product-card:hover .quick-add { transform: translateY(0); }
        
        .pc-content { padding: 16px; }
        .pc-cat { font-size: 0.7rem; color: var(--gold); letter-spacing: 0.05em; text-transform: uppercase; margin-bottom: 5px; }
        .pc-name { font-weight: 600; font-size: 1rem; color: white; margin-bottom: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; display: block; }
        .pc-stars { color: var(--gold); font-size: 0.8rem; margin-bottom: 12px; }
        .pc-price-row { display: flex; align-items: center; justify-content: space-between; }
        .pc-price { font-weight: 700; font-size: 1.2rem; color: white; }
        .pc-old-price { font-size: 0.8rem; color: var(--text2); text-decoration: line-through; margin-left: 8px; }
        
        @keyframes float { 0%,100% {transform: translateY(0);} 50% {transform: translateY(-20px);} }
        @keyframes bounce { 0%,100% {transform: translateY(0) scaleY(1);} 50% {transform: translateY(10px) scaleY(0.8);} }
        @keyframes slideInLeft { from {opacity:0; transform:translateX(-50px);} to {opacity:1; transform:translateX(0);} }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <!-- HERO SECTION -->
    <section class="hero-section">
        <div class="hero-left">
            <div class="pill-badge">NEW ARRIVALS 2024</div>
            <h1 class="heading-syne hero-heading">
                <span class="line1">DISCOVER</span>
                <span class="line2">THE FUTURE</span>
                <span class="line3">OF STYLE</span>
            </h1>
            <p style="color: var(--text2); max-width: 400px; line-height: 1.6;">
                Experience the next generation of online commerce. Curated collections, exclusive drops, and cinematic shopping.
            </p>
            <div class="hero-actions">
                <a href="${pageContext.request.contextPath}/products" class="btn-gold interactive">Shop Now</a>
                <a href="${pageContext.request.contextPath}/products?sort=newest" class="btn-ghost interactive">View Lookbook</a>
            </div>
            <div class="hero-stats">
                <span><span style="color:var(--gold);">•</span> 10K+ Products</span>
                <span><span style="color:var(--gold);">•</span> Free Delivery</span>
                <span><span style="color:var(--gold);">•</span> 30-Day Returns</span>
            </div>
        </div>
        <div class="hero-right">
            <div class="floating-frame">
                <div class="float-card fc-top">⭐ 4.9 Rating</div>
                <div class="float-card fc-bot">🔥 2.3K sold</div>
            </div>
        </div>
        <div class="scroll-indicator">SCROLL</div>
    </section>

    <!-- MARQUEE STRIP -->
    <div class="marquee-container">
        <div class="marquee-content">
            FREE SHIPPING OVER $999 • 30 DAY RETURNS • AUTHENTIC PRODUCTS • SECURE PAYMENT • 
            FREE SHIPPING OVER $999 • 30 DAY RETURNS • AUTHENTIC PRODUCTS • SECURE PAYMENT • 
        </div>
    </div>

    <!-- CATEGORIES -->
    <div class="container pt-100 pb-100">
        <h2 class="heading-syne text-center" style="font-size: 2.5rem;"><span style="border-bottom: 2px solid var(--gold);">SHOP BY CATEGORY</span></h2>
        
        <div class="category-grid">
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/products?category=${cat.id}" class="cat-card interactive">
                    <div class="cat-card-inner" style="background: linear-gradient(to top, rgba(0,0,0,0.8), transparent);"></div>
                    <div class="icon">${cat.icon}</div>
                    <div class="cat-content">
                        <div class="cat-name">${cat.name}</div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>

    <!-- FEATURED / NEW PRODUCTS -->
    <div class="container pb-100">
        <h2 class="heading-syne" style="font-size: 2.5rem; display: flex; align-items: center; gap: 15px;">
            FEATURED DROPS <span class="pill-badge" style="margin: 0;">NEW</span>
        </h2>
        
        <div class="products-scroll mt-40">
            <c:forEach var="p" items="${featuredProducts}">
                <div class="product-card interactive">
                    <div class="pc-img-area">
                        <c:if test="${not empty p.badge}">
                            <div class="pc-badge badge-${p.badge}">${p.badge}</div>
                        </c:if>
                        <a href="#" class="btn-wishlist interactive" data-id="${p.id}">🤍</a>
                        <img src="${p.imageUrl}" alt="${p.name}">
                        <button class="quick-add interactive" onclick="addToCart(${p.id})">⚡ Quick Add</button>
                    </div>
                    <div class="pc-content">
                        <div class="pc-cat">${p.category.name}</div>
                        <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="pc-name interactive">${p.name}</a>
                        <div class="pc-stars">
                            ★★★★★ <span style="color: var(--text3); font-size: 0.7rem;">(${p.reviewCount})</span>
                        </div>
                        <div class="pc-price-row">
                            <div>
                                <span class="pc-price">₹<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></span>
                                <c:if test="${p.originalPrice != null}">
                                    <span class="pc-old-price">₹<fmt:formatNumber value="${p.originalPrice}" pattern="#,##0.00"/></span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>
