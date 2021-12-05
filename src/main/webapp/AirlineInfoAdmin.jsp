<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airline Information Admin</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp

			//String str = "SELECT * FROM user";

			//ResultSet result = stmt.executeQuery(str);
						out.print("Nothing to see here");
						%>					
					
						
						<form method="get" action="HomePage.jsp">
		  				<input type="submit" value="This button does nothing (or does it)" />
						</form>
					
						<%			
} catch (Exception e) {
	out.print(e);
}
			%>		
</body>
</html>