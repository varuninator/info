<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Viewing User's Account</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean userExist = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("SearchUser");
			if(username != null){
				session.setAttribute("userADsearch", username);
			}

			String str = "SELECT * FROM user";
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				if((result.getString("username").equals(session.getAttribute("userADsearch")))){
				 	userExist = true;
				 	%>
				 	<form method="get" action="AdminViewUserInfo.jsp">
					<label>Search another User: <input name = "SearchUser"/></label>
	 				 <input type="submit" value="Search User" />
				    </form>
				    <br>
				    <%
					out.print("User:  "+ session.getAttribute("userADsearch"));
				    %>
				    <form method="get" action="EditUser.jsp"> 
		  			<input type="submit" value="Edit User" />
					</form>	
					<form method="get" action="DeleteUser.jsp"> 
		  			<input type="submit" value="Delete User" />
					</form>		
				    <br>
					<form method="get" action="HomePage.jsp">
		  				<input type="submit" value="Back to Home Page" />
					</form>
					<%
					
					out.print("<br/>ALL tickets bought by " + session.getAttribute("userADsearch") + ":<br/><br/>");
					str = "SELECT * FROM ticket";
				    result = stmt.executeQuery(str);
				    while (result.next()){
				    	if ((result.getString("username").equals(session.getAttribute("userADsearch")))&&(result.getString("user_delete").equals("0"))){	
				    		if(result.getString("first_class").equals("1")){
				    			out.print("Ticket #: "+ result.getInt("id_num") +", Flight #: "+ result.getInt("flight_number") +", Username: "+ result.getString("username") + ", Seat #: " + result.getInt("seat_number") + ", First Name: "+ result.getString("first_name") + ", Last Name: " + result.getString("last_name") + ", Class: First Class<br/>");
							}
				    		else if(result.getString("business_class").equals("1")){
				    			out.print("Ticket #: "+ result.getInt("id_num") +", Flight #: "+ result.getInt("flight_number") +", Username: "+ result.getString("username") + ", Seat #: " + result.getInt("seat_number") + ", First Name: "+ result.getString("first_name") + ", Last Name: " + result.getString("last_name") + ", Class: Business Class<br/>");
							}
				    		else if(result.getString("economy_class").equals("1")){
				    			out.print("Ticket #: "+ result.getInt("id_num") +", Flight #: "+ result.getInt("flight_number") +", Username: "+ result.getString("username") + ", Seat #: " + result.getInt("seat_number") + ", First Name: "+ result.getString("first_name") + ", Last Name: " + result.getString("last_name") + ", Class: Economy Class<br/>");
							}
				    	}
				    }
					
					
				}
					
			}
			
			if(!userExist){
				out.print("This user does not exist. Try again.");
				%>
				<form method="get" action="HomePage.jsp">
	  				<input type="submit" value="Try Again" />
				</form>
				<%
			}
			
		
			
			
			
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>