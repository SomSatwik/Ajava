<%
String student = request.getParameter("student");

if(student != null){
    session.setAttribute("student", student);
    session.setAttribute("score", 0);
}
%>

<html>
<head>
<title>Question 1</title>
</head>

<body>

<h2>Question 1</h2>

<form action="question2.jsp" method="post">

What is 2 + 2?

<br><br>

<input type="radio" name="q1" value="3"> 3 <br>
<input type="radio" name="q1" value="4"> 4 <br>
<input type="radio" name="q1" value="5"> 5 <br>

<br>

<input type="submit" value="Next">

</form>

</body>
</html>