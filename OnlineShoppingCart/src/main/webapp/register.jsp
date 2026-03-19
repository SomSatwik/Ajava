<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pt-100 mt-40" style="display: flex; justify-content: center; align-items: center; min-height: 80vh; padding-bottom: 50px;">
        <div class="glass-panel" style="width: 100%; max-width: 500px;">
            <h2 class="heading-syne text-center mb-40" style="font-size: 2rem;">CREATE <span style="color: var(--gold)">ACCOUNT</span></h2>
            
            <c:if test="${not empty error}">
                <div style="color: var(--red); margin-bottom: 20px; text-align: center;">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label>Full Name</label>
                    <input type="text" name="name" class="form-input" required>
                </div>
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-input" required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="text" name="phone" class="form-input">
                </div>
                <div class="form-group">
                    <label>Shipping Address</label>
                    <textarea name="address" class="form-input" rows="3"></textarea>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-input" required autocomplete="new-password">
                </div>
                <button type="submit" class="btn-gold interactive" style="width: 100%; margin-top: 20px;">Sign Up</button>
            </form>
            <div class="text-center" style="margin-top: 30px; font-size: 0.9rem; color: var(--text2);">
                Already have an account? <a href="${pageContext.request.contextPath}/login" style="color: var(--gold);" class="interactive">Sign In</a>
            </div>
        </div>
    </div>
</body>
</html>
