<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Flight Info Admin</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean flightExist = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
            String flightNum = request.getParameter("SearchFlight");
            
			String str = "SELECT * FROM flight";
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				if((String.valueOf(result.getInt("flight_number")).equals(request.getParameter("SearchFlight")))){
					flightExist = true;
					%>
				 	<form method="get" action="FlightInfoAdminView.jsp">
					<label>Search another Flight: <input name = "SearchFlight"/></label>
	 				 <input type="submit" value="Search Flight" />
				    </form>
				    <br>
				    <%

				    str = "SELECT SUM(30) AS TRev FROM otrs.ticket t WHERE  t.flight_number = \"" + flightNum + "\"";
				    result = stmt.executeQuery(str);
	                result.next();
				    out.print("FLIGHT: #" + flightNum + "<br/>");
				    out.print("The total revenue from this flight: $" + result.getInt("TRev"));
				    
				    str = "SELECT SUM(1) AS TRev FROM otrs.ticket t WHERE  t.flight_number = \"" + flightNum + "\"";
				    result = stmt.executeQuery(str);
				    result.next();
				    out.print("<br/>The total tickets sold for this flight: " + result.getInt("TRev")+ "<br/>");
				    %>
				    <br>
					<form method="get" action="HomePage.jsp">
		  				<input type="submit" value="Back to Home Page" />
					</form>
					<%
					
				    out.print("<br/>ALL flight reservations for this flight:<br/><br/>");
				    str = "SELECT * FROM ticket";
				    result = stmt.executeQuery(str);
				    while (result.next()){
				    	if ((String.valueOf(result.getInt("flight_number")).equals(request.getParameter("SearchFlight")))){		
				    		if(result.getString("first_class").equals("1")){
				    			out.print("Ticket #: "+ result.getInt("id_num") +", Flight #: "+ result.getInt("flight_number") +", Username: "+ result.getString("username") + ", Seat #: " + result.getInt("seat_number") + ", First Name: "+ result.getString("first_name") + ", Last Name: " + result.getString("last_name") + ", Class: First Class<br/>");
							}
				    		else if(result.getString("business_class").equals("1")){
				    			out.print("Ticket #: "+ result.getInt("id_num") +", Flight #: "+ result.getInt("flight_number") +", Username: "+ result.getString("username") + ", Seat #: " + result.getInt("seat_number") + ", First Name: "+ result.getString("first_name") + ", Last Name: " + result.getString("last_name") + ", Class: Business Class<br/>");
							}
				    		else if(result.getString("economy_class").equals("1")){
				    			out.print("Ticket #: "+ result.getInt("id_num") +", Flight #: "+ result.getInt("flight_number") +", Username: "+ result.getString("username") + ", Seat #: " + result.getInt("seat_number") + ", First Name: "+ result.getString("first_name") + ", Last Name: " + result.getString("last_name") + ", Class: Economy Class<br/>");
							}
				    	}
				    }
				}
			}
			if(!flightExist){
				out.print("This Flight does not exist. Try again.");
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