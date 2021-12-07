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
			boolean search = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
			
			
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			//String str = "SELECT * FROM user";
			
			//Run the query against the database.
			//ResultSet result = stmt.executeQuery(str);
			String username = request.getParameter("user");
			if(username != null){
				session.setAttribute("user", username);
			}
			String str = "SELECT * FROM waitlist";
			ResultSet result = stmt.executeQuery(str);
			int seats = 0;
			int passenger = 0;
			
						%>
						
						<%--<form method="get" action="HomePage.jsp">
			 				 <input type="submit" value="Browse Current Flights" />
						</form>
						
						<form method="get" action="HomePage.jsp"> 
			 				 <input type="submit" value="Browse Past Flights" />
						</form> --%>
						
						<form method="get" action="Cancel.jsp">
		  				<input type="submit" value="Cancel Flights" />
						</form>
						
						<form method="get" action="changeTix.jsp">
		  				<input type="submit" value="Change Ticket" />
						</form> 
						
					
						<%
						
						boolean wl = true;
						   /*String insert = "INSERT INTO waitlist(flight_number, username, spot) value ("
								+ Collections.list(request.getParameterNames()).get(0) + ", \"" + session.getAttribute("user") + "\", " + 1 + ")";*/
						boolean checkUser = false;		
					
								while(result.next()){
									//out.print(result.getInt("passengers"));
									//out.print(result.getInt("number_of_seats"));
								if(session.getAttribute("user").equals(result.getString("username"))&&Collections.list(request.getParameterNames()).get(0).equals(result.getString("flight_number"))){
										out.print("You have already been put in waitlist. Please try another flight. ");
												
												wl = false;
												checkUser = true;
												//out.print(passenger);
												//out.print(seats);
												break;
								}
									
								
								}
								
								
								
								str ="SELECT * FROM flys INNER JOIN aircraft ON aircraft.aircraft_id = flys.aircraft_id INNER JOIN flight ON flight.flight_number = flys.flight_number";
								result = stmt.executeQuery(str);
								
								if(checkUser==false){	//necessary to check if booking still available			
									while(result.next()){
										
										if(result.getInt("passengers")<result.getInt("number_of_seats")&&Collections.list(request.getParameterNames()).get(0).equals(result.getString("flight_number"))){
												//out.print("GREATER");
														
														
														seats = result.getInt("number_of_seats");
														passenger = result.getInt("passengers");
														//out.print(passenger);
														//out.print(seats);
														break;
										}
											
										
										}
								}
								
								
								
								//out.print(wl);
								//out.print(passenger);
								//out.print(seats);
								//out.print(wl);
								if(wl == true&&passenger>=seats){
									
									str = "Select Max(spot) as spot from waitlist where flight_number = " + Collections.list(request.getParameterNames()).get(0);
									
									result = stmt.executeQuery(str);
									result.next();
									
									String insert = "INSERT INTO waitlist(flight_number, username, spot) value ("
											+ Collections.list(request.getParameterNames()).get(0) + ", \"" + session.getAttribute("user") + "\""+", " + (result.getInt("spot") + 1) +")"; //[increaments spot to check waitlist you can just say if the spot is less than any other spots that correspond to the flight number he is next in line]
									 PreparedStatement ps = con.prepareStatement(insert);

										//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
										
										//Run the query against the DB
										ps.executeUpdate();
										out.print("You have been added to the waitlist");
										//out.print(passenger);
										//out.print(seats);
								}else if(passenger<seats){
									out.print("Waitlist error. There are available seats on the flight");
									
								}
								
												
												//out.print(result.getString(username));
						
						
						//Create a Prepared SQL statement allowing you to introduce the parameters of the query
						//out.print(insert);
						
						
							//if(session.getAttribute("user").equals())
								/*while(result.next()){
									if(session.getAttribute("user").equals(result.getString("username"))){
										String up = "UPDATE otrs.waitlist SET waitlist.spot = waitlist.spot+1 WHERE flight_number =" + Collections.list(request.getParameterNames()).get(0);
										PreparedStatement ps1 = con.prepareStatement(up);
										ps1.executeUpdate();
										break;
									}
									
								}*/
							 
								
								
								
						
						
						
						
						
						
						
					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>