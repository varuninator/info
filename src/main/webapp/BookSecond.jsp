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
				out.print("You have been booked<br/>");
				
				
				
				String up = "UPDATE otrs.flight SET passengers = passengers+1 WHERE flight_number =" + Collections.list(request.getParameterNames()).get(0);
				PreparedStatement ps = con.prepareStatement(up);
				
				ps.executeUpdate();
				
				str = "Select Max(seat_number) as seat_number  FROM for_ INNER JOIN flight ON for_.flight_number = " + Collections.list(request.getParameterNames()).get(0) + " INNER JOIN ticket ON for_.id_num = ticket.id_num";
				
				result = stmt.executeQuery(str);
				result.next();
				
				int max_seat = result.getInt("seat_number");
				/*str = "SELECT * FROM otrs.ticket";
				result = stmt.executeQuery(str);
				result.next();*/
				String tix;
				if(session.getAttribute("rep_user") != null){
					str = "select * from user where username = \"" + session.getAttribute("rep_user") + "\"";
					result = stmt.executeQuery(str);
					result.next();
					if(result.getString("username") != null){
						tix = "INSERT otrs.ticket (username, seat_number, first_name, last_name, first_class, business_class, economy_class) value (" + "\"" + session.getAttribute("rep_user") + "\""+", " + (max_seat + 1) + ", \"" + result.getString("first_name") + "\""+", " +  "\"" + result.getString("last_name") + "\"" + ", false " + ", true" + ", false" + ")";	
						//out.print(tix);
						  ps = con.prepareStatement(tix);
						 ps.executeUpdate();
						 
						String for_ = "INSERT otrs.for_ (flight_number) value (" + Collections.list(request.getParameterNames()).get(0)+ ")";
						//out.print(for_);
						ps = con.prepareStatement(for_);
						 ps.executeUpdate();
					}
				}else{
					tix = "INSERT otrs.ticket (username, seat_number, first_name, last_name, first_class, business_class, economy_class) value (" + "\"" + session.getAttribute("user") + "\""+", " + (result.getInt("seat_number") + 1) + ", \"" + session.getAttribute("first") + "\""+", " +  "\"" + session.getAttribute("last") + "\"" + ", false " + ", true" + ", false" + ")";	
					//out.print(tix);
					  ps = con.prepareStatement(tix);
					 ps.executeUpdate();
					 
					String for_ = "INSERT otrs.for_ (flight_number) value (" + Collections.list(request.getParameterNames()).get(0)+ ")";
					//out.print(for_);
					ps = con.prepareStatement(for_);
					 ps.executeUpdate();
				}
			}
			else{
				out.print("Booking error<br/>");
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