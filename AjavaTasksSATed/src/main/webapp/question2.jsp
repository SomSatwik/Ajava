<%
String ans1 = request.getParameter("q1");

int score = (Integer) session.getAttribute("score");

if("4".equals(ans1)){
    score++;
}

session.setAttribute("score", score);
%>

<html>
<head>
<title>Question 2</title>
</head>

<body>

<h2>Question 2</h2>

<form action="result.jsp" method="post">

Capital of India?

<br><br>

<input type="radio" name="q2" value="Delhi"> Delhi <br>
<input type="radio" name="q2" value="Mumbai"> Mumbai <br>
<input type="radio" name="q2" value="Kolkata"> Kolkata <br>

<br>

<input type="submit" value="Finish Exam">

</form>

</body>
</html>