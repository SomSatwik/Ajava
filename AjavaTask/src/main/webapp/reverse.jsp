<%@ page language="java" %>

<html>
<head>
<title>Reverse String</title>
</head>

<body>

<h2>Reverse a String</h2>

<form method="post">

Enter String:
<input type="text" name="text">

<input type="submit" value="Reverse">

</form>

<%
String str = request.getParameter("text");

if(str != null){

String reversed = new StringBuilder(str).reverse().toString();
%>

<h3>Reversed String: <%= reversed %></h3>

<%
}
%>

</body>
</html>