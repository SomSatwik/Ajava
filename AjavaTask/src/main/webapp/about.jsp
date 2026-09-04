<%
String name = (String)session.getAttribute("username");

if(name == null){
response.sendRedirect("login.jsp");
}
%>

<html>
<head>
<title>About</title>
</head>

<body>

<h2>About Page</h2>

Welcome <%= name %>

<br><br>

<a href="home.jsp">Home</a>
<br><br>

<a href="logout.jsp">Logout</a>

</body>
</html>