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
			boolean loggedIn = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			String username = request.getParameter("user");
			String password = request.getParameter("pass");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT * FROM user";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				if((result.getString("username").equals(username))&&result.getString("pass").equals(password)){
				 	loggedIn = true;
					out.print("You are currently logged in as "+ username);
					if(result.getInt("type1")==(0)){
						out.print(" and are an admin.");
					}
					else if(result.getInt("type1")==1){
						out.print(" and are a customer representative.");
					}
					else{
						out.print(" and are a customer.");
					}
					%>
					<form method="get" action="HelloWorld.jsp">
		  				<input type="submit" value="Logout" />
					</form>
					<%
				}
				
				
		
				//out.print(result.getString("username")+ "\n");
			}
			
			if(!loggedIn){
				out.print("Sorry you have entered an incorrect username or password");
				%>
				<form method="get" action="HelloWorld.jsp">
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