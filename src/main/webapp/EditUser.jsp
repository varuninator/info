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
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM user";
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				if((result.getString("username").equals(session.getAttribute("userADsearch")))){
					out.print("Current Username: " + session.getAttribute("userADsearch") + "<br/>");
					out.print("Current Password: " + result.getString("pass") + "<br/>");
					out.print("Current First Name: " + result.getString("first_name") + "<br/>");
					out.print("Current Last Name: " + result.getString("last_name") + "<br/>");
					}
				}
					%>
					<br>					
				 	<form method="get" action="editingInfo.jsp">
					<label>Change Username: <input name = "editedusername"/></label>
	 				<input type="submit" value="New Username" />
				    </form>
				    <form method="get" action="editingInfo.jsp">
					<label>Change Password: <input name = "editedpassword"/></label>
	 				<input type="submit" value="New Password" />
				    </form>
				    <form method="get" action="editingInfo.jsp">
					<label>Change First Name: <input name = "editedFName"/></label>
	 				<input type="submit" value="New First Name" />
				    </form>
				    <form method="get" action="editingInfo.jsp">
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