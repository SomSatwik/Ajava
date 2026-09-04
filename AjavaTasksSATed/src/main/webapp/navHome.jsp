<%
String username = request.getParameter("username");
%>

<html>
<head>
<title>Navigation Home</title>
</head>

<body>

<h2>Home Page</h2>

Welcome <%= username %>

<br><br>

<a href="navAbout.jsp?username=<%= username %>">Go to About</a>

<br><br>

<a href="navProfile.jsp?username=<%= username %>">Go to Profile</a>

</body>
</html>