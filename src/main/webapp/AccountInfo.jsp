<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Info</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String checkClass = "";
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			
			String str = "SELECT * FROM user";
			ResultSet result = stmt.executeQuery(str);
			String firstName = null, lastName = null;
			
			while(result.next()){
				if(result.getString("username").equals(session.getAttribute("user"))){
					out.print("First Name: " + result.getString("first_name") + "<br/>Last Name: " + result.getString("last_name") + "<br/>Username: " + result.getString("username") + "<br/><br/>");
					firstName = result.getString("first_name");
					lastName = result.getString("last_name");
				}
			}
			
			str = "SELECT * FROM ticket t, user u, flight f WHERE u.username = t.username AND t.flight_number = f.flight_number ORDER BY t.flight_number ASC";
			result = stmt.executeQuery(str);
			out.print("Reservation Info: <br/>");
			
			boolean hasReservations = false;
			
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			SimpleDateFormat updatedDateFormat = new SimpleDateFormat("dd MMM yy hh:mm a");
			while(result.next()){
				//Date Formatting
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
				
				
				if(session.getAttribute("user").equals(result.getString("username"))) {
					
					out.print("<br/>");
					out.print("________________________________________");
					out.print("________________________________________");
					out.print("<br/>");
					out.print("Airline ID: " + "AA");
					//result.getString("airline_id") 
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
			
			if(!hasReservations) {
				out.print("No Reservations<br/>");
			}
			
			
			%>
			<br>
			<form method="get" action="Cancel.jsp">
				<input type="submit" value="Cancel A Reservation" />
			</form>
			<form method="get" action="HomePage.jsp">
				<input type="submit" value="Return to Home Page" />
			</form>			
			<%
				

} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>