<%@ page import="java.util.*" %>

<%
List<String> cart = (List<String>) session.getAttribute("cart");
%>

<html>
<head>
<title>Checkout</title>
</head>

<body>

<h2>Order Summary</h2>

<%
if(cart == null || cart.isEmpty()){
%>

<p>Your cart is empty</p>

<%
}else{

for(String item : cart){
%>

<p><%= item %></p>

<%
}
}
%>

<br>

<a href="products.jsp">Shop Again</a>

</body>
</html>