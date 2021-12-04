<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Information</title>
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
			
			if(request.getParameter("edit_flight_number") != null ){
				String update = "update flight set flight_number =" + request.getParameter("edit_flight_number") + " where flight_number = " + session.getAttribute("search");
				stmt.executeUpdate(update);
				session.setAttribute("search", request.getParameter("edit_flight_number"));
				
			}
			if(request.getParameter("edit_departing_airport") != null ){
				String update = "update flight set departing_airport =" + request.getParameter("edit_departing_airport") + " where flight_number = " + session.getAttribute("search");
				stmt.executeUpdate(update);
				
			}
			if(request.getParameter("edit_arriving_airport") != null ){
				String update = "update flight set arriving_airport =" + request.getParameter("edit_arriving_airport") + " where flight_number = " + session.getAttribute("search");
				stmt.executeUpdate(update);
				
			}
			if(request.getParameter("edit_departure_time") != null ){
				String update = "update flight set departure_time = \"" + request.getParameter("edit_departure_time") + "\" where flight_number = " + session.getAttribute("search");
				stmt.executeUpdate(update);
				
			}
			if(request.getParameter("edit_arrival_time") != null ){
				String update = "update flight set arrival_time = \"" + request.getParameter("edit_arrival_time") + "\" where flight_number = " + session.getAttribute("search");
				out.print(update);
				stmt.executeUpdate(update);
				
			}
			%>
			<form method="get" action="rep_FlightInformation.jsp">
					<label>Search Flight: <input name = "search"/></label>
	 				 <input type="submit" value="search" />
				</form>
			<%
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			String str = "SELECT * FROM flight";
			ResultSet result = stmt.executeQuery(str);
			//Run the query against the database.
			
			while(result.next()){
				if(result.getString("flight_number").equals(session.getAttribute("search"))){
					String label = "Flight Number: " + result.getInt("flight_number");
					%>
					<form method="get" action="rep_FlightInformation.jsp">
							<label><%=label + " "%><input name = "edit_flight_number"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					label = "Departing Airport: " + result.getString("departing_airport");
					%>
					<form method="get" action="rep_FlightInformation.jsp">
							<label><%=label + " "%><input name = "edit_departing_airport"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					label = "Arriving Airport: " + result.getString("arriving_airport");
					%>
					<form method="get" action="rep_FlightInformation.jsp">
							<label><%=label + " "%><input name = "edit_arriving_airport"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					label = "Departure time: " + result.getTimestamp("departure_time");
					%>
					<form method="get" action="rep_FlightInformation.jsp">
							<label><%=label + " "%><input name = "edit_departure_time"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					label = "arrival time: " + result.getTimestamp("arrival_time");
					%>
					<form method="get" action="rep_FlightInformation.jsp">
							<label><%=label + " "%><input name = "edit_arrival_time"/></label>
			 				 <input type="submit" value="edit" />
						</form>
					<%
					str = "SELECT * FROM waitlist where flight_number = " + result.getInt("flight_number");
					result = stmt.executeQuery(str);
					
					out.print("Waiting List: </br>");
					out.print(str + "</br>");
					while(result.next()){
						out.print(result.getString("username") +", " + result.getInt("spot") + "</br>");
					}
					
					break;
				}
			}
			
						
					
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>