<%
String ans2 = request.getParameter("q2");

int score = (Integer) session.getAttribute("score");

if("Delhi".equals(ans2)){
    score++;
}

String student = (String) session.getAttribute("student");
%>

<html>
<head>
<title>Exam Result</title>
</head>

<body>

<h2>Exam Result</h2>

Student: <%= student %>

<br><br>

Score: <%= score %> / 2

</body>
</html>