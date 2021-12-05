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
			
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			//String sch = request.getParameter("search");
			
			boolean booked = false;
			
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM otrs.flys";
			//String str1 = "SELECT * FROM otrs.flight";
			//Run the query against the database.
			String str = "SELECT * FROM flys INNER JOIN aircraft ON aircraft.aircraft_id = flys.aircraft_id INNER JOIN flight ON flight.flight_number = flys.flight_number;";
			ResultSet result = stmt.executeQuery(str);
			//ResultSet result1 = stmt.executeQuery(str1);
			//int count = 1;
			
			
			
			
			 while (result.next()) {
				if(result.getString("flight_number").equals(Collections.list(request.getParameterNames()).get(0)) &&  result.getInt("passengers")<result.getInt("number_of_seats")){ //count attribute on flight?
						
						booked = true;
						
					
					break;
				}
				//out.print(result.getInt("flight_number")+ " ");
			}
			
			
			
			if(booked==true){
				out.print("You have been booked");
				
				
				
				String up = "UPDATE otrs.flight SET passengers = passengers+1 WHERE flight_number =" + Collections.list(request.getParameterNames()).get(0);
				PreparedStatement ps = con.prepareStatement(up);
				
				ps.executeUpdate();
				
				/*String tix = "INSERT otrs.ticket (seat_number, first_name, last_name) value (" + result.getInt("seat_number") + ", \"" + session.getAttribute("user") + "\""+", " + (result.getInt("spot") + 1) +")";
				  ps = con.prepareStatement(tix);
				 ps.executeUpdate();*/
				 out.print(session.getAttribute("first_name"));
				
				
			}
			else{
				out.print("Booking error");
			}
			
			
			/*String up = "UPDATE otrs.aircraft SET f_count = f_count+1 WHERE aircraft_id " + "VALUES (?)";
			PreparedStatement ps = con.prepareStatement(up);
			ps.executeUpdate();*/
			
			
				
			
						
					
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>