<%@ page language="java" %>

<html>
<head>
<title>Page Visit Counter</title>
</head>

<body>

<h2>Page Visit Counter</h2>

<%
Integer count = (Integer)application.getAttribute("visitCount");

if(count == null){
    count = 1;
}else{
    count = count + 1;
}

application.setAttribute("visitCount", count);
%>

<h3>Number of times page visited: <%= count %></h3>

</body>
</html>