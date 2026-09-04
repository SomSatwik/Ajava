<%@ page import="java.util.*" %>

<html>
<head>
<title>Products</title>
</head>

<body>

<h2>Products</h2>

<form action="cart.jsp" method="post">
<input type="checkbox" name="product" value="Laptop"> Laptop <br>
<input type="checkbox" name="product" value="Mobile"> Mobile <br>
<input type="checkbox" name="product" value="Headphones"> Headphones <br>
<input type="checkbox" name="product" value="Keyboard"> Keyboard <br><br>

<input type="submit" value="Add to Cart">
</form>

</body>
</html>