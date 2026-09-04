<%
String student = (String)session.getAttribute("studentName");

if(student == null){
    response.sendRedirect("attendanceLogin.jsp");
    return;
}
%>

<html>
<head>
<title>Attendance Details</title>
</head>

<body>

<h2>Attendance Details</h2>

Student: <%= student %>

<br><br>

Total Classes: 40 <br>
Attended: 34 <br>
Attendance Percentage: 85%

<br><br>

<a href="attendanceHome.jsp">Back</a>

</body>
</html>