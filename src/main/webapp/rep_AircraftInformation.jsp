<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Aircraft Information</title>
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
			if(request.getParameter("edit_aircraft_id") != null ){
				String update = "update aircraft set aircraft_id = \"" + request.getParameter("edit_aircraft_id") + "\" where aircraft_id = \"" + session.getAttribute("search") + "\"";
				stmt.executeUpdate(update);
				
				session.setAttribute("search", request.getParameter("edit_aircraft_id"));
				
			}
			if(request.getParameter("edit_number_of_seats") != null ){
				String update = "update aircraft set number_of_seats = \"" + request.getParameter("edit_number_of_seats") + "\" where aircraft_id = \"" + session.getAttribute("search") + "\"";
				out.print(update);
				stmt.executeUpdate(update);
				
			}
			%>
			<form method="get" action="rep_AircraftInformation.jsp">
					<label>Search Aircraft: <input name = "search"/></label>
	 				 <input type="submit" value="search" />
				</form>
			<%
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			String str = "SELECT * FROM aircraft";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			while(result.next()){
				if(result.getString("aircraft_id").equals(session.getAttribute("search"))){
					String label = "Aircraft ID: " + result.getString("aircraft_id");
					%>
					<form method="get" action="rep_AircraftInformation.jsp">
							<label><%=label + " "%><input name = "edit_aircraft_id"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					label = "Number of Seats: " + result.getString("number_of_seats");
					%>
					<form method="get" action="rep_AircraftInformation.jsp">
							<label><%=label + " "%><input name = "edit_number_of_seats"/></label>
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