<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Products - Admin LUXCART</title>
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
        
        .modal { display: none; position: fixed; z-index: 1000; left: 0; top: 0; width: 100%; height: 100%; overflow: auto; background-color: rgba(0,0,0,0.8); backdrop-filter: blur(5px); }
        .modal-content { background-color: var(--surface); margin: 5% auto; padding: 40px; border: 1px solid var(--border); border-radius: var(--radius-lg); width: 80%; max-width: 800px; position: relative; }
        .close { color: var(--text2); float: right; font-size: 28px; font-weight: bold; cursor: pointer; }
        .close:hover { color: white; }
    </style>
</head>
<body>
    <jsp:include page="../includes/navbar.jsp" />

    <div class="admin-layout">
        <div class="admin-sidebar">
            <h3 class="heading-syne" style="margin-bottom: 30px; font-size: 1.2rem;">ADMIN PANEL</h3>
            <div class="admin-nav">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="interactive">📊 Dashboard</a>
                <a href="${pageContext.request.contextPath}/admin/products" class="interactive active">🛍️ Products</a>
                <a href="${pageContext.request.contextPath}/admin/orders" class="interactive">📦 Orders</a>
            </div>
        </div>
        
        <div class="admin-main">
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <h1 class="heading-syne" style="font-size: 2.5rem;">PRODUCTS</h1>
                <button onclick="document.getElementById('productModal').style.display='block'" class="btn-gold interactive px-4 py-2">
                    + Add Product
                </button>
            </div>
            
            <c:if test="${not empty message}">
                <div style="background: rgba(16,185,129,0.1); border: 1px solid var(--green); color: white; padding: 15px; border-radius: var(--radius); margin-bottom: 20px;">
                    ${message}
                </div>
            </c:if>
            <c:if test="${not empty error}">
                <div style="background: rgba(244,63,94,0.1); border: 1px solid var(--red); color: white; padding: 15px; border-radius: var(--radius); margin-bottom: 20px;">
                    ${error}
                </div>
            </c:if>

            <div class="glass-panel" style="padding: 0; overflow: hidden;">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Image</th>
                            <th>Name & Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Status/Badge</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${products}">
                            <tr>
                                <td><img src="${p.imageUrl}" style="width:60px; height:60px; border-radius:8px; object-fit:cover;"></td>
                                <td>
                                    <div style="font-weight: 600;">${p.name}</div>
                                    <div style="font-size: 0.8rem; color: var(--gold);">${p.category.name}</div>
                                </td>
                                <td>₹<fmt:formatNumber value="${p.price}" pattern="#,##0.00"/></td>
                                <td>
                                    <span style="${p.stock < 10 ? 'color: var(--red); font-weight:700;' : ''}">${p.stock}</span>
                                </td>
                                <td>
                                    <c:if test="${not empty p.badge}">
                                        <span style="background: var(--gold); color: black; padding: 4px 8px; border-radius: 4px; font-size: 0.7rem; font-weight: 700;">${p.badge}</span>
                                    </c:if>
                                </td>
                                <td>
                                    <div style="display: flex; gap: 10px;">
                                        <a href="?action=edit&id=${p.id}" class="btn-ghost interactive" style="padding: 6px 12px; font-size: 0.8rem;">Edit</a>
                                        <form action="${pageContext.request.contextPath}/admin/products" method="post" style="display:inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="${p.id}">
                                            <button type="submit" class="interactive" style="background:none; border:none; color:var(--red); text-decoration:underline;" onclick="return confirm('Delete this product?')">Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Product Modal (Add/Edit) -->
    <div id="productModal" class="modal" style="${not empty editProduct ? 'display:block;' : ''}">
        <div class="modal-content">
            <span class="close" onclick="document.getElementById('productModal').style.display='none'">&times;</span>
            <h2 class="heading-syne" style="margin-bottom: 30px;">${not empty editProduct ? 'EDIT PRODUCT' : 'ADD NEW PRODUCT'}</h2>
            
            <form action="${pageContext.request.contextPath}/admin/products" method="post">
                <input type="hidden" name="action" value="${not empty editProduct ? 'update' : 'add'}">
                <c:if test="${not empty editProduct}">
                    <input type="hidden" name="id" value="${editProduct.id}">
                </c:if>
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                    <div class="form-group">
                        <label>Product Name</label>
                        <input type="text" name="name" class="form-input" value="${editProduct.name}" required>
                    </div>
                    <div class="form-group">
                        <label>Category</label>
                        <select name="categoryId" class="form-input" required style="background: var(--surface2);">
                            <c:forEach var="c" items="${categories}">
                                <option value="${c.id}" ${editProduct.category.id == c.id ? 'selected' : ''}>${c.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Price ($)</label>
                        <input type="number" step="0.01" name="price" class="form-input" value="${editProduct.price}" required>
                    </div>
                    <div class="form-group">
                        <label>Original Price ($) (Optional)</label>
                        <input type="number" step="0.01" name="originalPrice" class="form-input" value="${editProduct.originalPrice}">
                    </div>
                    <div class="form-group">
                        <label>Stock Quantity</label>
                        <input type="number" name="stock" class="form-input" value="${editProduct.stock}" required>
                    </div>
                    <div class="form-group">
                        <label>Badge (e.g., NEW, SALE, HOT)</label>
                        <input type="text" name="badge" class="form-input" value="${editProduct.badge}">
                    </div>
                </div>
                
                <div class="form-group" style="margin-top: 20px;">
                    <label>Image URL</label>
                    <input type="text" name="imageUrl" class="form-input" value="${editProduct.imageUrl}" required>
                </div>
                
                <div class="form-group" style="margin-top: 20px;">
                    <label>Description</label>
                    <textarea name="description" class="form-input" rows="4" required>${editProduct.description}</textarea>
                </div>
                
                <div class="form-group" style="margin-top: 20px; display: flex; align-items: center; gap: 10px;">
                    <input type="checkbox" name="featured" value="true" ${editProduct.featured ? 'checked' : ''} style="width: 20px; height: 20px;">
                    <label style="margin: 0;">Featured Product</label>
                </div>
                
                <div style="text-align: right; margin-top: 30px;">
                    <button type="button" class="btn-ghost interactive" style="margin-right: 15px;" onclick="document.getElementById('productModal').style.display='none'">Cancel</button>
                    <button type="submit" class="btn-gold interactive">${not empty editProduct ? 'Update Product' : 'Save Product'}</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
