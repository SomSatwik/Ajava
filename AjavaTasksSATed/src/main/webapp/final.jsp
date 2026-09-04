<%
String name = request.getParameter("name");
String email = request.getParameter("email");
String branch = request.getParameter("branch");
%>

<html>
<head>
<title>Final Page</title>
</head>

<body>

<h2>Registration Details</h2>

Name: <%= name %> <br>
Email: <%= email %> <br>
Branch: <%= branch %> <br>

</body>
</html>