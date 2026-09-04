<%
String username = request.getParameter("username");
%>

<html>
<head>
<title>Navigation Profile</title>
</head>

<body>

<h2>Profile Page</h2>

User: <%= username %>

<br><br>

<a href="navHome.jsp?username=<%= username %>">Home</a>

<br><br>

<a href="navAbout.jsp?username=<%= username %>">About</a>

</body>
</html>