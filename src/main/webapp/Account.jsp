<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean search = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			
			
			
				
			
						%>
						
						<form method="get" action="HomePage.jsp">
			 				 <input type="submit" value="Browse Current Flights" />
						</form>
						
						<form method="get" action="HomePage.jsp"> 
			 				 <input type="submit" value="Browse Past Flights" />
						</form>
						
						<form method="get" action="Cancel.jsp">
		  				<input type="submit" value="Cancel Flights" />
						</form>
						
						<form method="get" action="changeTix.jsp">
		  				<input type="submit" value="Change Ticket" />
						</form>
						
				
						<%
						out.print("Waiting List Pending");
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>