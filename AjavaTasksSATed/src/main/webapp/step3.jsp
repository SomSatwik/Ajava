<%
String name = request.getParameter("name");
String email = request.getParameter("email");
%>

<html>
<head>
<title>Step 3</title>
</head>

<body>

<h2>Registration - Step 3</h2>

<form action="final.jsp" method="post">

Branch:
<input type="text" name="branch" required>

<input type="hidden" name="name" value="<%= name %>">
<input type="hidden" name="email" value="<%= email %>">

<br><br>

<input type="submit" value="Submit">

</form>

</body>
</html>