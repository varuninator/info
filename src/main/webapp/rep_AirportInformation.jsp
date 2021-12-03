<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airport Information</title>
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
			
			String sch = request.getParameter("search");
			
			if(sch != null){
				session.setAttribute("search", sch);
			}
			%>
			<form method="get" action="rep_AirportInformation.jsp">
					<label>Search Flight: <input name = "search"/></label>
	 				 <input type="submit" value="search" />
				</form>
			<%
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			String str = "SELECT * FROM users";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			while(result.next()){
				if(result.getString("airport_id").equals(session.getAttribute("search"))){
					String label = "Airportr: " + result.getInt("airport_id");
					%>
					<form method="get" action="rep_AirportInformation.jsp">
							<label><%=label + " "%><input name = "edit_airport"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					out.print("<br/>");
				}
			}
			
						
					
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>