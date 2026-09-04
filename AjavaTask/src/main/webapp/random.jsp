<%@ page import="java.util.Random" %>

<html>
<head>
<title>Random Number</title>
</head>

<body>

<h2>Random Number Generator</h2>

<%
Random r = new Random();
int num = r.nextInt(100);
%>

<h3>Random Number: <%= num %></h3>

</body>
</html>