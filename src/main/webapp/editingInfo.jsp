<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User's Information Edited!</title>
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
			String Newusername = request.getParameter("editedusername");
			String Newpassword = request.getParameter("editedpassword");
			String Newfname = request.getParameter("editedFName");
			String Newlname = request.getParameter("editedLName");

			String str = "SELECT * FROM user";
			ResultSet result = stmt.executeQuery(str);
			
			
			
			while (result.next()) {
				if((result.getString("username").equals(session.getAttribute("userADsearch")))){
					if(Newusername != null){ 
						if (!Newusername.trim().isEmpty()){
							out.print("New username is: " + Newusername);
							String up = "UPDATE otrs.user SET username = \"" + Newusername + "\"" + " WHERE username =\"" +session.getAttribute("userADsearch") + "\"";
							PreparedStatement ps = con.prepareStatement(up);
							//out.print(up);
						    
						    session.setAttribute("userADsearch", Newusername);
							
							ps.executeUpdate();
							
							
						}else{
							out.print("Invalid Username, Try again!");
						}
					}
					else if(Newpassword != null){
						if (!Newpassword.trim().isEmpty()){
							out.print("New password is: " + Newpassword);
							String up = "UPDATE otrs.user SET pass = \"" + Newpassword + "\"" + " WHERE pass =\"" + result.getString("pass") + "\"";
							PreparedStatement ps = con.prepareStatement(up);
							ps.executeUpdate();
						}else{
							out.print("Invalid Password, Try again!");
						}
					}
					else if(Newfname != null){
						if (!Newfname.trim().isEmpty()){
							out.print("New First Name is: " + Newfname);
							String up = "UPDATE otrs.user SET first_name = \"" + Newfname + "\"" + " WHERE first_name =\"" + result.getString("first_name") + "\"";
							PreparedStatement ps = con.prepareStatement(up);
							ps.executeUpdate();
						}else{
							out.print("Invalid First Name, Try again!");
						}
					}
					else if(Newlname != null){
						if (!Newlname.trim().isEmpty()){
							out.print("New Last Name is: " + Newlname);
							String up = "UPDATE otrs.user SET last_name = \"" + Newlname + "\"" + " WHERE last_name =\"" + result.getString("last_name") + "\"";
							PreparedStatement ps = con.prepareStatement(up);
							ps.executeUpdate();
						}else{
							out.print("Invalid Last Name, Try again!");
						}
					}
				}
			}			
			
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>