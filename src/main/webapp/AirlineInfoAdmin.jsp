<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Airline Info Admin</title>
</head>
<body>
<%
//Get the database connection
try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			boolean AirlineExist = false;
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
            String AirlineName = request.getParameter("SearchAirline");
            
			String str = "SELECT * FROM airline_company";
			ResultSet result = stmt.executeQuery(str);
			
			while (result.next()) {
				if((String.valueOf(result.getString("airline_id")).equals(request.getParameter("SearchAirline")))){
					AirlineExist = true;
					%>
				 	<form method="get" action="FlightInfoAdminView.jsp">
					<label>Search another Airline: <input name = "SearchAirline"/></label>
	 				 <input type="submit" value="Search Airline" />
				    </form>
				    <br>
				    <%
				    out.print("Airline: " + request.getParameter("SearchAirline") + "<br/><br/>Revenue gained from this Airline: ");
				    
				    
				    str = "";
				    out.print(str);
				    result = stmt.executeQuery(str);
				    
				    
				    
				    
					/*
				    str = "SELECT SUM(30) AS TRev FROM otrs.ticket t WHERE  t.flight_number = \"" + flightNum + "\"";
				    result = stmt.executeQuery(str);
	                result.next();
				    out.print("FLIGHT: #" + flightNum + "<br/>");
				    out.print("The total revenue from this flight: $" + result.getInt("TRev"));
				    
				    str = "SELECT SUM(1) AS TRev FROM otrs.ticket t WHERE  t.flight_number = \"" + flightNum + "\"";
				    result = stmt.executeQuery(str);
				    result.next();
				    out.print("<br/>The total tickets sold for this flight: " + result.getInt("TRev")+ "<br/>");
				    */
				    out.print("<br/>");
				    %>
				    <br>
					<form method="get" action="HomePage.jsp">
		  				<input type="submit" value="Back to Home Page" />
					</form>
					<%
				}
			}
			if(!AirlineExist){
				out.print("This Airline does not exist. Try again.");
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