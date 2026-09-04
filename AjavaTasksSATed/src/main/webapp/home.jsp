<%
String name = request.getParameter("name");
String email = request.getParameter("email");

session.setAttribute("username", name);
session.setAttribute("useremail", email);
%>

<html>
<head>
<title>Home</title>
</head>

<body>

<h2>Home Page</h2>

Welcome: <%= name %>
<br><br>

<a href="profile.jsp">Profile</a>
<br><br>

<a href="about.jsp">About</a>
<br><br>

<a href="logout.jsp">Logout</a>

</body>
</html>