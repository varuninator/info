<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
			String checkClass = "";
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
					<% 
					
					str = "SELECT SUM(30) AS URev FROM otrs.ticket t WHERE  t.username = \"" + session.getAttribute("userADsearch") + "\"";
				    result = stmt.executeQuery(str);
	                result.next();
				    out.print("The total revenue from this user: $" + result.getInt("URev"));
				    
				    str = "SELECT SUM(1) AS URev FROM otrs.ticket t WHERE  t.username = \"" + session.getAttribute("userADsearch") + "\"";
				    result = stmt.executeQuery(str);
				    result.next();
				    out.print("<br/>The total tickets sold for this user: " + result.getInt("URev")+ "<br/>");
					
					%>
				    <br>
					<form method="get" action="HomePage.jsp">
		  				<input type="submit" value="Back to Home Page" />
					</form>
					<%
					
					out.print("<br/>ALL tickets bought by " + session.getAttribute("userADsearch") + ":<br/><br/>");
					str = "SELECT * FROM ticket t, user u, flight f, airline_company a, flys fl WHERE u.username = t.username AND t.departure_time = f.departure_time AND f.flight_number = fl.flight_number AND fl.airline_id = a.airline_id ORDER BY t.departure_time DESC, t.id_num ASC;";
				    result = stmt.executeQuery(str);
				    
					boolean hasReservations = false;
				    
					SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
					SimpleDateFormat updatedDateFormat = new SimpleDateFormat("dd MMM yy hh:mm a");
				    while (result.next()){
				    	
						Date departingDate = dateFormat.parse(result.getString("departure_time"));
						Date arrivingDate = dateFormat.parse(result.getString("arrival_time"));
						String updatedDepartingDate = updatedDateFormat.format(departingDate);
						String updatedArrivingDate = updatedDateFormat.format(arrivingDate);
						

						if(result.getString("first_class").equals("1")){
							checkClass = "First Class";
						}
						else if(result.getString("business_class").equals("1")){
							checkClass = "Business Class";
						}
						else{
							checkClass = "Economy Class";
						}
						
						
						//Total Fare Calculation
						double baseFare = result.getInt("base_price") - 30;
						if(checkClass.equals("Economy Class")) {
							
						} else if(checkClass.equals("Business Class")) {
							baseFare = baseFare * 1.5 + 30;
						} else if(checkClass.equals("First Class")) {
							baseFare = baseFare * 2 + 30;
						}
						
						String firstName = result.getString("first_name");
						String lastName = result.getString("last_name");
						
						out.print("<br/>");
						out.print("________________________________________");
						out.print("________________________________________");
						out.print("<br/>");
						out.print("Airline ID: " + result.getString("airline_id"));
						//use the operates table to connect flight_number to aircraft_id and airline_id
						out.print(" - - - - - - - - - - - - - - - - - - - - ");
						out.print(checkClass + " Boarding Pass");
						out.print("<br/>");
						out.print("Passenger: " + firstName + " " + lastName);
						out.print("<br/>");
						out.print("From: " + result.getString("departing_airport") + " - - - - - - - - - - Departure Date: " + updatedDepartingDate.substring(0, 9) + " - - - - - - - - - - Departure Time: " + updatedDepartingDate.substring(9) + "<br/>");
						out.print("To: " + result.getString("arriving_airport") + " - - - - - - - - - - Arrival Date: " + updatedArrivingDate.substring(0, 9) + " - - - - - - - - - - Arrival Time: " + updatedArrivingDate.substring(9) + "<br/>");
						out.print(" - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - Total Fare: $" + baseFare);
						out.print("<br/>");
						out.print("Flight #: " + result.getString("flight_number") + " - - - - - - - - - - - - - - - - - - - - Seat: " + result.getInt("seat_number"));
						out.print("<br/>");
						out.print("Ticket ID #: " + result.getInt("id_num") + "<br/>");
						out.print("________________________________________");
						out.print("________________________________________");
						out.print("<br/>");
						//out.print("Ticket Number: "+ result.getInt("id_num") + ", flight number: " + result.getInt("flight_number") + ", username: " + result.getString("username") + ", seat number: "+ result.getInt("seat_number")+ ", first name: " + result.getString("first_name") + ", last name: " + result.getString("last_name")+ ", class: " + checkClass + "<br/>");
						hasReservations = true;
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