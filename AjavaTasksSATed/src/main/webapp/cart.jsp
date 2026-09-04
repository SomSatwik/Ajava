<%@ page import="java.util.*" %>

<%
String[] items = request.getParameterValues("product");

List<String> cart = (List<String>) session.getAttribute("cart");

if(cart == null){
    cart = new ArrayList<>();
}

if(items != null){
    for(String item : items){
        cart.add(item);
    }
}

session.setAttribute("cart", cart);
%>

<html>
<head>
<title>Shopping Cart</title>
</head>

<body>

<h2>Your Cart</h2>

<%
for(String item : cart){
%>
<p><%= item %></p>
<%
}
%>

<br>

<a href="products.jsp">Add More Products</a>
<br><br>

<a href="checkout.jsp">Checkout</a>

</body>
</html>