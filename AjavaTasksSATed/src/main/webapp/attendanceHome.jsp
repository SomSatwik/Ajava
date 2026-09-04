<%
String student = request.getParameter("student");

if(student != null){
    session.setAttribute("studentName", student);
}
%>

<html>
<head>
<title>Attendance Portal</title>
</head>

<body>

<h2>Welcome <%= student %></h2>

<br>

<a href="attendanceView.jsp">View Attendance</a>

<br><br>

<a href="logout.jsp">Logout</a>

</body>
</html>