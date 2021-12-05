<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit User information</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean search = false;
			
		
			//*add while loop later to find user on datatbase to display all relavent ifo except password*
			
			
			
			Statement stmt = con.createStatement();
					out.print("Current Username: " + session.getAttribute("userADsearch"));
					%>
					<br>					
				 	<form method="get" action="editingInfo.jsp">
					<label>Change Username: <input name = "editedusername"/></label>
	 				<input type="submit" value="New Username" />
				    </form>
				    <form method="get" >
					<label>Change Password: <input name = "editedpassword"/></label>
	 				<input type="submit" value="New Password" />
				    </form>
				    <form method="get" >
					<label>Change First Name: <input name = "editedFName"/></label>
	 				<input type="submit" value="New First Name" />
				    </form>
				    <form method="get" >
					<label>Change Last Name: <input name = "editedLName"/></label>
	 				<input type="submit" value="New Last Name" />
				    </form>
					<%
									
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>