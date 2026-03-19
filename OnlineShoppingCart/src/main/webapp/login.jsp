<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - LUXCART</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <script src="${pageContext.request.contextPath}/js/interactions.js" defer></script>
</head>
<body>
    <jsp:include page="includes/navbar.jsp" />

    <div class="container pt-100 mt-40" style="display: flex; justify-content: center; align-items: center; min-height: 80vh;">
        <div class="glass-panel" style="width: 100%; max-width: 450px;">
            <h2 class="heading-syne text-center mb-40" style="font-size: 2rem;">WELCOME <span style="color: var(--gold)">BACK</span></h2>
            
            <c:if test="${not empty error}">
                <div style="color: var(--red); margin-bottom: 20px; text-align: center;">${error}</div>
            </c:if>
            <c:if test="${param.registered == 'true'}">
                <div style="color: var(--green); margin-bottom: 20px; text-align: center;">Registration successful. Please login.</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label>Email Address</label>
                    <input type="email" name="email" class="form-input" required>
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" name="password" class="form-input" required>
                </div>
                <button type="submit" class="btn-gold interactive" style="width: 100%; margin-top: 20px;">Sign In</button>
            </form>
            <div class="text-center" style="margin-top: 30px; font-size: 0.9rem; color: var(--text2);">
                Don't have an account? <a href="${pageContext.request.contextPath}/register" style="color: var(--gold);" class="interactive">Create an account</a>
            </div>
        </div>
    </div>
</body>
</html>
