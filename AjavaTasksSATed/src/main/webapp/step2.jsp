<%
String name = request.getParameter("name");
%>

<html>
<head>
<title>Step 2</title>
</head>

<body>

<h2>Registration - Step 2</h2>

<form action="step3.jsp" method="post">

Email:
<input type="email" name="email" required>

<input type="hidden" name="name" value="<%= name %>">

<br><br>

<input type="submit" value="Next">

</form>

</body>
</html>