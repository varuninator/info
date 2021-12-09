<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Tickets</title>
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
			
			String cancel = request.getParameter("fCancel");
			String delTix = "";
			if(cancel != null){
				session.setAttribute("fCancel", cancel);
			}
			
			String str = "SELECT * FROM otrs.ticket";
			ResultSet result = stmt.executeQuery(str);
			
			%>
			<br>
			<form method="get" action="Cancel.jsp">
				<label>Please enter the ticket number you wish to cancel: <input name = "fCancel"/></label>
			  <input type="submit" value="Cancel Reservation" />
			</form>
			<br>
			<form method="get" action="AccountInfo.jsp">
			  <input type="submit" value="Back" />
			</form>
			
			


    
			<br>
		<% 
		
		String decPass = "";
		int count = 0;
		int flightNum = 0;
		boolean invalid = true;
		if(cancel!=null){
			while(result.next()){
				if(cancel.trim().equals(result.getString("id_num")) && session.getAttribute("user").equals(result.getString("username"))) {
					if(result.getBoolean("business_class") || result.getBoolean("first_class")) {
						
						delTix = "DELETE FROM otrs.ticket WHERE id_num = " + result.getInt("id_num");
						PreparedStatement ps = con.prepareStatement(delTix);
						ps.executeUpdate();
						out.print("Deleted ticket with id number: " + result.getInt("id_num"));
						invalid = false;
						flightNum = result.getInt("flight_number");
						
						/* str = "SELECT * FROM flys INNER JOIN aircraft ON aircraft.aircraft_id = flys.aircraft_id INNER JOIN flight ON flight.flight_number = flys.flight_number WHERE flight.flight_number = " + flightNum;
						result = stmt.executeQuery(str);
						result.next();
					if(result.getInt("passengers")==result.getInt("number_of_seats")){
							out.print("FLIGHT: " + result.getInt("flight_number") + " IS OPEN");
						}*/
						
							//session.setAttribute("f_num", flightNum);
							
							
						
							
						//session.setAttribute("flight_number");
						 str = "SELECT * FROM otrs.flight";
						result = stmt.executeQuery(str);
						result.next();
						decPass = "UPDATE otrs.flight SET passengers = passengers - 1 WHERE flight_number = " + flightNum;
						ps = con.prepareStatement(decPass);
						ps.executeUpdate();
						
					break;
					}
					else {
						out.print("You can only cancel business or first class reservations. Please contact our Customer Representatives for further assistance.<br/>");
// 						out.print("<br/>");
					}
				}
			}
			if(invalid){
				out.print("You have entered an invalid ticket number.");
			}
		}
		

			


					
} catch (Exception e) {
	out.print(e);
}
			%>
			
</body>
</html>