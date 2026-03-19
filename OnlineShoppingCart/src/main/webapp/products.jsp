<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Products - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
    <style>
        .page-header {
            padding: 120px 0 60px; text-align: center;
            background: linear-gradient(180deg, rgba(212,168,83,0.05) 0%, transparent 100%);
        }
        .filter-bar {
            background: var(--surface); border: 1px solid var(--border);
            border-radius: var(--radius-lg); padding: 15px 25px;
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 40px; box-shadow: var(--shadow-card);
        }
        .filter-group select, .filter-group input {
            background: var(--surface2); border: 1px solid var(--border); color: white;
            padding: 8px 15px; border-radius: 8px; outline: none; margin-left: 10px;
        }
        .products-grid {
            display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 30px;
        }
        
        .pagination { display: flex; justify-content: center; gap: 10px; margin-top: 50px; padding-bottom: 50px; }
        .page-btn {
            background: var(--surface); border: 1px solid var(--border);
            width: 40px; height: 40px; display: flex; justify-content: center; align-items: center;
            border-radius: 10px; color: white; transition: 0.3s;
        }
        .page-btn:hover, .page-btn.active { background: var(--gold); color: black; border-color: var(--gold); }
        
        .product-card {
            width: 100%; background: var(--surface);
            border: 1px solid var(--border); border-radius: 20px;
            overflow: hidden; box-shadow: var(--shadow-card);
            transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .pc-img-area { height: 260px; position: relative; overflow: hidden; }
        .pc-img-area img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
        .product-card:hover .pc-img-area img { transform: scale(1.08); }
        .pc-badge {
            position: absolute; top: 12px; left: 12px; z-index: 2;
            padding: 4px 10px; border-radius: 12px; font-size: 0.7rem; font-weight: 700; background: var(--gold); color: black;
        }
        .quick-add {
            position: absolute; bottom: 0; left: 0; width: 100%;
            background: linear-gradient(135deg, var(--gold), var(--amber)); color: black;
            padding: 12px; text-align: center; font-weight: 700; z-index: 2;
            transform: translateY(100%); transition: 0.3s; border: none; font-size: 0.9rem;
        }
        .product-card:hover .quick-add { transform: translateY(0); }
        .pc-content { padding: 16px; }
        .pc-cat { font-size: 0.7rem; color: var(--gold); letter-spacing: 0.05em; text-transform: uppercase; margin-bottom: 5px; }
        .pc-name { font-weight: 600; font-size: 1rem; color: white; display: block; margin-bottom: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .pc-stars { color: var(--gold); font-size: 0.8rem; margin-bottom: 12px; }
        .pc-price-row { display: flex; justify-content: space-between; }
        .pc-price { font-weight: 700; font-size: 1.2rem; white-space: nowrap; }
    </style>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />
    <div class="page-header">
        <h1 class="heading-syne" style="font-size: 3.5rem;">THE <span style="color:var(--gold);">COLLECTION</span></h1>
        <p style="color: var(--text2); margin-top: 15px;">Discover our full range of premium products.</p>
    </div>
    <div class="container">
        <div class="filter-bar">
            <form action="${pageContext.request.contextPath}/products" method="get" style="display: flex; gap: 20px; width: 100%; align-items: center;">
                <div class="filter-group">
                    <span style="color: var(--text2);">Category:</span>
                    <select name="category" onchange="this.form.submit()" class="interactive">
                        <option value="">All Categories</option>
                        <c:forEach var="c" items="${categories}">
                            <option value="${c.id}" ${param.category == c.id ? 'selected' : ''}>${c.name}</option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="filter-group">
                    <span style="color: var(--text2);">Sort By:</span>
                    <select name="sort" onchange="this.form.submit()" class="interactive">
                        <option value="newest" ${param.sort == 'newest' ? 'selected' : ''}>Newest First</option>
                        <option value="price_asc" ${param.sort == 'price_asc' ? 'selected' : ''}>Price: Low to High</option>
                        <option value="price_desc" ${param.sort == 'price_desc' ? 'selected' : ''}>Price: High to Low</option>
                        <option value="rating" ${param.sort == 'rating' ? 'selected' : ''}>Top Rated</option>
                    </select>
                </div>
                
                <div class="filter-group" style="flex-grow: 1; text-align: right;">
                    <input type="text" name="search" placeholder="Search products..." value="${param.search}" class="interactive">
                    <button type="submit" class="btn-gold interactive" style="padding: 8px 20px;">Search</button>
                </div>
            </form>
        </div>
        <c:if test="${empty products}">
            <div style="text-align: center; padding: 100px 0; color: var(--text2);">
                <h2>No products found matching your criteria.</h2>
            </div>
        </c:if>
        <div class="products-grid">
            <c:forEach var="p" items="${products}">
                <div class="product-card interactive">
                    <div class="pc-img-area">
                        <c:if test="${not empty p.badge}">
                            <div class="pc-badge">${p.badge}</div>
                        </c:if>
                        <img src="${p.imageUrl}" alt="${p.name}">
                        <button class="quick-add interactive" onclick="addToCart(${p.id})">⚡ Quick Add</button>
                    </div>
                    <div class="pc-content">
                        <div class="pc-cat">${p.category.name}</div>
                        <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="pc-name interactive">${p.name}</a>
                        <div class="pc-stars">★★★★★ <span style="color:var(--text3)">(${p.reviewCount})</span></div>
                        <div class="pc-price-row">
                            <span class="pc-price">₹<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <a href="?page=${i}&category=${param.category}&sort=${param.sort}&search=${param.search}" 
                       class="page-btn interactive ${i == currentPage ? 'active' : ''}">${i}</a>
                </c:forEach>
            </div>
        </c:if>
    </div>
</body>
</html>
