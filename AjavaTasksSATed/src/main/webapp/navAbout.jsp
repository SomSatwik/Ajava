<%
String username = request.getParameter("username");
%>

<html>
<head>
<title>Navigation About</title>
</head>

<body>

<h2>About Page</h2>

Hello <%= username %>

<br><br>

<a href="navHome.jsp?username=<%= username %>">Back to Home</a>

<br><br>

<a href="navProfile.jsp?username=<%= username %>">Go to Profile</a>

</body>
</html>