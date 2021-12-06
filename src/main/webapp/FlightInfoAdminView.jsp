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
				    
				    str = "SELECT SUM(30 * passengers) AS TRev FROM otrs.flight f WHERE f.flight_number = \"" + flightNum + "\"";
				    result = stmt.executeQuery(str);
	                result.next();
				    out.print("FLIGHT: #" + flightNum + "<br/>");
				    out.print("The total revenue from flight is: $" + result.getInt("Trev"));
				    out.print("<br/><br/>ALL flight reservations for this flight:");
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