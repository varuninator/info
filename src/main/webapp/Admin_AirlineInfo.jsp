<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airline Information</title>
</head>
<body>
	<%
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			
	%>
	<body>
	<label>Insert Name of Current Airline from Query</label>
	</body>
	<form method="get" action="HomePage.jsp">
		<label>Show Airline Revenue:</label> <input
			type="submit" value="Show" />
	</form>
	<form method="get" action="HomePage.jsp">
		<input type="submit" value="Back" />
	</form>

	<%
					
					
} catch (Exception e) {
	out.print(e);
}
			%>

</body>
</html>