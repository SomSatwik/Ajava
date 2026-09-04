<%
String name = (String)session.getAttribute("username");
String email = (String)session.getAttribute("useremail");

if(name == null){
response.sendRedirect("login.jsp");
}
%>

<html>
<head>
<title>Profile</title>
</head>

<body>

<h2>Profile Page</h2>

Name: <%= name %>
<br>

Email: <%= email %>
<br><br>

<a href="home.jsp">Home</a>
<br><br>

<a href="logout.jsp">Logout</a>

</body>
</html>