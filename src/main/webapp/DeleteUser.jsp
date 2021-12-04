<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Deleted</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			//Create a SQL statement
			Statement stmt = con.createStatement();		
			String str = "SELECT * FROM user";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			out.print(session.getAttribute("userADsearch") + "'s account has been deleted!");
			String deleteU = "DELETE FROM user WHERE username = \"" + session.getAttribute("userADsearch") + "\"";
			/* out.print(deleteU); */
			PreparedStatement ps = con.prepareStatement(deleteU);
			ps.executeUpdate();
			
			%>
		 	<form method="get" action="HomePage.jsp"> 
		  	<input type="submit" value="Go Back to Home Page" />
			</form>
		    <%

			con.close();
} catch (Exception e) {
	out.print(e);
}
%>			
</body>
</html>